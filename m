Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Mar 2009 15:46:21 -0800
From: Derek Chan <dwc+lkml@OCF.Berkeley.EDU>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: maxk@qualcomm.com, linux-bluetooth@vger.kernel.org
Subject: Re: another "blacklist" device for hci_usb
Message-ID: <20090304234621.GC3004@OCF.Berkeley.EDU>
References: <20090226091707.GG9042@OCF.Berkeley.EDU> <1235857191.6074.39.camel@localhost.localdomain> <20090304075902.GB3004@OCF.Berkeley.EDU> <1236200455.6670.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
In-Reply-To: <1236200455.6670.9.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2009 at 10:00:55PM +0100, Marcel Holtmann wrote:
> Hi Derek,
> 
> > >> I've got a USB bluetooth adapter that needed some of those handy module
> > >> params to get SCO working.
> > >>
> > >> Bus 001 Device 004: ID 0a5c:2121 Broadcom Corp. BCM2210 Bluetooth
> > 
> > > send "hciconfig -a" before and after your patch. You have to prove to me
> > > that you really need this patch.
> > 
> > Before: (2.6.26-1-686, no options for hci_usb)
> > hci0:   Type: USB
> >         BD Address: 00:50:B6:80:76:1A ACL MTU: 1017:8 SCO MTU: 64:0
> >         UP RUNNING PSCAN 
> >         RX bytes:939 acl:0 sco:0 events:23 errors:0
> >         TX bytes:342 acl:0 sco:0 commands:23 errors:0
> >         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> >         Link policy: RSWITCH HOLD SNIFF PARK 
> >         Link mode: SLAVE ACCEPT 
> >         Name: 'server-0'
> >         Class: 0x080100
> >         Service Classes: Capturing
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 2.0 (0x3) HCI Rev: 0x4118 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
> >         Manufacturer: Broadcom Corporation (15)
> > 
> > After: (2.6.26-1-686, options hci_usb reset=1 force_scofix=1)
> > hci0:   Type: USB
> >         BD Address: 00:50:B6:80:76:1A ACL MTU: 1017:8 SCO MTU: 64:8
> >         UP RUNNING PSCAN 
> >         RX bytes:1511 acl:0 sco:0 events:31 errors:0
> >         TX bytes:366 acl:0 sco:0 commands:31 errors:0
> >         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> >         Link policy: RSWITCH HOLD SNIFF PARK 
> >         Link mode: SLAVE ACCEPT 
> >         Name: 'server-0'
> >         Class: 0x080100
> >         Service Classes: Capturing
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 2.0 (0x3) HCI Rev: 0x4118 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
> >         Manufacturer: Broadcom Corporation (15)
> > 
> > > Also please post a patch against btusb.c since hci_usb.c has been
> > > removed.
> > 
> > I didn't actually patch hci_usb.  Since the options were there, it was
> > easier to use them.  As requested, I've gone back through gitweb to pull
> > this file to patch.  See attached.
> 
> please post the content of /proc/bus/usb/devices for that dongle and

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=2121 Rev= 1.00
S:  Manufacturer=Broadcom Corp
S:  Product=BCM92045B3 ROM
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

> also please send patches against bluetooth-next-2.6 or net-next-2.6
> trees.

 - Derek

-- 
Be the change you want to see in the world
        -- Mahatma Gandhi

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="btusb2.patch"

--- btusb.c.orig	2009-03-04 15:43:21.769731000 -0800
+++ btusb.c	2009-03-04 15:44:29.737532000 -0800
@@ -96,6 +96,9 @@
 	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = BTUSB_WRONG_SCO_MTU },
 
+	/* Broadcom BCM2210 */
+	{ USB_DEVICE(0x0a5c, 0x2121), .driver_info = BTUSB_WRONG_SCO_MTU },
+
 	/* IBM/Lenovo ThinkPad with Broadcom chip */
 	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = BTUSB_WRONG_SCO_MTU },

--MW5yreqqjyrRcusr--
