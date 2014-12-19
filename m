Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Fix Add Device to wait for HCI before sending cmd_complete
Date: Fri, 19 Dec 2014 11:23:37 +0200
Message-Id: <1418981017-10462-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com>
References: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the Add Device mgmt command handler to use a
hci_request to wait for HCI command completion before notifying user
space of the mgmt command completion. To do this we need to add an extra
hci_request parameter to the hci_conn_params_set function. This way we
ensure that once the mgmt command returns all HCI commands triggered by
it have also completed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         |  8 +++---
 net/bluetooth/mgmt.c             | 55 ++++++++++++++++++++++++++++++++--------
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d89a359c83ea..3cd121856b1e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -931,7 +931,7 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type);
 int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			u8 auto_connect);
+			u8 auto_connect, struct hci_request *req);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear_all(struct hci_dev *hdev);
 void hci_conn_params_clear_disabled(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4e54f6e0d248..d4358dc40375 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3733,7 +3733,7 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 
 /* This function requires the caller holds hdev->lock */
 int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			u8 auto_connect)
+			u8 auto_connect, struct hci_request *req)
 {
 	struct hci_conn_params *params;
 
@@ -3749,17 +3749,17 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
 	case HCI_AUTO_CONN_LINK_LOSS:
-		hci_update_background_scan(hdev, NULL);
+		hci_update_background_scan(hdev, req);
 		break;
 	case HCI_AUTO_CONN_REPORT:
 		list_add(&params->action, &hdev->pend_le_reports);
-		hci_update_background_scan(hdev, NULL);
+		hci_update_background_scan(hdev, req);
 		break;
 	case HCI_AUTO_CONN_DIRECT:
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type)) {
 			list_add(&params->action, &hdev->pend_le_conns);
-			hci_update_background_scan(hdev, NULL);
+			hci_update_background_scan(hdev, req);
 		}
 		break;
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ab3dae3076d7..9c44f4c3c2c0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5436,10 +5436,31 @@ static void device_added(struct sock *sk, struct hci_dev *hdev,
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
 
@@ -5456,14 +5477,23 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
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
+			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
 
@@ -5472,7 +5502,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		if (err)
 			goto unlock;
 
-		hci_update_page_scan(hdev, NULL);
+		hci_update_page_scan(hdev, &req);
 
 		goto added;
 	}
@@ -5493,18 +5523,23 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	 * they will be created and configured with defaults.
 	 */
 	if (hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type,
-				auto_conn) < 0) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
-				   MGMT_STATUS_FAILED,
-				   &cp->addr, sizeof(cp->addr));
+				auto_conn, &req) < 0) {
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

