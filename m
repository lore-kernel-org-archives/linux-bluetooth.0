Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: linux-bluetooth@vger.kernel.org
Subject: [rfc]btusb with SCO support
Date: Thu, 31 Jul 2008 14:52:23 +0200
Cc: linux-usb@vger.kernel.org,
 marcel@holtmann.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807311452.24166.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

here's my current version of btusb with SCO support. This is preliminary.
I am still looking at a way to delay using the higher altsettings until SCO
is actually used, but the timeouts seem to be too long to do the obvious.

Furthermore, could somebody point me at the description of a test setup
for bluetooth?

	Regards
		Oliver

---

--- linux-2.6/drivers/bluetooth/btusb.c	2008-07-31 10:26:38.000000000 +0200
+++ linux-btusb/drivers/bluetooth/btusb.c	2008-07-31 13:57:17.000000000 +0200
@@ -32,6 +32,8 @@
 
 #include <linux/usb.h>
 
+#include "hci_usb.h"
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
@@ -41,21 +43,127 @@
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "0.1"
+#define VERSION "0.3"
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
 
+	/* AVM BlueFRITZ! USB v2.0 */
+	{ USB_DEVICE(0x057c, 0x3800) },
+
+	/* Bluetooth Ultraport Module from IBM */
+	{ USB_DEVICE(0x04bf, 0x030a) },
+
+	/* ALPS Modules with non-standard id */
+	{ USB_DEVICE(0x044e, 0x3001) },
+	{ USB_DEVICE(0x044e, 0x3002) },
+
+	/* Ericsson with non-standard id */
+	{ USB_DEVICE(0x0bdb, 0x1002) },
+
+	/* Canyon CN-BTU1 with HID interfaces */
+	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = HCI_RESET },
+
 	{ }	/* Terminating entry */
 };
 
 MODULE_DEVICE_TABLE(usb, btusb_table);
 
 static struct usb_device_id blacklist_table[] = {
+	/* CSR BlueCore devices */
+	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = HCI_CSR },
+
+	/* Broadcom BCM2033 without firmware */
+	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = HCI_IGNORE },
+
+	/* Broadcom BCM2035 */
+	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Broadcom BCM2045 */
+	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* IBM/Lenovo ThinkPad with Broadcom chip */
+	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Targus ACB10US */
+	{ USB_DEVICE(0x0a5c, 0x2100), .driver_info = HCI_RESET },
+
+	/* ANYCOM Bluetooth USB-200 and USB-250 */
+	{ USB_DEVICE(0x0a5c, 0x2111), .driver_info = HCI_RESET },
+
+	/* HP laptop with Broadcom chip */
+	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Dell laptop with Broadcom chip */
+	{ USB_DEVICE(0x413c, 0x8126), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
+	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET },
+
+	/* Kensington Bluetooth USB adapter */
+	{ USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_RESET },
+	{ USB_DEVICE(0x047d, 0x105e), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* ISSC Bluetooth Adapter v3.1 */
+	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
+
+	/* RTX Telecom based adapters with buggy SCO support */
+	{ USB_DEVICE(0x0400, 0x0807), .driver_info = HCI_BROKEN_ISOC },
+	{ USB_DEVICE(0x0400, 0x080a), .driver_info = HCI_BROKEN_ISOC },
+
+	/* CONWISE Technology based adapters with buggy SCO support */
+	{ USB_DEVICE(0x0e5e, 0x6622), .driver_info = HCI_BROKEN_ISOC },
+
+	/* Belkin F8T012 and F8T013 devices */
+	{ USB_DEVICE(0x050d, 0x0012), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x050d, 0x0013), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+
+	/* Digianswer devices */
+	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = HCI_DIGIANSWER },
+	{ USB_DEVICE(0x08fd, 0x0002), .driver_info = HCI_IGNORE },
+
+	/* CSR BlueCore Bluetooth Sniffer */
+	{ USB_DEVICE(0x0a12, 0x0002), .driver_info = HCI_SNIFFER },
+
+	/* Frontline ComProbe Bluetooth Sniffer */
+	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = HCI_SNIFFER },
 	{ }	/* Terminating entry */
 };
 
+static struct usb_driver btusb_driver;
+
+static int reset = 0;
+module_param(reset, bool, 0644);
+MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
+
+static int force_scofix;
+module_param(force_scofix, bool, 0644);
+MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
+
+static int disable_scofix;
+module_param(disable_scofix, bool, 0644);
+MODULE_PARM_DESC(disable_scofix, "Disable fixup of wrong SCO buffer size");
+
+static int ignore_csr;
+module_param(ignore_csr, bool, 0644);
+MODULE_PARM_DESC(ignore_csr, "Ignore devices with id 0a12:0001");
+
+static int ignore_sniffer;
+module_param(ignore_sniffer, bool, 0644);
+MODULE_PARM_DESC(ignore_sniffer, "Ignore devices with id 0a12:0002");
+
+static int ignore_dga;
+module_param(ignore_dga, bool, 0644);
+MODULE_PARM_DESC(ignore_dga, "Ignore devices with id 08fd:0001");
+
+static int override_ignore;
+module_param(override_ignore, bool, 0644);
+MODULE_PARM_DESC(override_ignore, "Drive blacklisted devices");
+
 #define BTUSB_INTR_RUNNING	0
 #define BTUSB_BULK_RUNNING	1
 
@@ -67,17 +175,22 @@ struct btusb_data {
 
 	unsigned long flags;
 
-	struct work_struct work;
-
 	struct usb_anchor tx_anchor;
 	struct usb_anchor intr_anchor;
 	struct usb_anchor bulk_anchor;
+	struct usb_anchor sco_anchor;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
 	struct usb_endpoint_descriptor *bulk_rx_ep;
+	struct usb_host_endpoint *isoc_out_ep;
+	struct usb_host_endpoint *isoc_in_ep;
+
+	struct usb_interface *iso;
 };
 
+static void btusb_start_sco(struct btusb_data *data);
+
 static void btusb_intr_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
@@ -257,26 +370,81 @@ done:
 	kfree_skb(skb);
 }
 
+static void btusb_sco_tx_complete(struct urb *urb)
+{
+	struct sk_buff *skb = (struct sk_buff *)urb->context;
+
+	kfree_skb(skb);
+}
+
+static void btusb_sco_rx_complete(struct urb *urb)
+{
+	struct btusb_data *data = urb->context;
+	int status = urb->status;
+	int i;
+
+	if (!test_bit(HCI_RUNNING, &data->flags))
+		goto out;
+	if (status < 0)
+		goto out;
+
+	for (i=0; i < urb->number_of_packets; i++) {
+		BT_DBG("desc %d status %d offset %d len %d", i,
+				urb->iso_frame_desc[i].status,
+				urb->iso_frame_desc[i].offset,
+				urb->iso_frame_desc[i].actual_length);
+	
+		if (!urb->iso_frame_desc[i].status) {
+			data->hdev->stat.byte_rx += urb->iso_frame_desc[i].actual_length;
+			hci_recv_fragment(data->hdev, HCI_SCODATA_PKT,
+				urb->transfer_buffer + urb->iso_frame_desc[i].offset,
+				urb->iso_frame_desc[i].actual_length);
+		}
+	}
+
+	usb_anchor_urb(urb, &data->sco_anchor);
+	i = usb_submit_urb(urb, GFP_ATOMIC);
+	if (i < 0) {
+		usb_unanchor_urb(urb);
+out:
+		kfree(urb->transfer_buffer);
+	}
+}
+
 static int btusb_open(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hdev->driver_data;
+	static DEFINE_MUTEX(open_mut);
 	int err;
 
 	BT_DBG("%s", hdev->name);
 
+	mutex_lock(&open_mut);
 	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
+		goto out;
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
-		return 0;
+		goto out;;
 
+	err = usb_set_interface(data->udev, 1, 2);
+	if (err < 0)
+		goto err_out;
 	err = btusb_submit_intr_urb(hdev);
-	if (err < 0) {
-		clear_bit(BTUSB_INTR_RUNNING, &hdev->flags);
-		clear_bit(HCI_RUNNING, &hdev->flags);
-	}
+	if (err < 0)
+		goto err_out_setting;
 
-	return err;
+	btusb_start_sco(data);
+out:
+	mutex_unlock(&open_mut);
+	return 0;
+
+err_out_setting:
+	usb_set_interface(data->udev, 1, 0);
+err_out:
+	clear_bit(BTUSB_INTR_RUNNING, &hdev->flags);
+	clear_bit(HCI_RUNNING, &hdev->flags);
+	mutex_unlock(&open_mut);
+	return -EIO;
 }
 
 static int btusb_close(struct hci_dev *hdev)
@@ -294,6 +462,9 @@ static int btusb_close(struct hci_dev *h
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
 	usb_kill_anchored_urbs(&data->intr_anchor);
 
+	usb_kill_anchored_urbs(&data->sco_anchor);
+	usb_set_interface(data->udev, 1, 0);
+
 	return 0;
 }
 
@@ -304,15 +475,36 @@ static int btusb_flush(struct hci_dev *h
 	BT_DBG("%s", hdev->name);
 
 	usb_kill_anchored_urbs(&data->tx_anchor);
-
+	usb_kill_anchored_urbs(&data->sco_anchor);
 	return 0;
 }
 
+static void btusb_fill_isoc_desc(struct urb *urb, int len, int mtu)
+{
+	int offset = 0, i;
+
+	BT_DBG("len %d mtu %d", len, mtu);
+
+	for (i=0; i < HCI_MAX_ISOC_FRAMES && len >= mtu; i++, offset += mtu, len -= mtu) {
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length = mtu;
+		BT_DBG("desc %d offset %d len %d", i, offset, mtu);
+	}
+	if (len && i < HCI_MAX_ISOC_FRAMES) {
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length = len;
+		BT_DBG("desc %d offset %d len %d", i, offset, len);
+		i++;
+	}
+	urb->number_of_packets = i;
+}
+
 static int btusb_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 	struct btusb_data *data = hdev->driver_data;
 	struct usb_ctrlrequest *dr;
+	struct usb_anchor *queue = &data->tx_anchor;
 	struct urb *urb;
 	unsigned int pipe;
 	int err;
@@ -363,15 +555,32 @@ static int btusb_send_frame(struct sk_bu
 		break;
 
 	case HCI_SCODATA_PKT:
+		if (!data->iso)
+			return -ENODEV;
+		queue = &data->sco_anchor;
+		urb = usb_alloc_urb(HCI_MAX_ISOC_FRAMES, GFP_ATOMIC);
+		if (!urb)
+			return -ENOMEM;
+
+		urb->context  = skb;
+		urb->dev      = data->udev;
+		urb->pipe     = usb_sndisocpipe(data->udev, data->isoc_out_ep->desc.bEndpointAddress);
+		urb->complete = btusb_sco_tx_complete;
+		urb->transfer_flags = URB_ISO_ASAP;
+
+		urb->interval = data->isoc_out_ep->desc.bInterval;
+
+		urb->transfer_buffer = skb->data;
+		urb->transfer_buffer_length = skb->len;
 		hdev->stat.sco_tx++;
-		kfree_skb(skb);
-		return 0;
+		btusb_fill_isoc_desc(urb, skb->len, le16_to_cpu(data->isoc_out_ep->desc.wMaxPacketSize));
+		break;
 
 	default:
 		return -EILSEQ;
 	}
 
-	usb_anchor_urb(urb, &data->tx_anchor);
+	usb_anchor_urb(urb, queue);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err < 0) {
@@ -396,43 +605,65 @@ static void btusb_destruct(struct hci_de
 
 static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 {
-	struct btusb_data *data = hdev->driver_data;
-
 	BT_DBG("%s evt %d", hdev->name, evt);
-
-	if (evt == HCI_NOTIFY_CONN_ADD || evt == HCI_NOTIFY_CONN_DEL)
-		schedule_work(&data->work);
 }
 
-static void btusb_work(struct work_struct *work)
+static void btusb_start_sco(struct btusb_data *data)
 {
-	struct btusb_data *data = container_of(work, struct btusb_data, work);
-	struct hci_dev *hdev = data->hdev;
+	struct urb *urb;
+	int mtu, size, err;
+	u8 *buf;
+
+	mtu  = le16_to_cpu(data->isoc_in_ep->desc.wMaxPacketSize);
+	size = mtu * HCI_MAX_ISOC_FRAMES;
 
-	if (hdev->conn_hash.acl_num == 0) {
-		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-		usb_kill_anchored_urbs(&data->bulk_anchor);
+	urb = usb_alloc_urb(HCI_MAX_ISOC_FRAMES, GFP_KERNEL);
+	if (!urb)
 		return;
-	}
 
-	if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
-		if (btusb_submit_bulk_urb(hdev) < 0)
-			clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-		else
-			btusb_submit_bulk_urb(hdev);
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf) {
+		usb_free_urb(urb);
+		return;
 	}
+
+	urb->context  = data;
+	urb->dev      = data->udev;
+	urb->pipe     = usb_rcvisocpipe(data->udev, data->isoc_in_ep->desc.bEndpointAddress);
+	urb->complete = btusb_sco_rx_complete;
+
+	urb->interval = data->isoc_in_ep->desc.bInterval;
+
+	urb->transfer_buffer_length = size;
+	urb->transfer_buffer = buf;
+	urb->transfer_flags  = URB_ISO_ASAP;
+
+	btusb_fill_isoc_desc(urb, size, mtu);
+
+	usb_anchor_urb(urb, &data->sco_anchor);
+
+	err = usb_submit_urb(urb, GFP_KERNEL);
+	if (err < 0)
+		usb_unanchor_urb(urb);
+	usb_free_urb(urb);
 }
 
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
 	struct usb_endpoint_descriptor *ep_desc;
+	struct usb_interface *iso_intf;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
-	int i, err;
+	int i, a, err;
+	struct usb_host_endpoint *isoc_out_ep = NULL;
+	struct usb_host_endpoint *isoc_in_ep = NULL;
+	struct usb_host_endpoint  *ep;
+	struct usb_host_interface *uif;
 
 	BT_DBG("intf %p id %p", intf, id);
 
+	/* interface numbers are hardcoded in the spec */
 	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
 		return -ENODEV;
 
@@ -443,6 +674,15 @@ static int btusb_probe(struct usb_interf
 			id = match;
 	}
 
+	if (id->driver_info == HCI_IGNORE && !override_ignore)
+		return -ENODEV;
+	if (ignore_sniffer && id->driver_info & HCI_SNIFFER)
+		return -ENODEV;
+	if (ignore_csr && id->driver_info & HCI_CSR)
+		return -ENODEV;
+	if (ignore_dga && id->driver_info & HCI_DIGIANSWER)
+		return -ENODEV;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -473,13 +713,44 @@ static int btusb_probe(struct usb_interf
 
 	data->udev = interface_to_usbdev(intf);
 
-	spin_lock_init(&data->lock);
+	/* for sound */
+	iso_intf = usb_ifnum_to_if(data->udev, 1);
+	if (iso_intf && !(id->driver_info & (HCI_BROKEN_ISOC | HCI_SNIFFER))) {
+		err = usb_driver_claim_interface(&btusb_driver,
+						iso_intf,
+						data);
+
+		if (!err)
+			data->iso = iso_intf;
+
+		for (a = 0; a < iso_intf->num_altsetting; a++) {
+			uif = &iso_intf->altsetting[a];
+			for (i = 0; i < uif->desc.bNumEndpoints; i++) {
+				ep = &uif->endpoint[i];
+
+				switch (ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
+				case USB_ENDPOINT_XFER_ISOC:
+					if (uif->desc.bAlternateSetting != 2)
+						break;
+
+					if (ep->desc.bEndpointAddress & USB_DIR_IN)
+						isoc_in_ep  = ep;
+					else
+						isoc_out_ep = ep;
+					break;
+				}
+			}
+		}
+		data->isoc_in_ep = isoc_in_ep;
+		data->isoc_out_ep = isoc_out_ep;
+	}
 
-	INIT_WORK(&data->work, btusb_work);
+	spin_lock_init(&data->lock);
 
 	init_usb_anchor(&data->tx_anchor);
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
+	init_usb_anchor(&data->sco_anchor);
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -503,10 +774,18 @@ static int btusb_probe(struct usb_interf
 
 	hdev->owner = THIS_MODULE;
 
-	set_bit(HCI_QUIRK_RESET_ON_INIT, &hdev->quirks);
+	if (reset || id->driver_info & HCI_RESET)
+		set_bit(HCI_QUIRK_RESET_ON_INIT, &hdev->quirks);
+
+	if (force_scofix || id->driver_info & HCI_WRONG_SCO_MTU) {
+		if (!disable_scofix)
+			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
+	}
 
 	err = hci_register_dev(hdev);
 	if (err < 0) {
+		if (iso_intf)
+			usb_driver_release_interface(&btusb_driver, iso_intf);
 		hci_free_dev(hdev);
 		kfree(data);
 		return err;
@@ -524,12 +803,16 @@ static void btusb_disconnect(struct usb_
 
 	BT_DBG("intf %p", intf);
 
+	/* ignore second interface */
 	if (!data)
 		return;
 
 	hdev = data->hdev;
 
-	usb_set_intfdata(intf, NULL);
+	if (intf == data->iso)
+		usb_set_intfdata(intf, NULL);
+	else if (data->iso)
+		usb_set_intfdata(data->iso, NULL);
 
 	hci_unregister_dev(hdev);
 
