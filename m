Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/12] Bluetooth: Fix clearing and restarting all LE actions on power cycle
Date: Fri,  4 Jul 2014 12:37:23 +0300
Message-Id: <1404466647-16352-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When powering off (hci_dev_do_close) we should clear both the
pend_le_reports and pend_le_conns types of entries. When powering on
respectively we should populate both lists. This patch converts the
hci_pend_le_conns_clear() function into hci_pend_le_actions_clear()
(which can now be static) and converts the restart_le_auto_conns()
function into restart_le_actions().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 23 ++++++++++++-----------
 net/bluetooth/mgmt.c             | 33 ++++++++++++++++-----------------
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 758146c513d3..9208b18cb1e9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -871,7 +871,6 @@ void hci_conn_params_clear_enabled(struct hci_dev *hdev);
 struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
 						bdaddr_t *addr, u8 addr_type);
 void hci_pend_le_conn_add(struct hci_dev *hdev, struct hci_conn_params *params);
-void hci_pend_le_conns_clear(struct hci_dev *hdev);
 
 void hci_update_background_scan(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6eadde820333..3a1a25dcb2bc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2354,6 +2354,17 @@ done:
 	return err;
 }
 
+/* This function requires the caller holds hdev->lock */
+static void hci_pend_le_actions_clear(struct hci_dev *hdev)
+{
+	struct hci_conn_params *p;
+
+	list_for_each_entry(p, &hdev->le_conn_params, list)
+		list_del_init(&p->action);
+
+	BT_DBG("All LE pending actions cleared");
+}
+
 static int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
@@ -2391,7 +2402,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_dev_lock(hdev);
 	hci_inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
-	hci_pend_le_conns_clear(hdev);
+	hci_pend_le_actions_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_notify(hdev, HCI_DEV_DOWN);
@@ -3460,16 +3471,6 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, struct hci_conn_params *params)
 	hci_update_background_scan(hdev);
 }
 
-/* This function requires the caller holds hdev->lock */
-void hci_pend_le_conns_clear(struct hci_dev *hdev)
-{
-	while (!list_empty(&hdev->pend_le_conns))
-		list_del_init(hdev->pend_le_conns.next);
-
-	BT_DBG("All LE pending connections cleared");
-}
-
-/* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 77c64b8cb7e2..f1672b15c0f3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5533,29 +5533,28 @@ void mgmt_index_removed(struct hci_dev *hdev)
 }
 
 /* This function requires the caller holds hdev->lock */
-static void restart_le_auto_conns(struct hci_dev *hdev)
+static void restart_le_actions(struct hci_dev *hdev)
 {
 	struct hci_conn_params *p;
-	bool added = false;
 
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
-		if (p->auto_connect == HCI_AUTO_CONN_ALWAYS) {
-			hci_pend_le_conn_add(hdev, p);
-			added = true;
+		/* Needed for AUTO_OFF case where might not "really"
+		 * have been powered off.
+		 */
+		list_del_init(&p->action);
+
+		switch (p->auto_connect) {
+		case HCI_AUTO_CONN_ALWAYS:
+			list_add(&p->action, &hdev->pend_le_conns);
+			break;
+		case HCI_AUTO_CONN_REPORT:
+			list_add(&p->action, &hdev->pend_le_reports);
+			break;
+		default:
+			break;
 		}
 	}
 
-	/* Calling hci_pend_le_conn_add will actually already trigger
-	 * background scanning when needed. So no need to trigger it
-	 * just another time.
-	 *
-	 * This check is here to avoid an unneeded restart of the
-	 * passive scanning. Since this is during the controller
-	 * power up phase the duplicate filtering is not an issue.
-	 */
-	if (added)
-		return;
-
 	hci_update_background_scan(hdev);
 }
 
@@ -5567,7 +5566,7 @@ static void powered_complete(struct hci_dev *hdev, u8 status)
 
 	hci_dev_lock(hdev);
 
-	restart_le_auto_conns(hdev);
+	restart_le_actions(hdev);
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
-- 
1.9.3

