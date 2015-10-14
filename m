Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, <luiz.dentz@gmail.com>,
	<marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
CC: Harish Jenny K N <harish_kandiga@mentor.com>, <gustavo@padovan.org>,
	<johan.hedberg@gmail.com>
Subject: [PATCH v1 1/3] Bluetooth: Unwind l2cap_sock_shutdown()
Date: Wed, 14 Oct 2015 12:18:45 +0200
Message-ID: <1444817927-18834-2-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1444817927-18834-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1444817927-18834-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_sock_shutdown() is designed to only action shutdown
of the channel when shutdown is not already in progress.
Therefore, reorganise the code flow by adding a goto
to jump to the end of function handling when shutdown is
already being actioned. This removes one level of code
indentation and make the code more readable.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---
 net/bluetooth/l2cap_sock.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 586b3d5..ca5598d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1111,6 +1111,11 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	if (!sk)
 		return 0;
 
+	if (sk->sk_shutdown)
+		goto shutdown_already;
+
+	BT_DBG("Handling sock shutdown");
+
 	/* prevent sk structure from being freed whilst unlocked */
 	sock_hold(sk);
 
@@ -1127,23 +1132,21 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
-	if (!sk->sk_shutdown) {
-		if (chan->mode == L2CAP_MODE_ERTM &&
-		    chan->unacked_frames > 0 &&
-		    chan->state == BT_CONNECTED)
-			err = __l2cap_wait_ack(sk, chan);
+	if (chan->mode == L2CAP_MODE_ERTM &&
+	    chan->unacked_frames > 0 &&
+	    chan->state == BT_CONNECTED)
+		err = __l2cap_wait_ack(sk, chan);
 
-		sk->sk_shutdown = SHUTDOWN_MASK;
+	sk->sk_shutdown = SHUTDOWN_MASK;
 
-		release_sock(sk);
-		l2cap_chan_close(chan, 0);
-		lock_sock(sk);
+	release_sock(sk);
+	l2cap_chan_close(chan, 0);
+	lock_sock(sk);
 
-		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
-		    !(current->flags & PF_EXITING))
-			err = bt_sock_wait_state(sk, BT_CLOSED,
-						 sk->sk_lingertime);
-	}
+	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+	    !(current->flags & PF_EXITING))
+		err = bt_sock_wait_state(sk, BT_CLOSED,
+					 sk->sk_lingertime);
 
 	if (!err && sk->sk_err)
 		err = -sk->sk_err;
@@ -1157,6 +1160,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	l2cap_chan_put(chan);
 	sock_put(sk);
 
+shutdown_already:
 	BT_DBG("err: %d", err);
 
 	return err;
-- 
1.8.5.6
