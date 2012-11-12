Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Convert BCM92035 support  to driver setup callback
Date: Mon, 12 Nov 2012 14:02:15 +0900
Message-Id: <1352696536-13937-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the early init stage during setup, this quirk can be simplified
and kept fully inside the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index debda27..5b43b0d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -234,6 +234,7 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *isoc_rx_ep;
 
 	__u8 cmdreq_type;
+	unsigned long driver_info;
 
 	unsigned int sco_num;
 	int isoc_altsetting;
@@ -687,6 +688,20 @@ static int btusb_flush(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btusb_setup(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	BT_DBG("%s", hdev->name);
+
+	if (data->driver_info & BTUSB_BCM92035) {
+		__u8 val = 0x00;
+		hci_send_cmd(hdev, 0xfc3b, 1, &val);
+	}
+
+	return 0;
+}
+
 static int btusb_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
@@ -984,6 +999,7 @@ static int btusb_probe(struct usb_interface *intf,
 		return -ENODEV;
 
 	data->cmdreq_type = USB_TYPE_CLASS;
+	data->driver_info = id->driver_info;
 
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
@@ -1014,6 +1030,7 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->open     = btusb_open;
 	hdev->close    = btusb_close;
 	hdev->flush    = btusb_flush;
+	hdev->setup    = btusb_setup;
 	hdev->send     = btusb_send_frame;
 	hdev->notify   = btusb_notify;
 
@@ -1054,17 +1071,6 @@ static int btusb_probe(struct usb_interface *intf,
 		data->isoc = NULL;
 	}
 
-	if (id->driver_info & BTUSB_BCM92035) {
-		unsigned char cmd[] = { 0x3b, 0xfc, 0x01, 0x00 };
-		struct sk_buff *skb;
-
-		skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
-		if (skb) {
-			memcpy(skb_put(skb, sizeof(cmd)), cmd, sizeof(cmd));
-			skb_queue_tail(&hdev->driver_init, skb);
-		}
-	}
-
 	if (data->isoc) {
 		err = usb_driver_claim_interface(&btusb_driver,
 							data->isoc, data);
-- 
1.7.11.7

