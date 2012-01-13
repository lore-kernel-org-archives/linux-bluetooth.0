Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] Bluetooth: Change sk to l2cap_chan
Date: Fri, 13 Jan 2012 17:21:43 +0200
Message-Id: <1326468103-12731-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326468103-12731-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326468103-12731-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 52c7412..0087db8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1518,9 +1518,10 @@ static void l2cap_send_srejtail(struct l2cap_chan *chan)
 	l2cap_send_sframe(chan, control);
 }
 
-static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, int len, int count, struct sk_buff *skb)
+static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan, struct msghdr *msg, int len, int count, struct sk_buff *skb)
 {
-	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
+	struct sock *sk = chan->sk;
+	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff **frag;
 	int err, sent = 0;
 
@@ -1578,7 +1579,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
 	put_unaligned_le16(chan->psm, skb_put(skb, 2));
 
-	err = l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
+	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -1611,7 +1612,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
 
-	err = l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
+	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
@@ -1661,7 +1662,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	if (sdulen)
 		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
 
-	err = l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
+	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
 	if (unlikely(err < 0)) {
 		kfree_skb(skb);
 		return ERR_PTR(err);
-- 
1.7.4.1

