Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Restrict high speed support to SSP enabled controllers
Date: Thu, 10 Oct 2013 03:08:11 -0700
Message-Id: <1381399691-42391-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The support for Bluetooth High Speed can only be enabled on controllers
where also Secure Simple Pairing has been enabled. Trying to enable
high speed when SSP is disabled will result into an error. Disabling
SSP will at the same time disable high speed as well.

It is required to enforce this dependency on SSP since high speed
support is only defined for authenticated, unauthenticated and
debug link keys. These link key types require SSP.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2fb4d35..e7ffd39 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1310,11 +1310,19 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		bool changed = false;
+		bool changed;
 
-		if (val != test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
-			change_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
-			changed = true;
+		if (cp->val) {
+			changed = !test_and_set_bit(HCI_SSP_ENABLED,
+						    &hdev->dev_flags);
+		} else {
+			changed = test_and_clear_bit(HCI_SSP_ENABLED,
+						     &hdev->dev_flags);
+			if (!changed)
+				changed = test_and_clear_bit(HCI_HS_ENABLED,
+							     &hdev->dev_flags);
+			else
+				clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
 		}
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_SSP, hdev);
@@ -1327,7 +1335,8 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
+	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev) ||
+	    mgmt_pending_find(MGMT_OP_SET_HS, hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
 				 MGMT_STATUS_BUSY);
 		goto failed;
@@ -1368,6 +1377,14 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	if (status)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS, status);
 
+	if (!lmp_ssp_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	if (!test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+				  MGMT_STATUS_REJECTED);
+
 	if (cp->val != 0x00 && cp->val != 0x01)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 				  MGMT_STATUS_INVALID_PARAMS);
@@ -4403,8 +4420,10 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 		u8 mgmt_err = mgmt_status(status);
 
 		if (enable && test_and_clear_bit(HCI_SSP_ENABLED,
-						 &hdev->dev_flags))
+						 &hdev->dev_flags)) {
+			clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
 			err = new_settings(hdev, NULL);
+		}
 
 		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, cmd_status_rsp,
 				     &mgmt_err);
@@ -4413,11 +4432,14 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	}
 
 	if (enable) {
-		if (!test_and_set_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
-			changed = true;
+		changed = !test_and_set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
 	} else {
-		if (test_and_clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
-			changed = true;
+		changed = test_and_clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+		if (!changed)
+			changed = test_and_clear_bit(HCI_HS_ENABLED,
+						     &hdev->dev_flags);
+		else
+			clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
 	}
 
 	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
-- 
1.8.3.1

