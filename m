Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 13/32] Bluetooth: Add L2CAP Disconnect suppport for LE
Date: Thu,  5 Dec 2013 15:11:11 +0200
Message-Id: <1386249090-10236-14-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The normal L2CAP Disconnect request and response are also used for LE
connection oriented channels. Therefore, we can simply use the existing
handler functions for terminating LE based L2CAP channels.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 333031fde67e..d6921a4222e9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5552,6 +5552,13 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 	case L2CAP_LE_CONN_REQ:
 		return l2cap_le_connect_req(conn, cmd, cmd_len, data);
 
+	case L2CAP_DISCONN_REQ:
+		return l2cap_disconnect_req(conn, cmd, cmd_len, data);
+
+	case L2CAP_DISCONN_RSP:
+		l2cap_disconnect_rsp(conn, cmd, cmd_len, data);
+		return 0;
+
 	default:
 		BT_ERR("Unknown LE signaling command 0x%2.2x", cmd->code);
 		return -EINVAL;
-- 
1.8.4.2

