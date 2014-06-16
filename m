Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Provide L2CAP ops callback for memcpy_fromiovec
Date: Mon, 16 Jun 2014 18:45:48 +0200
Message-Id: <1402937148-11662-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The highly optimized TX path for L2CAP channels and its fragmentation
within the HCI ACL packets requires to copy data from user provided
IO vectors and also kernel provided memory buffers.

This patch allows channel clients to provide a memcpy_fromiovec callback
to keep this optimized behavior, but adapt it to kernel vs user memory
for the TX path. For all kernel internal L2CAP channels, a default
implementation is provided that can be referenced.

In case of A2MP, this fixes a long-standing issue with wrongly accessing
kernel memory as user memory.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Tested-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/l2cap.h | 22 ++++++++++++++++++++++
 net/bluetooth/a2mp.c          |  1 +
 net/bluetooth/l2cap_core.c    |  6 ++++--
 net/bluetooth/l2cap_sock.c    | 34 +++++++++++++++++++++-------------
 4 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 92511034d1d4..6dcf4c79e668 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -602,6 +602,9 @@ struct l2cap_ops {
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long hdr_len,
 					       unsigned long len, int nb);
+	int			(*memcpy_fromiovec) (struct l2cap_chan *chan,
+						     unsigned char *kdata,
+						     struct iovec *iov, int len);
 };
 
 struct l2cap_conn {
@@ -857,6 +860,25 @@ static inline long l2cap_chan_no_get_sndtimeo(struct l2cap_chan *chan)
 	return 0;
 }
 
+static inline int l2cap_chan_no_memcpy_fromiovec(struct l2cap_chan *chan,
+						 unsigned char *kdata,
+						 struct iovec *iov, int len)
+{
+	while (len > 0) {
+		if (iov->iov_len) {
+			int copy = min_t(unsigned int, len, iov->iov_len);
+			memcpy(kdata, iov->iov_base, copy);
+			len -= copy;
+			kdata += copy;
+			iov->iov_base += copy;
+			iov->iov_len -= copy;
+		}
+		iov++;
+	}
+
+	return 0;
+}
+
 extern bool disable_ertm;
 
 int l2cap_init_sockets(void);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 0fd8d1dda709..5dcade511fdb 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -720,6 +720,7 @@ static const struct l2cap_ops a2mp_chan_ops = {
 	.resume = l2cap_chan_no_resume,
 	.set_shutdown = l2cap_chan_no_set_shutdown,
 	.get_sndtimeo = l2cap_chan_no_get_sndtimeo,
+	.memcpy_fromiovec = l2cap_chan_no_memcpy_fromiovec,
 };
 
 static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ac2461442f21..d0a5fde61a07 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2118,7 +2118,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 	struct sk_buff **frag;
 	int sent = 0;
 
-	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
+	if (chan->ops->memcpy_fromiovec(chan, skb_put(skb, count),
+					msg->msg_iov, count))
 		return -EFAULT;
 
 	sent += count;
@@ -2138,7 +2139,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 
 		*frag = tmp;
 
-		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
+		if (chan->ops->memcpy_fromiovec(chan, skb_put(*frag, count),
+						msg->msg_iov, count))
 			return -EFAULT;
 
 		sent += count;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 55215ebf6547..bf72886de6ef 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1313,6 +1313,13 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 	return skb;
 }
 
+static int l2cap_sock_memcpy_fromiovec_cb(struct l2cap_chan *chan,
+					  unsigned char *kdata,
+					  struct iovec *iov, int len)
+{
+	return memcpy_fromiovec(kdata, iov, len);
+}
+
 static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
@@ -1379,19 +1386,20 @@ static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
 }
 
 static const struct l2cap_ops l2cap_chan_ops = {
-	.name		= "L2CAP Socket Interface",
-	.new_connection	= l2cap_sock_new_connection_cb,
-	.recv		= l2cap_sock_recv_cb,
-	.close		= l2cap_sock_close_cb,
-	.teardown	= l2cap_sock_teardown_cb,
-	.state_change	= l2cap_sock_state_change_cb,
-	.ready		= l2cap_sock_ready_cb,
-	.defer		= l2cap_sock_defer_cb,
-	.resume		= l2cap_sock_resume_cb,
-	.suspend	= l2cap_sock_suspend_cb,
-	.set_shutdown	= l2cap_sock_set_shutdown_cb,
-	.get_sndtimeo	= l2cap_sock_get_sndtimeo_cb,
-	.alloc_skb	= l2cap_sock_alloc_skb_cb,
+	.name			= "L2CAP Socket Interface",
+	.new_connection		= l2cap_sock_new_connection_cb,
+	.recv			= l2cap_sock_recv_cb,
+	.close			= l2cap_sock_close_cb,
+	.teardown		= l2cap_sock_teardown_cb,
+	.state_change		= l2cap_sock_state_change_cb,
+	.ready			= l2cap_sock_ready_cb,
+	.defer			= l2cap_sock_defer_cb,
+	.resume			= l2cap_sock_resume_cb,
+	.suspend		= l2cap_sock_suspend_cb,
+	.set_shutdown		= l2cap_sock_set_shutdown_cb,
+	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
+	.alloc_skb		= l2cap_sock_alloc_skb_cb,
+	.memcpy_fromiovec	= l2cap_sock_memcpy_fromiovec_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.9.3

