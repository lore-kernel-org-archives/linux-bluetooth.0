Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 6/9] Bluetooth: Add common code for stream-oriented recvmsg()
Date: Thu,  5 Aug 2010 15:54:24 -0700
Message-Id: <1281048867-32630-7-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
References: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commit adds a bt_sock_stream_recvmsg() function for use by any
Bluetooth code that uses SOCK_STREAM sockets.  This code is copied
from rfcomm_sock_recvmsg() with minimal modifications to remove
RFCOMM-specific functionality and improve readability.

L2CAP (with the SOCK_STREAM socket type) and RFCOMM have common needs
when it comes to reading data.  Proper stream read semantics require
that applications can read from a stream one byte at a time and not
lose any data.  The RFCOMM code already operated on and pulled data
from the underlying L2CAP socket, so very few changes were required to
make the code more generic for use with non-RFCOMM data over L2CAP.

Applications that need more awareness of L2CAP frame boundaries are
still free to use SOCK_SEQPACKET sockets, and may verify that they
connection did not fall back to basic mode by calling getsockopt().

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/bluetooth.h |    2 +
 net/bluetooth/af_bluetooth.c      |  109 +++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 27a902d..08b6c2a 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -126,6 +126,8 @@ int  bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
 int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
+int  bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
+			struct msghdr *msg, size_t len, int flags);
 uint bt_sock_poll(struct file * file, struct socket *sock, poll_table *wait);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 421c45b..77a26fe 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -265,6 +265,115 @@ int bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 }
 EXPORT_SYMBOL(bt_sock_recvmsg);
 
+static long bt_sock_data_wait(struct sock *sk, long timeo)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	add_wait_queue(sk_sleep(sk), &wait);
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (!skb_queue_empty(&sk->sk_receive_queue))
+			break;
+
+		if (sk->sk_err || (sk->sk_shutdown & RCV_SHUTDOWN))
+			break;
+
+		if (signal_pending(current) || !timeo)
+			break;
+
+		set_bit(SOCK_ASYNC_WAITDATA, &sk->sk_socket->flags);
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock(sk);
+		clear_bit(SOCK_ASYNC_WAITDATA, &sk->sk_socket->flags);
+	}
+
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(sk_sleep(sk), &wait);
+	return timeo;
+}
+
+int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
+			       struct msghdr *msg, size_t size, int flags)
+{
+	struct sock *sk = sock->sk;
+	int err = 0;
+	size_t target, copied = 0;
+	long timeo;
+
+	if (flags & MSG_OOB)
+		return -EOPNOTSUPP;
+
+	msg->msg_namelen = 0;
+
+	BT_DBG("sk %p size %zu", sk, size);
+
+	lock_sock(sk);
+
+	target = sock_rcvlowat(sk, flags & MSG_WAITALL, size);
+	timeo  = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+
+	do {
+		struct sk_buff *skb;
+		int chunk;
+
+		skb = skb_dequeue(&sk->sk_receive_queue);
+		if (!skb) {
+			if (copied >= target)
+				break;
+
+			if ((err = sock_error(sk)) != 0)
+				break;
+			if (sk->sk_shutdown & RCV_SHUTDOWN)
+				break;
+
+			err = -EAGAIN;
+			if (!timeo)
+				break;
+
+			timeo = bt_sock_data_wait(sk, timeo);
+
+			if (signal_pending(current)) {
+				err = sock_intr_errno(timeo);
+				goto out;
+			}
+			continue;
+		}
+
+		chunk = min_t(unsigned int, skb->len, size);
+		if (memcpy_toiovec(msg->msg_iov, skb->data, chunk)) {
+			skb_queue_head(&sk->sk_receive_queue, skb);
+			if (!copied)
+				copied = -EFAULT;
+			break;
+		}
+		copied += chunk;
+		size   -= chunk;
+
+		sock_recv_ts_and_drops(msg, sk, skb);
+
+		if (!(flags & MSG_PEEK)) {
+			skb_pull(skb, chunk);
+			if (skb->len) {
+				skb_queue_head(&sk->sk_receive_queue, skb);
+				break;
+			}
+			kfree_skb(skb);
+
+		} else {
+			/* put message back and return */
+			skb_queue_head(&sk->sk_receive_queue, skb);
+			break;
+		}
+	} while (size);
+
+out:
+	release_sock(sk);
+	return copied ? : err;
+}
+EXPORT_SYMBOL(bt_sock_stream_recvmsg);
+
 static inline unsigned int bt_accept_poll(struct sock *parent)
 {
 	struct list_head *p, *n;
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
