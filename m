Return-Path: <cyrus@holtmann.org>
Sender: Al Cho <alcho.novell@gmail.com>
From: "Cho, Yu-Chen" <acho@novell.com>
To: marcel@holtmann.org,
	padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: acho@novell.com,
	jlee@novell.com
Subject: [PATCH] add Atheros BT AR9285 fw supported
Date: Wed, 26 Jan 2011 17:10:59 +0800
Message-Id: <edc8dae4f78c3c93397e1bd34a7e2337c4aaeb88.1296032839.git.acho@novell.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add the btusb.c blacklist [03f0:311d] for Atheros AR9285 Malbec BT
and add to ath3k.c ath3-1.fw (md5:1211fa34c09e10ba48381586b7c3883d)
supported this device.

Signed-off-by: Cho, Yu-Chen <acho@novell.com>
---
 drivers/bluetooth/ath3k.c |    2 ++
 drivers/bluetooth/btusb.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 949ed09..5b494b8 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -39,6 +39,8 @@ static struct usb_device_id ath3k_table[] = {
 	/* Atheros AR3011 with sflash firmware*/
 	{ USB_DEVICE(0x0CF3, 0x3002) },
 
+	/* Atheros AR9285 Malbec with sflash firmware */
+	{ USB_DEVICE(0x03F0, 0x311D) },
 	{ }	/* Terminating entry */
 };
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1da773f..4cefa91 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -102,6 +102,9 @@ static struct usb_device_id blacklist_table[] = {
 	/* Atheros 3011 with sflash firmware */
 	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
 
+	/* Atheros AR9285 Malbec with sflash firmware */
+	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
+
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
-- 
1.7.1
