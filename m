Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix PSM value for L2CAP connectionless data packets
Date: Sat, 12 Oct 2013 06:01:26 -0700
Message-Id: <1381582886-43884-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The put_unaligned() for setting the PSM is missing the (__le16 *)
cast. Without this, the PSM information transmitted over the air
are bogus.

In addition, print the used PSM value in the debug message so this
becomes easier to debug in the future.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a7d10c3..ab976a1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2283,7 +2283,8 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	int err, count, hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("chan %p len %zu priority %u", chan, len, priority);
+	BT_DBG("chan %p psm 0x%2.2x len %zu priority %u", chan,
+	       __le16_to_cpu(chan->psm), len, priority);
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
@@ -2298,7 +2299,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len + L2CAP_PSMLEN_SIZE);
-	put_unaligned(chan->psm, skb_put(skb, L2CAP_PSMLEN_SIZE));
+	put_unaligned(chan->psm, (__le16 *) skb_put(skb, L2CAP_PSMLEN_SIZE));
 
 	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
 	if (unlikely(err < 0)) {
-- 
1.8.3.1

