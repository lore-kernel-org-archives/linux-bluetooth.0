Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded calculation and magic number
Date: Fri,  4 May 2012 10:29:16 +0300
Message-Id: <1336116556-27540-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove magic number unneeded calculation since
hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index edc9a37..7ea00d3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1875,8 +1875,8 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
-	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
-	put_unaligned(chan->psm, skb_put(skb, 2));
+	lh->len = cpu_to_le16(len + L2CAP_PSMLEN_SIZE);
+	put_unaligned(chan->psm, skb_put(skb, L2CAP_PSMLEN_SIZE));
 
 	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
 	if (unlikely(err < 0)) {
-- 
1.7.9.5

