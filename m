Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Petr =?iso-8859-2?q?Palack=FD?= <petr@palacky.net>
To: bluez-users@lists.sourceforge.net
Date: Mon, 11 Sep 2006 21:46:15 +0200
MIME-Version: 1.0
Message-Id: <200609112146.15972.petr@palacky.net>
Subject: [Bluez-users] 3 or more BT dongles over 1 USB-2.0 4-port HUB
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

Hi all,

i have problem with three (and more) USB BT dongles (all are the same, 
CSR-based) and 4-port USB-2.0 HUB.

When i attach one USB dongle alone, everything is good (hci0 is up and 
running). When i attach the second dongle (after the first), still is 
everything OK (hci0 and hci1 are up and running).
But when i attach third (or fourth) dongle, this does not work.

I tried attaching all dongles differently but every time the third (or fourth) 
dongle is not OK and dmesg says:
#dmesg
hci_usb_intr_rx_submit: hci2 intr rx submit failed urb cd55b674 err -28

If i have attached all four dongles only the first two are OK, if i manualy 
change its state to "DOWN" and next two to "UP", now i have also hci2 and 
hci3 working (but never all three or more along).

If i have state for the first two dongles "UP" and trying setting up next two 
dongles "UP" also, then i get message:
# hciconfig hci2 up
"Can't init device hci2: Input/output error (5)"

I also tried another USB-2.0 HUB, but everything is the same - nothing 
happens.

When i attach two dongles and second USB HUB (with one or more dongle 
attached) into first USB HUB, everything is OK. Now i have all three or four 
dongles working, but this isn't good solution.

If i attach two dongles, one printer and one mouse into this (or my second) 
USB HUB, evereything is good and all devices are working, so these HUBs are 
good.

I tried this procedure on four different computers (3x PC, 1x Laptop - all 
with linux-2.6.x with distros Gentoo, SUSE and Debian), but still nothing 
happens.

Please, is there any way how to run more than two USB BT dongles attached to 
one 4-port USB-2.0 HUB?

Thank for any idea

Here are some informations about my system:
====================================
#uname -r
2.6.16-gentoo-r6

#cat /usr/src/linux/.config | grep BT
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m

#lsmod
rfcomm                 36500  0
l2cap                  23232  5 rfcomm
hci_usb                14676  4
bluetooth              45092  9 rfcomm,l2cap,hci_usb

#lsusb
Bus 001 Device 041: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle 
(HCI mode)
Bus 001 Device 040: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle 
(HCI mode)
Bus 001 Device 039: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle 
(HCI mode)
Bus 001 Device 038: ID 05e3:0605 Genesys Logic, Inc. USB 2.0 Hub [ednet]

-- 
Best regards

Petr Palacky

Outgoing message is virus free
because we use Linux (http://www.linux.org)
version 2.6.16-gentoo-r6 / Gentoo Linux
--
Windows NT:
New Technology? I don't think so...

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
