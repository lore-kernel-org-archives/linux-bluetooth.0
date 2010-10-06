Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v2] Bluetooth: Latest firmware support for ath3k USB device
Date: Wed, 6 Oct 2010 14:01:36 +0530
Message-ID: <1286353896-8811-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for latest ath3k USB Bluetooth device firmare.
The firmware implements shared antenna support and
fixes few critical bugs.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 drivers/bluetooth/ath3k.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 128cae4..6eb4bcf 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -103,6 +103,8 @@ error:
 	return err;
 }
 
+#define ATH3K_FW	"ath3k-fw.fw"
+#define ATH3K_FW_LEGACY	"ath3k-1.fw"
 static int ath3k_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
@@ -122,9 +124,12 @@ static int ath3k_probe(struct usb_interface *intf,
 
 	data->udev = udev;
 
-	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
-		kfree(data);
-		return -EIO;
+	if (request_firmware(&firmware, ATH3K_FW, &udev->dev) < 0) {
+		if (request_firmware(&firmware, ATH3K_FW_LEGACY,
+							&udev->dev) < 0) {
+			kfree(data);
+			return -EIO;
+		}
 	}
 
 	size = max_t(uint, firmware->size, 4096);
-- 
1.7.0.4

