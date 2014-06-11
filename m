Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Provide L2CAP ops callback for memcpy_fromiovec
Date: Wed, 11 Jun 2014 15:35:14 +0200
Message-Id: <1402493714-30849-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h | 35 +++++++++++++++++++++++++++++++++++
 net/bluetooth/a2mp.c          | 18 ++++--------------
 net/bluetooth/l2cap_core.c    |  6 ++++--
 net/bluetooth/l2cap_sock.c    | 34 +++++++++++++++++++++-------------
 4 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 92511034d1d4..e4f4ca69e301 100644
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
@@ -857,6 +860,38 @@ static inline long l2cap_chan_no_get_sndtimeo(struct l2cap_chan *chan)
 	return 0;
 }
 
+static inline struct sk_buff *l2cap_chan_no_alloc_skb(struct l2cap_chan *chan,
+						      unsigned long hdr_len,
+						      unsigned long len, int nb)
+{
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(hdr_len + len, GFP_KERNEL);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	return skb;
+}
+
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
index 0fd8d1dda709..4cda6213cfc3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -692,25 +692,15 @@ static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state,
 	}
 }
 
-static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
-					      unsigned long hdr_len,
-					      unsigned long len, int nb)
-{
-	struct sk_buff *skb;
-
-	skb = bt_skb_alloc(hdr_len + len, GFP_KERNEL);
-	if (!skb)
-		return ERR_PTR(-ENOMEM);
-
-	return skb;
-}
-
 static const struct l2cap_ops a2mp_chan_ops = {
 	.name = "L2CAP A2MP channel",
 	.recv = a2mp_chan_recv_cb,
 	.close = a2mp_chan_close_cb,
 	.state_change = a2mp_chan_state_change_cb,
-	.alloc_skb = a2mp_chan_alloc_skb_cb,
+
+	/* Use default kernel implementation */
+	.alloc_skb = l2cap_chan_no_alloc_skb,
+	.memcpy_fromiovec = l2cap_chan_no_memcpy_fromiovec,
 
 	/* Not implemented for A2MP */
 	.new_connection = l2cap_chan_no_new_connection,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b093e98aa968..eb0d43da80d5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2112,7 +2112,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 	struct sk_buff **frag;
 	int sent = 0;
 
-	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
+	if (chan->ops->memcpy_fromiovec(chan, skb_put(skb, count),
+					msg->msg_iov, count))
 		return -EFAULT;
 
 	sent += count;
@@ -2132,7 +2133,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 
 		*frag = tmp;
 
-		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
+		if (chan->ops->memcpy_fromiovec(chan, skb_put(*frag, count),
+						msg->msg_iov, count))
 			return -EFAULT;
 
 		sent += count;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6ab282212d5c..e64e1bbba14d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1318,6 +1318,13 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
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
@@ -1384,19 +1391,20 @@ static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
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

