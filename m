Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Consolidate Broadcom based device entries
Date: Fri, 27 Mar 2015 15:11:41 -0700
Message-Id: <1427494301-13702-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For all modern Bluetooth USB devices from Broadcom it makes a lot more
sense to use USB_VENDOR_AND_INTERFACE_INFO instead of manually adding
USB_DEVICE for each one of them. There are already interface entries
for these vendors and so just remove the duplicate device entries.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9bf4d6ae6c6b..6e4ff16e487b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -111,13 +111,7 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
 	/* Broadcom BCM20702A0 */
-	{ USB_DEVICE(0x0489, 0xe042) },
-	{ USB_DEVICE(0x04ca, 0x2003) },
-	{ USB_DEVICE(0x0b05, 0x17b5) },
-	{ USB_DEVICE(0x0b05, 0x17cb) },
 	{ USB_DEVICE(0x413c, 0x8197) },
-	{ USB_DEVICE(0x13d3, 0x3404),
-	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Broadcom BCM20702B0 (Dynex/Insignia) */
 	{ USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
@@ -139,10 +133,12 @@ static const struct usb_device_id btusb_table[] = {
 	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Belkin F8065bf - Broadcom based */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* IMC Networks - Broadcom based */
-	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Intel Bluetooth USB Bootloader (RAM module) */
 	{ USB_DEVICE(0x8087, 0x0a5a),
-- 
2.1.0

