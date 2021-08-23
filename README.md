# pppoeperf-docker
Docker image for [PPPoEPerf](https://github.com/iKuaiNetworks/PPPoEPerf)

## Usage
### Download pppoeperf-docker
```
git clone https://github.com/burryfun/pppoeperf-docker.git
```
### Start pppoe_perf for [100/1000/5000/10000] sessions
```
docker-compose run app pppoe_perf -c /etc/pppoe_perf/conf_[count].json
```
