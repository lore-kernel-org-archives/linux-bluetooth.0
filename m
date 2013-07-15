Return-Path: <cyrus@holtmann.org>
From: Sujith Manoharan <sujith@msujith.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH] ath3k: Add support for ID 0x13d3/0x3402
Date: Mon, 15 Jul 2013 09:53:46 +0530
Message-Id: <1373862226-9658-1-git-send-email-sujith@msujith.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=59701

Signed-off-by: Sujith Manoharan <sujith@msujith.org>
---
 drivers/bluetooth/ath3k.c | 2 ++
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 6f17e4d..81973ec 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -92,6 +92,7 @@ static struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x0489, 0xe056) },
 	{ USB_DEVICE(0x0489, 0xe04d) },
 	{ USB_DEVICE(0x04c5, 0x1330) },
+	{ USB_DEVICE(0x13d3, 0x3402) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -130,6 +131,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3402), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU22 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE03C), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ad03394..c4145c7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -152,6 +152,7 @@ static struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3402), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
-- 
1.8.3.2

