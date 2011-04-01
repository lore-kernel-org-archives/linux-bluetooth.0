Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/15] Bluetooth: Move ident to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:09 -0300
Message-Id: <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ident is chan property, no need to reside on socket.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    4 ++--
 net/bluetooth/l2cap_core.c    |   38 +++++++++++++++++++-------------------
 net/bluetooth/l2cap_sock.c    |    4 ++--
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d24b51c..81829e5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -279,6 +279,8 @@ struct l2cap_conn_param_update_rsp {
 /* ----- L2CAP channels and connections ----- */
 struct l2cap_chan {
 	struct sock *sk;
+	__u8		ident;
+
 	struct list_head list;
 };
 
@@ -363,8 +365,6 @@ struct l2cap_pinfo {
 	__u16		partial_sdu_len;
 	struct sk_buff	*sdu;
 
-	__u8		ident;
-
 	__u8		tx_win;
 	__u8		max_tx;
 	__u8		remote_tx_win;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3047c47..778b30b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -118,8 +118,7 @@ static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &conn->chan_l, list) {
-		struct sock *s = c->sk;
-		if (l2cap_pi(s)->ident == ident)
+		if (c->ident == ident)
 			return c;
 	}
 	return NULL;
@@ -410,8 +409,9 @@ static inline int __l2cap_no_conn_pending(struct sock *sk)
 	return !(l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND);
 }
 
-static void l2cap_do_start(struct sock *sk)
+static void l2cap_do_start(struct l2cap_chan *chan)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) {
@@ -423,11 +423,11 @@ static void l2cap_do_start(struct sock *sk)
 			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
 			req.psm  = l2cap_pi(sk)->psm;
 
-			l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+			chan->ident = l2cap_get_ident(conn);
 			l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
 
-			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-					L2CAP_CONN_REQ, sizeof(req), &req);
+			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ,
+							sizeof(req), &req);
 		}
 	} else {
 		struct l2cap_info_req req;
@@ -529,11 +529,11 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
 			req.psm  = l2cap_pi(sk)->psm;
 
-			l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+			chan->ident = l2cap_get_ident(conn);
 			l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
 
-			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-				L2CAP_CONN_REQ, sizeof(req), &req);
+			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ,
+							sizeof(req), &req);
 
 		} else if (sk->sk_state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -558,8 +558,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				rsp.status = cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
 			}
 
-			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
+							sizeof(rsp), &rsp);
 
 			if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT ||
 					rsp.result != L2CAP_CR_SUCCESS) {
@@ -694,7 +694,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
 		} else if (sk->sk_state == BT_CONNECT)
-			l2cap_do_start(sk);
+			l2cap_do_start(chan);
 
 		bh_unlock_sock(sk);
 	}
@@ -905,7 +905,7 @@ int l2cap_do_connect(struct sock *sk)
 			if (l2cap_check_security(sk))
 				sk->sk_state = BT_CONNECTED;
 		} else
-			l2cap_do_start(sk);
+			l2cap_do_start(chan);
 	}
 
 	err = 0;
@@ -2065,7 +2065,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
-	l2cap_pi(sk)->ident = cmd->ident;
+	chan->ident = cmd->ident;
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_check_security(sk)) {
@@ -2158,7 +2158,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		sk->sk_state = BT_CONFIG;
-		l2cap_pi(sk)->ident = 0;
+		chan->ident = 0;
 		l2cap_pi(sk)->dcid = dcid;
 		l2cap_pi(sk)->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
 
@@ -3864,10 +3864,10 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
 				req.psm  = l2cap_pi(sk)->psm;
 
-				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+				chan->ident = l2cap_get_ident(conn);
 				l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
 
-				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+				l2cap_send_cmd(conn, chan->ident,
 					L2CAP_CONN_REQ, sizeof(req), &req);
 			} else {
 				l2cap_sock_clear_timer(sk);
@@ -3890,8 +3890,8 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
 			rsp.result = cpu_to_le16(result);
 			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
+							sizeof(rsp), &rsp);
 		}
 
 		bh_unlock_sock(sk);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7df8118..cad4bc7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -818,7 +818,7 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
 		rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
 		rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-		l2cap_send_cmd(l2cap_pi(sk)->conn, l2cap_pi(sk)->ident,
+		l2cap_send_cmd(l2cap_pi(sk)->conn, l2cap_pi(sk)->chan->ident,
 					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
 
 		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) {
@@ -921,7 +921,7 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 			rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
 			rsp.result = cpu_to_le16(result);
 			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+			l2cap_send_cmd(conn, l2cap_pi(sk)->chan->ident,
 					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
 		}
 
-- 
1.7.4.1

