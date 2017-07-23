#!/bin/bash

WORK=$(mktemp -d)
cd $WORK

pi2b() {
    URL="https://nodejs.org/dist/v4.0.0/node-v4.0.0-linux-armv7l.tar.gz"
    wget $URL -O - |tar xzf -
    
    cd node-v4.0.0-linux-armv7l
    sudo cp -R * /usr/local
}

pi2b
