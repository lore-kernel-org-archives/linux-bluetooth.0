Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0] Bluetooth: Fix SO_LINGER in L2CAP
Date: Mon, 10 Sep 2012 11:23:08 +0300
Message-Id: <1347265388-19759-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <alpine.DEB.2.02.1209070949580.3761@mathewm-linux>
References: <alpine.DEB.2.02.1209070949580.3761@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   35 ++++++++++++++++-------------------
 net/bluetooth/l2cap_sock.c    |    9 +++------
 3 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 8a726ff..72ffe53 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -757,7 +757,7 @@ int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
 
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
-int __l2cap_wait_ack(struct sock *sk);
+int __l2cap_wait_ack(struct sock *sk, unsigned long timeo);
 
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b1914e6..0502042 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1696,35 +1696,32 @@ done:
 	return err;
 }
 
-int __l2cap_wait_ack(struct sock *sk)
+int __l2cap_wait_ack(struct sock *sk, unsigned long timeo)
 {
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
-	int timeo = HZ/5;
 
-	add_wait_queue(sk_sleep(sk), &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	while (chan->unacked_frames > 0 && chan->conn) {
-		if (!timeo)
-			timeo = HZ/5;
+	if (unlikely(!skb_queue_empty(&chan->tx_q))) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		add_wait_queue(sk_sleep(sk), &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (signal_pending(current)) {
 			err = sock_intr_errno(timeo);
-			break;
-		}
+		} else {
+			release_sock(sk);
+			timeo = schedule_timeout(timeo);
+			lock_sock(sk);
+			set_current_state(TASK_INTERRUPTIBLE);
 
-		release_sock(sk);
-		timeo = schedule_timeout(timeo);
-		lock_sock(sk);
-		set_current_state(TASK_INTERRUPTIBLE);
+			err = sock_error(sk);
+		}
 
-		err = sock_error(sk);
-		if (err)
-			break;
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(sk_sleep(sk), &wait);
 	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(sk_sleep(sk), &wait);
+
 	return err;
 }
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f9cdc02..bb3515f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -866,18 +866,15 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	lock_sock(sk);
 
 	if (!sk->sk_shutdown) {
-		if (chan->mode == L2CAP_MODE_ERTM)
-			err = __l2cap_wait_ack(sk);
+		if (chan->mode == L2CAP_MODE_ERTM &&
+		    sock_flag(sk, SOCK_LINGER && sk->sk_lingertime))
+			err = __l2cap_wait_ack(sk, sk->sk_lingertime);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
 
 		release_sock(sk);
 		l2cap_chan_close(chan, 0);
 		lock_sock(sk);
-
-		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
-			err = bt_sock_wait_state(sk, BT_CLOSED,
-							sk->sk_lingertime);
 	}
 
 	if (!err && sk->sk_err)
-- 
1.7.9.5

