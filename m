Return-Path: <cyrus@holtmann.org>
From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH resend 1/5] Bluetooth: Add BTUSB_BCM_PATCHRAM to Broadcom devices 13d3:*
Date: Wed, 21 Jan 2015 15:59:52 +0800
Message-Id: <1421827196-25277-1-git-send-email-jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is known that at least 13d3:3388, 13d3:3389, and 13d3:3404 require
external firmwares to work properly. Since the firmware loading
procedure is skipped if there's no firmware file provided, it is safe to
set BTUSB_BCM_PATCHRAM for 13d3:* instead of adding each module one by
one.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 19cf2cf..fd3ac5b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -106,8 +106,6 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0b05, 0x17b5) },
 	{ USB_DEVICE(0x0b05, 0x17cb) },
 	{ USB_DEVICE(0x413c, 0x8197) },
-	{ USB_DEVICE(0x13d3, 0x3404),
-	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
@@ -124,7 +122,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01) },
 
 	/* IMC Networks - Broadcom based */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Intel Bluetooth USB Bootloader (RAM module) */
 	{ USB_DEVICE(0x8087, 0x0a5a),
-- 
2.1.0

