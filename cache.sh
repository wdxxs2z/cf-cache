#!/bin/bash

CONSUL_AGENT_SERVER=""
CONSUL_AGENT_ENCRYPT=""
CONSUL_AGENT_CRT=""
CONSUL_AGENT_KEY=""
CONSUL_CA_CRT=""
CONSUL_SERVER_CRT=""
CONSUL_SERVER_KEY=""
BBS_CA_CRT=""
BBS_CLIENT_CRT=""
BBS_CLIENT_KEY=""
NATS_ADDRESS=""
NATS_USERNAME=""
NATS_PASSWORD=""
ETCD_SERVER=""

IP_ADDRESS=${IP_ADDRESS:-`ip addr | grep 'inet .*global' | cut -f 6 -d ' ' | cut -f1 -d '/' | head -n 1`}

echo $CONSUL_AGENT_CRT > /var/vcap/jobs/consul_agent/config/certs/agent.crt

echo $CONSUL_AGENT_KEY > /var/vcap/jobs/consul_agent/config/certs/agent.key

echo $CONSUL_SERVER_CRT > /var/vcap/jobs/consul_agent/config/certs/server.crt

echo $CONSUL_SERVER_KEY > /var/vcap/jobs/consul_agent/config/certs/server.key

echo $CONSUL_CA_CRT > /var/vcap/jobs/consul_agent/config/certs/ca.crt

echo $BBS_CA_CRT > /var/vcap/jobs/receptor/config/certs/bbs/ca.crt

echo $BBS_CLIENT_CRT > /var/vcap/jobs/receptor/config/certs/bbs/client.crt

echo $BBS_CLIENT_KEY > /var/vcap/jobs/receptor/config/certs/bbs/client.key

sed -i "s/0mTX0RfWX0zxgUVnMimkPw==/$CONSUL_AGENT_ENCRYPT/g" /var/vcap/jobs/consul_agent/config/config.json

sed -i "s/10.10.130.104/$CONSUL_AGENT_SERVER/g" /var/vcap/jobs/consul_agent/config/config.json

sed -i "s/10.10.30.120/$IP_ADDRESS/g" /var/vcap/jobs/consul_agent/config/config.json

sed -i "s/10.10.130.104/$CONSUL_AGENT_SERVER/g" /var/vcap/jobs/consul_agent/bin/agent_ctl

sed -i "s/10.10.130.120/$IP_ADDRESS/g" /var/vcap/jobs/consul_agent/bin/agent_ctl

sed -i "s/10.10.130.120/$IP_ADDRESS/g" /var/vcap/jobs/metron_agent/config/syslog_forwarder.conf

sed -i "s/10.10.130.105/$ETCD_SERVER/g" /var/vcap/jobs/metron_agent/config/metron_agent.json

sed -i "s/10.10.130.103/$NATS_ADDRESS/g" /var/vcap/jobs/receptor/bin/receptor_ctl

sed -i "s/b6945a6105c1cf5ce66b/$NATS_PASSWORD/g" /var/vcap/jobs/receptor/bin/receptor_ctl

mkdir -p /var/vcap/sys/log/consul_agent \
         /var/vcap/sys/log/metron_agent \
         /var/vcap/sys/log/monit \
         /var/vcap/sys/log/receptor \
         /var/vcap/sys/log/registry

mkdir -p /var/vcap/sys/run/{consul_agent,metron_agent,receptor,registry}

mkdir -p /var/vcap/data/registry