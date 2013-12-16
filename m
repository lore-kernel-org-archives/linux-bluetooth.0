Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Dec 2013 23:28:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] Bluetooth: fix ->alloc_skb() error checking
Message-ID: <20131216202857.GB19601@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

There are two functions that implement ->alloc_skb().

a2mp_cahan_alloc_skb_cb() returns NULL.
l2cap_sock_alloc_skb_cb() returns an ERR_PTR.

The callers all check for ERR_PTRs and don't check for NULL.  On the
other hand bt_skb_alloc() and the core net alloc_skb() return NULL so
returning an error pointer is inconsistent.  This confusion between some
alloc_skb() functions returning ERR_PTR and some returning NULL has been
a source of bugs such as 787949039fcd ('Bluetooth: fix return value
check').  This patch makes ->alloc_skb() return NULL and changes the
callers to match.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b0ad2c752d73..84c3ce04cb35 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2341,8 +2341,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 
 		tmp = chan->ops->alloc_skb(chan, count,
 					   msg->msg_flags & MSG_DONTWAIT);
-		if (IS_ERR(tmp))
-			return PTR_ERR(tmp);
+		if (!tmp)
+			return -ENOMEM;
 
 		*frag = tmp;
 
@@ -2379,8 +2379,8 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
 				   msg->msg_flags & MSG_DONTWAIT);
-	if (IS_ERR(skb))
-		return skb;
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
 
 	skb->priority = priority;
 
@@ -2413,8 +2413,8 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 
 	skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
 				   msg->msg_flags & MSG_DONTWAIT);
-	if (IS_ERR(skb))
-		return skb;
+	if (skb)
+		return ERR_PTR(-ENOMEM);
 
 	skb->priority = priority;
 
@@ -2457,8 +2457,8 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
 				   msg->msg_flags & MSG_DONTWAIT);
-	if (IS_ERR(skb))
-		return skb;
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
 
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
@@ -2578,8 +2578,8 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
 
 	skb = chan->ops->alloc_skb(chan, count + hlen,
 				   msg->msg_flags & MSG_DONTWAIT);
-	if (IS_ERR(skb))
-		return skb;
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
 
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
