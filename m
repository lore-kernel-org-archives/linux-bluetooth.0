Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Fix Add Device to wait for HCI before sending cmd_complete
Date: Fri, 19 Dec 2014 22:26:02 +0200
Message-Id: <1419020763-9139-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
References: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the Add Device mgmt command handler to use a
hci_request to wait for HCI command completion before notifying user
space of the mgmt command completion. To do this we need to add an extra
hci_request parameter to the hci_conn_params_set function. Since this
function has no other users besides mgmt.c it's moved there as a static
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   2 -
 net/bluetooth/hci_core.c         |  58 -------------------
 net/bluetooth/mgmt.c             | 119 +++++++++++++++++++++++++++++++++++----
 3 files changed, 109 insertions(+), 70 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8eccdf029500..79724c87ab00 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -920,8 +920,6 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type);
-int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			u8 auto_connect);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear_all(struct hci_dev *hdev);
 void hci_conn_params_clear_disabled(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index def6fba01b45..ee2096c7ec2c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3660,23 +3660,6 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 	return NULL;
 }
 
-static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
-{
-	struct hci_conn *conn;
-
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
-	if (!conn)
-		return false;
-
-	if (conn->dst_type != type)
-		return false;
-
-	if (conn->state != BT_CONNECTED)
-		return false;
-
-	return true;
-}
-
 /* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr, u8 addr_type)
@@ -3732,47 +3715,6 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 	return params;
 }
 
-/* This function requires the caller holds hdev->lock */
-int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			u8 auto_connect)
-{
-	struct hci_conn_params *params;
-
-	params = hci_conn_params_add(hdev, addr, addr_type);
-	if (!params)
-		return -EIO;
-
-	if (params->auto_connect == auto_connect)
-		return 0;
-
-	list_del_init(&params->action);
-
-	switch (auto_connect) {
-	case HCI_AUTO_CONN_DISABLED:
-	case HCI_AUTO_CONN_LINK_LOSS:
-		hci_update_background_scan(hdev);
-		break;
-	case HCI_AUTO_CONN_REPORT:
-		list_add(&params->action, &hdev->pend_le_reports);
-		hci_update_background_scan(hdev);
-		break;
-	case HCI_AUTO_CONN_DIRECT:
-	case HCI_AUTO_CONN_ALWAYS:
-		if (!is_connected(hdev, addr, addr_type)) {
-			list_add(&params->action, &hdev->pend_le_conns);
-			hci_update_background_scan(hdev);
-		}
-		break;
-	}
-
-	params->auto_connect = auto_connect;
-
-	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
-	       auto_connect);
-
-	return 0;
-}
-
 static void hci_conn_params_free(struct hci_conn_params *params)
 {
 	if (params->conn) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6b925733c6f8..ec7c0ec3d8d3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5425,6 +5425,65 @@ unlock:
 	return err;
 }
 
+static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
+{
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
+	if (!conn)
+		return false;
+
+	if (conn->dst_type != type)
+		return false;
+
+	if (conn->state != BT_CONNECTED)
+		return false;
+
+	return true;
+}
+
+/* This function requires the caller holds hdev->lock */
+static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
+			       u8 addr_type, u8 auto_connect)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_conn_params *params;
+
+	params = hci_conn_params_add(hdev, addr, addr_type);
+	if (!params)
+		return -EIO;
+
+	if (params->auto_connect == auto_connect)
+		return 0;
+
+	list_del_init(&params->action);
+
+	switch (auto_connect) {
+	case HCI_AUTO_CONN_DISABLED:
+	case HCI_AUTO_CONN_LINK_LOSS:
+		__hci_update_background_scan(req);
+		break;
+	case HCI_AUTO_CONN_REPORT:
+		list_add(&params->action, &hdev->pend_le_reports);
+		__hci_update_background_scan(req);
+		break;
+	case HCI_AUTO_CONN_DIRECT:
+	case HCI_AUTO_CONN_ALWAYS:
+		if (!is_connected(hdev, addr, addr_type)) {
+			list_add(&params->action, &hdev->pend_le_conns);
+			__hci_update_background_scan(req);
+		}
+		break;
+	}
+
+	params->auto_connect = auto_connect;
+
+	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
+	       auto_connect);
+
+	return 0;
+}
+
 static void device_added(struct sock *sk, struct hci_dev *hdev,
 			 bdaddr_t *bdaddr, u8 type, u8 action)
 {
@@ -5437,10 +5496,31 @@ static void device_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
+static void add_device_complete(struct hci_dev *hdev, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(MGMT_OP_ADD_DEVICE, hdev);
+	if (!cmd)
+		goto unlock;
+
+	cmd->cmd_complete(cmd, mgmt_status(status));
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static int add_device(struct sock *sk, struct hci_dev *hdev,
 		      void *data, u16 len)
 {
 	struct mgmt_cp_add_device *cp = data;
+	struct pending_cmd *cmd;
+	struct hci_request req;
 	u8 auto_conn, addr_type;
 	int err;
 
@@ -5457,14 +5537,24 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 				    MGMT_STATUS_INVALID_PARAMS,
 				    &cp->addr, sizeof(cp->addr));
 
+	hci_req_init(&req, hdev);
+
 	hci_dev_lock(hdev);
 
+	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_DEVICE, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	cmd->cmd_complete = addr_cmd_complete;
+
 	if (cp->addr.type == BDADDR_BREDR) {
 		/* Only incoming connections action is supported for now */
 		if (cp->action != 0x01) {
-			err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
-					   MGMT_STATUS_INVALID_PARAMS,
-					   &cp->addr, sizeof(cp->addr));
+			err = 0;
+			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
 
@@ -5473,7 +5563,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		if (err)
 			goto unlock;
 
-		hci_update_page_scan(hdev);
+		__hci_update_page_scan(&req);
 
 		goto added;
 	}
@@ -5493,19 +5583,28 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	/* If the connection parameters don't exist for this device,
 	 * they will be created and configured with defaults.
 	 */
-	if (hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type,
+	if (hci_conn_params_set(&req, &cp->addr.bdaddr, addr_type,
 				auto_conn) < 0) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
-				   MGMT_STATUS_FAILED,
-				   &cp->addr, sizeof(cp->addr));
+		err = 0;
+		cmd->cmd_complete(cmd, MGMT_STATUS_FAILED);
+		mgmt_pending_remove(cmd);
 		goto unlock;
 	}
 
 added:
 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
-			   MGMT_STATUS_SUCCESS, &cp->addr, sizeof(cp->addr));
+	err = hci_req_run(&req, add_device_complete);
+	if (err < 0) {
+		/* ENODATA means no HCI commands were needed (e.g. if
+		 * the adapter is powered off).
+		 */
+		if (err == -ENODATA) {
+			cmd->cmd_complete(cmd, MGMT_STATUS_SUCCESS);
+			err = 0;
+		}
+		mgmt_pending_remove(cmd);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.1.0

