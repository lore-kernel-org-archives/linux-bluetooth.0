Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Convert Set SC to use HCI Request
Date: Fri, 23 Jan 2015 15:42:46 +0200
Message-Id: <1422020566-30680-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the Set Secure Connection HCI handling to use a HCI
request instead of using a hard-coded callback in hci_event.c. This e.g.
ensures that we don't clear the flags incorrectly if something goes
wrong with the power up process (not related to a mgmt Set SC command).

The code can also be simplified a bit since only one pending Set SC
command is allowed, i.e. mgmt_pending_foreach usage is not needed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_event.c        |  4 +-
 net/bluetooth/mgmt.c             | 92 +++++++++++++++++++++-------------------
 3 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7777124bff55..0f5e59f1e3cb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1369,7 +1369,6 @@ int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_auth_failed(struct hci_conn *conn, u8 status);
 void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
-void mgmt_sc_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a58845e98921..e2b81adc232f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -525,9 +525,7 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 			hdev->features[1][0] &= ~LMP_HOST_SC;
 	}
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
-		mgmt_sc_enable_complete(hdev, sent->support, status);
-	else if (!status) {
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags) && !status) {
 		if (sent->support)
 			set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
 		else
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 862a005d9db2..25e40e82b9a2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4741,11 +4741,57 @@ unlock:
 	return err;
 }
 
+static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_mode *cp;
+
+	BT_DBG("%s status %u", hdev->name, status);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_SECURE_CONN, hdev);
+	if (!cmd)
+		goto unlock;
+
+	if (status) {
+		cmd_status(cmd->sk, cmd->index, cmd->opcode,
+			   mgmt_status(status));
+		goto remove;
+	}
+
+	cp = cmd->param;
+
+	switch (cp->val) {
+	case 0x00:
+		clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		break;
+	case 0x01:
+		set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		break;
+	case 0x02:
+		set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+		set_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		break;
+	}
+
+	send_settings_rsp(cmd->sk, MGMT_OP_SET_SECURE_CONN, hdev);
+	new_settings(hdev, cmd->sk);
+
+remove:
+	mgmt_pending_remove(cmd);
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
+	struct hci_request req;
 	u8 val;
 	int err;
 
@@ -4814,17 +4860,14 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_SC_SUPPORT, 1, &val);
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_WRITE_SC_SUPPORT, 1, &val);
+	err = hci_req_run(&req, sc_enable_complete);
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
-	if (cp->val == 0x02)
-		set_bit(HCI_SC_ONLY, &hdev->dev_flags);
-	else
-		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
-
 failed:
 	hci_dev_unlock(hdev);
 	return err;
@@ -7001,43 +7044,6 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	hci_req_run(&req, NULL);
 }
 
-void mgmt_sc_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
-{
-	struct cmd_lookup match = { NULL, hdev };
-	bool changed = false;
-
-	if (status) {
-		u8 mgmt_err = mgmt_status(status);
-
-		if (enable) {
-			if (test_and_clear_bit(HCI_SC_ENABLED,
-					       &hdev->dev_flags))
-				new_settings(hdev, NULL);
-			clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
-		}
-
-		mgmt_pending_foreach(MGMT_OP_SET_SECURE_CONN, hdev,
-				     cmd_status_rsp, &mgmt_err);
-		return;
-	}
-
-	if (enable) {
-		changed = !test_and_set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
-	} else {
-		changed = test_and_clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
-		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
-	}
-
-	mgmt_pending_foreach(MGMT_OP_SET_SECURE_CONN, hdev,
-			     settings_rsp, &match);
-
-	if (changed)
-		new_settings(hdev, match.sk);
-
-	if (match.sk)
-		sock_put(match.sk);
-}
-
 static void sk_lookup(struct pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
-- 
2.1.0

