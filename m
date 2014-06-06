Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2] Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
Date: Fri,  6 Jun 2014 16:15:42 +0300
Message-Id: <1402060542-9394-1-git-send-email-jukka.rissanen@linux.intel.com>
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
Hi,

this is take 2 of the refactoring l2cap_sock_sendmsg(). Instead of
passing func pointer like in v1, I added callbacks to l2cap_ops struct
that handle the skb delivery. 

The code is not really tested or ready yet but compiles ok.
Any opinions of this solution?


Cheers,
Jukka



 include/net/bluetooth/l2cap.h |  27 ++++++-
 net/bluetooth/a2mp.c          |  12 +---
 net/bluetooth/l2cap_core.c    | 160 ++++++++++++++++++++++++++++++++++--------
 net/bluetooth/l2cap_sock.c    |   3 +-
 4 files changed, 157 insertions(+), 45 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4abdcb2..d61f8c8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -601,6 +601,17 @@ struct l2cap_ops {
 	long			(*get_sndtimeo) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
+	int			(*user_delivery) (struct l2cap_chan *chan,
+						  const struct msghdr *msg,
+						  int len, unsigned int flags,
+						  int count,
+						  struct sk_buff *skb);
+	int			(*kernel_delivery) (struct l2cap_chan *chan,
+						    const void *buf,
+						    int len,
+						    unsigned int flags,
+						    int count,
+						    struct sk_buff *skb);
 };
 
 struct l2cap_conn {
@@ -872,8 +883,20 @@ struct l2cap_chan *l2cap_chan_create(void);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type);
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
-								u32 priority);
+
+int l2cap_chan_send(struct l2cap_chan *chan, const void *buf,
+		    size_t len, u32 priority, unsigned int flags);
+int l2cap_chan_send_fromiovec(struct l2cap_chan *chan,
+			      const struct msghdr *msg, size_t len,
+			      u32 priority);
+int l2cap_default_user_deliver_cb(struct l2cap_chan *chan,
+				  const struct msghdr *msg, int len,
+				  unsigned int flags, int count,
+				  struct sk_buff *skb);
+int l2cap_default_kernel_deliver_cb(struct l2cap_chan *chan,
+				    const void *buf, int len,
+				    unsigned int flags, int count,
+				    struct sk_buff *skb);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 9514cc9..6b99b1b 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -48,22 +48,12 @@ void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 	struct l2cap_chan *chan = mgr->a2mp_chan;
 	struct a2mp_cmd *cmd;
 	u16 total_len = len + sizeof(*cmd);
-	struct kvec iv;
-	struct msghdr msg;
 
 	cmd = __a2mp_build(code, ident, len, data);
 	if (!cmd)
 		return;
 
-	iv.iov_base = cmd;
-	iv.iov_len = total_len;
-
-	memset(&msg, 0, sizeof(msg));
-
-	msg.msg_iov = (struct iovec *) &iv;
-	msg.msg_iovlen = 1;
-
-	l2cap_chan_send(chan, &msg, total_len, 0);
+	l2cap_chan_send(chan, cmd, total_len, 0, 0);
 
 	kfree(cmd);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7468482..8e95858 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2105,7 +2105,8 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 }
 
 static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
-					 struct msghdr *msg, int len,
+					 const struct msghdr *msg, int len,
+					 unsigned int flags,
 					 int count, struct sk_buff *skb)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -2126,13 +2127,14 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 		count = min_t(unsigned int, conn->mtu, len);
 
 		tmp = chan->ops->alloc_skb(chan, count,
-					   msg->msg_flags & MSG_DONTWAIT);
+					   flags & MSG_DONTWAIT);
 		if (IS_ERR(tmp))
 			return PTR_ERR(tmp);
 
 		*frag = tmp;
 
-		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
+		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov,
+				     count))
 			return -EFAULT;
 
 		(*frag)->priority = skb->priority;
@@ -2149,9 +2151,90 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 	return sent;
 }
 
+int l2cap_default_user_deliver_cb(struct l2cap_chan *chan,
+				  const struct msghdr *msg, int len,
+				  unsigned int flags, int count,
+				  struct sk_buff *skb)
+{
+	return l2cap_skbuff_fromiovec(chan, msg, len, flags, count, skb);
+}
+EXPORT_SYMBOL_GPL(l2cap_default_user_deliver_cb);
+
+static inline int l2cap_copy_into_skbuff(struct l2cap_chan *chan,
+					 const void *buf, int len,
+					 unsigned int flags, int count,
+					 struct sk_buff *skb)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct sk_buff **frag;
+	int sent = 0;
+
+	memcpy(skb_put(skb, count), buf, count);
+
+	sent += count;
+	len  -= count;
+	buf  += count;
+
+	/* Continuation fragments (no L2CAP header) */
+	frag = &skb_shinfo(skb)->frag_list;
+	while (len) {
+		struct sk_buff *tmp;
+
+		count = min_t(unsigned int, conn->mtu, len);
+
+		tmp = chan->ops->alloc_skb(chan, count,
+					   flags & MSG_DONTWAIT);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+
+		*frag = tmp;
+
+		memcpy(skb_put(*frag, count), buf, count);
+
+		(*frag)->priority = skb->priority;
+
+		sent += count;
+		len  -= count;
+		buf  += count;
+
+		skb->len += (*frag)->len;
+		skb->data_len += (*frag)->len;
+
+		frag = &(*frag)->next;
+	}
+
+	return sent;
+}
+
+int l2cap_default_kernel_deliver_cb(struct l2cap_chan *chan,
+				    const void *buf, int len,
+				    unsigned int flags, int count,
+				    struct sk_buff *skb)
+{
+	return l2cap_copy_into_skbuff(chan, buf, len, flags, count, skb);
+}
+EXPORT_SYMBOL_GPL(l2cap_default_kernel_deliver_cb);
+
+int l2cap_deliver_skb(struct l2cap_chan *chan,
+		      const void *buf, int len,
+		      unsigned int flags, int count,
+		      struct sk_buff *skb)
+{
+	if (chan->ops->user_delivery)
+		return chan->ops->user_delivery(chan, buf, len, flags, count,
+						skb);
+
+	if (chan->ops->kernel_delivery)
+		return chan->ops->kernel_delivery(chan, buf, len, flags, count,
+						  skb);
+
+	return -EINVAL;
+}
+
 static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
-						 struct msghdr *msg, size_t len,
-						 u32 priority)
+						 const void *buf, size_t len,
+						 u32 priority,
+						 unsigned int flags)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
@@ -2164,7 +2247,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
-				   msg->msg_flags & MSG_DONTWAIT);
+				   flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
 
@@ -2176,7 +2259,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	lh->len = cpu_to_le16(len + L2CAP_PSMLEN_SIZE);
 	put_unaligned(chan->psm, (__le16 *) skb_put(skb, L2CAP_PSMLEN_SIZE));
 
-	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
+	err = l2cap_deliver_skb(chan, buf, len, flags, count, skb);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -2185,8 +2268,8 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
-					      struct msghdr *msg, size_t len,
-					      u32 priority)
+					      const void *buf, size_t len,
+					      u32 priority, unsigned int flags)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
@@ -2198,7 +2281,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
 
 	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
-				   msg->msg_flags & MSG_DONTWAIT);
+				   flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
 
@@ -2209,7 +2292,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len);
 
-	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
+	err = l2cap_deliver_skb(chan, buf, len, flags, count, skb);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -2218,8 +2301,8 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
-					       struct msghdr *msg, size_t len,
-					       u16 sdulen)
+					       const void *buf, size_t len,
+					       u16 sdulen, unsigned int flags)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
@@ -2242,7 +2325,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
-				   msg->msg_flags & MSG_DONTWAIT);
+				   flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
 
@@ -2260,7 +2343,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	if (sdulen)
 		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
 
-	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
+	err = l2cap_deliver_skb(chan, buf, len, flags, count, skb);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -2273,14 +2356,15 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 
 static int l2cap_segment_sdu(struct l2cap_chan *chan,
 			     struct sk_buff_head *seg_queue,
-			     struct msghdr *msg, size_t len)
+			     const void *buf, size_t len,
+			     unsigned int flags)
 {
 	struct sk_buff *skb;
 	u16 sdu_len;
 	size_t pdu_len;
 	u8 sar;
 
-	BT_DBG("chan %p, msg %p, len %zu", chan, msg, len);
+	BT_DBG("chan %p, buf %p, len %zu", chan, buf, len);
 
 	/* It is critical that ERTM PDUs fit in a single HCI fragment,
 	 * so fragmented skbs are not used.  The HCI layer's handling
@@ -2314,7 +2398,8 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	}
 
 	while (len > 0) {
-		skb = l2cap_create_iframe_pdu(chan, msg, pdu_len, sdu_len);
+		skb = l2cap_create_iframe_pdu(chan, buf, pdu_len, sdu_len,
+					      flags);
 
 		if (IS_ERR(skb)) {
 			__skb_queue_purge(seg_queue);
@@ -2342,8 +2427,9 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
-						   struct msghdr *msg,
-						   size_t len, u16 sdulen)
+						   const void *buf, size_t len,
+						   u16 sdulen,
+						   unsigned int flags)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
@@ -2363,7 +2449,7 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
-				   msg->msg_flags & MSG_DONTWAIT);
+				   flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
 
@@ -2375,7 +2461,7 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
 	if (sdulen)
 		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
 
-	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
+	err = l2cap_deliver_skb(chan, buf, len, flags, count, skb);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -2386,13 +2472,14 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
 
 static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 				struct sk_buff_head *seg_queue,
-				struct msghdr *msg, size_t len)
+				const void *buf, size_t len,
+				unsigned int flags)
 {
 	struct sk_buff *skb;
 	size_t pdu_len;
 	u16 sdu_len;
 
-	BT_DBG("chan %p, msg %p, len %zu", chan, msg, len);
+	BT_DBG("chan %p, buf %p, len %zu", chan, buf, len);
 
 	pdu_len = chan->conn->mtu - L2CAP_HDR_SIZE;
 
@@ -2405,7 +2492,8 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 		if (len <= pdu_len)
 			pdu_len = len;
 
-		skb = l2cap_create_le_flowctl_pdu(chan, msg, pdu_len, sdu_len);
+		skb = l2cap_create_le_flowctl_pdu(chan, buf, pdu_len, sdu_len,
+						  flags);
 		if (IS_ERR(skb)) {
 			__skb_queue_purge(seg_queue);
 			return PTR_ERR(skb);
@@ -2414,6 +2502,7 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 		__skb_queue_tail(seg_queue, skb);
 
 		len -= pdu_len;
+		buf += pdu_len;
 
 		if (sdu_len) {
 			sdu_len = 0;
@@ -2424,8 +2513,8 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 	return 0;
 }
 
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
-		    u32 priority)
+int l2cap_chan_send(struct l2cap_chan *chan, const void *buf, size_t len,
+		    u32 priority, unsigned int flags)
 {
 	struct sk_buff *skb;
 	int err;
@@ -2436,7 +2525,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 
 	/* Connectionless channel */
 	if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
-		skb = l2cap_create_connless_pdu(chan, msg, len, priority);
+		skb = l2cap_create_connless_pdu(chan, buf, len, priority,
+						flags);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
@@ -2463,7 +2553,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 
 		__skb_queue_head_init(&seg_queue);
 
-		err = l2cap_segment_le_sdu(chan, &seg_queue, msg, len);
+		err = l2cap_segment_le_sdu(chan, &seg_queue, buf, len, flags);
 
 		if (chan->state != BT_CONNECTED) {
 			__skb_queue_purge(&seg_queue);
@@ -2493,7 +2583,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 			return -EMSGSIZE;
 
 		/* Create a basic PDU */
-		skb = l2cap_create_basic_pdu(chan, msg, len, priority);
+		skb = l2cap_create_basic_pdu(chan, buf, len, priority, flags);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
@@ -2523,7 +2613,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		 * since it's possible to block while waiting for memory
 		 * allocation.
 		 */
-		err = l2cap_segment_sdu(chan, &seg_queue, msg, len);
+		err = l2cap_segment_sdu(chan, &seg_queue, buf, len, flags);
 
 		/* The channel could have been closed while segmenting,
 		 * check that it is still connected.
@@ -2557,6 +2647,14 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 	return err;
 }
 
+int l2cap_chan_send_fromiovec(struct l2cap_chan *chan,
+			      const struct msghdr *msg, size_t len,
+			      u32 priority)
+{
+	return l2cap_chan_send(chan, msg, len, priority, msg->msg_flags);
+}
+EXPORT_SYMBOL_GPL(l2cap_chan_send_fromiovec);
+
 static void l2cap_send_srej(struct l2cap_chan *chan, u16 txseq)
 {
 	struct l2cap_ctrl control;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f59e00c..315424e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -969,7 +969,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		return err;
 
 	l2cap_chan_lock(chan);
-	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
+	err = l2cap_chan_send_fromiovec(chan, msg, len, sk->sk_priority);
 	l2cap_chan_unlock(chan);
 
 	return err;
@@ -1391,6 +1391,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.set_shutdown	= l2cap_sock_set_shutdown_cb,
 	.get_sndtimeo	= l2cap_sock_get_sndtimeo_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
+	.user_delivery  = l2cap_default_user_deliver_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.8.3.1

