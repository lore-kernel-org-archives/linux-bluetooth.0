Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add convenience function to check for pending power off
Date: Fri,  1 Aug 2014 11:13:30 +0300
Message-Id: <1406880812-19731-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several situations where we're interested in knowing whether
we're currently in the process of powering off an adapter. This patch
adds a convenience function for the purpose and makes it public since
we'll soon need to access it from hci_event.c as well.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/mgmt.c             | 52 +++++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b5d5af3aa469..8394abc4fd87 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1351,6 +1351,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
+bool mgmt_powering_down(struct hci_dev *hdev);
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
 void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
 void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b8554d429d88..c9de0d9945f5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6281,25 +6281,35 @@ static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
+bool mgmt_powering_down(struct hci_dev *hdev)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_mode *cp;
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
+	if (!cmd)
+		return false;
+
+	cp = cmd->param;
+	if (!cp->val)
+		return true;
+
+	return false;
+}
+
 void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      u8 link_type, u8 addr_type, u8 reason,
 			      bool mgmt_connected)
 {
 	struct mgmt_ev_device_disconnected ev;
-	struct pending_cmd *power_off;
 	struct sock *sk = NULL;
 
-	power_off = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
-	if (power_off) {
-		struct mgmt_mode *cp = power_off->param;
-
-		/* The connection is still in hci_conn_hash so test for 1
-		 * instead of 0 to know if this is the last one.
-		 */
-		if (!cp->val && hci_conn_count(hdev) == 1) {
-			cancel_delayed_work(&hdev->power_off);
-			queue_work(hdev->req_workqueue, &hdev->power_off.work);
-		}
+	/* The connection is still in hci_conn_hash so test for 1
+	 * instead of 0 to know if this is the last one.
+	 */
+	if (mgmt_powering_down(hdev) && hci_conn_count(hdev) == 1) {
+		cancel_delayed_work(&hdev->power_off);
+		queue_work(hdev->req_workqueue, &hdev->power_off.work);
 	}
 
 	if (!mgmt_connected)
@@ -6359,19 +6369,13 @@ void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			 u8 addr_type, u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
-	struct pending_cmd *power_off;
-
-	power_off = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
-	if (power_off) {
-		struct mgmt_mode *cp = power_off->param;
 
-		/* The connection is still in hci_conn_hash so test for 1
-		 * instead of 0 to know if this is the last one.
-		 */
-		if (!cp->val && hci_conn_count(hdev) == 1) {
-			cancel_delayed_work(&hdev->power_off);
-			queue_work(hdev->req_workqueue, &hdev->power_off.work);
-		}
+	/* The connection is still in hci_conn_hash so test for 1
+	 * instead of 0 to know if this is the last one.
+	 */
+	if (mgmt_powering_down(hdev) && hci_conn_count(hdev) == 1) {
+		cancel_delayed_work(&hdev->power_off);
+		queue_work(hdev->req_workqueue, &hdev->power_off.work);
 	}
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-- 
1.9.3

