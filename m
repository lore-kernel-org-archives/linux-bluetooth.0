Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] Bluetooth: Make mgmt_pin_code_reply_complete() return void
Date: Tue, 15 Oct 2013 14:26:21 -0700
Message-Id: <1381872389-34389-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_pin_code_reply_complete() function is not
used and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/mgmt.c             | 13 +++++--------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a167a9d..95baf35 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1088,8 +1088,8 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			 u8 addr_type, u8 status);
 void mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
-int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				 u8 status);
+void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				  u8 status);
 int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 status);
 int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index efa2c52..608aa0f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4544,26 +4544,23 @@ void mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
 	mgmt_event(MGMT_EV_PIN_CODE_REQUEST, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				 u8 status)
+void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				  u8 status)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_rp_pin_code_reply rp;
-	int err;
 
 	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_REPLY, hdev);
 	if (!cmd)
-		return -ENOENT;
+		return;
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
 	rp.addr.type = BDADDR_BREDR;
 
-	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
-			   mgmt_status(status), &rp, sizeof(rp));
+	cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
+		     mgmt_status(status), &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
-
-	return err;
 }
 
 int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
1.8.3.1

