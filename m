Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Update class of device on discoverable timeout
Date: Tue, 15 Oct 2013 10:45:58 -0700
Message-Id: <1381859158-57636-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the discoverable timeout triggers and limited discoverable mode
was used, then the class of device needs to be updated to remove
the limited discoverable bit.

To keep the class of device logic in a central place, expose a new
function mgmt_discoverable_timeout that can be called from the
timeout callback. In case the class of device value needs updating,
it will add the HCI command the transaction.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 19 +------------------
 net/bluetooth/mgmt.c             | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b076cd9..fc04bc8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1072,6 +1072,7 @@ void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
+void mgmt_discoverable_timeout(struct hci_dev *hdev);
 void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 void mgmt_connectable(struct hci_dev *hdev, u8 connectable);
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7a3d179..2af0bac 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1705,29 +1705,12 @@ static void hci_power_off(struct work_struct *work)
 static void hci_discov_off(struct work_struct *work)
 {
 	struct hci_dev *hdev;
-	struct hci_request req;
-	u8 scan = SCAN_PAGE;
 
 	hdev = container_of(work, struct hci_dev, discov_off.work);
 
 	BT_DBG("%s", hdev->name);
 
-	hci_dev_lock(hdev);
-
-	hci_req_init(&req, hdev);
-	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
-	hci_req_run(&req, NULL);
-
-	/* When discoverable timeout triggers, then just make sure
-	 * the limited discoverable flag is cleared. Even in the case
-	 * of a timeout triggered from general discoverable, it is
-	 * safe to unconditionally clear the flag.
-	 */
-	clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
-
-	hdev->discov_timeout = 0;
-
-	hci_dev_unlock(hdev);
+	mgmt_discoverable_timeout(hdev);
 }
 
 int hci_uuids_clear(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 292e81f..ca3cdb5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4288,6 +4288,30 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
 	mgmt_pending_remove(cmd);
 }
 
+void mgmt_discoverable_timeout(struct hci_dev *hdev)
+{
+	struct hci_request req;
+	u8 scan = SCAN_PAGE;
+
+	hci_dev_lock(hdev);
+
+	/* When discoverable timeout triggers, then just make sure
+	 * the limited discoverable flag is cleared. Even in the case
+	 * of a timeout triggered from general discoverable, it is
+	 * safe to unconditionally clear the flag.
+	 */
+	clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
+	update_class(&req);
+	hci_req_run(&req, NULL);
+
+	hdev->discov_timeout = 0;
+
+	hci_dev_unlock(hdev);
+}
+
 void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 {
 	bool changed;
-- 
1.8.3.1

