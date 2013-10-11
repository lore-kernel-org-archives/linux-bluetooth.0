Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Declare bfusb_table[] as const
Date: Fri, 11 Oct 2013 07:46:19 -0700
Message-Id: <1381502781-42826-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bfusb_table[] device table can be declared as const

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bfusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index cce2304..3138699 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -42,7 +42,7 @@
 
 static struct usb_driver bfusb_driver;
 
-static struct usb_device_id bfusb_table[] = {
+static const struct usb_device_id bfusb_table[] = {
 	/* AVM BlueFRITZ! USB */
 	{ USB_DEVICE(0x057c, 0x2200) },
 
-- 
1.8.3.1

