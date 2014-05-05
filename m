Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
Date: Mon,  5 May 2014 12:31:23 +0300
Message-Id: <1399282285-32743-2-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The l2cap_chan_send() is changed to use kernel memory directly,
so this function must read the user buffer before sending the
message.

The change is done as the 6LoWPAN also uses l2cap_chan_send()
and in order to minimize the amount of code changes, we must
copy the user buffer in sock handling code.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/l2cap_core.c | 25 +++++++++++++++++++++----
 net/bluetooth/l2cap_sock.c | 25 ++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a1e5bb7..528b38a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2098,6 +2098,24 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 	}
 }
 
+static inline void memcpy_fromiovec_kernel(void *kdata, struct iovec *iov,
+					   int len)
+{
+	while (len > 0) {
+		if (iov->iov_len) {
+			int copy = min_t(unsigned int, len, iov->iov_len);
+
+			memcpy(kdata, iov->iov_base, copy);
+
+			len -= copy;
+			kdata += copy;
+			iov->iov_base += copy;
+			iov->iov_len -= copy;
+		}
+		iov++;
+	}
+}
+
 static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 					 struct msghdr *msg, int len,
 					 int count, struct sk_buff *skb)
@@ -2106,8 +2124,7 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 	struct sk_buff **frag;
 	int sent = 0;
 
-	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
-		return -EFAULT;
+	memcpy_fromiovec_kernel(skb_put(skb, count), msg->msg_iov, count);
 
 	sent += count;
 	len  -= count;
@@ -2126,8 +2143,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 
 		*frag = tmp;
 
-		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
-			return -EFAULT;
+		memcpy_fromiovec_kernel(skb_put(*frag, count), msg->msg_iov,
+					count);
 
 		(*frag)->priority = skb->priority;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f59e00c..bbee8dc 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -948,6 +948,9 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct msghdr kernel_msg;
+	struct kvec iv;
+	void *buf;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -968,10 +971,30 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	if (err)
 		return err;
 
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (memcpy_fromiovec(buf, msg->msg_iov, len)) {
+		err = -EFAULT;
+		goto done;
+	}
+
+	iv.iov_base = buf;
+	iv.iov_len = len;
+
+	memset(&kernel_msg, 0, sizeof(kernel_msg));
+
+	kernel_msg.msg_iov = (struct iovec *) &iv;
+	kernel_msg.msg_iovlen = 1;
+	kernel_msg.msg_flags = msg->msg_flags;
+
 	l2cap_chan_lock(chan);
-	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
+	err = l2cap_chan_send(chan, &kernel_msg, len, sk->sk_priority);
 	l2cap_chan_unlock(chan);
 
+done:
+	kfree(buf);
 	return err;
 }
 
-- 
1.8.3.1

