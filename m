Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2] Bluetooth: Fix deadlock when closing socket
Date: Tue, 28 Aug 2012 11:20:32 +0300
Message-Id: <1346142032-8845-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346079173-3284-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346079173-3284-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If we have unacked frames when closing bluetooth socket we deadlock
since conn->chan_lock, chan->lock and socket lock are taken. Remove
__l2cap_wait_ack completely.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/l2cap_core.c    |   32 --------------------------------
 net/bluetooth/l2cap_sock.c    |    3 ---
 3 files changed, 36 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 430218b..3ec8679 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -755,7 +755,6 @@ int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
 
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
-int __l2cap_wait_ack(struct sock *sk);
 
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bd13fb7..ea2082a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1686,38 +1686,6 @@ done:
 	return err;
 }
 
-int __l2cap_wait_ack(struct sock *sk)
-{
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-	DECLARE_WAITQUEUE(wait, current);
-	int err = 0;
-	int timeo = HZ/5;
-
-	add_wait_queue(sk_sleep(sk), &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	while (chan->unacked_frames > 0 && chan->conn) {
-		if (!timeo)
-			timeo = HZ/5;
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
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(sk_sleep(sk), &wait);
-	return err;
-}
-
 static void l2cap_monitor_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 997e0cb..cc26b1f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -866,9 +866,6 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	lock_sock(sk);
 
 	if (!sk->sk_shutdown) {
-		if (chan->mode == L2CAP_MODE_ERTM)
-			err = __l2cap_wait_ack(sk);
-
 		sk->sk_shutdown = SHUTDOWN_MASK;
 
 		release_sock(sk);
-- 
1.7.9.5

