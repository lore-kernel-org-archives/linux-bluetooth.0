Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 8/8] Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND flag
Date: Sat, 14 Sep 2013 20:28:31 +0300
Message-Id: <1379179711-16436-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In the case of blocking sockets we should not proceed with sendmsg() if
the socket has the BT_SK_SUSPEND flag set. So far the code was only
ensuring that POLLOUT doesn't get set for non-blocking sockets using
poll() but there was no code in place to ensure that blocking sockets do
the right thing when writing to them.

This patch adds a new bt_sock_wait_ready helper function to sleep in the
sendmsg call if the BT_SK_SUSPEND flag is set, and wake up as soon as it
is unset. It also updates the L2CAP and RFCOMM sendmsg callbacks to take
advantage of this new helper function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v3: Use wait_ready instead of wait_unsuspend

 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 39 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_sock.c        |  6 ++++++
 net/bluetooth/rfcomm/sock.c       |  9 +++++++--
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 10d43d8..afbc711 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -249,6 +249,7 @@ int  bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 uint bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
+int  bt_sock_wait_ready(struct sock *sk, unsigned long flags);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk);
 void bt_accept_unlink(struct sock *sk);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 9096137..a883171c 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -525,6 +525,45 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
 }
 EXPORT_SYMBOL(bt_sock_wait_state);
 
+int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	unsigned long timeo;
+	int err = 0;
+
+	BT_DBG("sk %p", sk);
+
+	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
+
+	add_wait_queue(sk_sleep(sk), &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (test_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags)) {
+		if (!timeo) {
+			err = -EAGAIN;
+			break;
+		}
+
+		if (signal_pending(current)) {
+			err = sock_intr_errno(timeo);
+			break;
+		}
+
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock(sk);
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		err = sock_error(sk);
+		if (err)
+			break;
+	}
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(sk_sleep(sk), &wait);
+
+	return err;
+}
+EXPORT_SYMBOL(bt_sock_wait_ready);
+
 #ifdef CONFIG_PROC_FS
 struct bt_seq_state {
 	struct bt_sock_list *l;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0098af8..ad95b42 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -777,6 +777,12 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	if (sk->sk_state != BT_CONNECTED)
 		return -ENOTCONN;
 
+	lock_sock(sk);
+	err = bt_sock_wait_ready(sk, msg->msg_flags);
+	release_sock(sk);
+	if (err)
+		return err;
+
 	l2cap_chan_lock(chan);
 	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
 	l2cap_chan_unlock(chan);
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 30b3721..02d96e4 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -544,7 +544,7 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	struct sock *sk = sock->sk;
 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
 	struct sk_buff *skb;
-	int sent = 0;
+	int err, sent = 0;
 
 	if (test_bit(RFCOMM_DEFER_SETUP, &d->flags))
 		return -ENOTCONN;
@@ -559,9 +559,14 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 	lock_sock(sk);
 
+	err = bt_sock_wait_ready(sk, msg->msg_flags);
+	if (err) {
+		release_sock(sk);
+		return err;
+	}
+
 	while (len) {
 		size_t size = min_t(size_t, len, d->mtu);
-		int err;
 
 		skb = sock_alloc_send_skb(sk, size + RFCOMM_SKB_RESERVE,
 				msg->msg_flags & MSG_DONTWAIT, &err);
-- 
1.8.4.rc3

