Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove err parameter from alloc_skb()
Date: Fri,  6 Apr 2012 20:15:47 -0300
Message-Id: <1333754148-18796-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use ERR_PTR maginc instead.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   30 +++++++++++++-----------------
 net/bluetooth/l2cap_sock.c    |   12 ++++++++----
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 09cbd33..b74b3f9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -522,7 +522,7 @@ struct l2cap_ops {
 	void			(*close) (void *data);
 	void			(*state_change) (void *data, int state);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
-					unsigned long len, int nb, int *err);
+					unsigned long len, int nb);
 
 };
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a080b00..ab8d522 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1563,7 +1563,7 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff **frag;
-	int err, sent = 0;
+	int sent = 0;
 
 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
 		return -EFAULT;
@@ -1577,11 +1577,10 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 		count = min_t(unsigned int, conn->mtu, len);
 
 		*frag = chan->ops->alloc_skb(chan, count,
-					     msg->msg_flags & MSG_DONTWAIT,
-					     &err);
+					     msg->msg_flags & MSG_DONTWAIT);
 
-		if (!*frag)
-			return err;
+		if (IS_ERR(*frag))
+			return PTR_ERR(*frag);
 		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
 			return -EFAULT;
 
@@ -1610,10 +1609,9 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
-				   msg->msg_flags & MSG_DONTWAIT, &err);
-
-	if (!skb)
-		return ERR_PTR(err);
+				   msg->msg_flags & MSG_DONTWAIT);
+	if (IS_ERR(skb))
+		return skb;
 
 	skb->priority = priority;
 
@@ -1645,10 +1643,9 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
-				   msg->msg_flags & MSG_DONTWAIT, &err);
-
-	if (!skb)
-		return ERR_PTR(err);
+				   msg->msg_flags & MSG_DONTWAIT);
+	if (IS_ERR(skb))
+		return skb;
 
 	skb->priority = priority;
 
@@ -1693,10 +1690,9 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
-					msg->msg_flags & MSG_DONTWAIT, &err);
-
-	if (!skb)
-		return ERR_PTR(err);
+				   msg->msg_flags & MSG_DONTWAIT);
+	if (IS_ERR(skb))
+		return skb;
 
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ae1d78e..1463b5d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -927,12 +927,16 @@ static void l2cap_sock_state_change_cb(void *data, int state)
 }
 
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
-					       unsigned long len, int nb,
-					       int *err)
+					       unsigned long len, int nb)
 {
-	struct sock *sk = chan->sk;
+	struct sk_buff *skb;
+	int err;
+
+	skb = bt_skb_send_alloc(chan->sk, len, nb, &err);
+	if (!skb)
+		return (ERR_PTR(err));
 
-	return bt_skb_send_alloc(sk, len, nb, err);
+	return skb;
 }
 
 static struct l2cap_ops l2cap_chan_ops = {
-- 
1.7.7.6

