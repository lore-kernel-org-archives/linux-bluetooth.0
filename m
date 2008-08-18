Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808181803.48778.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
	 <200808181638.51851.oliver@neukum.org>
	 <1219072360.7591.59.camel@violet.holtmann.net>
	 <200808181803.48778.oliver@neukum.org>
Content-Type: multipart/mixed; boundary="=-14rRNTnb/iXcQC8cs31F"
Date: Mon, 18 Aug 2008 19:07:53 +0200
Message-Id: <1219079273.7591.62.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-14rRNTnb/iXcQC8cs31F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Oliver,

> > actually we can't move the URB killing for ACL into notify() since that
> > gives me a kernel panic (fatal exception in interrupt).
> > 
> > Your patch for the IRQ disabling doesn't make a difference.
> 
> Please send me the version that triggers it.

the attached version makes it oops. Just create a connection with rfcomm
or sdptool and you will see it when disconnecting.

Regards

Marcel


--=-14rRNTnb/iXcQC8cs31F
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 95ae9ba..5aa5d0e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2,7 +2,7 @@
  *
  *  Generic Bluetooth USB driver
  *
- *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -41,7 +41,7 @@
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "0.2"
+#define VERSION "0.3"
 
 static int ignore_dga;
 static int ignore_csr;
@@ -160,12 +160,16 @@ static struct usb_device_id blacklist_table[] = {
 	{ }	/* Terminating entry */
 };
 
+#define BTUSB_MAX_ISOC_FRAMES	10
+
 #define BTUSB_INTR_RUNNING	0
 #define BTUSB_BULK_RUNNING	1
+#define BTUSB_ISOC_RUNNING	2
 
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
+	struct usb_interface *isoc;
 
 	spinlock_t lock;
 
@@ -176,10 +180,15 @@ struct btusb_data {
 	struct usb_anchor tx_anchor;
 	struct usb_anchor intr_anchor;
 	struct usb_anchor bulk_anchor;
+	struct usb_anchor isoc_anchor;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
 	struct usb_endpoint_descriptor *bulk_rx_ep;
+	struct usb_endpoint_descriptor *isoc_tx_ep;
+	struct usb_endpoint_descriptor *isoc_rx_ep;
+
+	int isoc_altsetting;
 };
 
 static void btusb_intr_complete(struct urb *urb)
@@ -195,6 +204,8 @@ static void btusb_intr_complete(struct urb *urb)
 		return;
 
 	if (urb->status == 0) {
+		hdev->stat.byte_rx += urb->actual_length;
+
 		if (hci_recv_fragment(hdev, HCI_EVENT_PKT,
 						urb->transfer_buffer,
 						urb->actual_length) < 0) {
@@ -216,7 +227,7 @@ static void btusb_intr_complete(struct urb *urb)
 	}
 }
 
-static inline int btusb_submit_intr_urb(struct hci_dev *hdev)
+static int btusb_submit_intr_urb(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -226,6 +237,9 @@ static inline int btusb_submit_intr_urb(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	if (!data->intr_ep)
+		return -ENODEV;
+
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
 		return -ENOMEM;
@@ -274,6 +288,8 @@ static void btusb_bulk_complete(struct urb *urb)
 		return;
 
 	if (urb->status == 0) {
+		hdev->stat.byte_rx += urb->actual_length;
+
 		if (hci_recv_fragment(hdev, HCI_ACLDATA_PKT,
 						urb->transfer_buffer,
 						urb->actual_length) < 0) {
@@ -295,7 +311,7 @@ static void btusb_bulk_complete(struct urb *urb)
 	}
 }
 
-static inline int btusb_submit_bulk_urb(struct hci_dev *hdev)
+static int btusb_submit_bulk_urb(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -305,13 +321,16 @@ static inline int btusb_submit_bulk_urb(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!data->bulk_rx_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
 		return -ENOMEM;
 
 	size = le16_to_cpu(data->bulk_rx_ep->wMaxPacketSize);
 
-	buf = kmalloc(size, GFP_KERNEL);
+	buf = kmalloc(size, GFP_ATOMIC);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
@@ -326,6 +345,127 @@ static inline int btusb_submit_bulk_urb(struct hci_dev *hdev)
 
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		BT_ERR("%s urb %p submission failed (%d)",
+						hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+		kfree(buf);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
+static void btusb_isoc_complete(struct urb *urb)
+{
+	struct hci_dev *hdev = urb->context;
+	struct btusb_data *data = hdev->driver_data;
+	int i, err;
+
+	BT_DBG("%s urb %p status %d count %d", hdev->name,
+					urb, urb->status, urb->actual_length);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return;
+
+	if (urb->status == 0) {
+		for (i = 0; i < urb->number_of_packets; i++) {
+			unsigned int offset = urb->iso_frame_desc[i].offset;
+			unsigned int length = urb->iso_frame_desc[i].actual_length;
+
+			if (urb->iso_frame_desc[i].status)
+				continue;
+
+			hdev->stat.byte_rx += length;
+
+			if (hci_recv_fragment(hdev, HCI_SCODATA_PKT,
+						urb->transfer_buffer + offset,
+								length) < 0) {
+				BT_ERR("%s corrupted SCO packet", hdev->name);
+				hdev->stat.err_rx++;
+			}
+		}
+	}
+
+	if (!test_bit(BTUSB_ISOC_RUNNING, &data->flags))
+		return;
+
+	usb_anchor_urb(urb, &data->isoc_anchor);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		BT_ERR("%s urb %p failed to resubmit (%d)",
+						hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+}
+
+static void inline __fill_isoc_descriptor(struct urb *urb, int len, int mtu)
+{
+	int i, offset = 0;
+
+	BT_DBG("len %d mtu %d", len, mtu);
+
+	for (i = 0; i < BTUSB_MAX_ISOC_FRAMES && len >= mtu;
+					i++, offset += mtu, len -= mtu) {
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length = mtu;
+	}
+
+	if (len && i < BTUSB_MAX_ISOC_FRAMES) {
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length = len;
+		i++;
+	}
+
+	urb->number_of_packets = i;
+}
+
+static int btusb_submit_isoc_urb(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hdev->driver_data;
+	struct urb *urb;
+	unsigned char *buf;
+	unsigned int pipe;
+	int err, size;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!data->isoc_rx_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_KERNEL);
+	if (!urb)
+		return -ENOMEM;
+
+	size = le16_to_cpu(data->isoc_rx_ep->wMaxPacketSize) *
+						BTUSB_MAX_ISOC_FRAMES;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvisocpipe(data->udev, data->isoc_rx_ep->bEndpointAddress);
+
+	urb->dev      = data->udev;
+	urb->pipe     = pipe;
+	urb->context  = hdev;
+	urb->complete = btusb_isoc_complete;
+	urb->interval = data->isoc_rx_ep->bInterval;
+
+	urb->transfer_flags  = URB_FREE_BUFFER | URB_ISO_ASAP;
+	urb->transfer_buffer = buf;
+	urb->transfer_buffer_length = size;
+
+	__fill_isoc_descriptor(urb, size,
+			le16_to_cpu(data->isoc_rx_ep->wMaxPacketSize));
+
+	usb_anchor_urb(urb, &data->isoc_anchor);
+
 	err = usb_submit_urb(urb, GFP_KERNEL);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
@@ -392,6 +532,11 @@ static int btusb_close(struct hci_dev *hdev)
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
+	flush_work(&data->work);
+
+	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+	usb_kill_anchored_urbs(&data->intr_anchor);
+
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	usb_kill_anchored_urbs(&data->bulk_anchor);
 
@@ -453,6 +598,9 @@ static int btusb_send_frame(struct sk_buff *skb)
 		break;
 
 	case HCI_ACLDATA_PKT:
+		if (!data->bulk_tx_ep || hdev->conn_hash.acl_num < 1)
+			return -ENODEV;
+
 		urb = usb_alloc_urb(0, GFP_ATOMIC);
 		if (!urb)
 			return -ENOMEM;
@@ -467,9 +615,31 @@ static int btusb_send_frame(struct sk_buff *skb)
 		break;
 
 	case HCI_SCODATA_PKT:
+		if (!data->isoc_tx_ep || hdev->conn_hash.sco_num < 1)
+			return -ENODEV;
+
+		urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_ATOMIC);
+		if (!urb)
+			return -ENOMEM;
+
+		pipe = usb_sndisocpipe(data->udev,
+					data->isoc_tx_ep->bEndpointAddress);
+
+		urb->dev      = data->udev;
+		urb->pipe     = pipe;
+		urb->context  = skb;
+		urb->complete = btusb_tx_complete;
+		urb->interval = data->isoc_tx_ep->bInterval;
+
+		urb->transfer_flags  = URB_ISO_ASAP;
+		urb->transfer_buffer = skb->data;
+		urb->transfer_buffer_length = skb->len;
+
+		__fill_isoc_descriptor(urb, skb->len,
+				le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
+
 		hdev->stat.sco_tx++;
-		kfree_skb(skb);
-		return 0;
+		break;
 
 	default:
 		return -EILSEQ;
@@ -504,8 +674,62 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 
 	BT_DBG("%s evt %d", hdev->name, evt);
 
-	if (evt == HCI_NOTIFY_CONN_ADD || evt == HCI_NOTIFY_CONN_DEL)
-		schedule_work(&data->work);
+	if (hdev->conn_hash.acl_num > 0) {
+		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
+			if (btusb_submit_bulk_urb(hdev) < 0)
+				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+			else
+				btusb_submit_bulk_urb(hdev);
+		}
+	} else {
+		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+		usb_kill_anchored_urbs(&data->bulk_anchor);
+	}
+
+	schedule_work(&data->work);
+}
+
+static int inline __set_isoc_interface(struct hci_dev *hdev, int altsetting)
+{
+	struct btusb_data *data = hdev->driver_data;
+	struct usb_interface *intf = data->isoc;
+	struct usb_endpoint_descriptor *ep_desc;
+	int i, err;
+
+	if (!data->isoc)
+		return -ENODEV;
+
+	err = usb_set_interface(data->udev, 1, altsetting);
+	if (err < 0) {
+		BT_ERR("%s setting interface failed (%d)", hdev->name, -err);
+		return err;
+	}
+
+	data->isoc_altsetting = altsetting;
+
+	data->isoc_tx_ep = NULL;
+	data->isoc_rx_ep = NULL;
+
+	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
+		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
+
+		if (!data->isoc_tx_ep && usb_endpoint_is_isoc_out(ep_desc)) {
+			data->isoc_tx_ep = ep_desc;
+			continue;
+		}
+
+		if (!data->isoc_rx_ep && usb_endpoint_is_isoc_in(ep_desc)) {
+			data->isoc_rx_ep = ep_desc;
+			continue;
+		}
+	}
+
+	if (!data->isoc_tx_ep || !data->isoc_rx_ep) {
+		BT_ERR("%s invalid SCO descriptors", hdev->name);
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
 static void btusb_work(struct work_struct *work)
@@ -513,17 +737,26 @@ static void btusb_work(struct work_struct *work)
 	struct btusb_data *data = container_of(work, struct btusb_data, work);
 	struct hci_dev *hdev = data->hdev;
 
-	if (hdev->conn_hash.acl_num == 0) {
-		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-		usb_kill_anchored_urbs(&data->bulk_anchor);
-		return;
-	}
+	if (hdev->conn_hash.sco_num > 0) {
+		if (data->isoc_altsetting != 2) {
+			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+			usb_kill_anchored_urbs(&data->isoc_anchor);
 
-	if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
-		if (btusb_submit_bulk_urb(hdev) < 0)
-			clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-		else
-			btusb_submit_bulk_urb(hdev);
+			if (__set_isoc_interface(hdev, 2) < 0)
+				return;
+		}
+
+		if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
+			if (btusb_submit_isoc_urb(hdev) < 0)
+				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+			else
+				btusb_submit_isoc_urb(hdev);
+		}
+	} else {
+		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+		usb_kill_anchored_urbs(&data->isoc_anchor);
+
+		__set_isoc_interface(hdev, 0);
 	}
 }
 
@@ -597,6 +830,7 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->tx_anchor);
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
+	init_usb_anchor(&data->isoc_anchor);
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -620,6 +854,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	hdev->owner = THIS_MODULE;
 
+	/* interface numbers are hardcoded in the spec */
+	data->isoc = usb_ifnum_to_if(data->udev, 1);
+
 	if (reset || id->driver_info & BTUSB_RESET)
 		set_bit(HCI_QUIRK_RESET_ON_INIT, &hdev->quirks);
 
@@ -628,11 +865,16 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
 	}
 
+	if (id->driver_info & BTUSB_BROKEN_ISOC)
+		data->isoc = NULL;
+
 	if (id->driver_info & BTUSB_SNIFFER) {
-		struct usb_device *udev = interface_to_usbdev(intf);
+		struct usb_device *udev = data->udev;
 
 		if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x997)
 			set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
+
+		data->isoc = NULL;
 	}
 
 	if (id->driver_info & BTUSB_BCM92035) {
@@ -646,6 +888,16 @@ static int btusb_probe(struct usb_interface *intf,
 		}
 	}
 
+	if (data->isoc) {
+		err = usb_driver_claim_interface(&btusb_driver,
+							data->isoc, NULL);
+		if (err < 0) {
+			hci_free_dev(hdev);
+			kfree(data);
+			return err;
+		}
+	}
+
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		hci_free_dev(hdev);
@@ -670,6 +922,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 
 	hdev = data->hdev;
 
+	if (data->isoc)
+		usb_driver_release_interface(&btusb_driver, data->isoc);
+
 	usb_set_intfdata(intf, NULL);
 
 	hci_unregister_dev(hdev);

--=-14rRNTnb/iXcQC8cs31F--

