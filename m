Return-Path: <cyrus@holtmann.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-bluetooth@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] Bluetooth: sort the list of IDs in the source code
Date: Tue, 18 Feb 2014 18:26:19 +0200
Message-Id: <1392740780-27372-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This will help to manage table of supported IDs.

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/ath3k.c | 78 +++++++++++++++++++++++------------------------
 drivers/bluetooth/btusb.c | 52 +++++++++++++++----------------
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 41ec6f9..fc93ade 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -62,52 +62,52 @@ static const struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x0CF3, 0x3000) },
 
 	/* Atheros AR3011 with sflash firmware*/
+	{ USB_DEVICE(0x0489, 0xE027) },
+	{ USB_DEVICE(0x0489, 0xE03D) },
+	{ USB_DEVICE(0x0930, 0x0215) },
 	{ USB_DEVICE(0x0CF3, 0x3002) },
 	{ USB_DEVICE(0x0CF3, 0xE019) },
 	{ USB_DEVICE(0x13d3, 0x3304) },
-	{ USB_DEVICE(0x0930, 0x0215) },
-	{ USB_DEVICE(0x0489, 0xE03D) },
-	{ USB_DEVICE(0x0489, 0xE027) },
 
 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03F0, 0x311D) },
 
 	/* Atheros AR3012 with sflash firmware*/
+	{ USB_DEVICE(0x0489, 0xe04d) },
+	{ USB_DEVICE(0x0489, 0xe04e) },
+	{ USB_DEVICE(0x0489, 0xe057) },
+	{ USB_DEVICE(0x0489, 0xe056) },
+	{ USB_DEVICE(0x0489, 0xe05f) },
+	{ USB_DEVICE(0x04c5, 0x1330) },
+	{ USB_DEVICE(0x04CA, 0x3004) },
+	{ USB_DEVICE(0x04CA, 0x3005) },
+	{ USB_DEVICE(0x04CA, 0x3006) },
+	{ USB_DEVICE(0x04CA, 0x3008) },
+	{ USB_DEVICE(0x04CA, 0x300b) },
+	{ USB_DEVICE(0x0930, 0x0219) },
+	{ USB_DEVICE(0x0930, 0x0220) },
 	{ USB_DEVICE(0x0CF3, 0x0036) },
 	{ USB_DEVICE(0x0CF3, 0x3004) },
 	{ USB_DEVICE(0x0CF3, 0x3008) },
 	{ USB_DEVICE(0x0CF3, 0x311D) },
 	{ USB_DEVICE(0x0CF3, 0x311E) },
 	{ USB_DEVICE(0x0CF3, 0x311F) },
+	{ USB_DEVICE(0x0cf3, 0x3121) },
 	{ USB_DEVICE(0x0CF3, 0x817a) },
-	{ USB_DEVICE(0x13d3, 0x3375) },
-	{ USB_DEVICE(0x04CA, 0x3004) },
-	{ USB_DEVICE(0x04CA, 0x3005) },
-	{ USB_DEVICE(0x04CA, 0x3006) },
-	{ USB_DEVICE(0x04CA, 0x3008) },
-	{ USB_DEVICE(0x04CA, 0x300b) },
-	{ USB_DEVICE(0x13d3, 0x3362) },
+	{ USB_DEVICE(0x0cf3, 0xe003) },
 	{ USB_DEVICE(0x0CF3, 0xE004) },
 	{ USB_DEVICE(0x0CF3, 0xE005) },
-	{ USB_DEVICE(0x0930, 0x0219) },
-	{ USB_DEVICE(0x0930, 0x0220) },
-	{ USB_DEVICE(0x0489, 0xe057) },
+	{ USB_DEVICE(0x13d3, 0x3362) },
+	{ USB_DEVICE(0x13d3, 0x3375) },
 	{ USB_DEVICE(0x13d3, 0x3393) },
-	{ USB_DEVICE(0x0489, 0xe04e) },
-	{ USB_DEVICE(0x0489, 0xe056) },
-	{ USB_DEVICE(0x0489, 0xe04d) },
-	{ USB_DEVICE(0x04c5, 0x1330) },
 	{ USB_DEVICE(0x13d3, 0x3402) },
-	{ USB_DEVICE(0x0cf3, 0x3121) },
-	{ USB_DEVICE(0x0cf3, 0xe003) },
-	{ USB_DEVICE(0x0489, 0xe05f) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
 
 	/* Atheros AR5BBU22 with sflash firmware */
-	{ USB_DEVICE(0x0489, 0xE03C) },
 	{ USB_DEVICE(0x0489, 0xE036) },
+	{ USB_DEVICE(0x0489, 0xE03C) },
 
 	{ }	/* Terminating entry */
 };
@@ -120,38 +120,38 @@ MODULE_DEVICE_TABLE(usb, ath3k_table);
 static const struct usb_device_id ath3k_blist_tbl[] = {
 
 	/* Atheros AR3012 with sflash firmware*/
+	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe05f), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3006), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0CF3, 0x0036), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311D), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311E), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311F), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0CF3, 0x817a), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x3006), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe005), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3393), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3402), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe05f), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU22 with sflash firmware */
-	{ USB_DEVICE(0x0489, 0xE03C), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xE036), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xE03C), .driver_info = BTUSB_ATH3012 },
 
 	{ }	/* Terminating entry */
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e5680fa..46640e9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -101,16 +101,16 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
 	/* Broadcom BCM20702A0 */
+	{ USB_DEVICE(0x0489, 0xe042) },
+	{ USB_DEVICE(0x04ca, 0x2003) },
 	{ USB_DEVICE(0x0b05, 0x17b5) },
 	{ USB_DEVICE(0x0b05, 0x17cb) },
-	{ USB_DEVICE(0x04ca, 0x2003) },
-	{ USB_DEVICE(0x0489, 0xe042) },
 	{ USB_DEVICE(0x413c, 0x8197) },
 
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
 
-	/*Broadcom devices with vendor specific id */
+	/* Broadcom devices with vendor specific id */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) },
 
 	/* Belkin F8065bf - Broadcom based */
@@ -132,57 +132,57 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = BTUSB_IGNORE },
 
 	/* Atheros 3011 with sflash firmware */
+	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
-	{ USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
-	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
-	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
 
 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
 
 	/* Atheros 3012 with sflash firmware */
+	{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe05f), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3006), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311f), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x817a), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x3006), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe005), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3393), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3402), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0489, 0xe05f), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
 
 	/* Atheros AR5BBU12 with sflash firmware */
-	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe036), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* Broadcom BCM2035 */
-	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
+	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_WRONG_SCO_MTU },
 
 	/* Broadcom BCM2045 */
 	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = BTUSB_WRONG_SCO_MTU },
-- 
1.9.0.rc3
