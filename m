Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/31] Bluetooth: Pass command length to LE signaling channel handlers
Date: Wed,  4 Dec 2013 16:11:01 +0200
Message-Id: <1386166287-13693-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The LE signaling PDU length is already calculated in the
l2cap_le_sig_channel function so we can just pass the value to the
various handler functions to avoid unnecessary recalculations (byte
order conversions). Right now the only user is the connection parameter
update procedure, but as new LE signaling operations become available
(for connection oriented channels) they will also be able to make use of
the value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 510a17cefd26..eafcdf65718b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5165,18 +5165,17 @@ static inline int l2cap_check_conn_param(u16 min, u16 max, u16 latency,
 
 static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 					      struct l2cap_cmd_hdr *cmd,
-					      u8 *data)
+					      u16 cmd_len, u8 *data)
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_conn_param_update_req *req;
 	struct l2cap_conn_param_update_rsp rsp;
-	u16 min, max, latency, to_multiplier, cmd_len;
+	u16 min, max, latency, to_multiplier;
 	int err;
 
 	if (!(hcon->link_mode & HCI_LM_MASTER))
 		return -EINVAL;
 
-	cmd_len = __le16_to_cpu(cmd->len);
 	if (cmd_len != sizeof(struct l2cap_conn_param_update_req))
 		return -EPROTO;
 
@@ -5287,14 +5286,15 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 }
 
 static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
-				   struct l2cap_cmd_hdr *cmd, u8 *data)
+				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
+				   u8 *data)
 {
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
 		return 0;
 
 	case L2CAP_CONN_PARAM_UPDATE_REQ:
-		return l2cap_conn_param_update_req(conn, cmd, data);
+		return l2cap_conn_param_update_req(conn, cmd, cmd_len, data);
 
 	case L2CAP_CONN_PARAM_UPDATE_RSP:
 		return 0;
@@ -5331,7 +5331,7 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 		goto drop;
 	}
 
-	err = l2cap_le_sig_cmd(conn, cmd, skb->data);
+	err = l2cap_le_sig_cmd(conn, cmd, len, skb->data);
 	if (err) {
 		struct l2cap_cmd_rej_unk rej;
 
-- 
1.8.4.2

