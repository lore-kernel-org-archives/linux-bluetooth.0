Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] siemens lifebook 6120
From: Marcel Holtmann <marcel@holtmann.org>
To: Gabor Halaszvari <fire@3hacker.hu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200309142035.30749.fire@3hacker.hu>
References: <200309132053.40178.fire@3hacker.hu>
	<1063546262.28890.467.camel@pegasus>  <200309142035.30749.fire@3hacker.hu>
Content-Type: multipart/mixed; boundary="=-UO2yWL8xfeDbtqa+O2mX"
Message-Id: <1064253356.5641.123.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 22 Sep 2003 19:55:50 +0200


--=-UO2yWL8xfeDbtqa+O2mX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Gabor,

> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=044e ProdID=3001 Rev= 3.36
> S:  Manufacturer=ALPS
> S:  Product=USB BT
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=250mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

the problem is, that the USB Bluetooth class is not set correctly. Try
this patch. How old is your notebook?

Regards

Marcel


--=-UO2yWL8xfeDbtqa+O2mX
Content-Disposition: attachment; filename=patch-hci-usb-alps-fix
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch-hci-usb-alps-fix; charset=ISO-8859-15

diff -urN linux-2.4.22/drivers/bluetooth/hci_usb.c linux-2.4.22-mh/drivers/=
bluetooth/hci_usb.c
--- linux-2.4.22/drivers/bluetooth/hci_usb.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.22-mh/drivers/bluetooth/hci_usb.c	Mon Sep 22 19:53:05 2003
@@ -76,6 +76,9 @@
 	/* Ericsson with non-standard id */
 	{ USB_DEVICE(0x0bdb, 0x1002) },
=20
+	/* ALPS Module with non-standard id */
+	{ USB_DEVICE(0x044e, 0x3002) },
+
 	/* Bluetooth Ultraport Module from IBM */
 	{ USB_DEVICE(0x04bf, 0x030a) },
=20

--=-UO2yWL8xfeDbtqa+O2mX--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
