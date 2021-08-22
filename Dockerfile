FROM ubuntu
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    cmake \
    vim \
    wget \
    git \
    g++ \
    libboost-all-dev \
    build-essential \
    checkinstall \
    zlib1g-dev \
    libpcap-dev \
    libssl-dev \
    cmake \ 
    make

WORKDIR /usr/local/src
RUN wget https://www.openssl.org/source/openssl-1.1.1c.tar.gz \
    && tar -xf openssl-1.1.1c.tar.gz

WORKDIR /usr/local/src/openssl-1.1.1c
RUN ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib \
    make \
    make install

WORKDIR /etc/ld.so.conf.d
RUN touch openssl-1.1.1c.conf \
    && echo "/usr/local/ssl/lib" > openssl-1.1.1c.conf \
    && ldconfig -v \
    && mv /usr/bin/c_rehash /usr/bin/c_rehash.backup \
    && mv /usr/bin/openssl /usr/bin/openssl.backup

WORKDIR /etc/
RUN rm environment \
    && touch environment \
    && echo "PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/ssl/bin"" > environment \
    && source /etc/environment

RUN git clone https://github.com/burryfun/PPPoEPerf.git /usr/src/PPPoEPerf

WORKDIR /usr/src/PPPoEPerf/build
RUN cmake .. \
    && make \
    && make install
