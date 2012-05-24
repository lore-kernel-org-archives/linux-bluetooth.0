Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 12/12] Bluetooth: Used void * as parameter in alloc_skb()
Date: Thu, 24 May 2012 20:05:42 -0300
Message-Id: <1337900742-31036-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337900742-31036-1-git-send-email-gustavo@padovan.org>
References: <1337900389-30915-9-git-send-email-gustavo@padovan.org>
 <1337900742-31036-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This keep l2cap chan ops functions parameters in sync.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |    4 ++--
 net/bluetooth/l2cap_core.c    |    8 ++++----
 net/bluetooth/l2cap_sock.c    |    8 +++++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b03861f..8a1c741 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -528,8 +528,8 @@ struct l2cap_ops {
 	void			(*close) (void *data);
 	void			(*teardown) (void *data, int err);
 	void			(*state_change) (void *data, int state);
-	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
-					       unsigned long len, int nb);
+	struct sk_buff		*(*alloc_skb) (void *data, unsigned long len,
+					       int nb);
 	void			(*ready) (void *data);
 	void			(*defer) (void *data);
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c38447b..71ca1ef 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1893,7 +1893,7 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 
 		count = min_t(unsigned int, conn->mtu, len);
 
-		tmp = chan->ops->alloc_skb(chan, count,
+		tmp = chan->ops->alloc_skb(chan->data, count,
 					   msg->msg_flags & MSG_DONTWAIT);
 		if (IS_ERR(tmp))
 			return PTR_ERR(tmp);
@@ -1930,7 +1930,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
-	skb = chan->ops->alloc_skb(chan, count + hlen,
+	skb = chan->ops->alloc_skb(chan->data, count + hlen,
 				   msg->msg_flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
@@ -1964,7 +1964,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 
 	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
 
-	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
+	skb = chan->ops->alloc_skb(chan->data, count + L2CAP_HDR_SIZE,
 				   msg->msg_flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
@@ -2011,7 +2011,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
-	skb = chan->ops->alloc_skb(chan, count + hlen,
+	skb = chan->ops->alloc_skb(chan->data, count + hlen,
 				   msg->msg_flags & MSG_DONTWAIT);
 	if (IS_ERR(skb))
 		return skb;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 22f1874..fa98be7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1019,14 +1019,16 @@ static void l2cap_sock_state_change_cb(void *data, int state)
 	sk->sk_state = state;
 }
 
-static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
-					       unsigned long len, int nb)
+static struct sk_buff *l2cap_sock_alloc_skb_cb(void *data, unsigned long len,
+					       int nb)
 {
+	struct sock *sk = data;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct sk_buff *skb;
 	int err;
 
 	l2cap_chan_unlock(chan);
-	skb = bt_skb_send_alloc(chan->sk, len, nb, &err);
+	skb = bt_skb_send_alloc(sk, len, nb, &err);
 	l2cap_chan_lock(chan);
 
 	if (!skb)
-- 
1.7.10.1

