Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 2/7] Bluetooth: Create __l2cap_chan_close()
Date: Fri, 13 May 2011 16:20:45 -0300
Message-Id: <1305314450-25493-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305314450-25493-2-git-send-email-padovan@profusion.mobi>
References: <1305314450-25493-1-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is actually __l2cap_sock_close() renamed to __l2cap_chan_close().
At a first look it may not make sense, but with the further cleanups that
will come it will.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    5 +--
 net/bluetooth/l2cap_core.c    |   97 ++++++++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    |   85 +-----------------------------------
 3 files changed, 94 insertions(+), 93 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d09c9b1..ed75e65 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -446,7 +446,6 @@ extern int disable_ertm;
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
 
-void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data);
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
 int __l2cap_wait_ack(struct sock *sk);
 
@@ -463,14 +462,12 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 void l2cap_sock_set_timer(struct sock *sk, long timeout);
 void l2cap_sock_clear_timer(struct sock *sk);
-void __l2cap_sock_close(struct sock *sk, int reason);
 void l2cap_sock_kill(struct sock *sk);
 void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
-void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err);
 struct l2cap_chan *l2cap_chan_create(struct sock *sk);
-void l2cap_chan_del(struct l2cap_chan *chan, int err);
+void __l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
 int l2cap_chan_connect(struct l2cap_chan *chan);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a5ab4a2..550585e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -69,7 +69,11 @@ static void l2cap_busy_work(struct work_struct *work);
 
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
+static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
+								void *data);
 static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
+static void l2cap_send_disconn_req(struct l2cap_conn *conn,
+				struct l2cap_chan *chan, int err);
 
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
@@ -271,7 +275,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 /* Delete channel.
  * Must be called on the locked socket. */
-void l2cap_chan_del(struct l2cap_chan *chan, int err)
+static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
@@ -327,6 +331,87 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	}
 }
 
+/* Must be called on unlocked socket. */
+static void l2cap_chan_close(struct sock *sk)
+{
+	l2cap_sock_clear_timer(sk);
+	lock_sock(sk);
+	__l2cap_chan_close(l2cap_pi(sk)->chan, ECONNRESET);
+	release_sock(sk);
+	l2cap_sock_kill(sk);
+}
+
+static void l2cap_chan_cleanup_listen(struct sock *parent)
+{
+	struct sock *sk;
+
+	BT_DBG("parent %p", parent);
+
+	/* Close not yet accepted channels */
+	while ((sk = bt_accept_dequeue(parent, NULL)))
+		l2cap_chan_close(sk);
+
+	parent->sk_state = BT_CLOSED;
+	sock_set_flag(parent, SOCK_ZAPPED);
+}
+
+void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct sock *sk = chan->sk;
+
+	BT_DBG("chan %p state %d socket %p", chan, sk->sk_state, sk->sk_socket);
+
+	switch (sk->sk_state) {
+	case BT_LISTEN:
+		l2cap_chan_cleanup_listen(sk);
+		break;
+
+	case BT_CONNECTED:
+	case BT_CONFIG:
+		if ((sk->sk_type == SOCK_SEQPACKET ||
+					sk->sk_type == SOCK_STREAM) &&
+					conn->hcon->type == ACL_LINK) {
+			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
+			l2cap_send_disconn_req(conn, chan, reason);
+		} else
+			l2cap_chan_del(chan, reason);
+		break;
+
+	case BT_CONNECT2:
+		if ((sk->sk_type == SOCK_SEQPACKET ||
+					sk->sk_type == SOCK_STREAM) &&
+					conn->hcon->type == ACL_LINK) {
+			struct l2cap_conn_rsp rsp;
+			__u16 result;
+
+			if (bt_sk(sk)->defer_setup)
+				result = L2CAP_CR_SEC_BLOCK;
+			else
+				result = L2CAP_CR_BAD_PSM;
+
+			rsp.scid   = cpu_to_le16(chan->dcid);
+			rsp.dcid   = cpu_to_le16(chan->scid);
+			rsp.result = cpu_to_le16(result);
+			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
+							sizeof(rsp), &rsp);
+		}
+
+		l2cap_chan_del(chan, reason);
+		break;
+
+	case BT_CONNECT:
+	case BT_DISCONN:
+		l2cap_chan_del(chan, reason);
+		break;
+
+	default:
+		sock_set_flag(sk, SOCK_ZAPPED);
+		break;
+	}
+}
+
 static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->sk;
@@ -393,7 +478,7 @@ u8 l2cap_get_ident(struct l2cap_conn *conn)
 	return id;
 }
 
-void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
+static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
 {
 	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
 	u8 flags;
@@ -533,7 +618,7 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 	}
 }
 
-void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
+static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
 {
 	struct sock *sk;
 	struct l2cap_disconn_req req;
@@ -591,10 +676,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					conn->feat_mask)
 					&& chan->conf_state &
 					L2CAP_CONF_STATE2_DEVICE) {
-				/* __l2cap_sock_close() calls list_del(chan)
+				/* __l2cap_chan_close() calls list_del(chan)
 				 * so release the lock */
 				read_unlock_bh(&conn->chan_lock);
-				 __l2cap_sock_close(sk, ECONNRESET);
+				 __l2cap_chan_close(chan, ECONNRESET);
 				read_lock_bh(&conn->chan_lock);
 				bh_unlock_sock(sk);
 				continue;
@@ -3949,7 +4034,7 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 			l2cap_sock_clear_timer(sk);
 			l2cap_sock_set_timer(sk, HZ * 5);
 		} else if (chan->sec_level == BT_SECURITY_HIGH)
-			__l2cap_sock_close(sk, ECONNREFUSED);
+			__l2cap_chan_close(chan, ECONNREFUSED);
 	} else {
 		if (chan->sec_level == BT_SECURITY_MEDIUM)
 			l2cap_sock_clear_timer(sk);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c98360d..f57afa5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -58,7 +58,7 @@ static void l2cap_sock_timeout(unsigned long arg)
 	else
 		reason = ETIMEDOUT;
 
-	__l2cap_sock_close(sk, reason);
+	__l2cap_chan_close(l2cap_pi(sk)->chan, reason);
 
 	bh_unlock_sock(sk);
 
@@ -813,87 +813,6 @@ void l2cap_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
-/* Must be called on unlocked socket. */
-static void l2cap_sock_close(struct sock *sk)
-{
-	l2cap_sock_clear_timer(sk);
-	lock_sock(sk);
-	__l2cap_sock_close(sk, ECONNRESET);
-	release_sock(sk);
-	l2cap_sock_kill(sk);
-}
-
-static void l2cap_sock_cleanup_listen(struct sock *parent)
-{
-	struct sock *sk;
-
-	BT_DBG("parent %p", parent);
-
-	/* Close not yet accepted channels */
-	while ((sk = bt_accept_dequeue(parent, NULL)))
-		l2cap_sock_close(sk);
-
-	parent->sk_state = BT_CLOSED;
-	sock_set_flag(parent, SOCK_ZAPPED);
-}
-
-void __l2cap_sock_close(struct sock *sk, int reason)
-{
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-	struct l2cap_conn *conn = chan->conn;
-
-	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
-
-	switch (sk->sk_state) {
-	case BT_LISTEN:
-		l2cap_sock_cleanup_listen(sk);
-		break;
-
-	case BT_CONNECTED:
-	case BT_CONFIG:
-		if ((sk->sk_type == SOCK_SEQPACKET ||
-					sk->sk_type == SOCK_STREAM) &&
-					conn->hcon->type == ACL_LINK) {
-			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
-			l2cap_send_disconn_req(conn, chan, reason);
-		} else
-			l2cap_chan_del(chan, reason);
-		break;
-
-	case BT_CONNECT2:
-		if ((sk->sk_type == SOCK_SEQPACKET ||
-					sk->sk_type == SOCK_STREAM) &&
-					conn->hcon->type == ACL_LINK) {
-			struct l2cap_conn_rsp rsp;
-			__u16 result;
-
-			if (bt_sk(sk)->defer_setup)
-				result = L2CAP_CR_SEC_BLOCK;
-			else
-				result = L2CAP_CR_BAD_PSM;
-
-			rsp.scid   = cpu_to_le16(chan->dcid);
-			rsp.dcid   = cpu_to_le16(chan->scid);
-			rsp.result = cpu_to_le16(result);
-			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
-							sizeof(rsp), &rsp);
-		}
-
-		l2cap_chan_del(chan, reason);
-		break;
-
-	case BT_CONNECT:
-	case BT_DISCONN:
-		l2cap_chan_del(chan, reason);
-		break;
-
-	default:
-		sock_set_flag(sk, SOCK_ZAPPED);
-		break;
-	}
-}
-
 static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
@@ -912,7 +831,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
 		l2cap_sock_clear_timer(sk);
-		__l2cap_sock_close(sk, 0);
+		__l2cap_chan_close(chan, 0);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
 			err = bt_sock_wait_state(sk, BT_CLOSED,
-- 
1.7.5.rc3

