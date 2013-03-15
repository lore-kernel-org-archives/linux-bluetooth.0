Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 05/26] Bluetooth: Fix UUID/class mgmt command response synchronization
Date: Fri, 15 Mar 2013 17:06:55 -0500
Message-Id: <1363385236-25704-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should only return a mgmt command complete once all HCI commands to a
mgmt_set_dev_class or mgmt_add/remove_uuid command have completed. This
patch fixes the issue by having a proper async request complete callback
for these actions and responding to user space in the callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   73 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 367837d..8a0bbb9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1378,6 +1378,32 @@ static u8 get_uuid_size(const u8 *uuid)
 	return 16;
 }
 
+static void mgmt_class_complete(struct hci_dev *hdev, u16 mgmt_op, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(mgmt_op, hdev);
+	if (!cmd)
+		goto unlock;
+
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(status),
+		     hdev->dev_class, 3);
+
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static void add_uuid_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("status 0x%02x", status);
+
+	mgmt_class_complete(hdev, MGMT_OP_ADD_UUID, status);
+}
+
 static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
@@ -1413,9 +1439,11 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	update_class(&req);
 	update_eir(&req);
 
-	hci_req_run(&req, NULL);
+	err = hci_req_run(&req, add_uuid_complete);
+	if (err < 0) {
+		if (err != -ENODATA)
+			goto failed;
 
-	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
 				   hdev->dev_class, 3);
 		goto failed;
@@ -1448,6 +1476,13 @@ static bool enable_service_cache(struct hci_dev *hdev)
 	return false;
 }
 
+static void remove_uuid_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("status 0x%02x", status);
+
+	mgmt_class_complete(hdev, MGMT_OP_REMOVE_UUID, status);
+}
+
 static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 		       u16 len)
 {
@@ -1503,9 +1538,11 @@ update_class:
 	update_class(&req);
 	update_eir(&req);
 
-	hci_req_run(&req, NULL);
+	err = hci_req_run(&req, remove_uuid_complete);
+	if (err < 0) {
+		if (err != -ENODATA)
+			goto unlock;
 
-	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
 				   hdev->dev_class, 3);
 		goto unlock;
@@ -1524,6 +1561,13 @@ unlock:
 	return err;
 }
 
+static void set_class_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("status 0x%02x", status);
+
+	mgmt_class_complete(hdev, MGMT_OP_SET_DEV_CLASS, status);
+}
+
 static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 len)
 {
@@ -1572,9 +1616,11 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	update_class(&req);
 
-	hci_req_run(&req, NULL);
+	err = hci_req_run(&req, set_class_complete);
+	if (err < 0) {
+		if (err != -ENODATA)
+			goto unlock;
 
-	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
 				   hdev->dev_class, 3);
 		goto unlock;
@@ -3700,21 +3746,14 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	return err;
 }
 
-static void class_rsp(struct pending_cmd *cmd, void *data)
+static void sk_lookup(struct pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
 
-	cmd_complete(cmd->sk, cmd->index, cmd->opcode, match->mgmt_status,
-		     match->hdev->dev_class, 3);
-
-	list_del(&cmd->list);
-
 	if (match->sk == NULL) {
 		match->sk = cmd->sk;
 		sock_hold(match->sk);
 	}
-
-	mgmt_pending_free(cmd);
 }
 
 int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
@@ -3725,9 +3764,9 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 
 	clear_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
 
-	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, class_rsp, &match);
-	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, class_rsp, &match);
-	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, class_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, sk_lookup, &match);
+	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, sk_lookup, &match);
+	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
 
 	if (!status)
 		err = mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class,
-- 
1.7.10.4

