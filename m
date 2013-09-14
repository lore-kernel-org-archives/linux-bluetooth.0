Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/8] Bluetooth: Fix L2CAP command reject reason
Date: Sat, 14 Sep 2013 20:28:25 +0300
Message-Id: <1379179711-16436-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several possible reason codes that can be sent in the command
reject L2CAP packet. Before this patch the code has used a hard-coded
single response code ("command not understood"). This patch adds a
helper function to map the return value of an L2CAP handler function to
the correct command reject reason.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b3bb7bc..83acb28 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5294,6 +5294,20 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 	}
 }
 
+static u16 l2cap_err_to_reason(int err)
+{
+	switch (err) {
+	case -EFAULT:
+		return L2CAP_REJ_INVALID_CID;
+	case -EMSGSIZE:
+		return L2CAP_REJ_MTU_EXCEEDED;
+	case -EINVAL:
+	case -EPROTO:
+	default:
+		return L2CAP_REJ_NOT_UNDERSTOOD;
+	}
+}
+
 static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 					struct sk_buff *skb)
 {
@@ -5323,11 +5337,11 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 		err = l2cap_le_sig_cmd(conn, &cmd, data);
 		if (err) {
 			struct l2cap_cmd_rej_unk rej;
+			u16 reason = l2cap_err_to_reason(err);
 
 			BT_ERR("Wrong link type (%d)", err);
 
-			/* FIXME: Map err to a valid reason */
-			rej.reason = __constant_cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
+			rej.reason = cpu_to_le16(reason);
 			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ,
 				       sizeof(rej), &rej);
 		}
@@ -5368,11 +5382,11 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 		err = l2cap_bredr_sig_cmd(conn, &cmd, cmd_len, data);
 		if (err) {
 			struct l2cap_cmd_rej_unk rej;
+			u16 reason = l2cap_err_to_reason(err);
 
 			BT_ERR("Wrong link type (%d)", err);
 
-			/* FIXME: Map err to a valid reason */
-			rej.reason = __constant_cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
+			rej.reason = cpu_to_le16(reason);
 			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ,
 				       sizeof(rej), &rej);
 		}
-- 
1.8.4.rc3

