Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/4] Bluetooth: bnep: Add support to extended headers of control frames
Date: Tue, 31 Mar 2015 16:56:00 +0200
Message-Id: <1427813761-32123-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427813761-32123-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427813761-32123-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handling extended headers of control frames is required BNEP
functionality. This patch refractor bnep rx frame handling function.
Extended header for control frames shouldn't be omitted as it was
previously done. Every control frame should be checked if it contains
extended header and then every extension should be parsed separately.

Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
---
 net/bluetooth/bnep/core.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index c627817..77ae725 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -292,29 +292,55 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct net_device *dev = s->dev;
 	struct sk_buff *nskb;
-	u8 type;
+	u8 type, ctrl_type;
 
 	dev->stats.rx_bytes += skb->len;
 
 	type = *(u8 *) skb->data;
 	skb_pull(skb, 1);
+	ctrl_type = *(u8 *)skb->data;
 
 	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
 		goto badframe;
 
 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
-		bnep_rx_control(s, skb->data, skb->len);
-		kfree_skb(skb);
-		return 0;
-	}
+		if (bnep_rx_control(s, skb->data, skb->len) < 0) {
+			dev->stats.tx_errors++;
+			kfree_skb(skb);
+			return 0;
+		}
 
-	skb_reset_mac_header(skb);
+		if (!(type & BNEP_EXT_HEADER)) {
+			kfree_skb(skb);
+			return 0;
+		}
 
-	/* Verify and pull out header */
-	if (!skb_pull(skb, __bnep_rx_hlen[type & BNEP_TYPE_MASK]))
-		goto badframe;
+		/* Verify and pull ctrl message since it's already processed */
+		switch (ctrl_type) {
+		case BNEP_SETUP_CONN_REQ:
+			/* Pull: ctrl type (1 b), len (1 b), data (len bytes) */
+			if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2))
+				goto badframe;
+			break;
+		case BNEP_FILTER_MULTI_ADDR_SET:
+		case BNEP_FILTER_NET_TYPE_SET:
+			/* Pull: ctrl type (1 b), len (2 b), data (len bytes) */
+			if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * 2))
+				goto badframe;
+			break;
+		default:
+			kfree_skb(skb);
+			return 0;
+		}
+	} else {
+		skb_reset_mac_header(skb);
 
-	s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
+		/* Verify and pull out header */
+		if (!skb_pull(skb, __bnep_rx_hlen[type & BNEP_TYPE_MASK]))
+			goto badframe;
+
+		s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
+	}
 
 	if (type & BNEP_EXT_HEADER) {
 		if (bnep_rx_extension(s, skb) < 0)
-- 
2.1.0

