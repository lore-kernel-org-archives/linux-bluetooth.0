Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use explicit header and body length for L2CAP SKB allocation
Date: Sun,  8 Jun 2014 11:22:28 +0200
Message-Id: <1402219348-17134-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When allocating the L2CAP SKB for transmission, provide the upper layers
with a clear distinction on what is the header and what is the body
portion of the SKB.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/a2mp.c          |  3 ++-
 net/bluetooth/l2cap_core.c    | 10 +++++-----
 net/bluetooth/l2cap_sock.c    |  3 ++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 18f4f27e0f74..92511034d1d4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -600,6 +600,7 @@ struct l2cap_ops {
 	void			(*set_shutdown) (struct l2cap_chan *chan);
 	long			(*get_sndtimeo) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
+					       unsigned long hdr_len,
 					       unsigned long len, int nb);
 };
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 1a5b1eb96d1a..0fd8d1dda709 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -693,11 +693,12 @@ static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state,
 }
 
 static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
+					      unsigned long hdr_len,
 					      unsigned long len, int nb)
 {
 	struct sk_buff *skb;
 
-	skb = bt_skb_alloc(len, GFP_KERNEL);
+	skb = bt_skb_alloc(hdr_len + len, GFP_KERNEL);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7a9252783861..dd1b9cdaa9f5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2125,7 +2125,7 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 
 		count = min_t(unsigned int, conn->mtu, len);
 
-		tmp = chan->ops->alloc_skb(chan, count,
+		tmp = chan->ops->alloc_skb(chan, 0, count,
 					   msg->msg_flags & MSG_DONTWAIT);
 		if (IS_ERR(tmp))
 			return PTR_ERR(tmp);
@@ -2160,7 +2160,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
-	skb = chan->ops->alloc_skb(chan, count + hlen,
+	skb = chan->ops->alloc_skb(chan, hlen, count,
 				   msg->msg_flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
@@ -2191,7 +2191,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 
 	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
 
-	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
+	skb = chan->ops->alloc_skb(chan, L2CAP_HDR_SIZE, count,
 				   msg->msg_flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
@@ -2233,7 +2233,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
-	skb = chan->ops->alloc_skb(chan, count + hlen,
+	skb = chan->ops->alloc_skb(chan, hlen, count,
 				   msg->msg_flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
@@ -2354,7 +2354,7 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
-	skb = chan->ops->alloc_skb(chan, count + hlen,
+	skb = chan->ops->alloc_skb(chan, hlen, count,
 				   msg->msg_flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a083a24d80ae..f722e764eafa 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1297,6 +1297,7 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 }
 
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
+					       unsigned long hdr_len,
 					       unsigned long len, int nb)
 {
 	struct sock *sk = chan->data;
@@ -1304,7 +1305,7 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 	int err;
 
 	l2cap_chan_unlock(chan);
-	skb = bt_skb_send_alloc(sk, len, nb, &err);
+	skb = bt_skb_send_alloc(sk, hdr_len + len, nb, &err);
 	l2cap_chan_lock(chan);
 
 	if (!skb)
-- 
1.9.3

