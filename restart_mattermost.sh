#!/bin/sh
## script for restart mattermost 

echo "*** restarting mattermost"

#  Copy config.json
cp config.json config-backup.json

#  move to bitnami 
cd /opt/bitnami
#cd ./opt/bitnami/

#  move to bitnami 
echo "${PWD}"

# change permissions
chmod a+x "${PWD}"/ctlscript.sh

# # stop services
# ## /opt/bitnami/ctlscript.sh stop
"${PWD}"/ctlscript.sh stop

# # start services
# ## /opt/bitnami/ctlscript.sh start
"${PWD}"/ctlscript.sh start

# validate if not running
if "${PWD}"/ctlscript.sh status | grep -w 'not running'
then
    echo "error"
    port=`llsof -i:80 | awk 'FNR == 2 {print $2}'`
    # port=`lsof -i:8080 | awk 'FNR == 2 {print $2}'`
    echo "port: ${port}"
    sudo kill ${port}
    "${PWD}"/ctlscript.sh start
else
    echo "everything ok"
fi

