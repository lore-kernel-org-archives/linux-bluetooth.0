Return-Path: <cyrus@holtmann.org>
From: varkabhadram@gmail.com
To: linux-zigbee-devel@lists.sourceforge.net
Cc: linux-bluetooth@vger.kernel.org, alex.aring@gmail.com,
	Varka Bhadram <varkab@cdac.in>
Subject: [PATCH bluetooth-next 2/2] 6lowpan: remove unused function
Date: Wed, 30 Jul 2014 11:05:12 +0530
Message-Id: <1406698512-29405-3-git-send-email-varkabhadram@gmail.com>
In-Reply-To: <1406698512-29405-1-git-send-email-varkabhadram@gmail.com>
References: <1406698512-29405-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Varka Bhadram <varkab@cdac.in>

This patch removes the unused function.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/6lowpan.h |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 614920a..d184df1 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -240,17 +240,6 @@ static inline int lowpan_fetch_skb_u8(struct sk_buff *skb, u8 *val)
 	return 0;
 }
 
-static inline int lowpan_fetch_skb_u16(struct sk_buff *skb, u16 *val)
-{
-	if (unlikely(!pskb_may_pull(skb, 2)))
-		return -EINVAL;
-
-	*val = (skb->data[0] << 8) | skb->data[1];
-	skb_pull(skb, 2);
-
-	return 0;
-}
-
 static inline bool lowpan_fetch_skb(struct sk_buff *skb,
 		void *data, const unsigned int len)
 {
-- 
1.7.9.5

