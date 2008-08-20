Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@suse.cz>
Subject: [rfc]full autosuspend for btusb
Date: Wed, 20 Aug 2008 18:28:09 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Stefan Seyfried <seife@suse.de>,
 linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808201828.10392.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

in the great tradition of totally untested patches here's a version that
should do ultraaggressive runtime powersave. In all likelihood it doesn't
work. I'll test it, but only tomorrow.

	Regards
		Oliver

----

--- linux-2.6.27-rc3/drivers/usb/core/urb.c.alt3	2008-08-20 17:04:50.000000000 +0200
+++ linux-2.6.27-rc3/drivers/usb/core/urb.c	2008-08-20 17:21:24.000000000 +0200
@@ -633,3 +633,47 @@ int usb_wait_anchor_empty_timeout(struct
 				  msecs_to_jiffies(timeout));
 }
 EXPORT_SYMBOL_GPL(usb_wait_anchor_empty_timeout);
+
+struct urb *usb_get_from_anchor(struct usb_anchor *anchor)
+{
+	struct urb *victim;
+	unsigned long flags;
+
+	spin_lock_irqsave(&anchor->lock, flags);
+	if (!list_empty(&anchor->urb_list)) {
+		victim = list_entry(anchor->urb_list.next, struct urb,
+				    anchor_list);
+		usb_get_urb(victim);
+		spin_unlock_irqrestore(&anchor->lock, flags);
+		usb_unanchor_urb(victim);
+	} else {
+		spin_unlock_irqrestore(&anchor->lock, flags);
+		victim = NULL;
+	}
+
+	return victim;
+}
+
+EXPORT_SYMBOL_GPL(usb_get_from_anchor);
+
+void usb_scuttle_anchored_urbs(struct usb_anchor *anchor)
+{
+	struct urb *victim;
+	unsigned long flags;
+
+	spin_lock_irqsave(&anchor->lock, flags);
+	while (!list_empty(&anchor->urb_list)) {
+		victim = list_entry(anchor->urb_list.prev, struct urb,
+				    anchor_list);
+		usb_get_urb(victim);
+		spin_unlock_irqrestore(&anchor->lock, flags);
+		/* this will unanchor the URB */
+		usb_unanchor_urb(victim);
+		usb_put_urb(victim);
+		spin_lock_irqsave(&anchor->lock, flags);
+	}
+	spin_unlock_irqrestore(&anchor->lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(usb_scuttle_anchored_urbs);
+
--- linux-2.6.27-rc3/include/linux/usb.h.alt	2008-08-20 17:05:19.000000000 +0200
+++ linux-2.6.27-rc3/include/linux/usb.h	2008-08-20 17:09:57.000000000 +0200
@@ -1460,6 +1460,8 @@ extern void usb_anchor_urb(struct urb *u
 extern void usb_unanchor_urb(struct urb *urb);
 extern int usb_wait_anchor_empty_timeout(struct usb_anchor *anchor,
 					 unsigned int timeout);
+extern struct urb *usb_get_from_anchor(struct usb_anchor *anchor);
+extern void usb_scuttle_anchored_urbs(struct usb_anchor *anchor);
 
 /**
  * usb_urb_dir_in - check if an URB describes an IN transfer
--- linux-2.6.27-rc3/drivers/bluetooth/btusb.c.alt2	2008-08-20 09:46:20.000000000 +0200
+++ linux-2.6.27-rc3/drivers/bluetooth/btusb.c	2008-08-20 17:46:14.000000000 +0200
@@ -41,7 +41,7 @@
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "0.3"
+#define VERSION "0.4"
 
 static int ignore_dga;
 static int ignore_csr;
@@ -165,6 +165,7 @@ static struct usb_device_id blacklist_ta
 #define BTUSB_INTR_RUNNING	0
 #define BTUSB_BULK_RUNNING	1
 #define BTUSB_ISOC_RUNNING	2
+#define BTUSB_SUSPENDING	3
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -177,11 +178,15 @@ struct btusb_data {
 	unsigned long flags;
 
 	struct work_struct work;
+	struct work_struct waker;
 
 	struct usb_anchor tx_anchor;
 	struct usb_anchor intr_anchor;
 	struct usb_anchor bulk_anchor;
 	struct usb_anchor isoc_anchor;
+	struct usb_anchor deferred;
+	int tx_in_flight;
+	spinlock_t txlock;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
@@ -190,8 +195,23 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *isoc_rx_ep;
 
 	int isoc_altsetting;
+	int did_iso_resume:1;
 };
 
+static int inc_tx(struct btusb_data *data)
+{
+	unsigned long flags;
+	int rv;
+
+	spin_lock_irqsave(&data->txlock, flags);
+	rv = test_bit(BTUSB_SUSPENDING, &data->flags);
+	if (!rv)
+		data->tx_in_flight++;
+	spin_unlock_irqrestore(&data->txlock, flags);
+
+	return rv;
+}
+
 static void btusb_intr_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
@@ -218,6 +238,7 @@ static void btusb_intr_complete(struct u
 	if (!test_bit(BTUSB_INTR_RUNNING, &data->flags))
 		return;
 
+	usb_mark_last_busy(data->udev);
 	usb_anchor_urb(urb, &data->intr_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -228,7 +249,7 @@ static void btusb_intr_complete(struct u
 	}
 }
 
-static int btusb_submit_intr_urb(struct hci_dev *hdev)
+static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -241,13 +262,13 @@ static int btusb_submit_intr_urb(struct
 	if (!data->intr_ep)
 		return -ENODEV;
 
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	urb = usb_alloc_urb(0, gfp);
 	if (!urb)
 		return -ENOMEM;
 
 	size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
 
-	buf = kmalloc(size, GFP_ATOMIC);
+	buf = kmalloc(size, gfp);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
@@ -263,7 +284,7 @@ static int btusb_submit_intr_urb(struct
 
 	usb_anchor_urb(urb, &data->intr_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -302,6 +323,7 @@ static void btusb_bulk_complete(struct u
 	if (!test_bit(BTUSB_BULK_RUNNING, &data->flags))
 		return;
 
+	usb_mark_last_busy(data->udev);
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -312,7 +334,7 @@ static void btusb_bulk_complete(struct u
 	}
 }
 
-static int btusb_submit_bulk_urb(struct hci_dev *hdev)
+static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -325,18 +347,19 @@ static int btusb_submit_bulk_urb(struct
 	if (!data->bulk_rx_ep)
 		return -ENODEV;
 
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	urb = usb_alloc_urb(0, gfp);
 	if (!urb)
 		return -ENOMEM;
 
 	size = le16_to_cpu(data->bulk_rx_ep->wMaxPacketSize);
 
-	buf = kmalloc(size, GFP_ATOMIC);
+	buf = kmalloc(size, gfp);
 	if (!buf) {
 		usb_free_urb(urb);
 		return -ENOMEM;
 	}
 
+	usb_mark_last_busy(data->udev);
 	pipe = usb_rcvbulkpipe(data->udev, data->bulk_rx_ep->bEndpointAddress);
 
 	usb_fill_bulk_urb(urb, data->udev, pipe,
@@ -346,7 +369,7 @@ static int btusb_submit_bulk_urb(struct
 
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -484,6 +507,33 @@ static void btusb_tx_complete(struct urb
 {
 	struct sk_buff *skb = urb->context;
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
+	struct btusb_data *data = hdev->driver_data;
+
+	BT_DBG("%s urb %p status %d count %d", hdev->name,
+					urb, urb->status, urb->actual_length);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		goto done;
+
+	if (!urb->status)
+		hdev->stat.byte_tx += urb->transfer_buffer_length;
+	else
+		hdev->stat.err_tx++;
+
+done:
+	spin_lock(&data->txlock);
+	data->tx_in_flight--;
+	spin_unlock(&data->txlock);
+
+	kfree(urb->setup_packet);
+
+	kfree_skb(skb);
+}
+
+static void btusb_isoc_tx_complete(struct urb *urb)
+{
+	struct sk_buff *skb = urb->context;
+	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
@@ -509,13 +559,19 @@ static int btusb_open(struct hci_dev *hd
 
 	BT_DBG("%s", hdev->name);
 
+	err = usb_autopm_get_interface(data->acl);
+	if (err < 0)
+		return err;
+	data->acl->needs_remote_wakeup = 1;
+	usb_autopm_put_interface(data->acl);
+
 	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		return 0;
 
-	err = btusb_submit_intr_urb(hdev);
+	err = btusb_submit_intr_urb(hdev, GFP_ATOMIC);
 	if (err < 0) {
 		clear_bit(BTUSB_INTR_RUNNING, &hdev->flags);
 		clear_bit(HCI_RUNNING, &hdev->flags);
@@ -524,9 +580,17 @@ static int btusb_open(struct hci_dev *hd
 	return err;
 }
 
+static void btusb_stop_traffic(struct btusb_data *data)
+{
+	usb_kill_anchored_urbs(&data->intr_anchor);
+	usb_kill_anchored_urbs(&data->bulk_anchor);
+	usb_kill_anchored_urbs(&data->isoc_anchor);
+}
+
 static int btusb_close(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hdev->driver_data;
+	int err;
 
 	BT_DBG("%s", hdev->name);
 
@@ -536,14 +600,14 @@ static int btusb_close(struct hci_dev *h
 	flush_work(&data->work);
 
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->intr_anchor);
-
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->bulk_anchor);
-
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->intr_anchor);
-
+	btusb_stop_traffic(data);
+	err = usb_autopm_get_interface(data->acl);
+	if (!err) {
+		data->acl->needs_remote_wakeup = 0;
+		usb_autopm_put_interface(data->acl);
+	}
 	return 0;
 }
 
@@ -629,7 +693,7 @@ static int btusb_send_frame(struct sk_bu
 		urb->dev      = data->udev;
 		urb->pipe     = pipe;
 		urb->context  = skb;
-		urb->complete = btusb_tx_complete;
+		urb->complete = btusb_isoc_tx_complete;
 		urb->interval = data->isoc_tx_ep->bInterval;
 
 		urb->transfer_flags  = URB_ISO_ASAP;
@@ -640,12 +704,19 @@ static int btusb_send_frame(struct sk_bu
 				le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
 
 		hdev->stat.sco_tx++;
-		break;
+		goto skip_waking;
 
 	default:
 		return -EILSEQ;
 	}
 
+	err = inc_tx(data);
+	if (err) {
+		usb_anchor_urb(urb, &data->deferred);
+		schedule_work(&data->waker);
+		goto out;
+	}
+skip_waking:
 	usb_anchor_urb(urb, &data->tx_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -657,6 +728,7 @@ static int btusb_send_frame(struct sk_bu
 
 	usb_free_urb(urb);
 
+out:
 	return err;
 }
 
@@ -677,10 +749,10 @@ static void btusb_notify(struct hci_dev
 
 	if (hdev->conn_hash.acl_num > 0) {
 		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
-			if (btusb_submit_bulk_urb(hdev) < 0)
+			if (btusb_submit_bulk_urb(hdev, GFP_ATOMIC) < 0)
 				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 			else
-				btusb_submit_bulk_urb(hdev);
+				btusb_submit_bulk_urb(hdev, GFP_ATOMIC);
 		}
 	} else {
 		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
@@ -737,8 +809,19 @@ static void btusb_work(struct work_struc
 {
 	struct btusb_data *data = container_of(work, struct btusb_data, work);
 	struct hci_dev *hdev = data->hdev;
+	int err;
 
 	if (hdev->conn_hash.sco_num > 0) {
+		if (!data->did_iso_resume) {
+			err = usb_autopm_get_interface(data->isoc);
+			if (!err) {
+				data->did_iso_resume = 1;
+			} else {
+				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+				usb_kill_anchored_urbs(&data->isoc_anchor);
+				return;
+			}
+		}
 		if (data->isoc_altsetting != 2) {
 			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 			usb_kill_anchored_urbs(&data->isoc_anchor);
@@ -758,9 +841,23 @@ static void btusb_work(struct work_struc
 		usb_kill_anchored_urbs(&data->isoc_anchor);
 
 		__set_isoc_interface(hdev, 0);
+		if (data->did_iso_resume) {
+			data->did_iso_resume = 0;
+			usb_autopm_put_interface(data->isoc);
+		}
 	}
 }
 
+static void btusb_waker(struct work_struct *work)
+{
+	struct btusb_data *data = container_of(work, struct btusb_data, work);
+	int err;
+
+	err = usb_autopm_get_interface(data->acl);
+	if (!err)
+		usb_autopm_put_interface(data->acl);
+}
+
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -828,11 +925,14 @@ static int btusb_probe(struct usb_interf
 	spin_lock_init(&data->lock);
 
 	INIT_WORK(&data->work, btusb_work);
+	INIT_WORK(&data->waker, btusb_waker);
+	spin_lock_init(&data->txlock);
 
 	init_usb_anchor(&data->tx_anchor);
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
 	init_usb_anchor(&data->isoc_anchor);
+	init_usb_anchor(&data->deferred);
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -944,11 +1044,94 @@ static void btusb_disconnect(struct usb_
 	hci_free_dev(hdev);
 }
 
+static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct btusb_data *data = usb_get_intfdata(intf);
+	struct hci_dev *hdev = data->hdev;
+
+	spin_lock_irq(&data->txlock);
+	if (!(interface_to_usbdev(intf)->auto_pm && data->tx_in_flight)) {
+		set_bit(BTUSB_SUSPENDING, &hdev->flags);
+	} else {
+		spin_unlock_irq(&data->txlock);
+		return -EBUSY;
+	}
+	spin_unlock_irq(&data->txlock);
+	cancel_work_sync(&data->work);
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+	return 0;
+}
+
+static void play_deferred(struct btusb_data *data)
+{
+	struct urb *urb;
+	int err;
+
+	while ((urb = usb_get_from_anchor(&data->deferred))) {
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (err < 0)
+			break;
+	}
+	usb_scuttle_anchored_urbs(&data->deferred);
+}
+
+static int btusb_resume(struct usb_interface *intf)
+{
+	struct btusb_data *data = usb_get_intfdata(intf);
+	struct hci_dev *hdev = data->hdev;
+	int ret;
+
+	if (test_bit(HCI_RUNNING, &hdev->flags)) {
+		ret = btusb_submit_intr_urb(hdev, GFP_NOIO);
+		if (ret < 0) {
+			clear_bit(HCI_RUNNING, &hdev->flags);
+			return ret;
+		}
+	}
+
+	if (hdev->conn_hash.acl_num > 0) {
+		ret = btusb_submit_bulk_urb(hdev, GFP_NOIO);
+		if (ret < 0) {
+			clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+			return ret;
+		} else {
+			ret = btusb_submit_bulk_urb(hdev, GFP_NOIO);
+			if (ret < 0) {
+				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+				usb_kill_anchored_urbs(&data->bulk_anchor);
+				return ret;
+			}
+		}
+	}
+
+	if (data->isoc) {
+		if (test_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
+			ret = btusb_submit_isoc_urb(hdev);
+			if (ret < 0)
+				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+			else
+				btusb_submit_isoc_urb(hdev);
+		}
+	}
+
+
+	spin_lock_irq(&data->txlock);
+	play_deferred(data);
+	set_bit(BTUSB_SUSPENDING, &hdev->flags);
+	spin_unlock_irq(&data->txlock);
+	schedule_work(&data->work);
+	return 0;
+}
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
 	.disconnect	= btusb_disconnect,
+	.suspend	= btusb_suspend,
+	.resume		= btusb_resume,
 	.id_table	= btusb_table,
+	.supports_autosuspend = 1,
 };
 
 static int __init btusb_init(void)
