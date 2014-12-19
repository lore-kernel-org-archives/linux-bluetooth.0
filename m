Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Fix Remove Device to wait for HCI before sending cmd_complete
Date: Fri, 19 Dec 2014 11:23:36 +0200
Message-Id: <1418981017-10462-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com>
References: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com>
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
 net/bluetooth/mgmt.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7efdeb3cf224..ab3dae3076d7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5522,16 +5522,47 @@ static void device_removed(struct sock *sk, struct hci_dev *hdev,
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
@@ -5555,7 +5586,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 				goto unlock;
 			}
 
-			hci_update_page_scan(hdev, NULL);
+			hci_update_page_scan(hdev, &req);
 
 			device_removed(sk, hdev, &cp->addr.bdaddr,
 				       cp->addr.type);
@@ -5586,7 +5617,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
-		hci_update_background_scan(hdev, NULL);
+		hci_update_background_scan(hdev, &req);
 
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
@@ -5606,7 +5637,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			kfree(b);
 		}
 
-		hci_update_page_scan(hdev, NULL);
+		hci_update_page_scan(hdev, &req);
 
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
@@ -5619,12 +5650,18 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 
 		BT_DBG("All LE connection parameters were removed");
 
-		hci_update_background_scan(hdev, NULL);
+		hci_update_background_scan(hdev, &req);
 	}
 
 complete:
-	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-			   MGMT_STATUS_SUCCESS, &cp->addr, sizeof(cp->addr));
+	err = hci_req_run(&req, remove_device_complete);
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

