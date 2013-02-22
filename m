Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 13/15] Bluetooth: Fix UUID/class mgmt command response synchronization
Date: Fri, 22 Feb 2013 16:48:30 +0200
Message-Id: <1361544512-4056-14-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361544512-4056-1-git-send-email-johan.hedberg@gmail.com>
References: <1361544512-4056-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should only return a mgmt command complete once all HCI commands to a
mgmt_set_dev_class or mgmt_add/remove_uuid command have completed. This
patch fixes the issue by having a proper transaction complete callback
for these actions and responding to user space in the callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   69 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 41a3265..d035bee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1377,6 +1377,28 @@ static u8 get_uuid_size(const u8 *uuid)
 	return 16;
 }
 
+static void mgmt_class_complete(struct hci_dev *hdev, u16 mgmt_op, int status)
+{
+	struct pending_cmd *cmd;
+
+	cmd = mgmt_pending_find(mgmt_op, hdev);
+	if (!cmd)
+		return;
+
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(status),
+		     hdev->dev_class, 3);
+
+	list_del(&cmd->list);
+	mgmt_pending_free(cmd);
+}
+
+static void add_uuid_complete(struct hci_dev *hdev, u16 opcode, int status)
+{
+	BT_DBG("opcode 0x%02x status %d", opcode, status);
+
+	mgmt_class_complete(hdev, MGMT_OP_ADD_UUID, status);
+}
+
 static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
@@ -1407,14 +1429,12 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	list_add_tail(&uuid->list, &hdev->uuids);
 
-	hci_transaction_init(&transaction, hdev, NULL);
+	hci_transaction_init(&transaction, hdev, add_uuid_complete);
 
 	update_class(&transaction);
 	update_eir(&transaction);
 
-	hci_transaction_run(&transaction);
-
-	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+	if (hci_transaction_run(&transaction) < 0) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
 				   hdev->dev_class, 3);
 		goto failed;
@@ -1447,6 +1467,13 @@ static bool enable_service_cache(struct hci_dev *hdev)
 	return false;
 }
 
+static void remove_uuid_complete(struct hci_dev *hdev, u16 opcode, int status)
+{
+	BT_DBG("opcode 0x%02x status %d", opcode, status);
+
+	mgmt_class_complete(hdev, MGMT_OP_REMOVE_UUID, status);
+}
+
 static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 		       u16 len)
 {
@@ -1497,14 +1524,12 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 update_class:
-	hci_transaction_init(&transaction, hdev, NULL);
+	hci_transaction_init(&transaction, hdev, remove_uuid_complete);
 
 	update_class(&transaction);
 	update_eir(&transaction);
 
-	hci_transaction_run(&transaction);
-
-	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+	if (hci_transaction_run(&transaction) < 0) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
 				   hdev->dev_class, 3);
 		goto unlock;
@@ -1523,6 +1548,13 @@ unlock:
 	return err;
 }
 
+static void set_class_complete(struct hci_dev *hdev, u16 opcode, int status)
+{
+	BT_DBG("opcode 0x%02x status %d", opcode, status);
+
+	mgmt_class_complete(hdev, MGMT_OP_SET_DEV_CLASS, status);
+}
+
 static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 len)
 {
@@ -1560,7 +1592,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	hci_transaction_init(&transaction, hdev, NULL);
+	hci_transaction_init(&transaction, hdev, set_class_complete);
 
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
 		hci_dev_unlock(hdev);
@@ -1571,9 +1603,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	update_class(&transaction);
 
-	hci_transaction_run(&transaction);
-
-	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+	if (hci_transaction_run(&transaction) < 0) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
 				   hdev->dev_class, 3);
 		goto unlock;
@@ -3702,21 +3732,14 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
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
@@ -3727,9 +3750,9 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 
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

