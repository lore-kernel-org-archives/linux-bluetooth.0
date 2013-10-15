Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] Bluetooth: Make mgmt_pin_code_neg_reply_complete() return void
Date: Tue, 15 Oct 2013 14:26:22 -0700
Message-Id: <1381872389-34389-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_pin_code_neg_reply_complete() function is
not used and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/mgmt.c             | 13 +++++--------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 95baf35..aaa897f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1090,8 +1090,8 @@ void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 void mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
 void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  u8 status);
-int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 status);
+void mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				      u8 status);
 int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      u8 link_type, u8 addr_type, __le32 value,
 			      u8 confirm_hint);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 608aa0f..c959915 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4563,26 +4563,23 @@ void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	mgmt_pending_remove(cmd);
 }
 
-int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 status)
+void mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				      u8 status)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_rp_pin_code_reply rp;
-	int err;
 
 	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, hdev);
 	if (!cmd)
-		return -ENOENT;
+		return;
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
 	rp.addr.type = BDADDR_BREDR;
 
-	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
-			   mgmt_status(status), &rp, sizeof(rp));
+	cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
+		     mgmt_status(status), &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
-
-	return err;
 }
 
 int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
1.8.3.1

