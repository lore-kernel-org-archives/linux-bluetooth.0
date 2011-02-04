Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 11/16] Bluetooth: move l2cap_sock_recvmsg() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:53 -0200
Message-Id: <1296799318-5517-12-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-11-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-7-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-8-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-9-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-10-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-11-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It causes the move of the declaration of 3 functions to l2cap.h:
l2cap_get_ident(), l2cap_send_cmd(), l2cap_build_conf_req()

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    5 +++-
 net/bluetooth/l2cap_core.c    |   49 ++--------------------------------------
 net/bluetooth/l2cap_sock.c    |   42 +++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b5ebf87..336b2af7 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -431,6 +431,10 @@ extern struct bt_sock_list l2cap_sk_list;
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
 
+u8 l2cap_get_ident(struct l2cap_conn *conn);
+void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data);
+int l2cap_build_conf_req(struct sock *sk, void *data);
+
 void l2cap_sock_set_timer(struct sock *sk, long timeout);
 void __l2cap_sock_close(struct sock *sk, int reason);
 void l2cap_sock_kill(struct sock *sk);
@@ -440,7 +444,6 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 int l2cap_do_connect(struct sock *sk);
 
 int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
-int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
 int l2cap_sock_shutdown(struct socket *sock, int how);
 
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2d141fc..8184d54 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -72,7 +72,6 @@ static void l2cap_busy_work(struct work_struct *work);
 
 static void l2cap_sock_close(struct sock *sk);
 
-static int l2cap_build_conf_req(struct sock *sk, void *data);
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
 
@@ -311,7 +310,7 @@ static inline int l2cap_check_security(struct sock *sk)
 								auth_type);
 }
 
-static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
+u8 l2cap_get_ident(struct l2cap_conn *conn)
 {
 	u8 id;
 
@@ -333,7 +332,7 @@ static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
 	return id;
 }
 
-static inline void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
+void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
 {
 	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
 	u8 flags;
@@ -1468,48 +1467,6 @@ done:
 	return err;
 }
 
-int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
-{
-	struct sock *sk = sock->sk;
-
-	lock_sock(sk);
-
-	if (sk->sk_state == BT_CONNECT2 && bt_sk(sk)->defer_setup) {
-		struct l2cap_conn_rsp rsp;
-		struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-		u8 buf[128];
-
-		sk->sk_state = BT_CONFIG;
-
-		rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
-		rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
-		rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
-		rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-		l2cap_send_cmd(l2cap_pi(sk)->conn, l2cap_pi(sk)->ident,
-					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
-
-		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) {
-			release_sock(sk);
-			return 0;
-		}
-
-		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-				l2cap_build_conf_req(sk, buf), buf);
-		l2cap_pi(sk)->num_conf_req++;
-
-		release_sock(sk);
-		return 0;
-	}
-
-	release_sock(sk);
-
-	if (sock->type == SOCK_STREAM)
-		return bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
-
-	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
-}
-
 int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
@@ -1759,7 +1716,7 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
 	}
 }
 
-static int l2cap_build_conf_req(struct sock *sk, void *data)
+int l2cap_build_conf_req(struct sock *sk, void *data)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e2f14f1..fa2bc5d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -681,6 +681,48 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 	return err;
 }
 
+static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
+{
+	struct sock *sk = sock->sk;
+
+	lock_sock(sk);
+
+	if (sk->sk_state == BT_CONNECT2 && bt_sk(sk)->defer_setup) {
+		struct l2cap_conn_rsp rsp;
+		struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+		u8 buf[128];
+
+		sk->sk_state = BT_CONFIG;
+
+		rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
+		rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
+		rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
+		rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+		l2cap_send_cmd(l2cap_pi(sk)->conn, l2cap_pi(sk)->ident,
+					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+
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
+		release_sock(sk);
+		return 0;
+	}
+
+	release_sock(sk);
+
+	if (sock->type == SOCK_STREAM)
+		return bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
+
+	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
+}
+
 static int l2cap_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

