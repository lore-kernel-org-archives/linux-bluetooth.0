Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Send ConfigReq after send a ConnectionRsp
Date: Thu,  8 Jul 2010 20:08:18 -0300
Message-Id: <1278630498-20401-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

The extended L2CAP features requires that one should initiate a
ConfigReq after send the ConnectionRsp. This patch changes the behaviour
of the configuration process of our stack.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index a3dfee9..e366be0 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -74,6 +74,7 @@ static void __l2cap_sock_close(struct sock *sk, int reason);
 static void l2cap_sock_close(struct sock *sk);
 static void l2cap_sock_kill(struct sock *sk);
 
+static int l2cap_build_conf_req(struct sock *sk, void *data);
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
 
@@ -548,6 +549,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			}
 		} else if (sk->sk_state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
+			char buf[128];
 			rsp.scid = cpu_to_le16(l2cap_pi(sk)->dcid);
 			rsp.dcid = cpu_to_le16(l2cap_pi(sk)->scid);
 
@@ -570,6 +572,17 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
 					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+
+			if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT ||
+					rsp.result != L2CAP_CR_SUCCESS) {
+				bh_unlock_sock(sk);
+				continue;
+			}
+
+			l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+						l2cap_build_conf_req(sk, buf), buf);
+			l2cap_pi(sk)->num_conf_req++;
 		}
 
 		bh_unlock_sock(sk);
@@ -1897,6 +1910,8 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 	if (sk->sk_state == BT_CONNECT2 && bt_sk(sk)->defer_setup) {
 		struct l2cap_conn_rsp rsp;
+		struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+		u8 buf[128];
 
 		sk->sk_state = BT_CONFIG;
 
@@ -1907,6 +1922,16 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		l2cap_send_cmd(l2cap_pi(sk)->conn, l2cap_pi(sk)->ident,
 					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
 
+		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) {
+			release_sock(sk);
+			return 0;
+		}
+
+		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+				l2cap_build_conf_req(sk, buf), buf);
+		l2cap_pi(sk)->num_conf_req++;
+
 		release_sock(sk);
 		return 0;
 	}
@@ -2613,7 +2638,7 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 		}
 	}
 
-	if (pi->num_conf_rsp || pi->num_conf_req)
+	if (pi->num_conf_rsp || pi->num_conf_req > 1)
 		goto done;
 
 	switch (pi->mode) {
@@ -2857,7 +2882,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	struct l2cap_chan_list *list = &conn->chan_list;
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
-	struct sock *sk, *parent;
+	struct sock *parent, *uninitialized_var(sk);
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -2966,6 +2991,15 @@ sendresp:
 					L2CAP_INFO_REQ, sizeof(info), &info);
 	}
 
+	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) &&
+				result == L2CAP_CR_SUCCESS) {
+		u8 buf[128];
+		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+					l2cap_build_conf_req(sk, buf), buf);
+		l2cap_pi(sk)->num_conf_req++;
+	}
+
 	return 0;
 }
 
@@ -2998,9 +3032,13 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		sk->sk_state = BT_CONFIG;
 		l2cap_pi(sk)->ident = 0;
 		l2cap_pi(sk)->dcid = dcid;
-		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
 		l2cap_pi(sk)->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
 
+		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)
+			break;
+
+		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(sk, req), req);
 		l2cap_pi(sk)->num_conf_req++;
-- 
1.7.1
