Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v3] Bluetooth: Add MSG_MORE support to L2CAP sockets
Date: Fri, 18 May 2012 20:46:18 -0300
Message-Id: <1337384778-25135-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MSG_MORE enables us to save buffer space in userspace, the packet is
built directly in the kernel and sent only when a msg with the MSG_MORE
flag not set arrives. If a send() tries to add more chan->omtu bytes
-EMSGSIZE is returned.

Only MSG_MORE for Basic Mode is supported right now. chan->skb_more keeps
a pointer to the L2CAP packet that is being build through many calls to
send().

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
v3: address Mat's comments from v2. 

 include/net/bluetooth/l2cap.h |    2 +
 net/bluetooth/l2cap_core.c    |  127 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 120 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7bc4019..d6dfbf2 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -512,6 +512,8 @@ struct l2cap_chan {
 	struct list_head	list;
 	struct list_head	global_l;
 
+	struct sk_buff		*skb_more;
+
 	void			*data;
 	struct l2cap_ops	*ops;
 	struct mutex		lock;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ae69da8..bae0d17 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -549,6 +549,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
 
+	kfree_skb(chan->skb_more);
+	chan->skb_more = NULL;
+
 	switch(chan->mode) {
 	case L2CAP_MODE_BASIC:
 		break;
@@ -1970,6 +1973,7 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 	struct sk_buff **frag;
 	int sent = 0;
 
+	count = min_t(unsigned int, count, len);
 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
 		return -EFAULT;
 
@@ -1981,7 +1985,11 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 	while (len) {
 		struct sk_buff *tmp;
 
-		count = min_t(unsigned int, conn->mtu, len);
+		if (msg->msg_flags & MSG_MORE)
+			count = min_t(unsigned int, conn->mtu,
+				      chan->omtu - skb->len + L2CAP_HDR_SIZE);
+		else
+			count = min_t(unsigned int, conn->mtu, len);
 
 		tmp = chan->ops->alloc_skb(chan, count,
 					   msg->msg_flags & MSG_DONTWAIT);
@@ -1990,6 +1998,7 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 
 		*frag = tmp;
 
+		count = min_t(unsigned int, count, len);
 		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
 			return -EFAULT;
 
@@ -2050,9 +2059,13 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	int err, count;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("chan %p len %d", chan, (int)len);
+	BT_DBG("chan %p len %d aclmtu %d" , chan, (int)len, conn->mtu);
 
-	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
+	if (msg->msg_flags & MSG_MORE)
+		count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE),
+			      chan->omtu);
+	else
+		count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
 
 	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
 				   msg->msg_flags & MSG_DONTWAIT);
@@ -2197,11 +2210,84 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	return err;
 }
 
+static int l2cap_append_pdu(struct l2cap_chan *chan, struct msghdr *msg,
+			    size_t len)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct sk_buff **frag, *skb = chan->skb_more, *skb1;
+	int sent = 0;
+	unsigned int count;
+	struct l2cap_hdr *lh;
+
+	BT_DBG("chan %p len %ld", chan, len);
+
+	frag = &skb_shinfo(skb)->frag_list;
+	while (*frag && (*frag)->next)
+		frag = &(*frag)->next;
+
+	if (*frag) {
+		skb1 = *frag;
+		frag = &(*frag)->next;
+	} else {
+		skb1 = skb;
+	}
+
+	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE),
+		      chan->omtu);
+	count = count - skb1->len + L2CAP_HDR_SIZE;
+	count = min_t(unsigned int, count, len);
+
+	if (memcpy_fromiovec(skb_put(skb1, count), msg->msg_iov, count))
+		return -EFAULT;
+
+	if (skb != skb1) {
+		skb->len += count;
+		skb->data_len += count;
+	}
+
+	sent += count;
+	len  -= count;
+
+	while (len) {
+		struct sk_buff *tmp;
+
+		count = chan->omtu - skb->len + L2CAP_HDR_SIZE;
+		count = min_t(unsigned int, conn->mtu, count);
+
+		tmp = chan->ops->alloc_skb(chan, count,
+					   msg->msg_flags & MSG_DONTWAIT);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+
+		*frag = tmp;
+
+		count = min_t(unsigned int, count, len);
+		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov,
+				     count))
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
+	lh = (struct l2cap_hdr *) skb->data;
+	lh->len = cpu_to_le16(skb->len - L2CAP_HDR_SIZE);
+
+	return sent;
+}
+
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 								u32 priority)
 {
 	struct sk_buff *skb;
-	int err;
+	int err, rem;
 	struct sk_buff_head seg_queue;
 
 	/* Connectionless channel */
@@ -2216,16 +2302,39 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
+		skb = chan->skb_more;
+
 		/* Check outgoing MTU */
-		if (len > chan->omtu)
+		if (skb)
+			rem = chan->omtu - skb->len + L2CAP_HDR_SIZE;
+		else
+			rem = chan->omtu;
+
+		if (len > rem)
 			return -EMSGSIZE;
 
-		/* Create a basic PDU */
-		skb = l2cap_create_basic_pdu(chan, msg, len, priority);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
+		if (chan->skb_more) {
+			err = l2cap_append_pdu(chan, msg, len);
+			if (err < 0) {
+				kfree_skb(chan->skb_more);
+				chan->skb_more = NULL;
+				return err;
+			}
+		} else {
+			skb = l2cap_create_basic_pdu(chan, msg, len, priority);
+			if (IS_ERR(skb))
+				return PTR_ERR(skb);
+		}
+
+		if (msg->msg_flags & MSG_MORE) {
+			chan->skb_more = skb;
+			return len;
+		}
 
 		l2cap_do_send(chan, skb);
+
+		chan->skb_more = NULL;
+
 		err = len;
 		break;
 
-- 
1.7.10.1

