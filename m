Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Set ISOC altsetting from within notify callback
Date: Fri,  4 Oct 2013 22:51:45 -0700
Message-Id: <1380952305-14104-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the event handling is done within a workqueue, the notify
callback can now sleep. So no need to trigger a separate workqueue
from within the Bluetooth USB driver.

This should give a little bit better latency with the SCO packet
processing since the ISOC altsetting is correct from the beginning.

However I am not sure if we can actually sleep in the USB reset
handler and what we need to do to restore the correct altsetting
in there. This could potentially fail, so please test ;)

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f3dfc0a..32cae73 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -245,7 +245,6 @@ struct btusb_data {
 
 	unsigned long flags;
 
-	struct work_struct work;
 	struct work_struct waker;
 
 	struct usb_anchor tx_anchor;
@@ -685,7 +684,6 @@ static int btusb_close(struct hci_dev *hdev)
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
-	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
@@ -827,18 +825,6 @@ done:
 	return err;
 }
 
-static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-
-	BT_DBG("%s evt %d", hdev->name, evt);
-
-	if (hdev->conn_hash.sco_num != data->sco_num) {
-		data->sco_num = hdev->conn_hash.sco_num;
-		schedule_work(&data->work);
-	}
-}
-
 static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -882,9 +868,8 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 	return 0;
 }
 
-static void btusb_work(struct work_struct *work)
+static void btusb_update_isoc_altsetting(struct btusb_data *data)
 {
-	struct btusb_data *data = container_of(work, struct btusb_data, work);
 	struct hci_dev *hdev = data->hdev;
 	int new_alts;
 	int err;
@@ -932,6 +917,18 @@ static void btusb_work(struct work_struct *work)
 	}
 }
 
+static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	BT_DBG("%s evt %d", hdev->name, evt);
+
+	if (hdev->conn_hash.sco_num != data->sco_num) {
+		data->sco_num = hdev->conn_hash.sco_num;
+		btusb_update_isoc_altsetting(data);
+	}
+}
+
 static void btusb_waker(struct work_struct *work)
 {
 	struct btusb_data *data = container_of(work, struct btusb_data, waker);
@@ -1404,7 +1401,6 @@ static int btusb_probe(struct usb_interface *intf,
 
 	spin_lock_init(&data->lock);
 
-	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
 	spin_lock_init(&data->txlock);
 
@@ -1540,8 +1536,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		return -EBUSY;
 	}
 
-	cancel_work_sync(&data->work);
-
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
 
@@ -1606,8 +1600,8 @@ static int btusb_resume(struct usb_interface *intf)
 	play_deferred(data);
 	clear_bit(BTUSB_SUSPENDING, &data->flags);
 	spin_unlock_irq(&data->txlock);
-	schedule_work(&data->work);
 
+	btusb_update_isoc_altsetting(data);
 	return 0;
 
 failed:
-- 
1.8.3.1

