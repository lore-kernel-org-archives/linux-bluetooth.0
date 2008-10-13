Return-Path: <cyrus@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [patch]full autosuspend for btusb #2 - with patch
Cc: Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
From: Oliver Neukum <oliver@neukum.org>
Date: Mon, 13 Oct 2008 12:28:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810131228.32124.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is the full autosuspend support for btusb.
It depends on the patch usb-anchor-api-changes-needed-for-btusb.patch
and should go in after it to allow bisect to work under all circumstances.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>

---

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0cd4a55..c4f2e69 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -35,13 +35,13 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-//#define CONFIG_BT_HCIBTUSB_DEBUG
+#define CONFIG_BT_HCIBTUSB_DEBUG
 #ifndef CONFIG_BT_HCIBTUSB_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "0.3"
+#define VERSION "0.4"
 
 static int ignore_dga;
 static int ignore_csr;
@@ -173,6 +173,7 @@ static struct usb_device_id blacklist_table[] = {
 #define BTUSB_INTR_RUNNING	0
 #define BTUSB_BULK_RUNNING	1
 #define BTUSB_ISOC_RUNNING	2
+#define BTUSB_SUSPENDING	3
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -185,11 +186,13 @@ struct btusb_data {
 	unsigned long flags;
 
 	struct work_struct work;
+	struct work_struct waker;
 
 	struct usb_anchor tx_anchor;
 	struct usb_anchor intr_anchor;
 	struct usb_anchor bulk_anchor;
 	struct usb_anchor isoc_anchor;
+	struct usb_anchor deferred;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
@@ -199,6 +202,7 @@ struct btusb_data {
 
 	int isoc_altsetting;
 	int suspend_count;
+	int did_iso_resume:1;
 };
 
 static void btusb_intr_complete(struct urb *urb)
@@ -227,6 +231,7 @@ static void btusb_intr_complete(struct urb *urb)
 	if (!test_bit(BTUSB_INTR_RUNNING, &data->flags))
 		return;
 
+	usb_mark_last_busy(data->udev);
 	usb_anchor_urb(urb, &data->intr_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -345,6 +350,7 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 		return -ENOMEM;
 	}
 
+	usb_mark_last_busy(data->udev);
 	pipe = usb_rcvbulkpipe(data->udev, data->bulk_rx_ep->bEndpointAddress);
 
 	usb_fill_bulk_urb(urb, data->udev, pipe,
@@ -352,6 +358,7 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 
 	urb->transfer_flags |= URB_FREE_BUFFER;
 
+	usb_mark_last_busy(data->udev);
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
 	err = usb_submit_urb(urb, mem_flags);
@@ -515,6 +522,12 @@ static int btusb_open(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return err;
+	data->intf->needs_remote_wakeup = 1;
+	usb_autopm_put_interface(data->intf);
+
 	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
@@ -530,9 +543,17 @@ static int btusb_open(struct hci_dev *hdev)
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
 
@@ -542,13 +563,15 @@ static int btusb_close(struct hci_dev *hdev)
 	cancel_work_sync(&data->work);
 
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->isoc_anchor);
-
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->bulk_anchor);
-
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->intr_anchor);
+	btusb_stop_traffic(data);
+
+	err = usb_autopm_get_interface(data->intf);
+	if (!err) {
+		data->intf->needs_remote_wakeup = 0;
+		usb_autopm_put_interface(data->intf);
+	}
 
 	return 0;
 }
@@ -571,7 +594,7 @@ static int btusb_send_frame(struct sk_buff *skb)
 	struct usb_ctrlrequest *dr;
 	struct urb *urb;
 	unsigned int pipe;
-	int err;
+	int err, susp;
 
 	BT_DBG("%s", hdev->name);
 
@@ -580,6 +603,7 @@ static int btusb_send_frame(struct sk_buff *skb)
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
+		BT_DBG("HCI_COMMAND_PKT");
 		urb = usb_alloc_urb(0, GFP_ATOMIC);
 		if (!urb)
 			return -ENOMEM;
@@ -605,6 +629,7 @@ static int btusb_send_frame(struct sk_buff *skb)
 		break;
 
 	case HCI_ACLDATA_PKT:
+		BT_DBG("HCI_ACLDATA_PKT");
 		if (!data->bulk_tx_ep || hdev->conn_hash.acl_num < 1)
 			return -ENODEV;
 
@@ -622,6 +647,7 @@ static int btusb_send_frame(struct sk_buff *skb)
 		break;
 
 	case HCI_SCODATA_PKT:
+		BT_DBG("HCI_SCODATA_PKT");
 		if (!data->isoc_tx_ep || hdev->conn_hash.sco_num < 1)
 			return -ENODEV;
 
@@ -652,17 +678,22 @@ static int btusb_send_frame(struct sk_buff *skb)
 		return -EILSEQ;
 	}
 
+	spin_lock(&data->lock);
+	susp = test_bit(BTUSB_SUSPENDING, &data->flags);
 	usb_anchor_urb(urb, &data->tx_anchor);
-
-	err = usb_submit_urb(urb, GFP_ATOMIC);
-	if (err < 0) {
-		BT_ERR("%s urb %p submission failed", hdev->name, urb);
-		kfree(urb->setup_packet);
-		usb_unanchor_urb(urb);
+	if (susp) {
+		schedule_work(&data->waker);
+		err = 0;
+	} else {
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (err < 0) {
+			BT_ERR("%s urb %p submission failed", hdev->name, urb);
+			kfree(urb->setup_packet);
+			usb_unanchor_urb(urb);
+		}
+		usb_free_urb(urb);
 	}
-
-	usb_free_urb(urb);
-
+	spin_unlock(&data->lock);
 	return err;
 }
 
@@ -764,9 +795,26 @@ static void btusb_work(struct work_struct *work)
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
+	struct btusb_data *data = container_of(work, struct btusb_data, waker);
+	int err;
+
+	BUG_ON(data == NULL);
+	BT_DBG("about to resume");
+	BUG_ON(data->intf == NULL);
+	err = usb_autopm_get_interface(data->intf);
+	if (!err)
+		usb_autopm_put_interface(data->intf);
+}
+
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -834,11 +882,13 @@ static int btusb_probe(struct usb_interface *intf,
 	spin_lock_init(&data->lock);
 
 	INIT_WORK(&data->work, btusb_work);
+	INIT_WORK(&data->waker, btusb_waker);
 
 	init_usb_anchor(&data->tx_anchor);
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
 	init_usb_anchor(&data->isoc_anchor);
+	init_usb_anchor(&data->deferred);
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -953,58 +1003,98 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 
-	BT_DBG("intf %p", intf);
+	BT_DBG("%s called\n", __func__);
 
 	if (data->suspend_count++)
 		return 0;
+	spin_lock_irq(&data->lock);
+	if (	interface_to_usbdev(intf)->auto_pm &&
+		!usb_anchor_empty(&data->tx_anchor)) {
+		spin_unlock_irq(&data->lock);
+		return -EBUSY;
+	}
 
-	cancel_work_sync(&data->work);
+	set_bit(BTUSB_SUSPENDING, &data->flags);
+	spin_unlock_irq(&data->lock);
 
+	cancel_work_sync(&data->work);
+	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
+	return 0;
+}
 
-	usb_kill_anchored_urbs(&data->isoc_anchor);
-	usb_kill_anchored_urbs(&data->bulk_anchor);
-	usb_kill_anchored_urbs(&data->intr_anchor);
+static int play_deferred(struct btusb_data *data)
+{
+	struct urb *urb;
+	int err = 0;
 
-	return 0;
+	while ((urb = usb_get_from_anchor(&data->tx_anchor))) {
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (err < 0)
+			break;
+	}
+
+	usb_scuttle_anchored_urbs(&data->tx_anchor);
+	return err;
 }
 
 static int btusb_resume(struct usb_interface *intf)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 	struct hci_dev *hdev = data->hdev;
-	int err;
-
-	BT_DBG("intf %p", intf);
+	int ret;
 
 	if (--data->suspend_count)
 		return 0;
+	if (test_bit(HCI_RUNNING, &hdev->flags)) {
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return 0;
+		spin_lock_irq(&data->lock);
+		ret = play_deferred(data);
+		clear_bit(BTUSB_SUSPENDING, &data->flags);
+		spin_unlock_irq(&data->lock);
 
-	if (test_bit(BTUSB_INTR_RUNNING, &data->flags)) {
-		err = btusb_submit_intr_urb(hdev, GFP_NOIO);
-		if (err < 0) {
-			clear_bit(BTUSB_INTR_RUNNING, &data->flags);
-			return err;
+		if (ret < 0) {
+			clear_bit(HCI_RUNNING, &hdev->flags);
+			return ret;
 		}
+
+		ret = btusb_submit_intr_urb(hdev, GFP_NOIO);
+		if (ret < 0) {
+			clear_bit(HCI_RUNNING, &hdev->flags);
+			return ret;
+		}
+	} else {
+		spin_lock_irq(&data->lock);
+		clear_bit(BTUSB_SUSPENDING, &data->flags);
+		spin_unlock_irq(&data->lock);
 	}
 
-	if (test_bit(BTUSB_BULK_RUNNING, &data->flags)) {
-		if (btusb_submit_bulk_urb(hdev, GFP_NOIO) < 0)
+	if (hdev->conn_hash.acl_num > 0) {
+		ret = btusb_submit_bulk_urb(hdev, GFP_NOIO);
+		if (ret < 0) {
 			clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-		else
-			btusb_submit_bulk_urb(hdev, GFP_NOIO);
+			return ret;
+		} else {
+			ret = btusb_submit_bulk_urb(hdev, GFP_NOIO);
+			if (ret < 0) {
+				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+				usb_kill_anchored_urbs(&data->bulk_anchor);
+				return ret;
+			}
+		}
 	}
 
-	if (test_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
-		if (btusb_submit_isoc_urb(hdev, GFP_NOIO) < 0)
-			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-		else
-			btusb_submit_isoc_urb(hdev, GFP_NOIO);
+	if (data->isoc) {
+		if (test_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
+			ret = btusb_submit_isoc_urb(hdev, GFP_NOIO);
+			if (ret < 0)
+				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+			else
+				btusb_submit_isoc_urb(hdev, GFP_NOIO);
+		}
 	}
 
+	schedule_work(&data->work);
 	return 0;
 }
 
@@ -1015,6 +1105,7 @@ static struct usb_driver btusb_driver = {
 	.suspend	= btusb_suspend,
 	.resume		= btusb_resume,
 	.id_table	= btusb_table,
+	.supports_autosuspend = 1,
 };
 
 static int __init btusb_init(void)
