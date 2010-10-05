Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH] Bluetooth: Support for new firmware for ath3k USB Bluetooth device
Date: Tue, 5 Oct 2010 11:47:16 +0530
Message-ID: <1286259436-25424-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for new ath3k USB Bluetooth device firmare.
The firmware implements shared antenna support and
fixes few critical bugs.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 drivers/bluetooth/ath3k.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 128cae4..eb79a8f 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -103,6 +103,9 @@ error:
 	return err;
 }
 
+#define FW_COUNT	2
+#define FW_PREFIX	"ath3k-"
+#define MAXPATHLEN	30
 static int ath3k_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
@@ -110,6 +113,8 @@ static int ath3k_probe(struct usb_interface *intf,
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct ath3k_data *data;
 	int size;
+	int i;
+	char fw_file[MAXPATHLEN];
 
 	BT_DBG("intf %p id %p", intf, id);
 
@@ -122,7 +127,16 @@ static int ath3k_probe(struct usb_interface *intf,
 
 	data->udev = udev;
 
-	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
+	for (i = FW_COUNT; i > 0; i--) {
+		snprintf(fw_file, MAXPATHLEN - 1, "%s%d.fw", FW_PREFIX, i);
+
+		if (request_firmware(&firmware, fw_file,
+						&udev->dev) >= 0)
+			break;
+
+	}
+
+	if (!i) {
 		kfree(data);
 		return -EIO;
 	}
-- 
1.7.0.4

