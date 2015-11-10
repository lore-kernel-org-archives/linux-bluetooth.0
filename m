Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/12] Bluetooth: Don't wait for HCI in Add/Remove Device
Date: Tue, 10 Nov 2015 20:14:25 +0200
Message-Id: <1447179274-12276-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
References: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no point in waiting for HCI activity in Add/Remove Device
since the effects of these calls are long-lasting and we can anyway
not report up to the application all HCI failures.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 161 ++++++++++++++++-----------------------------------
 1 file changed, 50 insertions(+), 111 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4afe1d58a32c..b268a6ed0c5f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6076,10 +6076,9 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 }
 
 /* This function requires the caller holds hdev->lock */
-static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
+static int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr,
 			       u8 addr_type, u8 auto_connect)
 {
-	struct hci_dev *hdev = req->hdev;
 	struct hci_conn_params *params;
 
 	params = hci_conn_params_add(hdev, addr, addr_type);
@@ -6099,26 +6098,17 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
 		 */
 		if (params->explicit_connect)
 			list_add(&params->action, &hdev->pend_le_conns);
-
-		__hci_update_background_scan(req);
 		break;
 	case HCI_AUTO_CONN_REPORT:
 		if (params->explicit_connect)
 			list_add(&params->action, &hdev->pend_le_conns);
 		else
 			list_add(&params->action, &hdev->pend_le_reports);
-		__hci_update_background_scan(req);
 		break;
 	case HCI_AUTO_CONN_DIRECT:
 	case HCI_AUTO_CONN_ALWAYS:
-		if (!is_connected(hdev, addr, addr_type)) {
+		if (!is_connected(hdev, addr, addr_type))
 			list_add(&params->action, &hdev->pend_le_conns);
-			/* If we are in scan phase of connecting, we were
-			 * already added to pend_le_conns and scanning.
-			 */
-			if (params->auto_connect != HCI_AUTO_CONN_EXPLICIT)
-				__hci_update_background_scan(req);
-		}
 		break;
 	}
 
@@ -6142,25 +6132,6 @@ static void device_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
-static void add_device_complete(struct hci_dev *hdev, u8 status, u16 opcode)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	BT_DBG("status 0x%02x", status);
-
-	hci_dev_lock(hdev);
-
-	cmd = pending_find(MGMT_OP_ADD_DEVICE, hdev);
-	if (!cmd)
-		goto unlock;
-
-	cmd->cmd_complete(cmd, mgmt_status(status));
-	mgmt_pending_remove(cmd);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
 static int add_device(struct sock *sk, struct hci_dev *hdev,
 		      void *data, u16 len)
 {
@@ -6198,9 +6169,10 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	if (cp->addr.type == BDADDR_BREDR) {
 		/* Only incoming connections action is supported for now */
 		if (cp->action != 0x01) {
-			err = cmd->cmd_complete(cmd,
-						MGMT_STATUS_INVALID_PARAMS);
-			mgmt_pending_remove(cmd);
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_ADD_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 			goto unlock;
 		}
 
@@ -6229,33 +6201,31 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	 * hci_conn_params_lookup.
 	 */
 	if (!hci_is_identity_address(&cp->addr.bdaddr, addr_type)) {
-		err = cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
-		mgmt_pending_remove(cmd);
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+					MGMT_STATUS_INVALID_PARAMS,
+					&cp->addr, sizeof(cp->addr));
 		goto unlock;
 	}
 
 	/* If the connection parameters don't exist for this device,
 	 * they will be created and configured with defaults.
 	 */
-	if (hci_conn_params_set(&req, &cp->addr.bdaddr, addr_type,
+	if (hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type,
 				auto_conn) < 0) {
-		err = cmd->cmd_complete(cmd, MGMT_STATUS_FAILED);
-		mgmt_pending_remove(cmd);
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+					MGMT_STATUS_FAILED, &cp->addr,
+					sizeof(cp->addr));
 		goto unlock;
 	}
 
+	hci_update_background_scan(hdev);
+
 added:
 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
 
-	err = hci_req_run(&req, add_device_complete);
-	if (err < 0) {
-		/* ENODATA means no HCI commands were needed (e.g. if
-		 * the adapter is powered off).
-		 */
-		if (err == -ENODATA)
-			err = cmd->cmd_complete(cmd, MGMT_STATUS_SUCCESS);
-		mgmt_pending_remove(cmd);
-	}
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+				MGMT_STATUS_SUCCESS, &cp->addr,
+				sizeof(cp->addr));
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -6273,55 +6243,25 @@ static void device_removed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
-static void remove_device_complete(struct hci_dev *hdev, u8 status, u16 opcode)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	BT_DBG("status 0x%02x", status);
-
-	hci_dev_lock(hdev);
-
-	cmd = pending_find(MGMT_OP_REMOVE_DEVICE, hdev);
-	if (!cmd)
-		goto unlock;
-
-	cmd->cmd_complete(cmd, mgmt_status(status));
-	mgmt_pending_remove(cmd);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
 static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			 void *data, u16 len)
 {
 	struct mgmt_cp_remove_device *cp = data;
-	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	BT_DBG("%s", hdev->name);
 
-	hci_req_init(&req, hdev);
-
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_DEVICE, hdev, data, len);
-	if (!cmd) {
-		err = -ENOMEM;
-		goto unlock;
-	}
-
-	cmd->cmd_complete = addr_cmd_complete;
-
 	if (bacmp(&cp->addr.bdaddr, BDADDR_ANY)) {
 		struct hci_conn_params *params;
 		u8 addr_type;
 
 		if (!bdaddr_type_is_valid(cp->addr.type)) {
-			err = cmd->cmd_complete(cmd,
-						MGMT_STATUS_INVALID_PARAMS);
-			mgmt_pending_remove(cmd);
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_REMOVE_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 			goto unlock;
 		}
 
@@ -6330,13 +6270,15 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 						  &cp->addr.bdaddr,
 						  cp->addr.type);
 			if (err) {
-				err = cmd->cmd_complete(cmd,
-							MGMT_STATUS_INVALID_PARAMS);
-				mgmt_pending_remove(cmd);
+				err = mgmt_cmd_complete(sk, hdev->id,
+							MGMT_OP_REMOVE_DEVICE,
+							MGMT_STATUS_INVALID_PARAMS,
+							&cp->addr,
+							sizeof(cp->addr));
 				goto unlock;
 			}
 
-			__hci_update_page_scan(&req);
+			hci_update_page_scan(hdev);
 
 			device_removed(sk, hdev, &cp->addr.bdaddr,
 				       cp->addr.type);
@@ -6351,33 +6293,36 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		 * hci_conn_params_lookup.
 		 */
 		if (!hci_is_identity_address(&cp->addr.bdaddr, addr_type)) {
-			err = cmd->cmd_complete(cmd,
-						MGMT_STATUS_INVALID_PARAMS);
-			mgmt_pending_remove(cmd);
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_REMOVE_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 			goto unlock;
 		}
 
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						addr_type);
 		if (!params) {
-			err = cmd->cmd_complete(cmd,
-						MGMT_STATUS_INVALID_PARAMS);
-			mgmt_pending_remove(cmd);
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_REMOVE_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 			goto unlock;
 		}
 
 		if (params->auto_connect == HCI_AUTO_CONN_DISABLED ||
 		    params->auto_connect == HCI_AUTO_CONN_EXPLICIT) {
-			err = cmd->cmd_complete(cmd,
-						MGMT_STATUS_INVALID_PARAMS);
-			mgmt_pending_remove(cmd);
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_REMOVE_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 			goto unlock;
 		}
 
 		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
-		__hci_update_background_scan(&req);
+		hci_update_background_scan(hdev);
 
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
@@ -6385,9 +6330,10 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		struct bdaddr_list *b, *btmp;
 
 		if (cp->addr.type) {
-			err = cmd->cmd_complete(cmd,
-						MGMT_STATUS_INVALID_PARAMS);
-			mgmt_pending_remove(cmd);
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_REMOVE_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 			goto unlock;
 		}
 
@@ -6397,7 +6343,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			kfree(b);
 		}
 
-		__hci_update_page_scan(&req);
+		hci_update_page_scan(hdev);
 
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
@@ -6414,20 +6360,13 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 
 		BT_DBG("All LE connection parameters were removed");
 
-		__hci_update_background_scan(&req);
+		hci_update_background_scan(hdev);
 	}
 
 complete:
-	err = hci_req_run(&req, remove_device_complete);
-	if (err < 0) {
-		/* ENODATA means no HCI commands were needed (e.g. if
-		 * the adapter is powered off).
-		 */
-		if (err == -ENODATA)
-			err = cmd->cmd_complete(cmd, MGMT_STATUS_SUCCESS);
-		mgmt_pending_remove(cmd);
-	}
-
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
+				MGMT_STATUS_SUCCESS, &cp->addr,
+				sizeof(cp->addr));
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
-- 
2.5.0

