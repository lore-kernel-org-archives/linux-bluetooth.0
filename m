Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use separate function for BCM92035 vendor setup
Date: Wed, 10 Apr 2013 08:11:35 -0700
Message-Id: <1365606695-43841-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Trying to squeeze every single vendor setup routine into the same function
and have it assigned all the time is actually a bad idea. Especially since
the core can handle the absence of a setup routine perfectly fine.

To make this a lot simpler for future additions of vendor setup code,
split the BCM92035 setup into its own function and only assign it when
this specific device has been detected.

Doing it like this has the nice side benefit that we do not have to keep
a copy of the driver_info around.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 52 ++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 35c967f..6c45dc5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -246,7 +246,6 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *isoc_rx_ep;
 
 	__u8 cmdreq_type;
-	unsigned long driver_info;
 
 	unsigned int sco_num;
 	int isoc_altsetting;
@@ -700,26 +699,6 @@ static int btusb_flush(struct hci_dev *hdev)
 	return 0;
 }
 
-static int btusb_setup(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-
-	BT_DBG("%s", hdev->name);
-
-	if (data->driver_info & BTUSB_BCM92035) {
-		struct sk_buff *skb;
-		__u8 val = 0x00;
-
-		skb = __hci_cmd_sync(hdev, 0xfc3b, 1, &val, HCI_INIT_TIMEOUT);
-		if (IS_ERR(skb))
-			BT_ERR("BCM92035 command failed (%ld)", -PTR_ERR(skb));
-		else
-			kfree_skb(skb);
-	}
-
-	return 0;
-}
-
 static int btusb_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
@@ -948,6 +927,22 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
+static int btusb_setup_bcm92035(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	__u8 val = 0x00;
+
+	BT_DBG("%s", hdev->name);
+
+	skb = __hci_cmd_sync(hdev, 0xfc3b, 1, &val, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		BT_ERR("BCM92035 command failed (%ld)", -PTR_ERR(skb));
+	else
+		kfree_skb(skb);
+
+	return 0;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -1017,7 +1012,6 @@ static int btusb_probe(struct usb_interface *intf,
 		return -ENODEV;
 
 	data->cmdreq_type = USB_TYPE_CLASS;
-	data->driver_info = id->driver_info;
 
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
@@ -1045,12 +1039,14 @@ static int btusb_probe(struct usb_interface *intf,
 
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
-	hdev->open     = btusb_open;
-	hdev->close    = btusb_close;
-	hdev->flush    = btusb_flush;
-	hdev->setup    = btusb_setup;
-	hdev->send     = btusb_send_frame;
-	hdev->notify   = btusb_notify;
+	hdev->open   = btusb_open;
+	hdev->close  = btusb_close;
+	hdev->flush  = btusb_flush;
+	hdev->send   = btusb_send_frame;
+	hdev->notify = btusb_notify;
+
+	if (id->driver_info & BTUSB_BCM92035)
+		hdev->setup = btusb_setup_bcm92035;
 
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
-- 
1.8.1.4

