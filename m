Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, <luiz.dentz@gmail.com>,
	<marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
CC: Harish Jenny K N <harish_kandiga@mentor.com>, <gustavo@padovan.org>,
	<johan.hedberg@gmail.com>
Subject: [PATCH v1 2/3] Bluetooth: Reorganize mutex lock in l2cap_sock_shutdown()
Date: Wed, 14 Oct 2015 12:18:46 +0200
Message-ID: <1444817927-18834-3-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1444817927-18834-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1444817927-18834-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This commit reorganizes the mutex lock and is now
only protecting l2cap_chan_close(). This is now consistent
with other places where l2cap_chan_close() is called.

If a conn connection exists, call
mutex_lock(&conn->chan_lock) before calling l2cap_chan_close()
to ensure other L2CAP protocol operations do not interfere.

Note that the conn structure has to be protected from being
freed as it is possible for the connection to be disconnected
whilst the locks are not held. This solution allows the mutex
lock to be used even when the connection has just been
disconnected.

This commit also reduces the scope of chan locking.

The only place where chan locking is needed is the call to
l2cap_chan_close(chan, 0) which if necessary closes the channel.
Therefore, move the l2cap_chan_lock(chan) and
l2cap_chan_lock(chan) locking calls to around
l2cap_chan_close(chan, 0).

This allows __l2cap_wait_ack(sk, chan) to be called with no
chan locks being held so L2CAP messaging over the ACL link
can be done unimpaired.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---
 net/bluetooth/l2cap_sock.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ca5598d..d06fb54 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1111,6 +1111,8 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	if (!sk)
 		return 0;
 
+	lock_sock(sk);
+
 	if (sk->sk_shutdown)
 		goto shutdown_already;
 
@@ -1122,25 +1124,37 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	chan = l2cap_pi(sk)->chan;
 	/* prevent chan structure from being freed whilst unlocked */
 	l2cap_chan_hold(chan);
-	conn = chan->conn;
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (conn)
-		mutex_lock(&conn->chan_lock);
-
-	l2cap_chan_lock(chan);
-	lock_sock(sk);
-
 	if (chan->mode == L2CAP_MODE_ERTM &&
 	    chan->unacked_frames > 0 &&
 	    chan->state == BT_CONNECTED)
 		err = __l2cap_wait_ack(sk, chan);
 
 	sk->sk_shutdown = SHUTDOWN_MASK;
-
 	release_sock(sk);
+
+	l2cap_chan_lock(chan);
+	conn = chan->conn;
+	if (conn)
+		/* prevent conn structure from being freed */
+		l2cap_conn_get(conn);
+	l2cap_chan_unlock(chan);
+
+	if (conn)
+		/* mutex lock must be taken before l2cap_chan_lock() */
+		mutex_lock(&conn->chan_lock);
+
+	l2cap_chan_lock(chan);
 	l2cap_chan_close(chan, 0);
+	l2cap_chan_unlock(chan);
+
+	if (conn) {
+		mutex_unlock(&conn->chan_lock);
+		l2cap_conn_put(conn);
+	}
+
 	lock_sock(sk);
 
 	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
@@ -1148,20 +1162,16 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 		err = bt_sock_wait_state(sk, BT_CLOSED,
 					 sk->sk_lingertime);
 
+	l2cap_chan_put(chan);
+	sock_put(sk);
+
+shutdown_already:
 	if (!err && sk->sk_err)
 		err = -sk->sk_err;
 
 	release_sock(sk);
-	l2cap_chan_unlock(chan);
-
-	if (conn)
-		mutex_unlock(&conn->chan_lock);
 
-	l2cap_chan_put(chan);
-	sock_put(sk);
-
-shutdown_already:
-	BT_DBG("err: %d", err);
+	BT_DBG("Sock shutdown complete err: %d", err);
 
 	return err;
 }
-- 
1.8.5.6
