Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alberto Garcia Hierro <tcpdevil@linuxlover.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408140030.10263.tcpdevil@linuxlover.org>
Subject: [Bluez-users] Can't get BT working on an iBook G4
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 14 Aug 2004 00:30:09 +0200

Hi all list,
	I'm trying to setup BT on my iBook G4 (builtin BT), but i can't. As far as=
 I=20
know, it's a usb device, so i modprobe hci_usb. Then, i tryed with hcitool,=
=20
but it doesn't show any device:


americana ~ $ modprobe hci_usb
americana ~ $ /etc/init.d/bluetooth start
 * Starting Bluetooth...                                                [ o=
k ]
americana ~ $ hcitool dev
Devices:

	hcid and sdpd are running:

americana ~ $ ps aux |egrep "hcid|sdpd"
root      8905  0.0  0.0  1656  612 ?        Ss   00:27   0:00 hcid:=20
processing events
root      8907  0.0  0.0  1640  584 ?        Ss   00:27   0:00 /usr/sbin/sd=
pd
root      8921  0.0  0.0  1568  528 pts/0    S+   00:28   0:00 egrep hcid|s=
dpd


	The most strange think it's i got it working some months ago, and i think =
i=20
did the same things. Here is the relevant part of my .config


	CONFIG_BT=3Dm
	CONFIG_BT_L2CAP=3Dm
	# CONFIG_BT_SCO is not set
	CONFIG_BT_RFCOMM=3Dm
	CONFIG_BT_RFCOMM_TTY=3Dy
	CONFIG_BT_BNEP=3Dm
	CONFIG_BT_BNEP_MC_FILTER=3Dy
	CONFIG_BT_BNEP_PROTO_FILTER=3Dy

	#
	# Bluetooth device drivers
	#
	CONFIG_BT_HCIUSB=3Dm
	# CONFIG_BT_HCIUSB_SCO is not set
	CONFIG_BT_HCIUART=3Dm
	CONFIG_BT_HCIUART_H4=3Dy
	CONFIG_BT_HCIUART_BCSP=3Dy
	CONFIG_BT_HCIUART_BCSP_TXCRC=3Dy
	CONFIG_BT_HCIBCM203X=3Dm
	CONFIG_BT_HCIBFUSB=3Dm
	CONFIG_BT_HCIVHCI=3Dm

	I've spent three hours searching on google, bluez.org and the list archive=
s=20
and i can't find any solution. I'll be very happy is someone can't help me.=
=20
TIA.=09

=2D-=20
/* Alberto Garc=EDa Hierro (Skyhusker) */


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
