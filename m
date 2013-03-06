Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Fix UUID/class mgmt command response synchronization
Date: Wed,  6 Mar 2013 09:16:30 +0200
Message-Id: <1362554191-21753-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362554191-21753-1-git-send-email-johan.hedberg@gmail.com>
References: <1362554191-21753-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should only return a mgmt command complete once all HCI commands to a
mgmt_set_dev_class or mgmt_add/remove_uuid command have completed. This
patch fixes the issue by having a proper async request complete callback
for these actions and responding to user space in the callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   67 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 18d4d7e..92437f9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1358,6 +1358,32 @@ static u8 get_uuid_size(const u8 *uuid)
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
@@ -1393,9 +1419,7 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	update_class(&req);
 	update_eir(&req);
 
-	hci_req_run(&req, NULL);
-
-	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+	if (hci_req_run(&req, add_uuid_complete) < 0) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
 				   hdev->dev_class, 3);
 		goto failed;
@@ -1428,6 +1452,13 @@ static bool enable_service_cache(struct hci_dev *hdev)
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
@@ -1483,9 +1514,7 @@ update_class:
 	update_class(&req);
 	update_eir(&req);
 
-	hci_req_run(&req, NULL);
-
-	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+	if (hci_req_run(&req, remove_uuid_complete) < 0) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
 				   hdev->dev_class, 3);
 		goto unlock;
@@ -1504,6 +1533,13 @@ unlock:
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
@@ -1548,9 +1584,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	update_class(&req);
 
-	hci_req_run(&req, NULL);
-
-	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+	if (hci_req_run(&req, set_class_complete) < 0) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
 				   hdev->dev_class, 3);
 		goto unlock;
@@ -3678,21 +3712,14 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
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
@@ -3703,9 +3730,9 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 
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

