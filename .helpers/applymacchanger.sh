#!/bin/bash
# author: eleAche
# version: 0.0 (esto es testing)
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi

ifconfig eth0 down
macchanger -r wlan0
macchanger -r eth0
ifconfig wlan0 up
ifconfig eth0 up
