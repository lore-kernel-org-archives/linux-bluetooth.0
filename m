Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: mgmt: Fix dev_class related command response timing
Date: Thu, 23 Feb 2012 23:32:53 +0200
Message-Id: <1330032774-16206-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330032774-16206-1-git-send-email-johan.hedberg@gmail.com>
References: <1330032774-16206-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All mgmt commands that may fire off a hci_write_class_of_device command
should wait for the completion of the HCI command before sending a
response to user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9f912dc..7a906d6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1332,6 +1332,7 @@ failed:
 static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
+	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	struct bt_uuid *uuid;
 	int err;
@@ -1374,7 +1375,17 @@ static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 	if (err < 0)
 		goto failed;
 
-	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, 0, hdev->dev_class, 3);
+	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+		err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, 0,
+							hdev->dev_class, 3);
+		goto failed;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_UUID, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
 
 failed:
 	hci_dev_unlock(hdev);
@@ -1386,6 +1397,7 @@ failed:
 static int remove_uuid(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct mgmt_cp_remove_uuid *cp = data;
+	struct pending_cmd *cmd;
 	struct list_head *p, *n;
 	struct hci_dev *hdev;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
@@ -1448,8 +1460,17 @@ update_class:
 	if (err < 0)
 		goto unlock;
 
-	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, 0,
+	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+		err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, 0,
 							hdev->dev_class, 3);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_UUID, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -1462,6 +1483,7 @@ static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_set_dev_class *cp = data;
+	struct pending_cmd *cmd;
 	int err;
 
 	BT_DBG("request for hci%u", index);
@@ -1500,10 +1522,20 @@ static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	err = update_class(hdev);
+	if (err < 0)
+		goto unlock;
 
-	if (err == 0)
+	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, 0,
 							hdev->dev_class, 3);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DEV_CLASS, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -3110,6 +3142,7 @@ int mgmt_index_removed(struct hci_dev *hdev)
 struct cmd_lookup {
 	struct sock *sk;
 	struct hci_dev *hdev;
+	u8 mgmt_status;
 };
 
 static void settings_rsp(struct pending_cmd *cmd, void *data)
@@ -3632,14 +3665,41 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	return err;
 }
 
+static void class_rsp(struct pending_cmd *cmd, void *data)
+{
+	struct cmd_lookup *match = data;
+
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, match->mgmt_status,
+						match->hdev->dev_class, 3);
+
+	list_del(&cmd->list);
+
+	if (match->sk == NULL) {
+		match->sk = cmd->sk;
+		sock_hold(match->sk);
+	}
+
+	mgmt_pending_free(cmd);
+}
+
 int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 								u8 status)
 {
-	int err;
+	struct cmd_lookup match = { NULL, hdev, mgmt_status(status) };
+	int err = 0;
 
 	clear_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
 
-	err = mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class, 3, NULL);
+	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, class_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, class_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, class_rsp, &match);
+
+	if (!status)
+		err = mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
+							dev_class, 3, NULL);
+
+	if (match.sk)
+		sock_put(match.sk);
 
 	return err;
 }
-- 
1.7.9

