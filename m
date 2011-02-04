Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 12/16] Bluetooth: move l2cap_sock_shutdown() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:54 -0200
Message-Id: <1296799318-5517-13-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-12-git-send-email-padovan@profusion.mobi>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Declare __l2cap_wait_ack() and  l2cap_sock_clear_timer() in l2cap.h

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    3 ++-
 net/bluetooth/l2cap_core.c    |   35 ++---------------------------------
 net/bluetooth/l2cap_sock.c    |   31 +++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 336b2af7..c9df0ef 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -434,8 +434,10 @@ void l2cap_cleanup_sockets(void);
 u8 l2cap_get_ident(struct l2cap_conn *conn);
 void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data);
 int l2cap_build_conf_req(struct sock *sk, void *data);
+int __l2cap_wait_ack(struct sock *sk);
 
 void l2cap_sock_set_timer(struct sock *sk, long timeout);
+void l2cap_sock_clear_timer(struct sock *sk);
 void __l2cap_sock_close(struct sock *sk, int reason);
 void l2cap_sock_kill(struct sock *sk);
 void l2cap_sock_init(struct sock *sk, struct sock *parent);
@@ -444,7 +446,6 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 int l2cap_do_connect(struct sock *sk);
 
 int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
-int l2cap_sock_shutdown(struct socket *sock, int how);
 
 
 void l2cap_load(void);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8184d54..0368a2e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -84,7 +84,7 @@ void l2cap_sock_set_timer(struct sock *sk, long timeout)
 	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
 }
 
-static void l2cap_sock_clear_timer(struct sock *sk)
+void l2cap_sock_clear_timer(struct sock *sk)
 {
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
 	sk_stop_timer(sk, &sk->sk_timer);
@@ -906,7 +906,7 @@ done:
 	return err;
 }
 
-static int __l2cap_wait_ack(struct sock *sk)
+int __l2cap_wait_ack(struct sock *sk)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
@@ -1467,37 +1467,6 @@ done:
 	return err;
 }
 
-int l2cap_sock_shutdown(struct socket *sock, int how)
-{
-	struct sock *sk = sock->sk;
-	int err = 0;
-
-	BT_DBG("sock %p, sk %p", sock, sk);
-
-	if (!sk)
-		return 0;
-
-	lock_sock(sk);
-	if (!sk->sk_shutdown) {
-		if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM)
-			err = __l2cap_wait_ack(sk);
-
-		sk->sk_shutdown = SHUTDOWN_MASK;
-		l2cap_sock_clear_timer(sk);
-		__l2cap_sock_close(sk, 0);
-
-		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
-			err = bt_sock_wait_state(sk, BT_CLOSED,
-							sk->sk_lingertime);
-	}
-
-	if (!err && sk->sk_err)
-		err = -sk->sk_err;
-
-	release_sock(sk);
-	return err;
-}
-
 static void l2cap_chan_ready(struct sock *sk)
 {
 	struct sock *parent = bt_sk(sk)->parent;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index fa2bc5d..93af233 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -723,6 +723,37 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
 }
 
+static int l2cap_sock_shutdown(struct socket *sock, int how)
+{
+	struct sock *sk = sock->sk;
+	int err = 0;
+
+	BT_DBG("sock %p, sk %p", sock, sk);
+
+	if (!sk)
+		return 0;
+
+	lock_sock(sk);
+	if (!sk->sk_shutdown) {
+		if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM)
+			err = __l2cap_wait_ack(sk);
+
+		sk->sk_shutdown = SHUTDOWN_MASK;
+		l2cap_sock_clear_timer(sk);
+		__l2cap_sock_close(sk, 0);
+
+		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
+			err = bt_sock_wait_state(sk, BT_CLOSED,
+							sk->sk_lingertime);
+	}
+
+	if (!err && sk->sk_err)
+		err = -sk->sk_err;
+
+	release_sock(sk);
+	return err;
+}
+
 static int l2cap_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

