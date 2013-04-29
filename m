Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/13] Bluetooth: Handle LE L2CAP signalling in its own function
Date: Mon, 29 Apr 2013 19:35:33 +0300
Message-Id: <1367253345-12482-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The LE L2CAP signalling channel follows its own rules and will continue
to evolve independently from the BR/EDR signalling channel. Therefore,
it makes sense to have a clear split from BR/EDR by having a dedicated
function for handling LE signalling commands.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |   53 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a76d1ac..1adda11 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5255,6 +5255,51 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 	}
 }
 
+static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
+					struct sk_buff *skb)
+{
+	u8 *data = skb->data;
+	int len = skb->len;
+	struct l2cap_cmd_hdr cmd;
+	int err;
+
+	l2cap_raw_recv(conn, skb);
+
+	while (len >= L2CAP_CMD_HDR_SIZE) {
+		u16 cmd_len;
+		memcpy(&cmd, data, L2CAP_CMD_HDR_SIZE);
+		data += L2CAP_CMD_HDR_SIZE;
+		len  -= L2CAP_CMD_HDR_SIZE;
+
+		cmd_len = le16_to_cpu(cmd.len);
+
+		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, cmd_len,
+		       cmd.ident);
+
+		if (cmd_len > len || !cmd.ident) {
+			BT_DBG("corrupted command");
+			break;
+		}
+
+		err = l2cap_le_sig_cmd(conn, &cmd, data);
+		if (err) {
+			struct l2cap_cmd_rej_unk rej;
+
+			BT_ERR("Wrong link type (%d)", err);
+
+			/* FIXME: Map err to a valid reason */
+			rej.reason = __constant_cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
+			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ,
+				       sizeof(rej), &rej);
+		}
+
+		data += cmd_len;
+		len  -= cmd_len;
+	}
+
+	kfree_skb(skb);
+}
+
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
@@ -5281,11 +5326,7 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 			break;
 		}
 
-		if (conn->hcon->type == LE_LINK)
-			err = l2cap_le_sig_cmd(conn, &cmd, data);
-		else
-			err = l2cap_bredr_sig_cmd(conn, &cmd, cmd_len, data);
-
+		err = l2cap_bredr_sig_cmd(conn, &cmd, cmd_len, data);
 		if (err) {
 			struct l2cap_cmd_rej_unk rej;
 
@@ -6358,6 +6399,8 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	switch (cid) {
 	case L2CAP_CID_LE_SIGNALING:
+		l2cap_le_sig_channel(conn, skb);
+		break;
 	case L2CAP_CID_SIGNALING:
 		l2cap_sig_channel(conn, skb);
 		break;
-- 
1.7.10.4

