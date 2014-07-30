Return-Path: <cyrus@holtmann.org>
From: varkabhadram@gmail.com
To: linux-zigbee-devel@lists.sourceforge.net
Cc: linux-bluetooth@vger.kernel.org, alex.aring@gmail.com,
	Varka Bhadram <varkab@cdac.in>
Subject: [PATCH bluetooth-next 1/2] 6lowpan: remove unused macros
Date: Wed, 30 Jul 2014 11:05:11 +0530
Message-Id: <1406698512-29405-2-git-send-email-varkabhadram@gmail.com>
In-Reply-To: <1406698512-29405-1-git-send-email-varkabhadram@gmail.com>
References: <1406698512-29405-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Varka Bhadram <varkab@cdac.in>

This patch removes the unused macros.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/6lowpan.h |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 3bb3503..614920a 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -75,10 +75,6 @@
 	 (((a)->s6_addr[14]) == (m)[6]) &&		\
 	 (((a)->s6_addr[15]) == (m)[7]))
 
-/* compare ipv6 addresses prefixes */
-#define ipaddr_prefixcmp(addr1, addr2, length) \
-	(memcmp(addr1, addr2, length >> 3) == 0)
-
 /*
  * check whether we can compress the IID to 16 bits,
  * it's possible for unicast adresses with first 49 bits are zero only.
@@ -92,17 +88,6 @@
 
 /* check whether the 112-bit gid of the multicast address is mappable to: */
 
-/* 9 bits, for FF02::1 (all nodes) and FF02::2 (all routers) addresses only. */
-#define lowpan_is_mcast_addr_compressable(a)	\
-	((((a)->s6_addr16[1]) == 0) &&		\
-	 (((a)->s6_addr16[2]) == 0) &&		\
-	 (((a)->s6_addr16[3]) == 0) &&		\
-	 (((a)->s6_addr16[4]) == 0) &&		\
-	 (((a)->s6_addr16[5]) == 0) &&		\
-	 (((a)->s6_addr16[6]) == 0) &&		\
-	 (((a)->s6_addr[14])  == 0) &&		\
-	 ((((a)->s6_addr[15]) == 1) || (((a)->s6_addr[15]) == 2)))
-
 /* 48 bits, FFXX::00XX:XXXX:XXXX */
 #define lowpan_is_mcast_addr_compressable48(a)	\
 	((((a)->s6_addr16[1]) == 0) &&		\
-- 
1.7.9.5

