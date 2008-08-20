Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [rfc/rft]power management for btusb
Date: Wed, 20 Aug 2008 11:42:52 +0200
Cc: Pavel Machek <pavel@suse.cz>,
 Stefan Seyfried <seife@suse.de>,
 linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808201142.52620.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this implements very simple power management for btusb.
Comments?

	Regards
		Oliver

---

--- linux-2.6.27-rc3/drivers/bluetooth/btusb.c.alt2	2008-08-20 09:46:20.000000000 +0200
+++ linux-2.6.27-rc3/drivers/bluetooth/btusb.c	2008-08-20 10:59:08.000000000 +0200
@@ -228,7 +228,7 @@ static void btusb_intr_complete(struct u
 	}
 }
 
-static int btusb_submit_intr_urb(struct hci_dev *hdev)
+static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -241,13 +241,13 @@ static int btusb_submit_intr_urb(struct
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
@@ -263,7 +263,7 @@ static int btusb_submit_intr_urb(struct
 
 	usb_anchor_urb(urb, &data->intr_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -312,7 +312,7 @@ static void btusb_bulk_complete(struct u
 	}
 }
 
-static int btusb_submit_bulk_urb(struct hci_dev *hdev)
+static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t gfp)
 {
 	struct btusb_data *data = hdev->driver_data;
 	struct urb *urb;
@@ -325,13 +325,13 @@ static int btusb_submit_bulk_urb(struct
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
@@ -346,7 +346,7 @@ static int btusb_submit_bulk_urb(struct
 
 	usb_anchor_urb(urb, &data->bulk_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, gfp);
 	if (err < 0) {
 		BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
@@ -509,21 +509,32 @@ static int btusb_open(struct hci_dev *hd
 
 	BT_DBG("%s", hdev->name);
 
+	err = usb_autopm_get_interface(data->acl);
+	if (err < 0)
+		return err;
 	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		return 0;
 
-	err = btusb_submit_intr_urb(hdev);
+	err = btusb_submit_intr_urb(hdev, GFP_ATOMIC);
 	if (err < 0) {
 		clear_bit(BTUSB_INTR_RUNNING, &hdev->flags);
 		clear_bit(HCI_RUNNING, &hdev->flags);
+		usb_autopm_put_interface(data->acl);
 	}
 
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
@@ -536,13 +547,10 @@ static int btusb_close(struct hci_dev *h
 	flush_work(&data->work);
 
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->intr_anchor);
-
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->bulk_anchor);
-
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
-	usb_kill_anchored_urbs(&data->intr_anchor);
+	btusb_stop_traffic(data);
+	usb_autopm_put_interface(data->acl);
 
 	return 0;
 }
@@ -677,10 +685,10 @@ static void btusb_notify(struct hci_dev
 
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
@@ -944,11 +952,67 @@ static void btusb_disconnect(struct usb_
 	hci_free_dev(hdev);
 }
 
+static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct btusb_data *data = usb_get_intfdata(intf);
+
+	cancel_work_sync(&data->work);
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+	return 0;
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
+	schedule_work(&data->work);
+	if (!data->isoc)
+		return 0;
+
+	if (test_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
+			ret = btusb_submit_isoc_urb(hdev);
+			if (ret < 0)
+				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+			else
+				btusb_submit_isoc_urb(hdev);
+	}
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
