Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Only one command per L2CAP LE signalling is supported
Date: Thu,  3 Oct 2013 01:26:37 -0700
Message-Id: <1380788797-8001-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth specification makes it clear that only one command
should be present in the L2CAP LE signalling packet. So tighten
the checks here and restrict it to exactly one command.

This is different from L2CAP BR/EDR signalling where multiple
commands can be part of the same packet.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 102a510..a2c223e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5322,43 +5322,37 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 					struct sk_buff *skb)
 {
 	struct hci_conn *hcon = conn->hcon;
-	u8 *data = skb->data;
-	int len = skb->len;
-	struct l2cap_cmd_hdr cmd;
+	struct l2cap_cmd_hdr *cmd;
+	u16 len;
 	int err;
 
 	if (hcon->type != LE_LINK)
 		goto drop;
 
-	while (len >= L2CAP_CMD_HDR_SIZE) {
-		u16 cmd_len;
-		memcpy(&cmd, data, L2CAP_CMD_HDR_SIZE);
-		data += L2CAP_CMD_HDR_SIZE;
-		len  -= L2CAP_CMD_HDR_SIZE;
+	if (skb->len < L2CAP_CMD_HDR_SIZE)
+		goto drop;
 
-		cmd_len = le16_to_cpu(cmd.len);
+	cmd = (void *) skb->data;
+	skb_pull(skb, L2CAP_CMD_HDR_SIZE);
 
-		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, cmd_len,
-		       cmd.ident);
+	len = le16_to_cpu(cmd->len);
 
-		if (cmd_len > len || !cmd.ident) {
-			BT_DBG("corrupted command");
-			break;
-		}
+	BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd->code, len, cmd->ident);
 
-		err = l2cap_le_sig_cmd(conn, &cmd, data);
-		if (err) {
-			struct l2cap_cmd_rej_unk rej;
+	if (len != skb->len || !cmd->ident) {
+		BT_DBG("corrupted command");
+		goto drop;
+	}
 
-			BT_ERR("Wrong link type (%d)", err);
+	err = l2cap_le_sig_cmd(conn, cmd, skb->data);
+	if (err) {
+		struct l2cap_cmd_rej_unk rej;
 
-			rej.reason = l2cap_err_to_reason(err);
-			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ,
-				       sizeof(rej), &rej);
-		}
+		BT_ERR("Wrong link type (%d)", err);
 
-		data += cmd_len;
-		len  -= cmd_len;
+		rej.reason = l2cap_err_to_reason(err);
+		l2cap_send_cmd(conn, cmd->ident, L2CAP_COMMAND_REJ,
+			       sizeof(rej), &rej);
 	}
 
 drop:
-- 
1.8.3.1

