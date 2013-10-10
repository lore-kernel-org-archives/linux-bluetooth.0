Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Remove unused bfusb_ioctl() callback
Date: Thu, 10 Oct 2013 10:50:00 -0700
Message-Id: <1381427406-26472-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bfusb_ioctl() function is not used and thus remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bfusb.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 995aee9..66faad0 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -544,11 +544,6 @@ static int bfusb_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static int bfusb_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
-{
-	return -ENOIOCTLCMD;
-}
-
 static int bfusb_load_firmware(struct bfusb_data *data,
 			       const unsigned char *firmware, int count)
 {
@@ -699,11 +694,10 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	hci_set_drvdata(hdev, data);
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
-	hdev->open     = bfusb_open;
-	hdev->close    = bfusb_close;
-	hdev->flush    = bfusb_flush;
-	hdev->send     = bfusb_send_frame;
-	hdev->ioctl    = bfusb_ioctl;
+	hdev->open  = bfusb_open;
+	hdev->close = bfusb_close;
+	hdev->flush = bfusb_flush;
+	hdev->send  = bfusb_send_frame;
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
-- 
1.8.3.1

