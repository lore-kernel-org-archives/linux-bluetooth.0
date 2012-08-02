Return-Path: <cyrus@holtmann.org>
From: Mohammed Shafi Shajakhan <mohammed@qca.qualcomm.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <gustavo@padovan.org>, Yevgeniy
 Melnichuk <yevgeniy.melnichuk@googlemail.com>, Mohammed Shafi Shajakhan
	<mohammed@qca.qualcomm.com>
Subject: [PATCH] Bluetooth: Add support for Sony Vaio T-Series
Date: Thu, 2 Aug 2012 16:49:21 +0530
Message-ID: <1343906361-2747-1-git-send-email-mohammed@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Yevgeniy Melnichuk <yevgeniy.melnichuk@googlemail.com>

Add Sony Vaio T-Series Bluetooth Module( 0x489:0xE036) to
the blacklist of btusb module and add it to the ath3k module.

Signed-off-by: Yevgeniy Melnichuk <yevgeniy.melnichuk@googlemail.com>
Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qca.qualcomm.com>
---
 drivers/bluetooth/ath3k.c |    2 ++
 drivers/bluetooth/btusb.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 10308cd..d1eecc3 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -85,6 +85,7 @@ static struct usb_device_id ath3k_table[] = {
 
 	/* Atheros AR5BBU22 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE03C) },
+	{ USB_DEVICE(0x0489, 0xE036) },
 
 	{ }	/* Terminating entry */
 };
@@ -107,6 +108,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
 
 	/* Atheros AR5BBU22 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE03C), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xE036), .driver_info = BTUSB_ATH3012 },
 
 	{ }	/* Terminating entry */
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e272214..1c505ee 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -139,6 +139,7 @@ static struct usb_device_id blacklist_table[] = {
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe036), .driver_info = BTUSB_ATH3012 },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_WRONG_SCO_MTU },
-- 
1.7.0.4
