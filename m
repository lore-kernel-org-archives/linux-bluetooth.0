Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 24 Jan 2007 21:25:26 -0800
From: Andres Vargas - zodman <zod@linuxmerida.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070124212526.2de68b62@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] hcid behing a hub usb
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

im using a usb-hub and get some errors with hcid...
and im conect the bluetooh on mi usb-hub with my mouse-usb ... 


lagrutadelzod:/home/andy# lsusb 
Bus 001 Device 029: ID 1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth Adapter
Bus 001 Device 028: ID 05e3:1205 Genesys Logic, Inc. Afilias Optical Mouse H3003
Bus 001 Device 027: ID 058f:9254 Alcor Micro Corp. Hub
Bus 001 Device 001: ID 0000:0000  


dmesg::::

hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.1: new low speed USB device using uhci_hcd and address 28
usb 1-1.1: configuration #1 chosen from 1 choice
input: USB Mouse as /class/input/input8
input: USB HID v1.10 Mouse [USB Mouse] on usb-0000:00:07.2-1.1
usb 1-1.3: new full speed USB device using uhci_hcd and address 29
usb 1-1.3: configuration #1 chosen from 1 choice

for this is good ...

lagrutadelzod:/home/andy# hcid -n -f /etc/bluetooth/hcid.conf
hcid[7408]: Bluetooth HCI daemon
hcid[7408]: Register path:/org/bluez fallback:1
hcid[7408]: HCI dev 0 registered
hcid[7408]: Register path:/org/bluez/hci0 fallback:0
hcid[7408]: HCI dev 0 already up
hcid[7408]: Device hci0 has been added
hcid[7408]: Starting security manager 0
hcid[7408]: Device hci0 has been activated

all is rigth ....

but ..........

lagrutadelzod:/home/andy# hciconfig  -a
hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN 
        RX bytes:2128 acl:0 sco:0 events:44 errors:0
        TX bytes:658 acl:0 sco:0 commands:44 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: 
        Link mode: SLAVE ACCEPT 
Can't read local name on hci0: Input/output error (5)

some times show the error and sometimes no. in small time function correct and  later back the error
on when the error is present dmesg::
hci_usb_rx_complete: hci0 corrupted packet: type 4 count 16



some suggest????? when i remove the usb-hub, and connect my bluetooth on usb plug no errors presents....

i need my usb-mouse :S

mi bluez Version: 3.7-1



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
