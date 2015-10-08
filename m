Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] Bluetooth: remove btusb_work related workqueue
Date: Thu,  8 Oct 2015 16:55:20 +0200
Message-Id: <1444316120-22893-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Workqueue handling btusb_work is no longer needed as btusb_notify
can sleep.

Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
---
 drivers/bluetooth/btusb.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 247b1062cb9affc67d9e7f7a0234c167f90f4b79..98c616ddd7bac53b2d5d5f8b3dcc2dca2b201e63 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -350,7 +350,6 @@ struct btusb_data {
 
 	unsigned long flags;
 
-	struct work_struct work;
 	struct work_struct waker;
 
 	struct usb_anchor deferred;
@@ -980,7 +979,6 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
@@ -1181,6 +1179,8 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
+static void btusb_sco_change(struct btusb_data *data);
+
 static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -1189,7 +1189,7 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 
 	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
 		data->sco_num = hci_conn_num(hdev, SCO_LINK);
-		schedule_work(&data->work);
+		btusb_sco_change(data);
 	}
 }
 
@@ -1236,9 +1236,8 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 	return 0;
 }
 
-static void btusb_work(struct work_struct *work)
+static void btusb_sco_change(struct btusb_data *data)
 {
-	struct btusb_data *data = container_of(work, struct btusb_data, work);
 	struct hci_dev *hdev = data->hdev;
 	int new_alts;
 	int err;
@@ -2618,7 +2617,6 @@ static int btusb_probe(struct usb_interface *intf,
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
 
-	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
 	init_usb_anchor(&data->deferred);
 	init_usb_anchor(&data->tx_anchor);
@@ -2848,8 +2846,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		return -EBUSY;
 	}
 
-	cancel_work_sync(&data->work);
-
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
 
@@ -2922,7 +2918,7 @@ static int btusb_resume(struct usb_interface *intf)
 	play_deferred(data);
 	clear_bit(BTUSB_SUSPENDING, &data->flags);
 	spin_unlock_irq(&data->txlock);
-	schedule_work(&data->work);
+	btusb_sco_change(data);
 
 	return 0;
 
-- 
1.9.3

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

