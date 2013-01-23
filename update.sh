#!/bin/bash

cd /opt
release=`curl -s 'http://releases.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/' | \
grep -o 'firefox-[0-9]\+\.[0-9]\+\.[0-9]\+.tar.bz2' | head -1`

if [ "$release" != "`cat current`" ]
    then
        curl -O -s "http://releases.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/$release"
        if [ $? -eq 0 ]
            then
                rm -rf '/opt/firefox'
                tar -xvjf $release
                echo $release > current
            else
                echo "  Download FAILED!"
        fi
    else
        echo "  Your Firefox is up to date!"
fi


