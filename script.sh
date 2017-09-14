# no shebang, already modified file to make it executable
FILE="log.txt";
dir="$(pwd)";
uuid="get uuid";
#add prompt to get uname and password
uname="amizone username";
passwd="passwd"
macaddr="$(sudo ifconfig wlan0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | tr '[:lower:]' '[:upper:]')";

if [ `id -u` -ne 0 ] ; then echo "Please run as root" ; sudo /bin/bash $dir/trial.sh ; exit 1 ; fi

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
#sudo /etc/NetworkManager/system-connections/AmityWiFi
#sudo cp log /etc/NetworkManager/system-connections
