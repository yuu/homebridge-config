#!/bin/bash

homebridge() {
    sudo apt install libavahi-compat-libdnssd-dev
    
    sudo npm install -g --unsafe-perm homebridge hap-nodejs node-gyp
    cd /usr/local/lib/node_modules/homebridge/
    sudo npm install --unsafe-perm bignum
    cd /usr/local/lib/node_modules/hap-nodejs/node_modules/mdns
    sudo node-gyp BUILDTYPE=Release rebuild

    URL="https://gist.githubusercontent.com/johannrichard/0ad0de1feb6adb9eb61a/raw/1cf926e63e553c7cbfacf9970042c5ac876fadfa/"
    CONF="homebridge"
    SERVICE="homebridge.service"
    
    WORKDIR=$(mktemp -d)
    cd $WORKDIR
    sudo wget "$URL/$CONF" -O $CONF
    sudo wget "$URL/$SERVICE" -O $SERVICE

    ## Change User
    sed -ie 's@User=homebridge@User=pi@g' homebridge.service
    ## Enable DEBUG LOG
    sed -ie 's@# DEBUG=*@DEBUG=@g' homebridge

    sudo cp $CONF /etc/default
    sudo cp $SERVICE /etc/systemd/system
    
    sudo systemctl daemon-reload
    sudo systemctl enable homebridge
    sudo systemctl start homebridge
}

plugin() {
    sudo npm install -g --unsafe-perm homebridge-irkit
}

# homebridge

plugin
