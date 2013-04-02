Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Convert BCM92035 support to driver setup callback
Date: Tue,  2 Apr 2013 20:21:26 +0300
Message-Id: <1364923287-25935-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1364923287-25935-1-git-send-email-johan.hedberg@gmail.com>
References: <1364923287-25935-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>

With the early init stage during setup, this quirk can be simplified
and kept fully inside the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/btusb.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1155ee0..b0399f7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -242,6 +242,7 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *isoc_rx_ep;
 
 	__u8 cmdreq_type;
+	unsigned long driver_info;
 
 	unsigned int sco_num;
 	int isoc_altsetting;
@@ -695,6 +696,20 @@ static int btusb_flush(struct hci_dev *hdev)
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
@@ -992,6 +1007,7 @@ static int btusb_probe(struct usb_interface *intf,
 		return -ENODEV;
 
 	data->cmdreq_type = USB_TYPE_CLASS;
+	data->driver_info = id->driver_info;
 
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
@@ -1022,6 +1038,7 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->open     = btusb_open;
 	hdev->close    = btusb_close;
 	hdev->flush    = btusb_flush;
+	hdev->setup    = btusb_setup;
 	hdev->send     = btusb_send_frame;
 	hdev->notify   = btusb_notify;
 
@@ -1062,17 +1079,6 @@ static int btusb_probe(struct usb_interface *intf,
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
1.7.10.4

