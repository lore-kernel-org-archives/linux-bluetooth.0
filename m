Return-Path: <cyrus@holtmann.org>
Message-ID: <530FB0CA.4070309@gmail.com>
Date: Thu, 27 Feb 2014 22:40:26 +0100
From: Bela Hausmann <bela.hausmann@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: ath3k: added Atheros AR3012 with ID 0x0b05:0x17d0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for the Atheros AR3012 chipset on the ASUS Z87-Pro (C2) mainboard (ID 0x0b05:0x17d0).

Signed-off-by: Bela Hausmann <bela.hausmann@gmail.com>
---
diff -uprN -X linux-3.13.5-gentoo/Documentation/dontdiff linux-3.13.5-gentoo/drivers/bluetooth/ath3k.c linux-3.13.5-gentoo-bela/drivers/bluetooth/ath3k.c
--- linux-3.13.5-gentoo/drivers/bluetooth/ath3k.c    2014-01-20 03:40:07.000000000 +0100
+++ linux-3.13.5-gentoo-bela/drivers/bluetooth/ath3k.c    2014-02-27 20:09:33.047878117 +0100
@@ -97,6 +97,7 @@ static const struct usb_device_id ath3k_
     { USB_DEVICE(0x13d3, 0x3402) },
     { USB_DEVICE(0x0cf3, 0x3121) },
     { USB_DEVICE(0x0cf3, 0xe003) },
+    { USB_DEVICE(0x0b05, 0x17d0) },

     /* Atheros AR5BBU12 with sflash firmware */
     { USB_DEVICE(0x0489, 0xE02C) },
@@ -140,6 +141,7 @@ static const struct usb_device_id ath3k_
     { USB_DEVICE(0x13d3, 0x3402), .driver_info = BTUSB_ATH3012 },
     { USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
     { USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
+    { USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },

     /* Atheros AR5BBU22 with sflash firmware */
     { USB_DEVICE(0x0489, 0xE03C), .driver_info = BTUSB_ATH3012 },
diff -uprN -X linux-3.13.5-gentoo/Documentation/dontdiff linux-3.13.5-gentoo/drivers/bluetooth/btusb.c linux-3.13.5-gentoo-bela/drivers/bluetooth/btusb.c
--- linux-3.13.5-gentoo/drivers/bluetooth/btusb.c    2014-01-20 03:40:07.000000000 +0100
+++ linux-3.13.5-gentoo-bela/drivers/bluetooth/btusb.c    2014-02-27 20:10:20.825905643 +0100
@@ -164,6 +164,7 @@ static const struct usb_device_id blackl
     { USB_DEVICE(0x13d3, 0x3402), .driver_info = BTUSB_ATH3012 },
     { USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
     { USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
+    { USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },

     /* Atheros AR5BBU12 with sflash firmware */
     { USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
