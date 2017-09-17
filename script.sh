#!/bin/bash

dir="$(pwd)";

#verify if this is the uuid for all the devices, fix if needed
uuid="6e71eb05-8d22-48e2-be90-5efaf295eacb";

if [ $# -eq 0 ]
    then
        read -p 'Enter Amizone username : ' uname;
    else uname=$1;
fi
echo "Password (enter 'password' if you haven't modified or don't know.)"
read -sp 'Password: ' passwd


if [ `id -u` -ne 0 ] ; then echo "Please run as root" ; sudo /bin/bash $dir/script.sh ; exit 1 ; fi

macaddr="$(sudo ifconfig wlan0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | tr '[:lower:]' '[:upper:]')";

cat > log <<EOL
[connection]
id=AmityWiFi
uuid=${uuid}
type=wifi
permissions=

[wifi]
hidden=true
mac-address=${macaddr}
mac-address-blacklist=
ssid=AmityWiFi

[wifi-security]
key-mgmt=wpa-eap

[802-1x]
eap=peap;
identity=${uname}@amity.edu.in
password=${passwd}
phase2-auth=mschapv2

[ipv4]
dns-search=
method=auto

[ipv6]
addr-gen-mode=stable-privacy
dns-search=
method=auto
EOL

cat log
#commented because still testing.further tests on WiFiRegister network
#sudo chmod u=rw,g=,o= log
#sudo rm /etc/NetworkManager/system-connections/AmityWiFi
#sudo mv log AmityWiFi
#sudo cp AmityWiFi /etc/NetworkManager/system-connections
#echo "Done, Restarting the system in 10 seconds, press Ctrl+c to cancel."
#sleep 10
#sudo shutdown -r now
