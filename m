Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [patch]race condition in btusb disconnect() handling
Date: Tue, 19 Aug 2008 14:23:52 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808191423.52657.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

btusb has some races in disconnect()

- it doesn't deal with only the iso interface disconnected
- it releases the data interface before unregistering the iso interface
- it isn't carefull to kill all URBs in case of soft disconnect

Signed-off-by: Oliver Neukum <oneukum@suse.de>

	Regards
		Oliver
---

--- linux-2.6.27-rc3/drivers/bluetooth/btusb.c.marcel	2008-08-19 10:21:51.000000000 +0200
+++ linux-2.6.27-rc3/drivers/bluetooth/btusb.c	2008-08-19 14:04:49.000000000 +0200
@@ -169,6 +169,7 @@ static struct usb_device_id blacklist_ta
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
+	struct usb_interface *acl;
 	struct usb_interface *isoc;
 
 	spinlock_t lock;
@@ -523,6 +524,14 @@ static int btusb_open(struct hci_dev *hd
 	return err;
 }
 
+static void btusb_stop_traffic(struct btusb_data *data)
+{
+	usb_kill_anchored_urbs(&data->intr_anchor);
+	usb_kill_anchored_urbs(&data->bulk_anchor);
+	usb_kill_anchored_urbs(&data->isoc_anchor);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+}
+
 static int btusb_close(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hdev->driver_data;
@@ -535,13 +544,9 @@ static int btusb_close(struct hci_dev *h
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
 
 	return 0;
 }
@@ -822,6 +827,7 @@ static int btusb_probe(struct usb_interf
 	}
 
 	data->udev = interface_to_usbdev(intf);
+	data->acl = intf;
 
 	spin_lock_init(&data->lock);
 
@@ -890,7 +896,7 @@ static int btusb_probe(struct usb_interf
 
 	if (data->isoc) {
 		err = usb_driver_claim_interface(&btusb_driver,
-							data->isoc, NULL);
+							data->isoc, data);
 		if (err < 0) {
 			hci_free_dev(hdev);
 			kfree(data);
@@ -922,13 +928,21 @@ static void btusb_disconnect(struct usb_
 
 	hdev = data->hdev;
 
+	usb_set_intfdata(data->acl, NULL);
 	if (data->isoc)
-		usb_driver_release_interface(&btusb_driver, data->isoc);
-
-	usb_set_intfdata(intf, NULL);
+		usb_set_intfdata(data->isoc, NULL);
 
+	/* unregister before releasing any interface */
 	hci_unregister_dev(hdev);
 
+	cancel_work_sync(&data->work);
+	btusb_stop_traffic(data);
+
+	if (intf == data->isoc)
+		usb_driver_release_interface(&btusb_driver, data->acl);
+	else if (data->isoc)
+		usb_driver_release_interface(&btusb_driver, data->isoc);
+
 	hci_free_dev(hdev);
 }
 
