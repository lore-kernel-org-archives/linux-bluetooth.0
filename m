Return-Path: <cyrus@holtmann.org>
From: "Cho, Yu-Chen" <acho@suse.com>
To: marcel@holtmann.org,
	padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
Cc: oneukum@suse.com,
	acho@suse.com,
	jlee@suse.com
Subject: Add Atheros maryann PIDVID support.
Date: Wed, 15 Feb 2012 17:44:21 +0800
Message-Id: <ef5cb1fa66b3deee2c51b0a85b681c0ecfafebe2.1329298278.git.acho@suse.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Cho, Yu-Chen" <acho@suse.com>

Add Atheros maryann 0cf3:311D PIDVID support.
This module is AR3012 Series.

Signed-off-by: Cho, Yu-Chen <acho@suse.com>
---
 drivers/bluetooth/ath3k.c |    2 ++
 drivers/bluetooth/btusb.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 07f14d1..be21d47 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -71,6 +71,7 @@ static struct usb_device_id ath3k_table[] = {
 
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0CF3, 0x3004) },
+	{ USB_DEVICE(0x0CF3, 0x311D) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -87,6 +88,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
 
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x311D), .driver_info = BTUSB_ATH3012 },
 
 	{ }	/* Terminating entry */
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f00f596..226b157 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -126,6 +126,7 @@ static struct usb_device_id blacklist_table[] = {
 
 	/* Atheros 3012 with sflash firmware */
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
-- 
1.7.7
