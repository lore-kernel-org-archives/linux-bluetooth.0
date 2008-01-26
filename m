Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201002028.7978.159.camel@aeonflux>
References: <1200991632.7006.20.camel@localhost>
	<1201002028.7978.159.camel@aeonflux>
Content-Type: multipart/mixed; boundary="=-OUBJBSvMZdXnIR6xuoV1"
Date: Sat, 26 Jan 2008 11:42:41 +0100
Message-Id: <1201344161.7769.28.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Asus WL-BTD202 needs force_scofix
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-OUBJBSvMZdXnIR6xuoV1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Le mardi 22 janvier 2008 à 12:40 +0100, Marcel Holtmann a écrit :
> Hi Guillaume,
> 
> > I'm currently testing bluetooth audio with latest cvs.
> > 
> > I use this dongle and a mono headset (PROF PBH-6W) :
> > $ /usr/sbin/lsusb | grep ASUS
> > Bus 001 Device 002: ID 0b05:1715 ASUSTek Computer, Inc. 
> > 
> > Apparently, it only works with this option set hci_usb :
> > options hci_usb force_scofix=1
> > 
> > Recording and playback work, mostly.
> > Sometimes noise is produced, retrying once or twice make it work...
> > 
> > Could this option be set as a default in hci_usb.c, or could it have
> > some drawback I'm not aware of ?
> 
> include the content of /proc/bus/usb/devices for this dongle
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0b05 ProdID=1715 Rev= 1.00
S:  Manufacturer=Broadcom Corp
S:  Product=WL-BTD202
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:* If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)


>  and create
> a kernel patch for hci_usb to always enable the SCO fix.

It is the joined file (it remains to test though).

What's the use of usb_device_id blacklist_ids[] ?

Best regards,

Guillaume B.

--=-OUBJBSvMZdXnIR6xuoV1
Content-Disposition: attachment;
	filename=hci_usb.c-automatically-set-scofix-for-wl-btd202.patch
Content-Type: text/x-patch;
	name=hci_usb.c-automatically-set-scofix-for-wl-btd202.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

--- drivers/bluetooth/hci_usb.c.orig	2008-01-26 11:33:36.000000000 +0100
+++ drivers/bluetooth/hci_usb.c	2008-01-26 11:36:43.000000000 +0100
@@ -98,6 +98,9 @@
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = HCI_RESET },
 
+	/* ASUS WL-BTD202 */
+	{ USB_DEVICE(0x0b05, 0x1715), .driver_info = HCI_WRONG_SCO_MTU },
+
 	{ }	/* Terminating entry */
 };
 

--=-OUBJBSvMZdXnIR6xuoV1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-OUBJBSvMZdXnIR6xuoV1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-OUBJBSvMZdXnIR6xuoV1--
