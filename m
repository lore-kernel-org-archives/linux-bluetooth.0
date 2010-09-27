Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Use the proper error value from bt_skb_send_alloc()
Date: Mon, 27 Sep 2010 17:16:49 -0300
Message-Id: <1285618609-11499-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1285618609-11499-1-git-send-email-padovan@profusion.mobi>
References: <1285618609-11499-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

&err points to the proper error set by bt_skb_send_alloc() when it
fails.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1e2ab05..1510812 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1537,7 +1537,7 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
 
 		*frag = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
 		if (!*frag)
-			return -EFAULT;
+			return err;
 		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
 			return -EFAULT;
 
@@ -1563,7 +1563,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr
 	skb = bt_skb_send_alloc(sk, count + hlen,
 			msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(err);
 
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
@@ -1592,7 +1592,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *ms
 	skb = bt_skb_send_alloc(sk, count + hlen,
 			msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(err);
 
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
@@ -1629,7 +1629,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
 	skb = bt_skb_send_alloc(sk, count + hlen,
 			msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(err);
 
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-- 
1.7.3

