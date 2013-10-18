Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 17:35:36 +0200
From: Robin Kreis <r.kreis@uni-bremen.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ath3k: add support for 0930:021c
Message-ID: <20131018173536.6f17d7a7@sat>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed for my Toshiba C850-1K0 (AR9462 chip) to discover any
Bluetooth devices.

---
 drivers/bluetooth/ath3k.c | 2 ++
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 0a327f4..23b813a 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -87,6 +87,7 @@ static struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x0CF3, 0xE004) },
 	{ USB_DEVICE(0x0CF3, 0xE005) },
 	{ USB_DEVICE(0x0930, 0x0219) },
+	{ USB_DEVICE(0x0930, 0x021c) },
 	{ USB_DEVICE(0x0489, 0xe057) },
 	{ USB_DEVICE(0x13d3, 0x3393) },
 	{ USB_DEVICE(0x0489, 0xe04e) },
@@ -129,6 +130,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe005), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x021c), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3393), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f3dfc0a..92fe3c00 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -154,6 +154,7 @@ static struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe005), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0930, 0x021c), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3393), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
-- 
1.8.4.1
