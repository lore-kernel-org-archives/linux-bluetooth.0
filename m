Return-Path: <cyrus@holtmann.org>
From: Paul Fertser <fercerpav@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH] ath3k: output firmware filename when request_firmware failed
Date: Sat, 29 Oct 2011 21:52:49 +0400
Message-Id: <1319910769-28518-1-git-send-email-fercerpav@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This makes it much easier for the users to understand why the driver
refuses to load when the firmware is unavailable.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 drivers/bluetooth/ath3k.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index db7cb81..1f04d4c 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -30,6 +30,7 @@
 #include <net/bluetooth/bluetooth.h>
 
 #define VERSION "1.0"
+#define ATH3K_MODULE_FIRMWARE	"ath3k-1.fw"
 
 #define ATH3K_DNLOAD				0x01
 #define ATH3K_GETSTATE				0x05
@@ -400,9 +401,15 @@ static int ath3k_probe(struct usb_interface *intf,
 		return 0;
 	}
 
-	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
-		BT_ERR("Error loading firmware");
-		return -EIO;
+	ret = request_firmware(&firmware, ATH3K_MODULE_FIRMWARE, &udev->dev);
+	if (ret < 0) {
+		if (ret == -ENOENT)
+			BT_ERR("Firmware file \"%s\" not found",
+				ATH3K_MODULE_FIRMWARE);
+		else
+			BT_ERR("Firmware file \"%s\" request failed (err=%d)",
+				ATH3K_MODULE_FIRMWARE, ret);
+		return ret;
 	}
 
 	ret = ath3k_load_firmware(udev, firmware);
@@ -441,4 +448,4 @@ MODULE_AUTHOR("Atheros Communications");
 MODULE_DESCRIPTION("Atheros AR30xx firmware driver");
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE("ath3k-1.fw");
+MODULE_FIRMWARE(ATH3K_MODULE_FIRMWARE);
-- 
1.7.3.4
