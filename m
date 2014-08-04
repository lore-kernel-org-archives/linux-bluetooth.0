Return-Path: <cyrus@holtmann.org>
From: Vincent Elger Zwanenburg <vincentezw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] drivers/bluetooth/: Toshiba Qualcomm AR9565 (ath3k) bluetooth fix for C55-B-138 notebooks
Date: Tue, 05 Aug 2014 00:31:36 +0100
Message-ID: <1721217.JWeHGVIyOq@venture>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From:  Vincent Elger Zwanenburg <vincentz@topmail.ie>
Date:   Tue Aug 5 01:34:27 2014 +0100

Assign the BTUSB_ATH3012 driver to the Toshiba USB Vendor ID and Product ID combination in btusb.c and ath3k.c.

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

