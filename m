Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Cc: alex.aring@gmail.com
Subject: [PATCH 3/5] 6lowpan: iphc: Fix missing blank line after variable declarations
Date: Wed, 30 Jul 2014 03:48:42 +0200
Message-Id: <1406684924-40906-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

WARNING: Missing a blank line after declarations
+		struct sk_buff *new;
+		if (uncompress_udp_header(skb, &uh))

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/6lowpan/iphc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index c718253a4e07..e6cf68e8667f 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -462,6 +462,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	if (iphc0 & LOWPAN_IPHC_NH_C) {
 		struct udphdr uh;
 		struct sk_buff *new;
+
 		if (uncompress_udp_header(skb, &uh))
 			goto drop;
 
-- 
1.9.3

