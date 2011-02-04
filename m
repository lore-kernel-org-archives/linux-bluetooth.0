Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 16/16] Bluetooth: move __l2cap_sock_close() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:58 -0200
Message-Id: <1296799318-5517-17-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-16-git-send-email-padovan@profusion.mobi>
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
 <1296799318-5517-12-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-13-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-14-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-15-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-16-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +
 net/bluetooth/l2cap_core.c    |   84 +----------------------------------------
 net/bluetooth/l2cap_sock.c    |   78 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d4c93ed..75ef0b2 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -451,6 +451,8 @@ void l2cap_sock_kill(struct sock *sk);
 void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
+void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int err);
+void l2cap_chan_del(struct sock *sk, int err);
 int l2cap_do_connect(struct sock *sk);
 
 void l2cap_load(void);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0ba097d..ba7f9da 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -70,8 +70,6 @@ struct bt_sock_list l2cap_sk_list = {
 
 static void l2cap_busy_work(struct work_struct *work);
 
-static void l2cap_sock_close(struct sock *sk);
-
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
 
@@ -207,7 +205,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct so
 
 /* Delete channel.
  * Must be called on the locked socket. */
-static void l2cap_chan_del(struct sock *sk, int err)
+void l2cap_chan_del(struct sock *sk, int err)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sock *parent = bt_sk(sk)->parent;
@@ -457,7 +455,7 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 	}
 }
 
-static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int err)
+void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int err)
 {
 	struct l2cap_disconn_req req;
 
@@ -739,84 +737,6 @@ static struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
 	return node ? sk : sk1;
 }
 
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
-	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
-
-	switch (sk->sk_state) {
-	case BT_LISTEN:
-		l2cap_sock_cleanup_listen(sk);
-		break;
-
-	case BT_CONNECTED:
-	case BT_CONFIG:
-		if (sk->sk_type == SOCK_SEQPACKET ||
-				sk->sk_type == SOCK_STREAM) {
-			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-
-			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
-			l2cap_send_disconn_req(conn, sk, reason);
-		} else
-			l2cap_chan_del(sk, reason);
-		break;
-
-	case BT_CONNECT2:
-		if (sk->sk_type == SOCK_SEQPACKET ||
-				sk->sk_type == SOCK_STREAM) {
-			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-			struct l2cap_conn_rsp rsp;
-			__u16 result;
-
-			if (bt_sk(sk)->defer_setup)
-				result = L2CAP_CR_SEC_BLOCK;
-			else
-				result = L2CAP_CR_BAD_PSM;
-
-			rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
-			rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
-			rsp.result = cpu_to_le16(result);
-			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
-		} else
-			l2cap_chan_del(sk, reason);
-		break;
-
-	case BT_CONNECT:
-	case BT_DISCONN:
-		l2cap_chan_del(sk, reason);
-		break;
-
-	default:
-		sock_set_flag(sk, SOCK_ZAPPED);
-		break;
-	}
-}
-
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
 int l2cap_do_connect(struct sock *sk)
 {
 	bdaddr_t *src = &bt_sk(sk)->src;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4b4e020..adf4169 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -854,6 +854,84 @@ void l2cap_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
+/* Must be called on unlocked socket. */
+static void l2cap_sock_close(struct sock *sk)
+{
+	l2cap_sock_clear_timer(sk);
+	lock_sock(sk);
+	__l2cap_sock_close(sk, ECONNRESET);
+	release_sock(sk);
+	l2cap_sock_kill(sk);
+}
+
+static void l2cap_sock_cleanup_listen(struct sock *parent)
+{
+	struct sock *sk;
+
+	BT_DBG("parent %p", parent);
+
+	/* Close not yet accepted channels */
+	while ((sk = bt_accept_dequeue(parent, NULL)))
+		l2cap_sock_close(sk);
+
+	parent->sk_state = BT_CLOSED;
+	sock_set_flag(parent, SOCK_ZAPPED);
+}
+
+void __l2cap_sock_close(struct sock *sk, int reason)
+{
+	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
+
+	switch (sk->sk_state) {
+	case BT_LISTEN:
+		l2cap_sock_cleanup_listen(sk);
+		break;
+
+	case BT_CONNECTED:
+	case BT_CONFIG:
+		if (sk->sk_type == SOCK_SEQPACKET ||
+				sk->sk_type == SOCK_STREAM) {
+			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+
+			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
+			l2cap_send_disconn_req(conn, sk, reason);
+		} else
+			l2cap_chan_del(sk, reason);
+		break;
+
+	case BT_CONNECT2:
+		if (sk->sk_type == SOCK_SEQPACKET ||
+				sk->sk_type == SOCK_STREAM) {
+			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+			struct l2cap_conn_rsp rsp;
+			__u16 result;
+
+			if (bt_sk(sk)->defer_setup)
+				result = L2CAP_CR_SEC_BLOCK;
+			else
+				result = L2CAP_CR_BAD_PSM;
+
+			rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
+			rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
+			rsp.result = cpu_to_le16(result);
+			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+		} else
+			l2cap_chan_del(sk, reason);
+		break;
+
+	case BT_CONNECT:
+	case BT_DISCONN:
+		l2cap_chan_del(sk, reason);
+		break;
+
+	default:
+		sock_set_flag(sk, SOCK_ZAPPED);
+		break;
+	}
+}
+
 static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

