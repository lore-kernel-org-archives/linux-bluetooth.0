Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Assign L2CAP socket priority when allocating SKB
Date: Thu,  5 Jun 2014 15:22:51 +0200
Message-Id: <1401974571-19264-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SKB for L2CAP sockets are all allocated in a central callback
in the socket support. Instead of having to pass around the socket
priority all the time, assign it to skb->priority when actually
allocating the SKB.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |  3 +--
 net/bluetooth/a2mp.c          |  2 +-
 net/bluetooth/l2cap_core.c    | 23 +++++++----------------
 net/bluetooth/l2cap_sock.c    |  4 +++-
 4 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4abdcb220e3a..ca1294260de1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -872,8 +872,7 @@ struct l2cap_chan *l2cap_chan_create(void);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type);
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
-								u32 priority);
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 9514cc9e850c..0b7ec20981f8 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -63,7 +63,7 @@ void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 	msg.msg_iov = (struct iovec *) &iv;
 	msg.msg_iovlen = 1;
 
-	l2cap_chan_send(chan, &msg, total_len, 0);
+	l2cap_chan_send(chan, &msg, total_len);
 
 	kfree(cmd);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 746848229c85..7a9252783861 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2135,8 +2135,6 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
 			return -EFAULT;
 
-		(*frag)->priority = skb->priority;
-
 		sent += count;
 		len  -= count;
 
@@ -2150,16 +2148,15 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
-						 struct msghdr *msg, size_t len,
-						 u32 priority)
+						 struct msghdr *msg, size_t len)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("chan %p psm 0x%2.2x len %zu priority %u", chan,
-	       __le16_to_cpu(chan->psm), len, priority);
+	BT_DBG("chan %p psm 0x%2.2x len %zu", chan,
+	       __le16_to_cpu(chan->psm), len);
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
@@ -2168,8 +2165,6 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	if (IS_ERR(skb))
 		return skb;
 
-	skb->priority = priority;
-
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
@@ -2185,8 +2180,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
-					      struct msghdr *msg, size_t len,
-					      u32 priority)
+					      struct msghdr *msg, size_t len)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
@@ -2202,8 +2196,6 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	if (IS_ERR(skb))
 		return skb;
 
-	skb->priority = priority;
-
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
@@ -2424,8 +2416,7 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 	return 0;
 }
 
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
-		    u32 priority)
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sk_buff *skb;
 	int err;
@@ -2436,7 +2427,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 
 	/* Connectionless channel */
 	if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
-		skb = l2cap_create_connless_pdu(chan, msg, len, priority);
+		skb = l2cap_create_connless_pdu(chan, msg, len);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
@@ -2493,7 +2484,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 			return -EMSGSIZE;
 
 		/* Create a basic PDU */
-		skb = l2cap_create_basic_pdu(chan, msg, len, priority);
+		skb = l2cap_create_basic_pdu(chan, msg, len);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 34d62348084d..f12c855a5a76 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -969,7 +969,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		return err;
 
 	l2cap_chan_lock(chan);
-	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
+	err = l2cap_chan_send(chan, msg, len);
 	l2cap_chan_unlock(chan);
 
 	return err;
@@ -1310,6 +1310,8 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 	if (!skb)
 		return ERR_PTR(err);
 
+	skb->priority = sk->sk_priority;
+
 	bt_cb(skb)->chan = chan;
 
 	return skb;
-- 
1.9.3

