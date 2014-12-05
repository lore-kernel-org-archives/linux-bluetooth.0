Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] Bluetooth: Use cmd_complete callback for authentication mgmt commands
Date: Fri,  5 Dec 2014 13:36:03 +0200
Message-Id: <1417779369-6428-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the user confirmation & PIN code mgmt commands to
take advantage of the new cmd_complete callback for pending mgmt
commands. The patch also adds a new generic addr_cmd_complete() helper
function to be used with commands that send a mgmt_addr_info response
based on a mgmt_addr_info in the beginning of the command parameters.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 81b2886f64b8..0fc3d6914ef0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1492,6 +1492,12 @@ static void generic_cmd_complete(struct pending_cmd *cmd, u8 status)
 		     cmd->param_len);
 }
 
+static void addr_cmd_complete(struct pending_cmd *cmd, u8 status)
+{
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, cmd->param,
+		     sizeof(struct mgmt_addr_info));
+}
+
 static u8 mgmt_bredr_support(struct hci_dev *hdev)
 {
 	if (!lmp_bredr_capable(hdev))
@@ -3032,6 +3038,8 @@ static int pin_code_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	cmd->cmd_complete = addr_cmd_complete;
+
 	bacpy(&reply.bdaddr, &cp->addr.bdaddr);
 	reply.pin_len = cp->pin_len;
 	memcpy(reply.pin_code, cp->pin_code, sizeof(reply.pin_code));
@@ -3363,6 +3371,8 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
+	cmd->cmd_complete = addr_cmd_complete;
+
 	/* Continue with pairing via HCI */
 	if (hci_op == HCI_OP_USER_PASSKEY_REPLY) {
 		struct hci_cp_user_passkey_reply cp;
@@ -6544,18 +6554,12 @@ void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  u8 status)
 {
 	struct pending_cmd *cmd;
-	struct mgmt_rp_pin_code_reply rp;
 
 	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_REPLY, hdev);
 	if (!cmd)
 		return;
 
-	bacpy(&rp.addr.bdaddr, bdaddr);
-	rp.addr.type = BDADDR_BREDR;
-
-	cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
-		     mgmt_status(status), &rp, sizeof(rp));
-
+	cmd->cmd_complete(cmd, mgmt_status(status));
 	mgmt_pending_remove(cmd);
 }
 
@@ -6563,18 +6567,12 @@ void mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				      u8 status)
 {
 	struct pending_cmd *cmd;
-	struct mgmt_rp_pin_code_reply rp;
 
 	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, hdev);
 	if (!cmd)
 		return;
 
-	bacpy(&rp.addr.bdaddr, bdaddr);
-	rp.addr.type = BDADDR_BREDR;
-
-	cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
-		     mgmt_status(status), &rp, sizeof(rp));
-
+	cmd->cmd_complete(cmd, mgmt_status(status));
 	mgmt_pending_remove(cmd);
 }
 
@@ -6614,21 +6612,15 @@ static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				      u8 opcode)
 {
 	struct pending_cmd *cmd;
-	struct mgmt_rp_user_confirm_reply rp;
-	int err;
 
 	cmd = mgmt_pending_find(opcode, hdev);
 	if (!cmd)
 		return -ENOENT;
 
-	bacpy(&rp.addr.bdaddr, bdaddr);
-	rp.addr.type = link_to_bdaddr(link_type, addr_type);
-	err = cmd_complete(cmd->sk, hdev->id, opcode, mgmt_status(status),
-			   &rp, sizeof(rp));
-
+	cmd->cmd_complete(cmd, mgmt_status(status));
 	mgmt_pending_remove(cmd);
 
-	return err;
+	return 0;
 }
 
 int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
2.1.0

