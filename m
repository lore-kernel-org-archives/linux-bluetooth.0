Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 06/16] Bluetooth: move l2cap_sock_accept() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:48 -0200
Message-Id: <1296799318-5517-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/l2cap_core.c    |   56 -----------------------------------------
 net/bluetooth/l2cap_sock.c    |   56 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3ca4fe3..7921b6b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -439,7 +439,6 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 
 int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags);
-int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int flags);
 int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer);
 int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
 int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4a90c5..32a615a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -992,62 +992,6 @@ done:
 	return err;
 }
 
-int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int flags)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	struct sock *sk = sock->sk, *nsk;
-	long timeo;
-	int err = 0;
-
-	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
-
-	if (sk->sk_state != BT_LISTEN) {
-		err = -EBADFD;
-		goto done;
-	}
-
-	timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
-
-	BT_DBG("sk %p timeo %ld", sk, timeo);
-
-	/* Wait for an incoming connection. (wake-one). */
-	add_wait_queue_exclusive(sk_sleep(sk), &wait);
-	while (!(nsk = bt_accept_dequeue(sk, newsock))) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (!timeo) {
-			err = -EAGAIN;
-			break;
-		}
-
-		release_sock(sk);
-		timeo = schedule_timeout(timeo);
-		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
-
-		if (sk->sk_state != BT_LISTEN) {
-			err = -EBADFD;
-			break;
-		}
-
-		if (signal_pending(current)) {
-			err = sock_intr_errno(timeo);
-			break;
-		}
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(sk_sleep(sk), &wait);
-
-	if (err)
-		goto done;
-
-	newsock->state = SS_CONNECTED;
-
-	BT_DBG("new socket %p", nsk);
-
-done:
-	release_sock(sk);
-	return err;
-}
-
 int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer)
 {
 	struct sockaddr_l2 *la = (struct sockaddr_l2 *) addr;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ef9a60f..b19a386 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -197,6 +197,62 @@ done:
 	return err;
 }
 
+static int l2cap_sock_accept(struct socket *sock, struct socket *newsock, int flags)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	struct sock *sk = sock->sk, *nsk;
+	long timeo;
+	int err = 0;
+
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+
+	if (sk->sk_state != BT_LISTEN) {
+		err = -EBADFD;
+		goto done;
+	}
+
+	timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
+
+	BT_DBG("sk %p timeo %ld", sk, timeo);
+
+	/* Wait for an incoming connection. (wake-one). */
+	add_wait_queue_exclusive(sk_sleep(sk), &wait);
+	while (!(nsk = bt_accept_dequeue(sk, newsock))) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!timeo) {
+			err = -EAGAIN;
+			break;
+		}
+
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+
+		if (sk->sk_state != BT_LISTEN) {
+			err = -EBADFD;
+			break;
+		}
+
+		if (signal_pending(current)) {
+			err = sock_intr_errno(timeo);
+			break;
+		}
+	}
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(sk_sleep(sk), &wait);
+
+	if (err)
+		goto done;
+
+	newsock->state = SS_CONNECTED;
+
+	BT_DBG("new socket %p", nsk);
+
+done:
+	release_sock(sk);
+	return err;
+}
+
 static int l2cap_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

