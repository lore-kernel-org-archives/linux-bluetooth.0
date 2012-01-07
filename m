Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 11/18] Bluetooth: bpa10x: Free private driver data on usb shutdown
Date: Sat,  7 Jan 2012 15:47:17 +0100
Message-Id: <1325947644-11736-12-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of waiting for the hci-device to be destroyed we now free the private
driver data on driver shutdown right away. We call hci_unregister_dev() on
driver shutdown, that means, the hci-core will never ever call our callbacks
again except the destruct callback. It also does not access hdev->driver_data so
there is no reason to keep that alive.
We simply set the destruct cb to NULL to avoid getting called again.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bpa10x.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 751b338..92c2424 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -432,17 +432,6 @@ static int bpa10x_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void bpa10x_destruct(struct hci_dev *hdev)
-{
-	struct bpa10x_data *data = hdev->driver_data;
-
-	BT_DBG("%s", hdev->name);
-
-	kfree_skb(data->rx_skb[0]);
-	kfree_skb(data->rx_skb[1]);
-	kfree(data);
-}
-
 static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct bpa10x_data *data;
@@ -480,7 +469,6 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 	hdev->close    = bpa10x_close;
 	hdev->flush    = bpa10x_flush;
 	hdev->send     = bpa10x_send_frame;
-	hdev->destruct = bpa10x_destruct;
 
 	hdev->owner = THIS_MODULE;
 
@@ -512,6 +500,9 @@ static void bpa10x_disconnect(struct usb_interface *intf)
 	hci_unregister_dev(data->hdev);
 
 	hci_free_dev(data->hdev);
+	kfree_skb(data->rx_skb[0]);
+	kfree_skb(data->rx_skb[1]);
+	kfree(data);
 }
 
 static struct usb_driver bpa10x_driver = {
-- 
1.7.8.1
