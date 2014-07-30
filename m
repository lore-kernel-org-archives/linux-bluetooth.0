Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Cc: alex.aring@gmail.com
Subject: [PATCH 4/5] 6lowpan: iphc: Fix missing braces for if statement
Date: Wed, 30 Jul 2014 03:48:43 +0200
Message-Id: <1406684924-40906-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CHECK: braces {} should be used on all arms of this statement
+	if ((iphc0 & 0x03) != LOWPAN_IPHC_TTL_I)
[...]
+	else {
[...]

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/6lowpan/iphc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index e6cf68e8667f..9e47702d24dd 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -408,9 +408,9 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	/* Hop Limit */
-	if ((iphc0 & 0x03) != LOWPAN_IPHC_TTL_I)
+	if ((iphc0 & 0x03) != LOWPAN_IPHC_TTL_I) {
 		hdr.hop_limit = lowpan_ttl_values[iphc0 & 0x03];
-	else {
+	} else {
 		if (lowpan_fetch_skb(skb, &hdr.hop_limit,
 				     sizeof(hdr.hop_limit)))
 			goto drop;
-- 
1.9.3

