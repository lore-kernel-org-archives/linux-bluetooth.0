Return-Path: <cyrus@holtmann.org>
From: Alistair Buxton <a.j.buxton@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org, Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH] Bluetooth: Add Lite-On Technology Corp [04ca:3002] as AR3011.
Date: Thu,  2 May 2013 16:15:55 +0100
Message-Id: <1367507755-25021-1-git-send-email-a.j.buxton@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A user reported this device not working. After looking at the related IDs
I took a shot in the dark, and the user reports it works with this patch.

The device is in an Asus K53U with internal bluetooth and ath9k wireless.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
---
 drivers/bluetooth/ath3k.c | 1 +
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 6aab00e..817586f 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -65,6 +65,7 @@ static struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x0CF3, 0x3002) },
 	{ USB_DEVICE(0x0CF3, 0xE019) },
 	{ USB_DEVICE(0x13d3, 0x3304) },
+	{ USB_DEVICE(0x04ca, 0x3002) },
 	{ USB_DEVICE(0x0930, 0x0215) },
 	{ USB_DEVICE(0x0489, 0xE03D) },
 	{ USB_DEVICE(0x0489, 0xE027) },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2cc5f77..2adb4d1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -123,6 +123,7 @@ static struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x04ca, 0x3002), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
-- 
1.8.1.2

