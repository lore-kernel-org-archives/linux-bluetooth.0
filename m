Return-Path: <cyrus@holtmann.org>
From: Vincent Elger Zwanenburg <vincentezw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] drivers/bluetooth/: Toshiba Qualcomm AR9565 (ath3k) bluetooth fix for c55-b-138 notebooks
Date: Thu, 07 Aug 2014 18:28:42 +0100
Message-ID: <2205962.RYjnk7AA7X@venture>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From:  Vincent Elger Zwanenburg <vincentz@topmail.ie>
Date:   Tue Aug 7 18:20:27 2014 +0100

Bluetooth: Add a new PID/VID 0227/0930 for AR3012.

usb devices info:

T:  Bus=01 Lev=02 Prnt=05 Port=00 Cnt=01 Dev#= 20 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0930 ProdID=0227 Rev= 0.02
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Vincent Elger Zwanenburg <vincentz@topmail.ie>
---
diff -uprN -X linux-3.16-vanilla/Documentation/dontdiff linux-3.16-vanilla/drivers/bluetooth/ath3k.c /usr/src/linux-3.16/drivers/bluetooth/ath3k.c
--- linux-3.16-vanilla/drivers/bluetooth/ath3k.c	2014-08-03 23:25:02.000000000 +0100
+++ /usr/src/linux-3.16/drivers/bluetooth/ath3k.c	2014-08-05 00:29:29.428745755 +0100
@@ -87,6 +87,7 @@ static const struct usb_device_id ath3k_
 	{ USB_DEVICE(0x04CA, 0x300b) },
 	{ USB_DEVICE(0x0930, 0x0219) },
 	{ USB_DEVICE(0x0930, 0x0220) },
+	{ USB_DEVICE(0x0930, 0x0227) },
 	{ USB_DEVICE(0x0b05, 0x17d0) },
 	{ USB_DEVICE(0x0CF3, 0x0036) },
 	{ USB_DEVICE(0x0CF3, 0x3004) },
@@ -136,6 +137,7 @@ static const struct usb_device_id ath3k_
 	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0CF3, 0x0036), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
diff -uprN -X linux-3.16-vanilla/Documentation/dontdiff linux-3.16-vanilla/drivers/bluetooth/btusb.c /usr/src/linux-3.16/drivers/bluetooth/btusb.c
--- linux-3.16-vanilla/drivers/bluetooth/btusb.c	2014-08-03 23:25:02.000000000 +0100
+++ /usr/src/linux-3.16/drivers/bluetooth/btusb.c	2014-08-05 00:27:43.394078791 +0100
@@ -159,6 +159,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },

