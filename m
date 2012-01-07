Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 09/18] Bluetooth: bfusb: Free driver_data on USB shutdown
Date: Sat,  7 Jan 2012 15:47:15 +0100
Message-Id: <1325947644-11736-10-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This frees the private driver data on USB shutdown instead of using the
hci-destruct callback. We already call usb_set_intfdata(intf, NULL) but we do
not do the same with the hci object. This would be totally safe, though.

After calling hci_unregister_dev()/hci_free_dev() the hdev object will never
call any callback of us again except the destruct callback. Therefore, we can
safely set the destruct callback to NULL and free the driver data right away.
This allows to unload the module without waiting for the hdev device to be
released.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bfusb.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index a936763..857a951 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -544,15 +544,6 @@ static int bfusb_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void bfusb_destruct(struct hci_dev *hdev)
-{
-	struct bfusb_data *data = hdev->driver_data;
-
-	BT_DBG("hdev %p bfusb %p", hdev, data);
-
-	kfree(data);
-}
-
 static int bfusb_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -712,7 +703,6 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	hdev->close    = bfusb_close;
 	hdev->flush    = bfusb_flush;
 	hdev->send     = bfusb_send_frame;
-	hdev->destruct = bfusb_destruct;
 	hdev->ioctl    = bfusb_ioctl;
 
 	hdev->owner = THIS_MODULE;
@@ -753,6 +743,7 @@ static void bfusb_disconnect(struct usb_interface *intf)
 
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
+	kfree(data);
 }
 
 static struct usb_driver bfusb_driver = {
-- 
1.7.8.1
