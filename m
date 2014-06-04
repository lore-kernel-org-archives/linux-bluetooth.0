Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
Date: Wed,  4 Jun 2014 11:24:53 +0300
Message-Id: <1401870293-23089-1-git-send-email-jukka.rissanen@linux.intel.com>
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

this is a proposal related to 6LoWPAN patches I sent earlier.
In this patch we do not copy the memory buffer for L2CAP sock
users thus avoiding one extra memory copy.


Cheers,
Jukka


 include/net/bluetooth/l2cap.h |  11 +++-
 net/bluetooth/a2mp.c          |  12 +----
 net/bluetooth/l2cap_core.c    | 115 +++++++++++++++++++++++++++++-------------
 net/bluetooth/l2cap_sock.c    |  49 +++++++++++++++++-
 4 files changed, 137 insertions(+), 50 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4abdcb2..c6f7358 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -872,8 +872,15 @@ struct l2cap_chan *l2cap_chan_create(void);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type);
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
-								u32 priority);
+int l2cap_chan_send(struct l2cap_chan *chan, const void *buf, size_t len,
+		    u32 priority, unsigned int flags);
+typedef int (*skb_copy_cb)(struct l2cap_chan *chan, const struct msghdr *msg,
+			   int len, unsigned int flags, int count,
+			   struct sk_buff *skb);
+int l2cap_chan_send_fromiovec(struct l2cap_chan *chan,
+			      const struct msghdr *msg, size_t len,
+			      u32 priority, skb_copy_cb fromiovec);
+
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
index 7468482..c10c2ee4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2104,19 +2104,24 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 	}
 }
 
-static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
-					 struct msghdr *msg, int len,
-					 int count, struct sk_buff *skb)
+static inline int l2cap_copy_into_skbuff(struct l2cap_chan *chan,
+					 const void *buf, int len,
+					 unsigned int flags, int count,
+					 struct sk_buff *skb,
+					 skb_copy_cb fromiovec)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff **frag;
 	int sent = 0;
 
-	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
-		return -EFAULT;
+	if (fromiovec)
+		return fromiovec(chan, buf, len, flags, count, skb);
+
+	memcpy(skb_put(skb, count), buf, count);
 
 	sent += count;
 	len  -= count;
+	buf  += count;
 
 	/* Continuation fragments (no L2CAP header) */
 	frag = &skb_shinfo(skb)->frag_list;
@@ -2126,19 +2131,19 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 		count = min_t(unsigned int, conn->mtu, len);
 
 		tmp = chan->ops->alloc_skb(chan, count,
-					   msg->msg_flags & MSG_DONTWAIT);
+					   flags & MSG_DONTWAIT);
 		if (IS_ERR(tmp))
 			return PTR_ERR(tmp);
 
 		*frag = tmp;
 
-		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
-			return -EFAULT;
+		memcpy(skb_put(*frag, count), buf, count);
 
 		(*frag)->priority = skb->priority;
 
 		sent += count;
 		len  -= count;
+		buf  += count;
 
 		skb->len += (*frag)->len;
 		skb->data_len += (*frag)->len;
@@ -2150,8 +2155,10 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
-						 struct msghdr *msg, size_t len,
-						 u32 priority)
+						 const void *buf, size_t len,
+						 u32 priority,
+						 unsigned int flags,
+						 skb_copy_cb fromiovec)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
@@ -2164,7 +2171,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
-				   msg->msg_flags & MSG_DONTWAIT);
+				   flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
 
@@ -2176,7 +2183,8 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	lh->len = cpu_to_le16(len + L2CAP_PSMLEN_SIZE);
 	put_unaligned(chan->psm, (__le16 *) skb_put(skb, L2CAP_PSMLEN_SIZE));
 
-	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
+	err = l2cap_copy_into_skbuff(chan, buf, len, flags, count, skb,
+				     fromiovec);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -2185,8 +2193,9 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
-					      struct msghdr *msg, size_t len,
-					      u32 priority)
+					      const void *buf, size_t len,
+					      u32 priority, unsigned int flags,
+					      skb_copy_cb fromiovec)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
@@ -2198,7 +2207,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
 
 	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
-				   msg->msg_flags & MSG_DONTWAIT);
+				   flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
 
@@ -2209,7 +2218,8 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len);
 
-	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
+	err = l2cap_copy_into_skbuff(chan, buf, len, flags, count, skb,
+				     fromiovec);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -2218,8 +2228,9 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
-					       struct msghdr *msg, size_t len,
-					       u16 sdulen)
+					       const void *buf, size_t len,
+					       u16 sdulen, unsigned int flags,
+					       skb_copy_cb fromiovec)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
@@ -2242,7 +2253,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
-				   msg->msg_flags & MSG_DONTWAIT);
+				   flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
 
@@ -2260,7 +2271,8 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	if (sdulen)
 		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
 
-	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
+	err = l2cap_copy_into_skbuff(chan, buf, len, flags, count, skb,
+				     fromiovec);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -2273,14 +2285,16 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 
 static int l2cap_segment_sdu(struct l2cap_chan *chan,
 			     struct sk_buff_head *seg_queue,
-			     struct msghdr *msg, size_t len)
+			     const void *buf, size_t len,
+			     unsigned int flags,
+			     skb_copy_cb fromiovec)
 {
 	struct sk_buff *skb;
 	u16 sdu_len;
 	size_t pdu_len;
 	u8 sar;
 
-	BT_DBG("chan %p, msg %p, len %zu", chan, msg, len);
+	BT_DBG("chan %p, buf %p, len %zu", chan, buf, len);
 
 	/* It is critical that ERTM PDUs fit in a single HCI fragment,
 	 * so fragmented skbs are not used.  The HCI layer's handling
@@ -2314,7 +2328,8 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	}
 
 	while (len > 0) {
-		skb = l2cap_create_iframe_pdu(chan, msg, pdu_len, sdu_len);
+		skb = l2cap_create_iframe_pdu(chan, buf, pdu_len, sdu_len,
+					      flags, fromiovec);
 
 		if (IS_ERR(skb)) {
 			__skb_queue_purge(seg_queue);
@@ -2342,8 +2357,10 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
-						   struct msghdr *msg,
-						   size_t len, u16 sdulen)
+						   const void *buf, size_t len,
+						   u16 sdulen,
+						   unsigned int flags,
+						   skb_copy_cb fromiovec)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
@@ -2363,7 +2380,7 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
-				   msg->msg_flags & MSG_DONTWAIT);
+				   flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
 
@@ -2375,7 +2392,8 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
 	if (sdulen)
 		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
 
-	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
+	err = l2cap_copy_into_skbuff(chan, buf, len, flags, count, skb,
+				     fromiovec);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -2386,13 +2404,15 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
 
 static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 				struct sk_buff_head *seg_queue,
-				struct msghdr *msg, size_t len)
+				const void *buf, size_t len,
+				unsigned int flags,
+				skb_copy_cb fromiovec)
 {
 	struct sk_buff *skb;
 	size_t pdu_len;
 	u16 sdu_len;
 
-	BT_DBG("chan %p, msg %p, len %zu", chan, msg, len);
+	BT_DBG("chan %p, buf %p, len %zu", chan, buf, len);
 
 	pdu_len = chan->conn->mtu - L2CAP_HDR_SIZE;
 
@@ -2405,7 +2425,8 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 		if (len <= pdu_len)
 			pdu_len = len;
 
-		skb = l2cap_create_le_flowctl_pdu(chan, msg, pdu_len, sdu_len);
+		skb = l2cap_create_le_flowctl_pdu(chan, buf, pdu_len, sdu_len,
+						  flags, fromiovec);
 		if (IS_ERR(skb)) {
 			__skb_queue_purge(seg_queue);
 			return PTR_ERR(skb);
@@ -2414,6 +2435,7 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 		__skb_queue_tail(seg_queue, skb);
 
 		len -= pdu_len;
+		buf += pdu_len;
 
 		if (sdu_len) {
 			sdu_len = 0;
@@ -2424,8 +2446,10 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 	return 0;
 }
 
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
-		    u32 priority)
+static int l2cap_chan_send_internal(struct l2cap_chan *chan, const void *buf,
+				    size_t len, u32 priority,
+				    unsigned int flags,
+				    skb_copy_cb fromiovec)
 {
 	struct sk_buff *skb;
 	int err;
@@ -2436,7 +2460,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 
 	/* Connectionless channel */
 	if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
-		skb = l2cap_create_connless_pdu(chan, msg, len, priority);
+		skb = l2cap_create_connless_pdu(chan, buf, len, priority,
+						flags, fromiovec);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
@@ -2463,7 +2488,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 
 		__skb_queue_head_init(&seg_queue);
 
-		err = l2cap_segment_le_sdu(chan, &seg_queue, msg, len);
+		err = l2cap_segment_le_sdu(chan, &seg_queue, buf, len, flags,
+					   fromiovec);
 
 		if (chan->state != BT_CONNECTED) {
 			__skb_queue_purge(&seg_queue);
@@ -2493,7 +2519,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 			return -EMSGSIZE;
 
 		/* Create a basic PDU */
-		skb = l2cap_create_basic_pdu(chan, msg, len, priority);
+		skb = l2cap_create_basic_pdu(chan, buf, len, priority, flags,
+					     fromiovec);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
@@ -2523,7 +2550,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		 * since it's possible to block while waiting for memory
 		 * allocation.
 		 */
-		err = l2cap_segment_sdu(chan, &seg_queue, msg, len);
+		err = l2cap_segment_sdu(chan, &seg_queue, buf, len, flags,
+					fromiovec);
 
 		/* The channel could have been closed while segmenting,
 		 * check that it is still connected.
@@ -2557,6 +2585,21 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 	return err;
 }
 
+int l2cap_chan_send_fromiovec(struct l2cap_chan *chan,
+			      const struct msghdr *msg, size_t len,
+			      u32 priority, skb_copy_cb fromiovec)
+{
+	return l2cap_chan_send_internal(chan, msg, len, priority,
+					msg->msg_flags, fromiovec);
+}
+
+int l2cap_chan_send(struct l2cap_chan *chan, const void *buf, size_t len,
+		    u32 priority, unsigned int flags)
+{
+	return l2cap_chan_send_internal(chan, buf, len, priority, flags, NULL);
+}
+EXPORT_SYMBOL_GPL(l2cap_chan_send);
+
 static void l2cap_send_srej(struct l2cap_chan *chan, u16 txseq)
 {
 	struct l2cap_ctrl control;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f59e00c..4c47497 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -943,6 +943,52 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	return err;
 }
 
+static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
+					 const struct msghdr *msg, int len,
+					 unsigned int flags,
+					 int count, struct sk_buff *skb)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct sk_buff **frag;
+	int sent = 0;
+
+	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
+		return -EFAULT;
+
+	sent += count;
+	len  -= count;
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
+		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
+			return -EFAULT;
+
+		(*frag)->priority = skb->priority;
+
+		sent += count;
+		len  -= count;
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
 static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			      struct msghdr *msg, size_t len)
 {
@@ -969,7 +1015,8 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		return err;
 
 	l2cap_chan_lock(chan);
-	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
+	err = l2cap_chan_send_fromiovec(chan, msg, len, sk->sk_priority,
+					l2cap_skbuff_fromiovec);
 	l2cap_chan_unlock(chan);
 
 	return err;
-- 
1.8.3.1

