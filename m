Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded elements from size calculation
Date: Wed,  2 May 2012 11:56:17 -0300
Message-Id: <1335970577-19224-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hlen - L2CAP_HDR_SIZE = 0, so we don't need to add them in the
calculation.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0f2b1be..870116a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1909,7 +1909,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
-	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
+	lh->len = cpu_to_le16(len);
 
 	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
 	if (unlikely(err < 0)) {
-- 
1.7.10

