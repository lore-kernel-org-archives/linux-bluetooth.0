Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: marcel@holtmann.org
Cc: jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/7] 6lowpan: iphc: remove check on null
Date: Tue, 29 Jul 2014 23:47:03 +0200
Message-Id: <1406670424-15596-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
References: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This memory is placed on stack and can't be null so remove the check on
null.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index d4fc2dd..de78deb 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -268,9 +268,6 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 	bool fail;
 	u8 tmp = 0, val = 0;
 
-	if (!uh)
-		goto err;
-
 	fail = lowpan_fetch_skb(skb, &tmp, sizeof(tmp));
 
 	if ((tmp & LOWPAN_NHC_UDP_MASK) == LOWPAN_NHC_UDP_ID) {
-- 
2.0.3
