Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add management command for Secure Connection Only Mode
Date: Sat,  1 Feb 2014 09:19:57 -0800
Message-Id: <1391275197-5060-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With support for Secure Connections it is possible to switch the
controller into a mode that is called Secure Connections Only. In
this mode only security level 4 connections are allowed (with the
exception of security level 0 approved services).

This patch just introduces the management command and setting of the
right internal flags to enable this mode. It does not yet enforce it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8c94841072a8..ce7ef339b1c4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4043,7 +4043,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
-	u8 status;
+	u8 val, status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
@@ -4058,7 +4058,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
-	if (cp->val != 0x00 && cp->val != 0x01)
+	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_INVALID_PARAMS);
 
@@ -4067,12 +4067,18 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 	if (!hdev_is_powered(hdev)) {
 		bool changed;
 
-		if (cp->val)
+		if (cp->val) {
 			changed = !test_and_set_bit(HCI_SC_ENABLED,
 						    &hdev->dev_flags);
-		else
+			if (cp->val == 0x02)
+				set_bit(HCI_SC_ONLY, &hdev->dev_flags);
+			else
+				clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		} else {
 			changed = test_and_clear_bit(HCI_SC_ENABLED,
 						     &hdev->dev_flags);
+			clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		}
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_SECURE_CONN, hdev);
 		if (err < 0)
@@ -4090,7 +4096,10 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	if (!!cp->val == test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
+	val = !!cp->val;
+
+	if (val == test_bit(HCI_SC_ENABLED, &hdev->dev_flags) &&
+	    (cp->val == 0x02) == test_bit(HCI_SC_ONLY, &hdev->dev_flags)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_SECURE_CONN, hdev);
 		goto failed;
 	}
@@ -4101,12 +4110,17 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_SC_SUPPORT, 1, &cp->val);
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_SC_SUPPORT, 1, &val);
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
+	if (cp->val == 0x02)
+		set_bit(HCI_SC_ONLY, &hdev->dev_flags);
+	else
+		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+
 failed:
 	hci_dev_unlock(hdev);
 	return err;
@@ -5063,19 +5077,24 @@ void mgmt_sc_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
 
-		if (enable && test_and_clear_bit(HCI_SC_ENABLED,
-						 &hdev->dev_flags))
-			new_settings(hdev, NULL);
+		if (enable) {
+			if (test_and_clear_bit(HCI_SC_ENABLED,
+					       &hdev->dev_flags))
+				new_settings(hdev, NULL);
+			clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		}
 
 		mgmt_pending_foreach(MGMT_OP_SET_SECURE_CONN, hdev,
 				     cmd_status_rsp, &mgmt_err);
 		return;
 	}
 
-	if (enable)
+	if (enable) {
 		changed = !test_and_set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
-	else
+	} else {
 		changed = test_and_clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+	}
 
 	mgmt_pending_foreach(MGMT_OP_SET_SECURE_CONN, hdev,
 			     settings_rsp, &match);
-- 
1.8.5.3

