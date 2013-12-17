Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v3 bluetooth-next 5/8] 6lowpan: add udp warning for elided checksum
Date: Tue, 17 Dec 2013 14:21:25 +0100
Message-Id: <1387286488-29382-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
References: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bit 5 of "UDP LOWPAN_NHC Format" indicate that the checksum can be
elided.
The host need to calculate the udp checksum afterwards but this isn't
supported right now.

See:
http://tools.ietf.org/html/rfc6282#section-4.3.3
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan.h      |  1 +
 net/ieee802154/6lowpan_iphc.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/6lowpan.h b/net/ieee802154/6lowpan.h
index 4981bf8..2b835db 100644
--- a/net/ieee802154/6lowpan.h
+++ b/net/ieee802154/6lowpan.h
@@ -231,6 +231,7 @@
 #define LOWPAN_NHC_UDP_CS_P_10	0xF2 /* source = 0xF0 + 8bit inline,
 					dest = 16 bit inline */
 #define LOWPAN_NHC_UDP_CS_P_11	0xF3 /* source & dest = 0xF0B + 4bit inline */
+#define LOWPAN_NHC_UDP_CS_C	0x04 /* checksum elided */
 
 #ifdef DEBUG
 /* print data in line */
diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 02bf74d..a70fa66 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -309,9 +309,14 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 		pr_debug("uncompressed UDP ports: src = %d, dst = %d\n",
 			 ntohs(uh->source), ntohs(uh->dest));
 
-		/* copy checksum */
-		memcpy(&uh->check, &skb->data[0], 2);
-		skb_pull(skb, 2);
+		/* checksum */
+		if (tmp & LOWPAN_NHC_UDP_CS_C) {
+			pr_debug_ratelimited("checksum elided currently not supported\n");
+			goto err;
+		} else {
+			memcpy(&uh->check, &skb->data[0], 2);
+			skb_pull(skb, 2);
+		}
 
 		/*
 		 * UDP lenght needs to be infered from the lower layers
-- 
1.8.5.1

