Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Add hci_request parameter to hci_update_background_scan
Date: Fri, 19 Dec 2014 11:23:35 +0200
Message-Id: <1418981017-10462-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com>
References: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Many places using hci_update_background_scan() try to synchronize
whatever they're doing with the help of hci_request callbacks. However,
since the hci_update_background_scan() function hasn't so far accepted a
hci_request pointer any commands triggered by it have been left out by
the synchronization. This patch an extra parameter to the function to
fix the issue. This there are also many places where there is no
existing hci_request context, the parameter is made optional, i.e. by
passing NULL hci_update_background_scan() uses its own request and a
dummy callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_core.c         | 33 ++++++++++++++++++++-------------
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/mgmt.c             | 19 +++++++++----------
 5 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 75aaae07037f..d89a359c83ea 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -940,7 +940,7 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr,
 						  u8 addr_type);
 
-void hci_update_background_scan(struct hci_dev *hdev);
+void hci_update_background_scan(struct hci_dev *hdev, struct hci_request *req);
 
 void hci_uuids_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fe18825cc8a4..2d3268bcd745 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -621,7 +621,7 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	/* Since we may have temporarily stopped the background scanning in
 	 * favor of connection establishment, we should restart it.
 	 */
-	hci_update_background_scan(hdev);
+	hci_update_background_scan(hdev, NULL);
 
 	/* Re-enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5dcacf9607e4..4e54f6e0d248 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2072,7 +2072,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
-		hci_update_background_scan(hdev);
+		hci_update_background_scan(hdev, NULL);
 
 		if (old_state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
@@ -3749,17 +3749,17 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
 	case HCI_AUTO_CONN_LINK_LOSS:
-		hci_update_background_scan(hdev);
+		hci_update_background_scan(hdev, NULL);
 		break;
 	case HCI_AUTO_CONN_REPORT:
 		list_add(&params->action, &hdev->pend_le_reports);
-		hci_update_background_scan(hdev);
+		hci_update_background_scan(hdev, NULL);
 		break;
 	case HCI_AUTO_CONN_DIRECT:
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type)) {
 			list_add(&params->action, &hdev->pend_le_conns);
-			hci_update_background_scan(hdev);
+			hci_update_background_scan(hdev, NULL);
 		}
 		break;
 	}
@@ -3795,7 +3795,7 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 
 	hci_conn_params_free(params);
 
-	hci_update_background_scan(hdev);
+	hci_update_background_scan(hdev, NULL);
 
 	BT_DBG("addr %pMR (type %u)", addr, addr_type);
 }
@@ -3823,7 +3823,7 @@ void hci_conn_params_clear_all(struct hci_dev *hdev)
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list)
 		hci_conn_params_free(params);
 
-	hci_update_background_scan(hdev);
+	hci_update_background_scan(hdev, NULL);
 
 	BT_DBG("All LE connection parameters were removed");
 }
@@ -5693,9 +5693,9 @@ static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
  *
  * This function requires the caller holds hdev->lock.
  */
-void hci_update_background_scan(struct hci_dev *hdev)
+void hci_update_background_scan(struct hci_dev *hdev, struct hci_request *req)
 {
-	struct hci_request req;
+	struct hci_request local_req;
 	struct hci_conn *conn;
 	int err;
 
@@ -5724,7 +5724,10 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	 */
 	hci_discovery_filter_clear(hdev);
 
-	hci_req_init(&req, hdev);
+	if (!req) {
+		req = &local_req;
+		hci_req_init(req, hdev);
+	}
 
 	if (list_empty(&hdev->pend_le_conns) &&
 	    list_empty(&hdev->pend_le_reports)) {
@@ -5737,7 +5740,7 @@ void hci_update_background_scan(struct hci_dev *hdev)
 		if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
 			return;
 
-		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_scan_disable(req);
 
 		BT_DBG("%s stopping background scanning", hdev->name);
 	} else {
@@ -5757,14 +5760,18 @@ void hci_update_background_scan(struct hci_dev *hdev)
 		 * don't miss any advertising (due to duplicates filter).
 		 */
 		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
-			hci_req_add_le_scan_disable(&req);
+			hci_req_add_le_scan_disable(req);
 
-		hci_req_add_le_passive_scan(&req);
+		hci_req_add_le_passive_scan(req);
 
 		BT_DBG("%s starting background scanning", hdev->name);
 	}
 
-	err = hci_req_run(&req, update_background_scan_complete);
+	/* Callers providing a req are responsible for calling req_run */
+	if (req != &local_req)
+		return;
+
+	err = hci_req_run(req, update_background_scan_complete);
 	if (err)
 		BT_ERR("Failed to run HCI request: err %d", err);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 39a5c8a01726..80ccafcde477 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2323,7 +2323,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		case HCI_AUTO_CONN_ALWAYS:
 			list_del_init(&params->action);
 			list_add(&params->action, &hdev->pend_le_conns);
-			hci_update_background_scan(hdev);
+			hci_update_background_scan(hdev, NULL);
 			break;
 
 		default:
@@ -4338,7 +4338,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 unlock:
-	hci_update_background_scan(hdev);
+	hci_update_background_scan(hdev, NULL);
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 693ce8bcd06e..7efdeb3cf224 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1816,7 +1816,7 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 		hci_update_page_scan(hdev, NULL);
 		if (discov_changed)
 			mgmt_update_adv_data(hdev);
-		hci_update_background_scan(hdev);
+		hci_update_background_scan(hdev, NULL);
 	}
 
 remove_cmd:
@@ -1848,7 +1848,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 
 	if (changed) {
 		hci_update_page_scan(hdev, NULL);
-		hci_update_background_scan(hdev);
+		hci_update_background_scan(hdev, NULL);
 		return new_settings(hdev, sk);
 	}
 
@@ -2227,9 +2227,8 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 		hci_req_init(&req, hdev);
 		update_adv_data(&req);
 		update_scan_rsp_data(&req);
+		hci_update_background_scan(hdev, &req);
 		hci_req_run(&req, NULL);
-
-		hci_update_background_scan(hdev);
 	}
 
 unlock:
@@ -5587,7 +5586,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
-		hci_update_background_scan(hdev);
+		hci_update_background_scan(hdev, NULL);
 
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
@@ -5620,7 +5619,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 
 		BT_DBG("All LE connection parameters were removed");
 
-		hci_update_background_scan(hdev);
+		hci_update_background_scan(hdev, NULL);
 	}
 
 complete:
@@ -6037,7 +6036,7 @@ void mgmt_index_removed(struct hci_dev *hdev)
 }
 
 /* This function requires the caller holds hdev->lock */
-static void restart_le_actions(struct hci_dev *hdev)
+static void restart_le_actions(struct hci_dev *hdev, struct hci_request *req)
 {
 	struct hci_conn_params *p;
 
@@ -6060,7 +6059,7 @@ static void restart_le_actions(struct hci_dev *hdev)
 		}
 	}
 
-	hci_update_background_scan(hdev);
+	hci_update_background_scan(hdev, req);
 }
 
 static void powered_complete(struct hci_dev *hdev, u8 status)
@@ -6071,8 +6070,6 @@ static void powered_complete(struct hci_dev *hdev, u8 status)
 
 	hci_dev_lock(hdev);
 
-	restart_le_actions(hdev);
-
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	new_settings(hdev, match.sk);
@@ -6130,6 +6127,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 
 		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 			enable_advertising(&req);
+
+		restart_le_actions(hdev, &req);
 	}
 
 	link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
-- 
2.1.0

