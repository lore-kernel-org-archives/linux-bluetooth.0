Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Allocate skb depending on sk
Date: Mon, 16 Jan 2012 14:23:40 +0200
Message-Id: <1326716620-6109-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Some channels might not have sk so we allocate skbuff directly.
The idea is to use l2cap_chan_send for sending packets not through
sockets.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0087db8..cb1091d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1536,7 +1536,12 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan, struct msghdr
 	while (len) {
 		count = min_t(unsigned int, conn->mtu, len);
 
-		*frag = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
+		if (sk)
+			*frag = bt_skb_send_alloc(sk, count,
+					msg->msg_flags & MSG_DONTWAIT, &err);
+		else
+			*frag = bt_skb_alloc(count, GFP_KERNEL);
+
 		if (!*frag)
 			return err;
 		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
@@ -1566,8 +1571,13 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
-	skb = bt_skb_send_alloc(sk, count + hlen,
-			msg->msg_flags & MSG_DONTWAIT, &err);
+
+	if (sk)
+		skb = bt_skb_send_alloc(sk, count + hlen,
+					msg->msg_flags & MSG_DONTWAIT, &err);
+	else
+		skb = bt_skb_alloc(count, GFP_KERNEL);
+
 	if (!skb)
 		return ERR_PTR(err);
 
@@ -1600,8 +1610,13 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	BT_DBG("sk %p len %d", sk, (int)len);
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
-	skb = bt_skb_send_alloc(sk, count + hlen,
-			msg->msg_flags & MSG_DONTWAIT, &err);
+
+	if (sk)
+		skb = bt_skb_send_alloc(sk, count + hlen,
+					msg->msg_flags & MSG_DONTWAIT, &err);
+	else
+		skb = bt_skb_alloc(count, GFP_KERNEL);
+
 	if (!skb)
 		return ERR_PTR(err);
 
@@ -1647,8 +1662,13 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 		hlen += L2CAP_FCS_SIZE;
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
-	skb = bt_skb_send_alloc(sk, count + hlen,
-			msg->msg_flags & MSG_DONTWAIT, &err);
+
+	if (sk)
+		skb = bt_skb_send_alloc(sk, count + hlen,
+					msg->msg_flags & MSG_DONTWAIT, &err);
+	else
+		skb = bt_skb_alloc(count, GFP_KERNEL);
+
 	if (!skb)
 		return ERR_PTR(err);
 
-- 
1.7.4.1

