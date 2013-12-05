Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 14/32] Bluetooth: Make l2cap_le_sig_cmd logic consistent
Date: Thu,  5 Dec 2013 15:11:12 +0200
Message-Id: <1386249090-10236-15-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch makes the error handling and return logic of l2cap_le_sig_cmd
consistent with its BR/EDR counterpart.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d6921a4222e9..cc7421568c68 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5535,34 +5535,42 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
 {
+	int err = 0;
+
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
-		return 0;
+		break;
 
 	case L2CAP_CONN_PARAM_UPDATE_REQ:
-		return l2cap_conn_param_update_req(conn, cmd, cmd_len, data);
+		err = l2cap_conn_param_update_req(conn, cmd, cmd_len, data);
+		break;
 
 	case L2CAP_CONN_PARAM_UPDATE_RSP:
-		return 0;
+		break;
 
 	case L2CAP_LE_CONN_RSP:
 		l2cap_le_connect_rsp(conn, cmd, cmd_len, data);
-		return 0;
+		break;
 
 	case L2CAP_LE_CONN_REQ:
-		return l2cap_le_connect_req(conn, cmd, cmd_len, data);
+		err = l2cap_le_connect_req(conn, cmd, cmd_len, data);
+		break;
 
 	case L2CAP_DISCONN_REQ:
-		return l2cap_disconnect_req(conn, cmd, cmd_len, data);
+		err = l2cap_disconnect_req(conn, cmd, cmd_len, data);
+		break;
 
 	case L2CAP_DISCONN_RSP:
 		l2cap_disconnect_rsp(conn, cmd, cmd_len, data);
-		return 0;
+		break;
 
 	default:
 		BT_ERR("Unknown LE signaling command 0x%2.2x", cmd->code);
-		return -EINVAL;
+		err = -EINVAL;
+		break;
 	}
+
+	return err;
 }
 
 static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
-- 
1.8.4.2

