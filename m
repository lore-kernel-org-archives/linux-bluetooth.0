Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1109664374.42242276c644b@mail.orbitel.bg>
From: Todor Todorov <dr_doom@engineer.bg>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Subject: [Bluez-users] BNEP connection destroing :(
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue,  1 Mar 2005 10:06:14 +0200

Hi. I successful make a bnep connection between my laptop (with Slackware 10.0, kernel 2.4.26 with openmosix 
patch and latest version of bluez libs and bluez pand, but i tryed also with other versions) and desktop PC with 
Windows XP Pro, after few minutes  (not measured), on linux system the bnep0 interface was destroyed.

Attempting to reconnect with pand worked silently, but the bnep0 interface was not created. Workaround was to 
remove and re-insert the dongle on my laptop, then i recreate the bnep connection again.
I make a simple script for making bnep connection with windows machine:

#!/bin/sh
hciconfig hci0 up
#sdpd
#sdptool add LAN
echo "Making PAN connection"
#pand --role PANU -c 00:10:60:A6:1C:30 --service GN
pand --role PANU -c 00:10:60:A6:1C:30 --service PANU
echo "Wait for connection"
sleep 6
echo "Bring UP BNEP"
hcitool lst 00:10:60:A6:1C:30 0
ifconfig bnep0 10.0.0.2 netmask 255.255.255.0
ifconfig bnep0 up
route add default gw 10.0.0.1
rm /etc/resolv.conf
touch /etc/resolv.conf
echo "nameserver 10.13.0.1" > /etc/resolv.conf

This is my kernel config for bluez:

CONFIG_BLUEZ=y
CONFIG_BLUEZ_L2CAP=y
# CONFIG_BLUEZ_SCO is not set
CONFIG_BLUEZ_RFCOMM=y
CONFIG_BLUEZ_RFCOMM_TTY=y
CONFIG_BLUEZ_BNEP=y
# CONFIG_BLUEZ_BNEP_MC_FILTER is not set
# CONFIG_BLUEZ_BNEP_PROTO_FILTER is not set
# CONFIG_BLUEZ_CMTP is not set
CONFIG_BLUEZ_HCIUSB=y
# CONFIG_BLUEZ_USB_SCO is not set
# CONFIG_BLUEZ_HCIUART is not set
# CONFIG_BLUEZ_HCIBFUSB is not set
# CONFIG_BLUEZ_HCIDTL1 is not set
# CONFIG_BLUEZ_HCIBT3C is not set
# CONFIG_BLUEZ_HCIBLUECARD is not set
# CONFIG_BLUEZ_HCIBTUART is not set
# CONFIG_BLUEZ_HCIVHCI is not set

Help me to resolve this problem.
Thank you in advance.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
