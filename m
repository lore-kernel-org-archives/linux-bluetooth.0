Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Remove unnecessary le_scan_restart_work_complete() function
Date: Wed, 11 Nov 2015 12:24:23 +0200
Message-Id: <1447237463-29233-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447237463-29233-1-git-send-email-johan.hedberg@gmail.com>
References: <1447237463-29233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The only user of this, le_scan_restart_work(), is so short and simple
that it makes sense to just merge the code there.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 60 ++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 04c3357b1e1c..e8345d8106b5 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -950,12 +950,35 @@ discov_stopped:
 	hci_dev_unlock(hdev);
 }
 
-static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
+static int le_scan_restart(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_scan_enable cp;
+
+	/* If controller is not scanning we are done. */
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		return 0;
+
+	hci_req_add_le_scan_disable(req);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_ENABLE;
+	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+
+	return 0;
+}
+
+static void le_scan_restart_work(struct work_struct *work)
 {
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    le_scan_restart.work);
 	unsigned long timeout, duration, scan_start, now;
+	u8 status;
 
 	BT_DBG("%s", hdev->name);
 
+	hci_req_sync(hdev, le_scan_restart, 0, HCI_CMD_TIMEOUT, &status);
 	if (status) {
 		BT_ERR("Failed to restart LE scan: status %d", status);
 		return;
@@ -995,41 +1018,6 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static int le_scan_restart(struct hci_request *req, unsigned long opt)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_scan_enable cp;
-
-	/* If controller is not scanning we are done. */
-	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		return 0;
-
-	hci_req_add_le_scan_disable(req);
-
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = LE_SCAN_ENABLE;
-	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-
-	return 0;
-}
-
-static void le_scan_restart_work(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    le_scan_restart.work);
-	u8 status;
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	err = hci_req_sync(hdev, le_scan_restart, 0, HCI_CMD_TIMEOUT, &status);
-	if (err)
-		return;
-
-	le_scan_restart_work_complete(hdev, status);
-}
-
 static void cancel_adv_timeout(struct hci_dev *hdev)
 {
 	if (hdev->adv_instance_timeout) {
-- 
2.5.0

