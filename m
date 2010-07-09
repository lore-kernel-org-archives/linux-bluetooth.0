Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/2] Bluetooth: Keep code under column 80
Date: Fri,  9 Jul 2010 16:38:35 -0300
Message-Id: <1278704315-28192-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1278704315-28192-1-git-send-email-gustavo@padovan.org>
References: <1278704315-28192-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Purely a cosmetic change, it doesn't change the code flow.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   48 ++++++++++++++++++++++++++----------------------
 1 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 419e2c3..449cbdd 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -522,31 +522,35 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		}
 
 		if (sk->sk_state == BT_CONNECT) {
-			if (l2cap_check_security(sk) &&
-					__l2cap_no_conn_pending(sk)) {
-				struct l2cap_conn_req req;
+			struct l2cap_conn_req req;
 
-				if (!l2cap_mode_supported(l2cap_pi(sk)->mode,
-						conn->feat_mask)
-						&& l2cap_pi(sk)->conf_state &
-						L2CAP_CONF_STATE2_DEVICE) {
-					tmp1 = kzalloc(sizeof(struct sock_del_list),
-							GFP_ATOMIC);
-					tmp1->sk = sk;
-					list_add_tail(&tmp1->list, &del.list);
-					bh_unlock_sock(sk);
-					continue;
-				}
+			if (!l2cap_check_security(sk) ||
+					!__l2cap_no_conn_pending(sk)) {
+				bh_unlock_sock(sk);
+				continue;
+			}
 
-				req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
-				req.psm  = l2cap_pi(sk)->psm;
+			if (!l2cap_mode_supported(l2cap_pi(sk)->mode,
+					conn->feat_mask)
+					&& l2cap_pi(sk)->conf_state &
+					L2CAP_CONF_STATE2_DEVICE) {
+				tmp1 = kzalloc(sizeof(struct sock_del_list),
+						GFP_ATOMIC);
+				tmp1->sk = sk;
+				list_add_tail(&tmp1->list, &del.list);
+				bh_unlock_sock(sk);
+				continue;
+			}
 
-				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
-				l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
+			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
+			req.psm  = l2cap_pi(sk)->psm;
+
+			l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+			l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
+
+			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+				L2CAP_CONN_REQ, sizeof(req), &req);
 
-				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-					L2CAP_CONN_REQ, sizeof(req), &req);
-			}
 		} else if (sk->sk_state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
 			char buf[128];
-- 
1.7.1

