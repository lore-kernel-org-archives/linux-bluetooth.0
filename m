Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Remove useless l2cap_err_to_reason function
Date: Wed, 16 Oct 2013 11:06:41 +0300
Message-Id: <1381910801-3130-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
References: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the only reason code this function can return is
L2CAP_REJ_NOT_UNDERSTOOD we can just do the necessary assignment without
needing a separate function at all.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5f2720c..5cbcd4a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5313,16 +5313,6 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 	}
 }
 
-static __le16 l2cap_err_to_reason(int err)
-{
-	switch (err) {
-	case -EINVAL:
-	case -EPROTO:
-	default:
-		return __constant_cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
-	}
-}
-
 static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 					struct sk_buff *skb)
 {
@@ -5355,7 +5345,7 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 
 		BT_ERR("Wrong link type (%d)", err);
 
-		rej.reason = l2cap_err_to_reason(err);
+		rej.reason = __constant_cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_COMMAND_REJ,
 			       sizeof(rej), &rej);
 	}
@@ -5400,7 +5390,7 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 
 			BT_ERR("Wrong link type (%d)", err);
 
-			rej.reason = l2cap_err_to_reason(err);
+			rej.reason = __constant_cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
 			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ,
 				       sizeof(rej), &rej);
 		}
-- 
1.8.3.1

