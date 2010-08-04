Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 7/9] Bluetooth:  Use common SOCK_STREAM receive code in RFCOMM.
Date: Wed,  4 Aug 2010 15:49:04 -0700
Message-Id: <1280962146-22604-8-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

To reduce code duplication, have rfcomm_sock_recvmsg() call
bt_sock_stream_recvmsg().  The common bt_sock_stream_recvmsg()
code is nearly identical, with the RFCOMM-specific functionality
for deferred setup and connection unthrottling left in
rfcomm_sock_recvmsg().

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/rfcomm/sock.c |  104 +++----------------------------------------
 1 files changed, 6 insertions(+), 98 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 44a6232..4396f47 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -617,121 +617,29 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	return sent;
 }
 
-static long rfcomm_sock_data_wait(struct sock *sk, long timeo)
-{
-	DECLARE_WAITQUEUE(wait, current);
-
-	add_wait_queue(sk_sleep(sk), &wait);
-	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (!skb_queue_empty(&sk->sk_receive_queue) ||
-		    sk->sk_err ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current) ||
-		    !timeo)
-			break;
-
-		set_bit(SOCK_ASYNC_WAITDATA, &sk->sk_socket->flags);
-		release_sock(sk);
-		timeo = schedule_timeout(timeo);
-		lock_sock(sk);
-		clear_bit(SOCK_ASYNC_WAITDATA, &sk->sk_socket->flags);
-	}
-
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(sk_sleep(sk), &wait);
-	return timeo;
-}
-
 static int rfcomm_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 			       struct msghdr *msg, size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
-	int err = 0;
-	size_t target, copied = 0;
-	long timeo;
+	int len;
 
 	if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags)) {
 		rfcomm_dlc_accept(d);
 		return 0;
 	}
 
-	if (flags & MSG_OOB)
-		return -EOPNOTSUPP;
-
-	msg->msg_namelen = 0;
-
-	BT_DBG("sk %p size %zu", sk, size);
+	len = bt_sock_stream_recvmsg(iocb, sock, msg, size, flags);
 
 	lock_sock(sk);
+	if (!(flags & MSG_PEEK) && len > 0)
+		atomic_sub(len, &sk->sk_rmem_alloc);
 
-	target = sock_rcvlowat(sk, flags & MSG_WAITALL, size);
-	timeo  = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
-
-	do {
-		struct sk_buff *skb;
-		int chunk;
-
-		skb = skb_dequeue(&sk->sk_receive_queue);
-		if (!skb) {
-			if (copied >= target)
-				break;
-
-			if ((err = sock_error(sk)) != 0)
-				break;
-			if (sk->sk_shutdown & RCV_SHUTDOWN)
-				break;
-
-			err = -EAGAIN;
-			if (!timeo)
-				break;
-
-			timeo = rfcomm_sock_data_wait(sk, timeo);
-
-			if (signal_pending(current)) {
-				err = sock_intr_errno(timeo);
-				goto out;
-			}
-			continue;
-		}
-
-		chunk = min_t(unsigned int, skb->len, size);
-		if (memcpy_toiovec(msg->msg_iov, skb->data, chunk)) {
-			skb_queue_head(&sk->sk_receive_queue, skb);
-			if (!copied)
-				copied = -EFAULT;
-			break;
-		}
-		copied += chunk;
-		size   -= chunk;
-
-		sock_recv_ts_and_drops(msg, sk, skb);
-
-		if (!(flags & MSG_PEEK)) {
-			atomic_sub(chunk, &sk->sk_rmem_alloc);
-
-			skb_pull(skb, chunk);
-			if (skb->len) {
-				skb_queue_head(&sk->sk_receive_queue, skb);
-				break;
-			}
-			kfree_skb(skb);
-
-		} else {
-			/* put message back and return */
-			skb_queue_head(&sk->sk_receive_queue, skb);
-			break;
-		}
-	} while (size);
-
-out:
 	if (atomic_read(&sk->sk_rmem_alloc) <= (sk->sk_rcvbuf >> 2))
 		rfcomm_dlc_unthrottle(rfcomm_pi(sk)->dlc);
-
 	release_sock(sk);
-	return copied ? : err;
+
+	return len;
 }
 
 static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
