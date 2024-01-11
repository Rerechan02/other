#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
MYIP=$(wget -qO- https://icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
domain=$(cat /etc/xray/domain)
#Update Repository VPS
clear
apt update 
apt-get -y upgrade

cd 
wget -O /usr/local/bin/ohp "https://raw.githubusercontent.com/Rerechan02/v/main/OPENVPN/ohp"
chmod +x /usr/local/bin/ohp

cat > /etc/systemd/system/ohp.service <<END
[Unit]
Description=Direct Squid Proxy For OpenVPN TCP By DIYVPN
Documentation=https://t.me/@FN
Wants=network.target
After=network.target

[Service]
ExecStart=/usr/local/bin/ohp -port 8585 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:1194
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

cat > /etc/systemd/system/ohpd.service <<END
[Unit]
Description=Direct Squid Proxy For OpenVPN TCP By DIYVPN
Documentation=https://t.me/@FN
Wants=network.target
After=network.target

[Service]
ExecStart=/usr/local/bin/ohp -port 8686 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:1194
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ohp
systemctl restart ohp
systemctl enable ohpd
systemctl restart ohpd
echo ""
echo -e "${GREEN}Done Installing OHP Server${NC}"
echo -e "Script By Rere OVPN"
sleep 4
clear