Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/13] Bluetooth: Create independent LE signalling defines and structs
Date: Mon, 29 Apr 2013 19:35:34 +0300
Message-Id: <1367253345-12482-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the LE signalling channel is independent from the BR/EDR
signalling channel and may experience changes incompatible with the
BR/EDR channel it makes sense from the start to have independent defines
and structs for it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |   34 ++++++++++++++++++++++++++++++----
 net/bluetooth/l2cap_core.c    |   24 ++++++++++++------------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fb94cf1..2f52a28 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -110,8 +110,13 @@ struct l2cap_conninfo {
 #define L2CAP_MOVE_CHAN_RSP	0x0f
 #define L2CAP_MOVE_CHAN_CFM	0x10
 #define L2CAP_MOVE_CHAN_CFM_RSP	0x11
-#define L2CAP_CONN_PARAM_UPDATE_REQ	0x12
-#define L2CAP_CONN_PARAM_UPDATE_RSP	0x13
+
+/* L2CAP LE command codes */
+#define L2CAP_LE_COMMAND_REJ		0x01
+#define L2CAP_LE_DISCONN_REQ		0x06
+#define L2CAP_LE_DISCONN_RSP		0x07
+#define L2CAP_LE_CONN_PARAM_UPDATE_REQ	0x12
+#define L2CAP_LE_CONN_PARAM_UPDATE_RSP	0x13
 
 /* L2CAP extended feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
@@ -406,14 +411,35 @@ struct l2cap_move_chan_cfm_rsp {
 #define L2CAP_IR_SUCCESS	0x0000
 #define L2CAP_IR_NOTSUPP	0x0001
 
-struct l2cap_conn_param_update_req {
+struct l2cap_le_cmd_hdr {
+	__u8       code;
+	__u8       ident;
+	__le16     len;
+} __packed;
+#define L2CAP_LE_CMD_HDR_SIZE	4
+
+struct l2cap_le_cmd_rej_unk {
+	__le16     reason;
+} __packed;
+
+struct l2cap_le_disconn_req {
+	__le16     dcid;
+	__le16     scid;
+} __packed;
+
+struct l2cap_le_disconn_rsp {
+	__le16     dcid;
+	__le16     scid;
+} __packed;
+
+struct l2cap_le_conn_param_update_req {
 	__le16      min;
 	__le16      max;
 	__le16      latency;
 	__le16      to_multiplier;
 } __packed;
 
-struct l2cap_conn_param_update_rsp {
+struct l2cap_le_conn_param_update_rsp {
 	__le16      result;
 } __packed;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1adda11..6bf5d19 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5113,13 +5113,13 @@ static inline int l2cap_check_conn_param(u16 min, u16 max, u16 latency,
 	return 0;
 }
 
-static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
-					      struct l2cap_cmd_hdr *cmd,
-					      u8 *data)
+static inline int l2cap_le_conn_param_update_req(struct l2cap_conn *conn,
+						 struct l2cap_cmd_hdr *cmd,
+						 u8 *data)
 {
 	struct hci_conn *hcon = conn->hcon;
-	struct l2cap_conn_param_update_req *req;
-	struct l2cap_conn_param_update_rsp rsp;
+	struct l2cap_le_conn_param_update_req *req;
+	struct l2cap_le_conn_param_update_rsp rsp;
 	u16 min, max, latency, to_multiplier, cmd_len;
 	int err;
 
@@ -5127,10 +5127,10 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 		return -EINVAL;
 
 	cmd_len = __le16_to_cpu(cmd->len);
-	if (cmd_len != sizeof(struct l2cap_conn_param_update_req))
+	if (cmd_len != sizeof(struct l2cap_le_conn_param_update_req))
 		return -EPROTO;
 
-	req = (struct l2cap_conn_param_update_req *) data;
+	req = (struct l2cap_le_conn_param_update_req *) data;
 	min		= __le16_to_cpu(req->min);
 	max		= __le16_to_cpu(req->max);
 	latency		= __le16_to_cpu(req->latency);
@@ -5147,7 +5147,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	else
 		rsp.result = __constant_cpu_to_le16(L2CAP_CONN_PARAM_ACCEPTED);
 
-	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
+	l2cap_send_cmd(conn, cmd->ident, L2CAP_LE_CONN_PARAM_UPDATE_RSP,
 		       sizeof(rsp), &rsp);
 
 	if (!err)
@@ -5240,13 +5240,13 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	switch (cmd->code) {
-	case L2CAP_COMMAND_REJ:
+	case L2CAP_LE_COMMAND_REJ:
 		return 0;
 
-	case L2CAP_CONN_PARAM_UPDATE_REQ:
-		return l2cap_conn_param_update_req(conn, cmd, data);
+	case L2CAP_LE_CONN_PARAM_UPDATE_REQ:
+		return l2cap_le_conn_param_update_req(conn, cmd, data);
 
-	case L2CAP_CONN_PARAM_UPDATE_RSP:
+	case L2CAP_LE_CONN_PARAM_UPDATE_RSP:
 		return 0;
 
 	default:
-- 
1.7.10.4

