Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: bfusb: Fix error path on firmware load
Date: Wed, 26 Oct 2011 11:22:46 +0200
Message-Id: <1319620966-11193-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

When loading the usb-configuration we do not signal the end of configuration on
memory allocation error. This patch moves the memory allocation to the top so
every error path uses "goto error" now to correctly send the usb-ctrl message
when detecting some error.

This also replaces GFP_ATOMIC with GFP_KERNEL as we are allowed to sleep here.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bfusb.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 6580d50..a936763 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -568,22 +568,23 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 
 	BT_INFO("BlueFRITZ! USB loading firmware");
 
+	buf = kmalloc(BFUSB_MAX_BLOCK_SIZE + 3, GFP_KERNEL);
+	if (!buf) {
+		BT_ERR("Can't allocate memory chunk for firmware");
+		return -ENOMEM;
+	}
+
 	pipe = usb_sndctrlpipe(data->udev, 0);
 
 	if (usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
 				0, 1, 0, NULL, 0, USB_CTRL_SET_TIMEOUT) < 0) {
 		BT_ERR("Can't change to loading configuration");
+		kfree(buf);
 		return -EBUSY;
 	}
 
 	data->udev->toggle[0] = data->udev->toggle[1] = 0;
 
-	buf = kmalloc(BFUSB_MAX_BLOCK_SIZE + 3, GFP_ATOMIC);
-	if (!buf) {
-		BT_ERR("Can't allocate memory chunk for firmware");
-		return -ENOMEM;
-	}
-
 	pipe = usb_sndbulkpipe(data->udev, data->bulk_out_ep);
 
 	while (count) {
-- 
1.7.7.1
