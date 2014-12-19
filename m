Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Fix Remove Device to wait for HCI before sending cmd_complete
Date: Fri, 19 Dec 2014 22:26:01 +0200
Message-Id: <1419020763-9139-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
References: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the Remove Device mgmt command handler to use a
hci_request to wait for HCI command completion before notifying user
space of the mgmt command completion. This way we ensure that once the
mgmt command returns all HCI commands triggered by it have also
completed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 84 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3afe1e175eb8..6b925733c6f8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5523,24 +5523,55 @@ static void device_removed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
+static void remove_device_complete(struct hci_dev *hdev, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(MGMT_OP_REMOVE_DEVICE, hdev);
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
 static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			 void *data, u16 len)
 {
 	struct mgmt_cp_remove_device *cp = data;
+	struct pending_cmd *cmd;
+	struct hci_request req;
 	int err;
 
 	BT_DBG("%s", hdev->name);
 
+	hci_req_init(&req, hdev);
+
 	hci_dev_lock(hdev);
 
+	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_DEVICE, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	cmd->cmd_complete = addr_cmd_complete;
+
 	if (bacmp(&cp->addr.bdaddr, BDADDR_ANY)) {
 		struct hci_conn_params *params;
 		u8 addr_type;
 
 		if (!bdaddr_type_is_valid(cp->addr.type)) {
-			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-					   MGMT_STATUS_INVALID_PARAMS,
-					   &cp->addr, sizeof(cp->addr));
+			err = 0;
+			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
 
@@ -5549,14 +5580,14 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 						  &cp->addr.bdaddr,
 						  cp->addr.type);
 			if (err) {
-				err = cmd_complete(sk, hdev->id,
-						   MGMT_OP_REMOVE_DEVICE,
-						   MGMT_STATUS_INVALID_PARAMS,
-						   &cp->addr, sizeof(cp->addr));
+				err = 0;
+				cmd->cmd_complete(cmd,
+						  MGMT_STATUS_INVALID_PARAMS);
+				mgmt_pending_remove(cmd);
 				goto unlock;
 			}
 
-			hci_update_page_scan(hdev);
+			__hci_update_page_scan(&req);
 
 			device_removed(sk, hdev, &cp->addr.bdaddr,
 				       cp->addr.type);
@@ -5571,23 +5602,23 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						addr_type);
 		if (!params) {
-			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-					   MGMT_STATUS_INVALID_PARAMS,
-					   &cp->addr, sizeof(cp->addr));
+			err = 0;
+			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
 
 		if (params->auto_connect == HCI_AUTO_CONN_DISABLED) {
-			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-					   MGMT_STATUS_INVALID_PARAMS,
-					   &cp->addr, sizeof(cp->addr));
+			err = 0;
+			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
 
 		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
-		hci_update_background_scan(hdev);
+		__hci_update_background_scan(&req);
 
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
@@ -5595,9 +5626,9 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		struct bdaddr_list *b, *btmp;
 
 		if (cp->addr.type) {
-			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-					   MGMT_STATUS_INVALID_PARAMS,
-					   &cp->addr, sizeof(cp->addr));
+			err = 0;
+			cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
+			mgmt_pending_remove(cmd);
 			goto unlock;
 		}
 
@@ -5607,7 +5638,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			kfree(b);
 		}
 
-		hci_update_page_scan(hdev);
+		__hci_update_page_scan(&req);
 
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
@@ -5620,12 +5651,21 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 
 		BT_DBG("All LE connection parameters were removed");
 
-		hci_update_background_scan(hdev);
+		__hci_update_background_scan(&req);
 	}
 
 complete:
-	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-			   MGMT_STATUS_SUCCESS, &cp->addr, sizeof(cp->addr));
+	err = hci_req_run(&req, remove_device_complete);
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

