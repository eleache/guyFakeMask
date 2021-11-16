#!/bin/bash
# author:Und3rf10w 
# editor: eleAche
# primero que nada, buenos dias.
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi
rm -f /etc/apt/sources.list.d/i2p.list
echo "deb http://deb.i2p2.no/ unstable main" > /etc/apt/sources.list.d/i2p.list # todo de el autentico i2p2
wget https://geti2p.net/_static/i2p-debian-repo.key.asc -O /tmp/i2p-debian-repo.key.asc # obtienes la llave
apt-key add /tmp/i2p-debian-repo.key.asc # la pones en tu mano
rm /tmp/i2p-debian-repo.key.asc # tira lo que no te sirva
apt-get update # preparate, llevas todo ? ok.
# ahora si va el escandalo...
# 
if [[ -n $(cat /etc/os-release |grep kali) ]]
then
	apt-get install libservlet3.0-java 
	wget http://ftp.us.debian.org/debian/pool/main/j/jetty8/libjetty8-java_8.1.16-4_all.deb
	dpkg -i libjetty8-java_8.1.16-4_all.deb # este paquete indica error
	apt-get install libecj-java libgetopt-java libservlet3.0-java glassfish-javaee ttf-dejavu i2p i2p-router libjbigi-jni # pero aqui te instala las dependencias i2p
	apt-get -f install # Por si se rompio algo
fi
apt-get install -y i2p-keyring # importante, se asegura que cumplen los criterios de cifrado. 
apt-get install -y secure-delete tor i2p # instala dependencias de tor
dpkg-deb -b kali-anonsurf-deb-src/ kali-anonsurf.deb # Construye el paquete .deb
dpkg -i kali-anonsurf.deb || (apt-get -f install && dpkg -i kali-anonsurf.deb) # esto instalara automaticamente anonsurf
echo 'ya esta anonsurf'
exit 0
