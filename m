Return-Path: <cyrus@holtmann.org>
From: ilia.kolominsky@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Ilia Kolomisnky <iliak@ti.com>
Subject: [PATCH Bluetooth-next v2] Fixes l2cap "command reject" reply according to spec.
Date: Thu,  7 Jul 2011 06:36:02 +0300
Message-Id: <1310009762-18032-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ilia Kolomisnky <iliak@ti.com>

There can 3 reasons for the "command reject" reply produced
by the stack. Each such reply should be accompanied by the
relevand data ( as defined in spec. ). Currently there is one
instance of "command reject" reply with reason "invalid cid"
wich is fixed. Also, added clean-up definitions related to the
"command reject" replies.

Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
---
 include/net/bluetooth/l2cap.h |   19 ++++++++++++++++++-
 net/bluetooth/l2cap_core.c    |   15 +++++++++------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9c18e55..6dee791 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -130,6 +130,12 @@ struct l2cap_conninfo {
 #define L2CAP_SDU_END               0x8000
 #define L2CAP_SDU_CONTINUE          0xC000
 
+/* L2CAP Command rej. reasons */
+#define L2CAP_REJ_NOT_UNDERSTOOD      0x0000
+#define L2CAP_REJ_MTU_EXCEEDED	       0x0001
+#define L2CAP_REJ_INVALID_CID         0x0002
+
+
 /* L2CAP structures */
 struct l2cap_hdr {
 	__le16     len;
@@ -144,8 +150,19 @@ struct l2cap_cmd_hdr {
 } __packed;
 #define L2CAP_CMD_HDR_SIZE	4
 
-struct l2cap_cmd_rej {
+struct l2cap_cmd_rej_unk {
+	__le16     reason;
+} __packed;
+
+struct l2cap_cmd_rej_mtu {
+	__le16     reason;
+	__le16     max_mtu;
+} __packed;
+
+struct l2cap_cmd_rej_cid {
 	__le16     reason;
+	__le16     scid;
+	__le16     dcid;
 } __packed;
 
 struct l2cap_conn_req {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bd5d992..951c311 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2284,9 +2284,9 @@ done:
 
 static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
-	struct l2cap_cmd_rej *rej = (struct l2cap_cmd_rej *) data;
+	struct l2cap_cmd_rej_unk *rej = (struct l2cap_cmd_rej_unk *) data;
 
-	if (rej->reason != 0x0000)
+	if (rej->reason != L2CAP_REJ_NOT_UNDERSTOOD)
 		return 0;
 
 	if ((conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) &&
@@ -2531,9 +2531,12 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr

	if ((bt_sk(sk)->defer_setup && sk->sk_state != BT_CONNECT2) ||
                (!bt_sk(sk)->defer_setup && sk->sk_state != BT_CONFIG)) { 
-		struct l2cap_cmd_rej rej;
+		struct l2cap_cmd_rej_cid rej;
+
+		rej.reason = cpu_to_le16(L2CAP_REJ_INVALID_CID);
+		rej.scid = cpu_to_le16(chan->scid);
+		rej.dcid = cpu_to_le16(chan->dcid);
 
-		rej.reason = cpu_to_le16(0x0002);
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_COMMAND_REJ,
 				sizeof(rej), &rej);
 		goto unlock;
@@ -3024,12 +3027,12 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 			err = l2cap_bredr_sig_cmd(conn, &cmd, cmd_len, data);
 
 		if (err) {
-			struct l2cap_cmd_rej rej;
+			struct l2cap_cmd_rej_unk rej;
 
 			BT_ERR("Wrong link type (%d)", err);
 
 			/* FIXME: Map err to a valid reason */
-			rej.reason = cpu_to_le16(0);
+			rej.reason = cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
 			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 		}
 
-- 
1.7.1

