Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Rename __l2cap_chan_close() to l2cap_chan_close()
Date: Thu, 12 May 2011 02:32:30 -0300
Message-Id: <1305178350-7568-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305178350-7568-5-git-send-email-padovan@profusion.mobi>
References: <1305178350-7568-1-git-send-email-padovan@profusion.mobi>
 <1305178350-7568-2-git-send-email-padovan@profusion.mobi>
 <1305178350-7568-3-git-send-email-padovan@profusion.mobi>
 <1305178350-7568-4-git-send-email-padovan@profusion.mobi>
 <1305178350-7568-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To make it consistent with the rest of the API.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   29 ++++++++++++-----------------
 net/bluetooth/l2cap_sock.c    |    2 +-
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 86a076f..f78bb23 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -464,7 +464,7 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 
 struct l2cap_chan *l2cap_chan_create(struct sock *sk);
-void __l2cap_chan_close(struct l2cap_chan *chan, int reason);
+void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
 int l2cap_chan_connect(struct l2cap_chan *chan);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4e8b1d..2ea5ea9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -250,7 +250,7 @@ static void l2cap_chan_timeout(unsigned long arg)
 	else
 		reason = ETIMEDOUT;
 
-	__l2cap_chan_close(chan, reason);
+	l2cap_chan_close(chan, reason);
 
 	bh_unlock_sock(sk);
 
@@ -383,16 +383,6 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	}
 }
 
-/* Must be called on unlocked socket. */
-static void l2cap_chan_close(struct sock *sk)
-{
-	l2cap_chan_clear_timer(l2cap_pi(sk)->chan);
-	lock_sock(sk);
-	__l2cap_chan_close(l2cap_pi(sk)->chan, ECONNRESET);
-	release_sock(sk);
-	l2cap_sock_kill(sk);
-}
-
 static void l2cap_chan_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
@@ -400,14 +390,19 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 	BT_DBG("parent %p", parent);
 
 	/* Close not yet accepted channels */
-	while ((sk = bt_accept_dequeue(parent, NULL)))
-		l2cap_chan_close(sk);
+	while ((sk = bt_accept_dequeue(parent, NULL))) {
+		l2cap_chan_clear_timer(l2cap_pi(sk)->chan);
+		lock_sock(sk);
+		l2cap_chan_close(l2cap_pi(sk)->chan, ECONNRESET);
+		release_sock(sk);
+		l2cap_sock_kill(sk);
+	}
 
 	parent->sk_state = BT_CLOSED;
 	sock_set_flag(parent, SOCK_ZAPPED);
 }
 
-void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
+void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sock *sk = chan->sk;
@@ -724,10 +719,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					conn->feat_mask)
 					&& chan->conf_state &
 					L2CAP_CONF_STATE2_DEVICE) {
-				/* __l2cap_chan_close() calls list_del(chan)
+				/* l2cap_chan_close() calls list_del(chan)
 				 * so release the lock */
 				read_unlock_bh(&conn->chan_lock);
-				 __l2cap_chan_close(chan, ECONNRESET);
+				 l2cap_chan_close(chan, ECONNRESET);
 				read_lock_bh(&conn->chan_lock);
 				bh_unlock_sock(sk);
 				continue;
@@ -4156,7 +4151,7 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 			l2cap_chan_clear_timer(chan);
 			l2cap_chan_set_timer(chan, HZ * 5);
 		} else if (chan->sec_level == BT_SECURITY_HIGH)
-			__l2cap_chan_close(chan, ECONNREFUSED);
+			l2cap_chan_close(chan, ECONNREFUSED);
 	} else {
 		if (chan->sec_level == BT_SECURITY_MEDIUM)
 			l2cap_chan_clear_timer(chan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 993846c..a6bfe85 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -707,7 +707,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 			err = __l2cap_wait_ack(sk);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
-		__l2cap_chan_close(chan, 0);
+		l2cap_chan_close(chan, 0);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
 			err = bt_sock_wait_state(sk, BT_CLOSED,
-- 
1.7.5.rc3

