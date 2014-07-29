Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: marcel@holtmann.org
Cc: jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/7] 6lowpan: iphc: use ipv6 api to check address scope
Date: Tue, 29 Jul 2014 23:47:02 +0200
Message-Id: <1406670424-15596-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
References: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the own implementation to check of link-layer,
broadcast and any address type and use the IPv6 api for that.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h | 13 -------------
 net/6lowpan/iphc.c    | 29 +++++++++++++++++------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 79b530f..18010bc 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -75,20 +75,10 @@
 	 (((a)->s6_addr[14]) == (m)[6]) &&		\
 	 (((a)->s6_addr[15]) == (m)[7]))
 
-/* ipv6 address is unspecified */
-#define is_addr_unspecified(a)		\
-	((((a)->s6_addr32[0]) == 0) &&	\
-	 (((a)->s6_addr32[1]) == 0) &&	\
-	 (((a)->s6_addr32[2]) == 0) &&	\
-	 (((a)->s6_addr32[3]) == 0))
-
 /* compare ipv6 addresses prefixes */
 #define ipaddr_prefixcmp(addr1, addr2, length) \
 	(memcmp(addr1, addr2, length >> 3) == 0)
 
-/* local link, i.e. FE80::/10 */
-#define is_addr_link_local(a) (((a)->s6_addr16[0]) == htons(0xFE80))
-
 /*
  * check whether we can compress the IID to 16 bits,
  * it's possible for unicast adresses with first 49 bits are zero only.
@@ -100,9 +90,6 @@
 	 (((a)->s6_addr[12]) == 0xfe) &&	\
 	 (((a)->s6_addr[13]) == 0))
 
-/* multicast address */
-#define is_addr_mcast(a) (((a)->s6_addr[0]) == 0xFF)
-
 /* check whether the 112-bit gid of the multicast address is mappable to: */
 
 /* 9 bits, for FF02::1 (all nodes) and FF02::2 (all routers) addresses only. */
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 636edd0..d4fc2dd 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -611,6 +611,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	u8 tmp, iphc0, iphc1, *hc_ptr;
 	struct ipv6hdr *hdr;
 	u8 head[100] = {};
+	int addr_type;
 
 	if (type != ETH_P_IPV6)
 		return -EINVAL;
@@ -720,23 +721,27 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 				    sizeof(hdr->hop_limit));
 	}
 
+	addr_type = ipv6_addr_type(&hdr->saddr);
 	/* source address compression */
-	if (is_addr_unspecified(&hdr->saddr)) {
+	if (addr_type == IPV6_ADDR_ANY) {
 		pr_debug("source address is unspecified, setting SAC\n");
 		iphc1 |= LOWPAN_IPHC_SAC;
-	/* TODO: context lookup */
-	} else if (is_addr_link_local(&hdr->saddr)) {
-		iphc1 |= lowpan_compress_addr_64(&hc_ptr,
-				LOWPAN_IPHC_SAM_BIT, &hdr->saddr, _saddr);
-		pr_debug("source address unicast link-local %pI6c "
-			"iphc1 0x%02x\n", &hdr->saddr, iphc1);
 	} else {
-		pr_debug("send the full source address\n");
-		lowpan_push_hc_data(&hc_ptr, &hdr->saddr.s6_addr[0], 16);
+		if (addr_type & IPV6_ADDR_LINKLOCAL) {
+			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
+							 LOWPAN_IPHC_SAM_BIT,
+							 &hdr->saddr, _saddr);
+			pr_debug("source address unicast link-local %pI6c iphc1 0x%02x\n",
+				 &hdr->saddr, iphc1);
+		} else {
+			pr_debug("send the full source address\n");
+			lowpan_push_hc_data(&hc_ptr, hdr->saddr.s6_addr, 16);
+		}
 	}
 
+	addr_type = ipv6_addr_type(&hdr->daddr);
 	/* destination address compression */
-	if (is_addr_mcast(&hdr->daddr)) {
+	if (addr_type & IPV6_ADDR_MULTICAST) {
 		pr_debug("destination address is multicast: ");
 		iphc1 |= LOWPAN_IPHC_M;
 		if (lowpan_is_mcast_addr_compressable8(&hdr->daddr)) {
@@ -767,8 +772,8 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
 		}
 	} else {
-		/* TODO: context lookup */
-		if (is_addr_link_local(&hdr->daddr)) {
+		if (addr_type & IPV6_ADDR_LINKLOCAL) {
+			/* TODO: context lookup */
 			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
 				LOWPAN_IPHC_DAM_BIT, &hdr->daddr, _daddr);
 			pr_debug("dest address unicast link-local %pI6c "
-- 
2.0.3
