#!/bin/bash

if [ "$1" != "firefox" ] && [ "$1" != "thunderbird" ]; then
    echo "No valid application specified!"
    echo "$0 APPLICATION"
    exit 1
fi

app=$1
app_path=/opt/$app
base_url="http://download-origin.cdn.mozilla.net/pub/mozilla.org/$app/releases/latest/linux-x86_64/en-US/"
release=`curl -s "$base_url" | grep -o "$app-[0-9]\+\.[0-9]\+\.\?[0-9]\?.tar.bz2" | head -1`

cd /opt

if [ "$release" != "`cat ${app}_current`" ]; then
    curl -O -s "${base_url}${release}"

    if [ $? -eq 0 ]; then
        rm -rf "/opt/${app}"
        tar -xvjf $release
        echo $release > ${app}_current
    else
        echo "  Download FAILED!"
    fi
    echo "  $app updated!"

else
    echo "  Your $app is up to date!"
fi


