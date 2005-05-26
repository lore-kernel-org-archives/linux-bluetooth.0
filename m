Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Early failures with Treo 650
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <429553F1.7020604@gmail.com>
References: <428EDFCA.5070702@gmail.com> <1116842776.30044.33.camel@pegasus>
	 <4292938B.2090000@gmail.com> <1116924491.30044.131.camel@pegasus>
	 <429553F1.7020604@gmail.com>
Content-Type: multipart/mixed; boundary="=-E3jG5bbeGy+vUxs9FFAZ"
Message-Id: <1117095364.12036.14.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 26 May 2005 10:16:04 +0200


--=-E3jG5bbeGy+vUxs9FFAZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi David,

> > what kind of USB dongle is this?
> 
> The USB dongle is a "Kensington Bluetooth USB Adapter".

be a little bit more specific.

> > Show us the content of /proc/bus/usb/devices.
> 
> red:~# cat /proc/bus/usb/devices
> 
> T:  Bus=03 Lev=02 Prnt=06 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=047d ProdID=105d Rev= 0.06
> S:  Manufacturer=Broadcom
> S:  Product=BCM92035DG
> S:  SerialNumber=000C55F85A2B
> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

So here we go. You can first try to load the hci_usb module with the
reset=1 parameter, but I doubt that it helps for this dongle. What you
need will be the attached patch to switch it from HID into HCI mode.

Regards

Marcel


--=-E3jG5bbeGy+vUxs9FFAZ
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: drivers/bluetooth/hci_usb.c
===================================================================
--- 4f435951a76bee847f0b9835a4374ce1a8531619/drivers/bluetooth/hci_usb.c  (mode:100644)
+++ uncommitted/drivers/bluetooth/hci_usb.c  (mode:100644)
@@ -107,6 +107,9 @@
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_BCM92035 },
 
+	/* Kensington Bluetooth USB adapter */
+	{ USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_BCM92035 },
+
 	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
 	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET },
 

--=-E3jG5bbeGy+vUxs9FFAZ--



-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
