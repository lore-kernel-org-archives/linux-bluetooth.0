Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Fix unnecessary list traversal in mgmt_pending_remove
Date: Sat, 19 Feb 2011 12:06:02 -0300
Message-Id: <1298127962-18576-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
References: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

All of the places that need to call mgmt_pending_remove already have a
pointer to the pending command, so searching for the command in the list
doesn't make sense. The added benefit is that many places that
previously had to call list_del + mgmt_pending_free can just call
mgmt_pending_remove now.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/mgmt.c |   42 ++++++++++++++----------------------------
 1 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 46e2c39..982becd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -290,14 +290,8 @@ static struct pending_cmd *mgmt_pending_find(u16 opcode, int index)
 	return NULL;
 }
 
-static void mgmt_pending_remove(u16 opcode, int index)
+static void mgmt_pending_remove(struct pending_cmd *cmd)
 {
-	struct pending_cmd *cmd;
-
-	cmd = mgmt_pending_find(opcode, index);
-	if (cmd == NULL)
-		return;
-
 	list_del(&cmd->list);
 	mgmt_pending_free(cmd);
 }
@@ -401,7 +395,7 @@ static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	if (err < 0)
-		mgmt_pending_remove(MGMT_OP_SET_DISCOVERABLE, dev_id);
+		mgmt_pending_remove(cmd);
 
 failed:
 	hci_dev_unlock_bh(hdev);
@@ -459,7 +453,7 @@ static int set_connectable(struct sock *sk, unsigned char *data, u16 len)
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	if (err < 0)
-		mgmt_pending_remove(MGMT_OP_SET_CONNECTABLE, dev_id);
+		mgmt_pending_remove(cmd);
 
 failed:
 	hci_dev_unlock_bh(hdev);
@@ -881,7 +875,7 @@ static int disconnect(struct sock *sk, unsigned char *data, u16 len)
 
 	err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(dc), &dc);
 	if (err < 0)
-		mgmt_pending_remove(MGMT_OP_DISCONNECT, dev_id);
+		mgmt_pending_remove(cmd);
 
 failed:
 	hci_dev_unlock_bh(hdev);
@@ -983,7 +977,7 @@ static int pin_code_reply(struct sock *sk, unsigned char *data, u16 len)
 
 	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_REPLY, sizeof(reply), &reply);
 	if (err < 0)
-		mgmt_pending_remove(MGMT_OP_PIN_CODE_REPLY, dev_id);
+		mgmt_pending_remove(cmd);
 
 failed:
 	hci_dev_unlock_bh(hdev);
@@ -1026,7 +1020,7 @@ static int pin_code_neg_reply(struct sock *sk, unsigned char *data, u16 len)
 	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY, sizeof(bdaddr_t),
 								&cp->bdaddr);
 	if (err < 0)
-		mgmt_pending_remove(MGMT_OP_PIN_CODE_NEG_REPLY, dev_id);
+		mgmt_pending_remove(cmd);
 
 failed:
 	hci_dev_unlock_bh(hdev);
@@ -1107,8 +1101,7 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 
 	hci_conn_put(conn);
 
-	list_del(&cmd->list);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 }
 
 static void pairing_complete_cb(struct hci_conn *conn, u8 status)
@@ -1230,10 +1223,8 @@ static int user_confirm_reply(struct sock *sk, unsigned char *data, u16 len,
 	}
 
 	err = hci_send_cmd(hdev, hci_op, sizeof(cp->bdaddr), &cp->bdaddr);
-	if (err < 0) {
-		list_del(&cmd->list);
-		mgmt_pending_free(cmd);
-	}
+	if (err < 0)
+		mgmt_pending_remove(cmd);
 
 failed:
 	hci_dev_unlock_bh(hdev);
@@ -1494,8 +1485,7 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 	*sk = cmd->sk;
 	sock_hold(*sk);
 
-	list_del(&cmd->list);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 }
 
 int mgmt_disconnected(u16 index, bdaddr_t *bdaddr)
@@ -1528,8 +1518,7 @@ int mgmt_disconnect_failed(u16 index)
 
 	err = cmd_status(cmd->sk, MGMT_OP_DISCONNECT, EIO);
 
-	list_del(&cmd->list);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 
 	return err;
 }
@@ -1571,8 +1560,7 @@ int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 
 	err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_REPLY, &rp, sizeof(rp));
 
-	list_del(&cmd->list);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 
 	return err;
 }
@@ -1594,8 +1582,7 @@ int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 	err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY,
 							&rp, sizeof(rp));
 
-	list_del(&cmd->list);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 
 	return err;
 }
@@ -1629,8 +1616,7 @@ static int confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status,
 	rp.status = status;
 	err = cmd_complete(cmd->sk, opcode, &rp, sizeof(rp));
 
-	list_del(&cmd->list);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 
 	return err;
 }
-- 
1.7.4.1

