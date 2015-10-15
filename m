Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Remove __l2cap_wait_ack
Date: Thu, 15 Oct 2015 16:06:56 +0300
Message-Id: <1444914416-27666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

__l2cap_wait_ack probably cause more harm than good since it was added as
a feature to wait until all unacked packets are processed and properly
acked by the remote but it ignored the fact that the remote may probably
wait some window threshold before start acking.

Since the window threshold is implementation specific, we ack when the
window is 3/4th full, it should probably be the receiving side that
should ack or discard the packets in the queue when processing the
Disconnect request.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 50 ----------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 586b3d5..5bfb406 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1054,51 +1054,6 @@ static void l2cap_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
-static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	int err = 0;
-	int timeo = L2CAP_WAIT_ACK_POLL_PERIOD;
-	/* Timeout to prevent infinite loop */
-	unsigned long timeout = jiffies + L2CAP_WAIT_ACK_TIMEOUT;
-
-	add_wait_queue(sk_sleep(sk), &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	do {
-		BT_DBG("Waiting for %d ACKs, timeout %04d ms",
-		       chan->unacked_frames, time_after(jiffies, timeout) ? 0 :
-		       jiffies_to_msecs(timeout - jiffies));
-
-		if (!timeo)
-			timeo = L2CAP_WAIT_ACK_POLL_PERIOD;
-
-		if (signal_pending(current)) {
-			err = sock_intr_errno(timeo);
-			break;
-		}
-
-		release_sock(sk);
-		timeo = schedule_timeout(timeo);
-		lock_sock(sk);
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		err = sock_error(sk);
-		if (err)
-			break;
-
-		if (time_after(jiffies, timeout)) {
-			err = -ENOLINK;
-			break;
-		}
-
-	} while (chan->unacked_frames > 0 &&
-		 chan->state == BT_CONNECTED);
-
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(sk_sleep(sk), &wait);
-	return err;
-}
-
 static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
@@ -1128,11 +1083,6 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	lock_sock(sk);
 
 	if (!sk->sk_shutdown) {
-		if (chan->mode == L2CAP_MODE_ERTM &&
-		    chan->unacked_frames > 0 &&
-		    chan->state == BT_CONNECTED)
-			err = __l2cap_wait_ack(sk, chan);
-
 		sk->sk_shutdown = SHUTDOWN_MASK;
 
 		release_sock(sk);
-- 
2.4.3

