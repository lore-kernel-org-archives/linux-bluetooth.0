Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Add hci_request support for hci_update_background_scan
Date: Fri, 19 Dec 2014 22:26:00 +0200
Message-Id: <1419020763-9139-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
References: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Many places using hci_update_background_scan() try to synchronize
whatever they're doing with the help of hci_request callbacks. However,
since the hci_update_background_scan() function hasn't so far accepted a
hci_request pointer any commands triggered by it have been left out by
the synchronization. This patch modifies the API in a similar way as was
done for hci_update_page_scan, i.e. there's a variant that takes a
hci_request and another one that takes a hci_dev.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 -
 net/bluetooth/hci_core.c         | 89 -------------------------------------
 net/bluetooth/hci_request.c      | 96 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h      |  3 ++
 net/bluetooth/mgmt.c             | 12 ++---
 5 files changed, 105 insertions(+), 97 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 93066f70f8ab..8eccdf029500 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -930,8 +930,6 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr,
 						  u8 addr_type);
 
-void hci_update_background_scan(struct hci_dev *hdev);
-
 void hci_uuids_clear(struct hci_dev *hdev);
 
 void hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2cfaaa6acb04..def6fba01b45 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5312,95 +5312,6 @@ static void hci_cmd_work(struct work_struct *work)
 	}
 }
 
-static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
-{
-	if (status)
-		BT_DBG("HCI request failed to update background scanning: "
-		       "status 0x%2.2x", status);
-}
-
-/* This function controls the background scanning based on hdev->pend_le_conns
- * list. If there are pending LE connection we start the background scanning,
- * otherwise we stop it.
- *
- * This function requires the caller holds hdev->lock.
- */
-void hci_update_background_scan(struct hci_dev *hdev)
-{
-	struct hci_request req;
-	struct hci_conn *conn;
-	int err;
-
-	if (!test_bit(HCI_UP, &hdev->flags) ||
-	    test_bit(HCI_INIT, &hdev->flags) ||
-	    test_bit(HCI_SETUP, &hdev->dev_flags) ||
-	    test_bit(HCI_CONFIG, &hdev->dev_flags) ||
-	    test_bit(HCI_AUTO_OFF, &hdev->dev_flags) ||
-	    test_bit(HCI_UNREGISTER, &hdev->dev_flags))
-		return;
-
-	/* No point in doing scanning if LE support hasn't been enabled */
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
-		return;
-
-	/* If discovery is active don't interfere with it */
-	if (hdev->discovery.state != DISCOVERY_STOPPED)
-		return;
-
-	/* Reset RSSI and UUID filters when starting background scanning
-	 * since these filters are meant for service discovery only.
-	 *
-	 * The Start Discovery and Start Service Discovery operations
-	 * ensure to set proper values for RSSI threshold and UUID
-	 * filter list. So it is safe to just reset them here.
-	 */
-	hci_discovery_filter_clear(hdev);
-
-	hci_req_init(&req, hdev);
-
-	if (list_empty(&hdev->pend_le_conns) &&
-	    list_empty(&hdev->pend_le_reports)) {
-		/* If there is no pending LE connections or devices
-		 * to be scanned for, we should stop the background
-		 * scanning.
-		 */
-
-		/* If controller is not scanning we are done. */
-		if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
-			return;
-
-		hci_req_add_le_scan_disable(&req);
-
-		BT_DBG("%s stopping background scanning", hdev->name);
-	} else {
-		/* If there is at least one pending LE connection, we should
-		 * keep the background scan running.
-		 */
-
-		/* If controller is connecting, we should not start scanning
-		 * since some controllers are not able to scan and connect at
-		 * the same time.
-		 */
-		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-		if (conn)
-			return;
-
-		/* If controller is currently scanning, we stop it to ensure we
-		 * don't miss any advertising (due to duplicates filter).
-		 */
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
-			hci_req_add_le_scan_disable(&req);
-
-		hci_req_add_le_passive_scan(&req);
-
-		BT_DBG("%s starting background scanning", hdev->name);
-	}
-
-	err = hci_req_run(&req, update_background_scan_complete);
-	if (err)
-		BT_ERR("Failed to run HCI request: err %d", err);
-}
-
 static bool disconnected_whitelist_entries(struct hci_dev *hdev)
 {
 	struct bdaddr_list *b;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index eba83a2a6556..e49f682f1550 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -395,3 +395,99 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 
 	return 0;
 }
+
+/* This function controls the background scanning based on hdev->pend_le_conns
+ * list. If there are pending LE connection we start the background scanning,
+ * otherwise we stop it.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+void __hci_update_background_scan(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_conn *conn;
+
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    test_bit(HCI_INIT, &hdev->flags) ||
+	    test_bit(HCI_SETUP, &hdev->dev_flags) ||
+	    test_bit(HCI_CONFIG, &hdev->dev_flags) ||
+	    test_bit(HCI_AUTO_OFF, &hdev->dev_flags) ||
+	    test_bit(HCI_UNREGISTER, &hdev->dev_flags))
+		return;
+
+	/* No point in doing scanning if LE support hasn't been enabled */
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		return;
+
+	/* If discovery is active don't interfere with it */
+	if (hdev->discovery.state != DISCOVERY_STOPPED)
+		return;
+
+	/* Reset RSSI and UUID filters when starting background scanning
+	 * since these filters are meant for service discovery only.
+	 *
+	 * The Start Discovery and Start Service Discovery operations
+	 * ensure to set proper values for RSSI threshold and UUID
+	 * filter list. So it is safe to just reset them here.
+	 */
+	hci_discovery_filter_clear(hdev);
+
+	if (list_empty(&hdev->pend_le_conns) &&
+	    list_empty(&hdev->pend_le_reports)) {
+		/* If there is no pending LE connections or devices
+		 * to be scanned for, we should stop the background
+		 * scanning.
+		 */
+
+		/* If controller is not scanning we are done. */
+		if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+			return;
+
+		hci_req_add_le_scan_disable(req);
+
+		BT_DBG("%s stopping background scanning", hdev->name);
+	} else {
+		/* If there is at least one pending LE connection, we should
+		 * keep the background scan running.
+		 */
+
+		/* If controller is connecting, we should not start scanning
+		 * since some controllers are not able to scan and connect at
+		 * the same time.
+		 */
+		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+		if (conn)
+			return;
+
+		/* If controller is currently scanning, we stop it to ensure we
+		 * don't miss any advertising (due to duplicates filter).
+		 */
+		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+			hci_req_add_le_scan_disable(req);
+
+		hci_req_add_le_passive_scan(req);
+
+		BT_DBG("%s starting background scanning", hdev->name);
+	}
+}
+
+static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
+{
+	if (status)
+		BT_DBG("HCI request failed to update background scanning: "
+		       "status 0x%2.2x", status);
+}
+
+void hci_update_background_scan(struct hci_dev *hdev)
+{
+	int err;
+	struct hci_request req;
+
+	hci_req_init(&req, hdev);
+
+	__hci_update_background_scan(&req);
+
+	err = hci_req_run(&req, update_background_scan_complete);
+	if (err && err != -ENODATA)
+		BT_ERR("Failed to run HCI request: err %d", err);
+}
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 1793a46fea65..adf074d33544 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -49,3 +49,6 @@ void __hci_update_page_scan(struct hci_request *req);
 
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			      u8 *own_addr_type);
+
+void hci_update_background_scan(struct hci_dev *hdev);
+void __hci_update_background_scan(struct hci_request *req);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 95473e966703..3afe1e175eb8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2228,9 +2228,8 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 		hci_req_init(&req, hdev);
 		update_adv_data(&req);
 		update_scan_rsp_data(&req);
+		__hci_update_background_scan(&req);
 		hci_req_run(&req, NULL);
-
-		hci_update_background_scan(hdev);
 	}
 
 unlock:
@@ -6038,8 +6037,9 @@ void mgmt_index_removed(struct hci_dev *hdev)
 }
 
 /* This function requires the caller holds hdev->lock */
-static void restart_le_actions(struct hci_dev *hdev)
+static void restart_le_actions(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct hci_conn_params *p;
 
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
@@ -6061,7 +6061,7 @@ static void restart_le_actions(struct hci_dev *hdev)
 		}
 	}
 
-	hci_update_background_scan(hdev);
+	__hci_update_background_scan(req);
 }
 
 static void powered_complete(struct hci_dev *hdev, u8 status)
@@ -6072,8 +6072,6 @@ static void powered_complete(struct hci_dev *hdev, u8 status)
 
 	hci_dev_lock(hdev);
 
-	restart_le_actions(hdev);
-
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	new_settings(hdev, match.sk);
@@ -6131,6 +6129,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 
 		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 			enable_advertising(&req);
+
+		restart_le_actions(&req);
 	}
 
 	link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
-- 
2.1.0

