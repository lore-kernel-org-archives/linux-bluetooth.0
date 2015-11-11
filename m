Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 12/12] Bluetooth: Move Stop Discovery to req_workqueue
Date: Wed, 11 Nov 2015 08:14:23 +0200
Message-Id: <1447222463-5069-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447222287-4288-1-git-send-email-johan.hedberg@gmail.com>
References: <1447222287-4288-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since discovery also deals with LE scanning it makes sense to move it
behind the same req_workqueue as other LE scanning changes. This also
simplifies the logic since we do many of the actions in a synchronous
manner.

Part of this refactoring is moving hci_req_stop_discovery() to
hci_request.c. At the same time the function receives support for
properly handling the STOPPING state since that's the state we'll be
in when stopping through the req_workqueue.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_request.c      | 62 ++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h      |  3 ++
 net/bluetooth/mgmt.c             | 72 +++-------------------------------------
 4 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 72ea8a6d7d70..609f4a03899c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1475,6 +1475,7 @@ void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status);
+void mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 13b5fb773ef5..cdf1c0fd5985 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1222,6 +1222,62 @@ static void start_discovery(struct hci_dev *hdev, u8 *status)
 			   timeout);
 }
 
+bool hci_req_stop_discovery(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct discovery_state *d = &hdev->discovery;
+	struct hci_cp_remote_name_req_cancel cp;
+	struct inquiry_entry *e;
+	bool ret = false;
+
+	BT_DBG("%s state %u", hdev->name, hdev->discovery.state);
+
+	if (d->state == DISCOVERY_FINDING || d->state == DISCOVERY_STOPPING) {
+		if (test_bit(HCI_INQUIRY, &hdev->flags))
+			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+			cancel_delayed_work(&hdev->le_scan_disable);
+			hci_req_add_le_scan_disable(req);
+		}
+
+		ret = true;
+	} else {
+		/* Passive scanning */
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+			hci_req_add_le_scan_disable(req);
+			ret = true;
+		}
+	}
+
+	/* No further actions needed for LE-only discovery */
+	if (d->type == DISCOV_TYPE_LE)
+		return ret;
+
+	if (d->state == DISCOVERY_RESOLVING || d->state == DISCOVERY_STOPPING) {
+		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
+						     NAME_PENDING);
+		if (!e)
+			return ret;
+
+		bacpy(&cp.bdaddr, &e->data.bdaddr);
+		hci_req_add(req, HCI_OP_REMOTE_NAME_REQ_CANCEL, sizeof(cp),
+			    &cp);
+		ret = true;
+	}
+
+	return ret;
+}
+
+static int stop_discovery(struct hci_request *req, unsigned long opt)
+{
+	hci_dev_lock(req->hdev);
+	hci_req_stop_discovery(req);
+	hci_dev_unlock(req->hdev);
+
+	return 0;
+}
+
 static void discov_update(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1237,6 +1293,12 @@ static void discov_update(struct work_struct *work)
 		else
 			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 		break;
+	case DISCOVERY_STOPPING:
+		hci_req_sync(hdev, stop_discovery, 0, HCI_CMD_TIMEOUT, &status);
+		mgmt_stop_discovery_complete(hdev, status);
+		if (!status)
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		break;
 	case DISCOVERY_STOPPED:
 	default:
 		return;
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 1927013f5e67..6b9e59f7f7a9 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -58,6 +58,9 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
+/* Returns true if HCI commands were queued */
+bool hci_req_stop_discovery(struct hci_request *req);
+
 void hci_update_page_scan(struct hci_dev *hdev);
 void __hci_update_page_scan(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 63b099471c92..8cdacef6b108 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1416,49 +1416,6 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	}
 }
 
-static bool hci_stop_discovery(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_remote_name_req_cancel cp;
-	struct inquiry_entry *e;
-
-	switch (hdev->discovery.state) {
-	case DISCOVERY_FINDING:
-		if (test_bit(HCI_INQUIRY, &hdev->flags))
-			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-			cancel_delayed_work(&hdev->le_scan_disable);
-			hci_req_add_le_scan_disable(req);
-		}
-
-		return true;
-
-	case DISCOVERY_RESOLVING:
-		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
-						     NAME_PENDING);
-		if (!e)
-			break;
-
-		bacpy(&cp.bdaddr, &e->data.bdaddr);
-		hci_req_add(req, HCI_OP_REMOTE_NAME_REQ_CANCEL, sizeof(cp),
-			    &cp);
-
-		return true;
-
-	default:
-		/* Passive scanning */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-			hci_req_add_le_scan_disable(req);
-			return true;
-		}
-
-		break;
-	}
-
-	return false;
-}
-
 static void advertising_added(struct sock *sk, struct hci_dev *hdev,
 			      u8 instance)
 {
@@ -1636,7 +1593,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		disable_advertising(&req);
 
-	discov_stopped = hci_stop_discovery(&req);
+	discov_stopped = hci_req_stop_discovery(&req);
 
 	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
 		/* 0x15 == Terminated due to Power Off */
@@ -4377,7 +4334,7 @@ failed:
 	return err;
 }
 
-static void stop_discovery_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+void mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status)
 {
 	struct mgmt_pending_cmd *cmd;
 
@@ -4391,9 +4348,6 @@ static void stop_discovery_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		mgmt_pending_remove(cmd);
 	}
 
-	if (!status)
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-
 	hci_dev_unlock(hdev);
 }
 
@@ -4402,7 +4356,6 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_stop_discovery *mgmt_cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -4431,24 +4384,9 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	cmd->cmd_complete = generic_cmd_complete;
 
-	hci_req_init(&req, hdev);
-
-	hci_stop_discovery(&req);
-
-	err = hci_req_run(&req, stop_discovery_complete);
-	if (!err) {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
-		goto unlock;
-	}
-
-	mgmt_pending_remove(cmd);
-
-	/* If no HCI commands were sent we're done */
-	if (err == -ENODATA) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
-					&mgmt_cp->type, sizeof(mgmt_cp->type));
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-	}
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
+	queue_work(hdev->req_workqueue, &hdev->discov_update);
+	err = 0;
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.5.0

