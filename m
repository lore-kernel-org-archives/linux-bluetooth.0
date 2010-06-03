Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] ath3k: add support for new firmware
From: Vikram <vkandukuri@atheros.com>
To: <linux-bluetooth@vger.kernel.org>, <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 3 Jun 2010 16:50:23 +0530
Message-ID: <1275564023.19511.31.camel@ATH-LT-538>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

updated new firmware has few critical bug fixes and shared antenna
support.

Signed-off-by: Vikram Kandukuri <vkandukuri@atheros.com>
---
 drivers/bluetooth/ath3k.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 128cae4..7bda549 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -122,9 +122,12 @@ static int ath3k_probe(struct usb_interface *intf,
 
 	data->udev = udev;
 
-	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
-		kfree(data);
-		return -EIO;
+	if (request_firmware(&firmware, "ath3k-2.fw", &udev->dev) < 0) {
+		BT_DBG("requesting old firmware");
+		if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
+			kfree(data);
+			return -EIO;
+		}
 	}
 
 	size = max_t(uint, firmware->size, 4096);
-- 
1.7.0
