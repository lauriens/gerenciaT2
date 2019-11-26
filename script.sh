#!/bin/sh

cd ~/wordpress
docker-compose up -d

gnome-terminal -e docker logs $(docker ps -qf "name=wordpress_db") >> /var/logs/db.log

gnome-terminal -e docker logs $(docker ps -qf "name=wordpress_wordpress") >> /var/logs/wp.log

sudo docker run -ti  --cap-add NET_BIND_SERVICE --cap-add NET_BROADCAST --cap-add DAC_OVERRIDE --cap-add CHOWN --cap-add SYSLOG --cap-add DAC_READ_SEARCH -v wordpress_db_log:/var/log/common/db/ -v /data/syslog-ng/conf/filread.conf:/etc/syslog-ng/syslog-ng.conf -v /data/syslog-ng/logs/:/var/log/ --name sng_fileread -v /var/log/:/var/log/app/ balabit/syslog-ng:latest
