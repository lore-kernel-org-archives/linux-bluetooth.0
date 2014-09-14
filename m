Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Separate TX URB allocation and submission
Date: Sun, 14 Sep 2014 09:11:06 +0200
Message-Id: <1410678666-51129-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The complete TX URB handling is done via a switch statement in the
btusb_send_frame function. To allow for more clear separation between
control, bulk and isoc URBs, split them into allocation and submission.

Previously the inc_tx function has been used for tracking in-flight
URB for HCI commands and ACL data packets. Convert that into a common
function that either submits the URB or queues it when needed.

This provides the flexibility to allow vendor specific hdev->send_frame
callbacks without having to duplicate the whole URB handling logic.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 206 ++++++++++++++++++++++++++++------------------
 1 file changed, 125 insertions(+), 81 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d696e68f326a..0713668fc0c9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -296,20 +296,6 @@ struct btusb_data {
 	int suspend_count;
 };
 
-static int inc_tx(struct btusb_data *data)
-{
-	unsigned long flags;
-	int rv;
-
-	spin_lock_irqsave(&data->txlock, flags);
-	rv = test_bit(BTUSB_SUSPENDING, &data->flags);
-	if (!rv)
-		data->tx_in_flight++;
-	spin_unlock_irqrestore(&data->txlock, flags);
-
-	return rv;
-}
-
 static void btusb_intr_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
@@ -752,100 +738,96 @@ static int btusb_flush(struct hci_dev *hdev)
 	return 0;
 }
 
-static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct usb_ctrlrequest *dr;
 	struct urb *urb;
 	unsigned int pipe;
-	int err;
 
-	BT_DBG("%s", hdev->name);
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
+	dr = kmalloc(sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		usb_free_urb(urb);
+		return ERR_PTR(-ENOMEM);
+	}
 
-	skb->dev = (void *) hdev;
+	dr->bRequestType = data->cmdreq_type;
+	dr->bRequest     = 0;
+	dr->wIndex       = 0;
+	dr->wValue       = 0;
+	dr->wLength      = __cpu_to_le16(skb->len);
 
-	switch (bt_cb(skb)->pkt_type) {
-	case HCI_COMMAND_PKT:
-		urb = usb_alloc_urb(0, GFP_KERNEL);
-		if (!urb)
-			return -ENOMEM;
-
-		dr = kmalloc(sizeof(*dr), GFP_KERNEL);
-		if (!dr) {
-			usb_free_urb(urb);
-			return -ENOMEM;
-		}
+	pipe = usb_sndctrlpipe(data->udev, 0x00);
 
-		dr->bRequestType = data->cmdreq_type;
-		dr->bRequest     = 0;
-		dr->wIndex       = 0;
-		dr->wValue       = 0;
-		dr->wLength      = __cpu_to_le16(skb->len);
+	usb_fill_control_urb(urb, data->udev, pipe, (void *) dr,
+			     skb->data, skb->len, btusb_tx_complete, skb);
 
-		pipe = usb_sndctrlpipe(data->udev, 0x00);
+	skb->dev = (void *) hdev;
 
-		usb_fill_control_urb(urb, data->udev, pipe, (void *) dr,
-				skb->data, skb->len, btusb_tx_complete, skb);
+	return urb;
+}
 
-		hdev->stat.cmd_tx++;
-		break;
+static struct urb *alloc_bulk_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct urb *urb;
+	unsigned int pipe;
 
-	case HCI_ACLDATA_PKT:
-		if (!data->bulk_tx_ep)
-			return -ENODEV;
+	if (!data->bulk_tx_ep)
+		return ERR_PTR(-ENODEV);
 
-		urb = usb_alloc_urb(0, GFP_KERNEL);
-		if (!urb)
-			return -ENOMEM;
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
 
-		pipe = usb_sndbulkpipe(data->udev,
-					data->bulk_tx_ep->bEndpointAddress);
+	pipe = usb_sndbulkpipe(data->udev, data->bulk_tx_ep->bEndpointAddress);
 
-		usb_fill_bulk_urb(urb, data->udev, pipe,
-				skb->data, skb->len, btusb_tx_complete, skb);
+	usb_fill_bulk_urb(urb, data->udev, pipe,
+			  skb->data, skb->len, btusb_tx_complete, skb);
 
-		hdev->stat.acl_tx++;
-		break;
+	skb->dev = (void *) hdev;
 
-	case HCI_SCODATA_PKT:
-		if (!data->isoc_tx_ep || hci_conn_num(hdev, SCO_LINK) < 1)
-			return -ENODEV;
+	return urb;
+}
 
-		urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_KERNEL);
-		if (!urb)
-			return -ENOMEM;
+static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct urb *urb;
+	unsigned int pipe;
 
-		pipe = usb_sndisocpipe(data->udev,
-					data->isoc_tx_ep->bEndpointAddress);
+	if (!data->isoc_tx_ep)
+		return ERR_PTR(-ENODEV);
 
-		usb_fill_int_urb(urb, data->udev, pipe,
-				skb->data, skb->len, btusb_isoc_tx_complete,
-				skb, data->isoc_tx_ep->bInterval);
+	urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
 
-		urb->transfer_flags  = URB_ISO_ASAP;
+	pipe = usb_sndisocpipe(data->udev, data->isoc_tx_ep->bEndpointAddress);
 
-		__fill_isoc_descriptor(urb, skb->len,
-				le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
+	usb_fill_int_urb(urb, data->udev, pipe,
+			 skb->data, skb->len, btusb_isoc_tx_complete,
+			 skb, data->isoc_tx_ep->bInterval);
 
-		hdev->stat.sco_tx++;
-		goto skip_waking;
+	urb->transfer_flags  = URB_ISO_ASAP;
 
-	default:
-		return -EILSEQ;
-	}
+	__fill_isoc_descriptor(urb, skb->len,
+			       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
 
-	err = inc_tx(data);
-	if (err) {
-		usb_anchor_urb(urb, &data->deferred);
-		schedule_work(&data->waker);
-		err = 0;
-		goto done;
-	}
+	skb->dev = (void *) hdev;
+
+	return urb;
+}
+
+static int submit_tx_urb(struct hci_dev *hdev, struct urb *urb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
 
-skip_waking:
 	usb_anchor_urb(urb, &data->tx_anchor);
 
 	err = usb_submit_urb(urb, GFP_KERNEL);
@@ -859,11 +841,73 @@ skip_waking:
 		usb_mark_last_busy(data->udev);
 	}
 
-done:
 	usb_free_urb(urb);
 	return err;
 }
 
+static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	unsigned long flags;
+	bool suspending;
+
+	spin_lock_irqsave(&data->txlock, flags);
+	suspending = test_bit(BTUSB_SUSPENDING, &data->flags);
+	if (!suspending)
+		data->tx_in_flight++;
+	spin_unlock_irqrestore(&data->txlock, flags);
+
+	if (!suspending)
+		return submit_tx_urb(hdev, urb);
+
+	usb_anchor_urb(urb, &data->deferred);
+	schedule_work(&data->waker);
+
+	usb_free_urb(urb);
+	return 0;
+}
+
+static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct urb *urb;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -EBUSY;
+
+	switch (bt_cb(skb)->pkt_type) {
+	case HCI_COMMAND_PKT:
+		urb = alloc_ctrl_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(skb);
+
+		hdev->stat.cmd_tx++;
+		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_ACLDATA_PKT:
+		urb = alloc_bulk_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(skb);
+
+		hdev->stat.acl_tx++;
+		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_SCODATA_PKT:
+		if (hci_conn_num(hdev, SCO_LINK) < 1)
+			return -ENODEV;
+
+		urb = alloc_isoc_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(skb);
+
+		hdev->stat.sco_tx++;
+		return submit_tx_urb(hdev, urb);
+	}
+
+	return -EILSEQ;
+}
+
 static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-- 
1.9.3

