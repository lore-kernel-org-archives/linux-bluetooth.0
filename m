Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can't get BT working on an iBook G4
References: <200408140030.10263.tcpdevil@linuxlover.org>
In-Reply-To: <200408140030.10263.tcpdevil@linuxlover.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408140048.14641.cijoml@volny.cz>
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
Date: Sat, 14 Aug 2004 00:48:14 +0200

Possibly you need activate device with hid2hci tool

Michal

Dne so 14. srpna 2004 00:30 Alberto Garcia Hierro napsal(a):
> Hi all list,
> 	I'm trying to setup BT on my iBook G4 (builtin BT), but i can't. As far as
> I know, it's a usb device, so i modprobe hci_usb. Then, i tryed with
> hcitool, but it doesn't show any device:
>
>
> americana ~ $ modprobe hci_usb
> americana ~ $ /etc/init.d/bluetooth start
>  * Starting Bluetooth...                                                [
> ok ] americana ~ $ hcitool dev
> Devices:
>
> 	hcid and sdpd are running:
>
> americana ~ $ ps aux |egrep "hcid|sdpd"
> root      8905  0.0  0.0  1656  612 ?        Ss   00:27   0:00 hcid:
> processing events
> root      8907  0.0  0.0  1640  584 ?        Ss   00:27   0:00
> /usr/sbin/sdpd root      8921  0.0  0.0  1568  528 pts/0    S+   00:28  
> 0:00 egrep hcid|sdpd
>
>
> 	The most strange think it's i got it working some months ago, and i think
> i did the same things. Here is the relevant part of my .config
>
>
> 	CONFIG_BT=m
> 	CONFIG_BT_L2CAP=m
> 	# CONFIG_BT_SCO is not set
> 	CONFIG_BT_RFCOMM=m
> 	CONFIG_BT_RFCOMM_TTY=y
> 	CONFIG_BT_BNEP=m
> 	CONFIG_BT_BNEP_MC_FILTER=y
> 	CONFIG_BT_BNEP_PROTO_FILTER=y
>
> 	#
> 	# Bluetooth device drivers
> 	#
> 	CONFIG_BT_HCIUSB=m
> 	# CONFIG_BT_HCIUSB_SCO is not set
> 	CONFIG_BT_HCIUART=m
> 	CONFIG_BT_HCIUART_H4=y
> 	CONFIG_BT_HCIUART_BCSP=y
> 	CONFIG_BT_HCIUART_BCSP_TXCRC=y
> 	CONFIG_BT_HCIBCM203X=m
> 	CONFIG_BT_HCIBFUSB=m
> 	CONFIG_BT_HCIVHCI=m
>
> 	I've spent three hours searching on google, bluez.org and the list
> archives and i can't find any solution. I'll be very happy is someone can't
> help me. TIA.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
