Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't send New Settings event during setup power down
Date: Tue, 21 Feb 2012 12:33:48 +0100
Message-Id: <1329824028-15497-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller gets brought up for initial setup, it will be brought
back down after a timeout. In that case, don't send a New Settings event.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a7439ae..a787c9c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -739,9 +739,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->discov_timeout = 0;
 	}
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-		cancel_delayed_work(&hdev->power_off);
-
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->service_cache);
 
@@ -787,9 +784,11 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	 * and no tasks are scheduled. */
 	hdev->close(hdev);
 
-	hci_dev_lock(hdev);
-	mgmt_powered(hdev, 0);
-	hci_dev_unlock(hdev);
+	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
+		hci_dev_lock(hdev);
+		mgmt_powered(hdev, 0);
+		hci_dev_unlock(hdev);
+	}
 
 	/* Clear flags */
 	hdev->flags = 0;
@@ -808,7 +807,12 @@ int hci_dev_close(__u16 dev)
 	hdev = hci_dev_get(dev);
 	if (!hdev)
 		return -ENODEV;
+
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+		cancel_delayed_work(&hdev->power_off);
+
 	err = hci_dev_do_close(hdev);
+
 	hci_dev_put(hdev);
 	return err;
 }
@@ -1102,9 +1106,7 @@ static void hci_power_off(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	clear_bit(HCI_AUTO_OFF, &hdev->dev_flags);
-
-	hci_dev_close(hdev->id);
+	hci_dev_do_close(hdev);
 }
 
 static void hci_discov_off(struct work_struct *work)
-- 
1.7.7.6

