Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Remove redundant setting to zero of bt_cb
Date: Thu,  5 Nov 2015 09:31:39 +0200
Message-Id: <1446708701-1387-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1446708701-1387-1-git-send-email-johan.hedberg@gmail.com>
References: <1446708701-1387-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The socket allocation functions will always memset skb->cb to zero so
there's no need to make other initializations needing the same thing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 663e0ef1eaa0..a85e6d3d75ef 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -325,10 +325,8 @@ static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
 	struct sk_buff *skb;
 
 	skb = alloc_skb(len + BT_SKB_RESERVE, how);
-	if (skb) {
+	if (skb)
 		skb_reserve(skb, BT_SKB_RESERVE);
-		bt_cb(skb)->incoming  = 0;
-	}
 	return skb;
 }
 
@@ -338,10 +336,8 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
 	struct sk_buff *skb;
 
 	skb = sock_alloc_send_skb(sk, len + BT_SKB_RESERVE, nb, err);
-	if (skb) {
+	if (skb)
 		skb_reserve(skb, BT_SKB_RESERVE);
-		bt_cb(skb)->incoming  = 0;
-	}
 
 	if (!skb && *err)
 		return NULL;
-- 
2.5.0

