Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add management command for Secure Connection Only mode
Date: Sat, 11 Jan 2014 14:05:27 -0800
Message-Id: <1389477927-36784-1-git-send-email-marcel@holtmann.org>
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
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/mgmt.c        | 36 +++++++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2bc19881e250..aed74d1bd206 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -124,6 +124,7 @@ enum {
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
 	HCI_SC_ENABLED,
+	HCI_SC_ONLY,
 	HCI_HS_ENABLED,
 	HCI_LE_ENABLED,
 	HCI_ADVERTISING,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4b6034fcc902..a1d42ae6f8fd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4040,7 +4040,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
-	u8 status;
+	u8 val, status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
@@ -4055,7 +4055,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
-	if (cp->val != 0x00 && cp->val != 0x01)
+	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_INVALID_PARAMS);
 
@@ -4064,12 +4064,16 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 	if (!hdev_is_powered(hdev)) {
 		bool changed;
 
-		if (cp->val)
+		if (cp->val) {
 			changed = !test_and_set_bit(HCI_SC_ENABLED,
 						    &hdev->dev_flags);
-		else
+			if (cp->val == 0x02)
+				set_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		} else {
 			changed = test_and_clear_bit(HCI_SC_ENABLED,
 						     &hdev->dev_flags);
+			clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		}
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_SECURE_CONN, hdev);
 		if (err < 0)
@@ -4087,7 +4091,9 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	if (!!cp->val == test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
+	val = !!cp->val;
+
+	if (val == test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_SECURE_CONN, hdev);
 		goto failed;
 	}
@@ -4098,12 +4104,15 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
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
+
 failed:
 	hci_dev_unlock(hdev);
 	return err;
@@ -5029,19 +5038,24 @@ void mgmt_sc_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
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
1.8.4.2

