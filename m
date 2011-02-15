Return-Path: <cyrus@holtmann.org>
Sender: Al Cho <alcho.novell@gmail.com>
From: "Cho, Yu-Chen" <acho@novell.com>
To: marcel@holtmann.org,
	padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: acho@novell.com,
	jlee@novell.com
Subject: [PATCH] Add Atheros BT AR5BBU12 fw supported
Date: Tue, 15 Feb 2011 09:58:54 +0800
Message-Id: <ce34a9f1d05bc28c97d7de0c2a99225f56b11953.1297735066.git.acho@novell.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add the btusb.c blacklist [0489:e02c] for Atheros AR5BBU12 BT
and add to ath3k.c supported this device.

Signed-off-by: Cho, Yu-Chen <acho@novell.com>
---
 drivers/bluetooth/ath3k.c |    4 ++++
 drivers/bluetooth/btusb.c |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 333c212..d4065c0 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -41,6 +41,10 @@ static struct usb_device_id ath3k_table[] = {
 
 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03F0, 0x311D) },
+
+	/* Atheros AR5BBU12 with sflash firmware */
+	{ USB_DEVICE(0x0489, 0xE02C) },
+
 	{ }	/* Terminating entry */
 };
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4cefa91..0ae22fd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -105,6 +105,9 @@ static struct usb_device_id blacklist_table[] = {
 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
 
+	/* Atheros AR5BBU12 with sflash firmware */
+	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
+
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
-- 
1.7.1
