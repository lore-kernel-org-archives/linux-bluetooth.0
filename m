Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] 6lowpan: fix/move/cleanup debug functions
Date: Thu, 12 Dec 2013 20:15:25 +0100
Message-Id: <1386875725-4436-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are several issues on current debug behaviour.
This patch fix the following issues:

- Fix debug printout only if DEBUG is defined.
- Move debug functions of 6LoWPAN code into 6lowpan header.
- Cleanup codestyle of debug functions.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/bluetooth/6lowpan.c       | 27 ---------------------------
 net/ieee802154/6lowpan.c      | 43 +++++--------------------------------------
 net/ieee802154/6lowpan.h      | 32 ++++++++++++++++++++++++++++++++
 net/ieee802154/6lowpan_iphc.c | 26 --------------------------
 4 files changed, 37 insertions(+), 91 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 5ad8b48..37239db 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -167,33 +167,6 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
 	return dev;
 }
 
-/* print data in line */
-static inline void raw_dump_inline(const char *caller, char *msg,
-				   unsigned char *buf, int len)
-{
-	if (msg)
-		pr_debug("%s():%s: ", caller, msg);
-
-	print_hex_dump_debug("", DUMP_PREFIX_NONE,
-			     16, 1, buf, len, false);
-}
-
-/* print data in a table format:
- *
- * addr: xx xx xx xx xx xx
- * addr: xx xx xx xx xx xx
- * ...
- */
-static inline void raw_dump_table(const char *caller, char *msg,
-				  unsigned char *buf, int len)
-{
-	if (msg)
-		pr_debug("%s():%s:\n", caller, msg);
-
-	print_hex_dump_debug("\t", DUMP_PREFIX_OFFSET,
-			     16, 1, buf, len, false);
-}
-
 static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sk_buff *skb_cp;
diff --git a/net/ieee802154/6lowpan.c b/net/ieee802154/6lowpan.c
index 53d0bd5..48b25c0 100644
--- a/net/ieee802154/6lowpan.c
+++ b/net/ieee802154/6lowpan.c
@@ -101,37 +101,6 @@ static inline void lowpan_address_flip(u8 *src, u8 *dest)
 		(dest)[IEEE802154_ADDR_LEN - i - 1] = (src)[i];
 }
 
-/* list of all 6lowpan devices, uses for package delivering */
-/* print data in line */
-static inline void lowpan_raw_dump_inline(const char *caller, char *msg,
-				   unsigned char *buf, int len)
-{
-#ifdef DEBUG
-	if (msg)
-		pr_debug("(%s) %s: ", caller, msg);
-	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
-		       16, 1, buf, len, false);
-#endif /* DEBUG */
-}
-
-/*
- * print data in a table format:
- *
- * addr: xx xx xx xx xx xx
- * addr: xx xx xx xx xx xx
- * ...
- */
-static inline void lowpan_raw_dump_table(const char *caller, char *msg,
-				   unsigned char *buf, int len)
-{
-#ifdef DEBUG
-	if (msg)
-		pr_debug("(%s) %s:\n", caller, msg);
-	print_hex_dump(KERN_DEBUG, "\t", DUMP_PREFIX_OFFSET,
-		       16, 1, buf, len, false);
-#endif /* DEBUG */
-}
-
 static int lowpan_header_create(struct sk_buff *skb,
 			   struct net_device *dev,
 			   unsigned short type, const void *_daddr,
@@ -153,8 +122,8 @@ static int lowpan_header_create(struct sk_buff *skb,
 	if (!saddr)
 		saddr = dev->dev_addr;
 
-	lowpan_raw_dump_inline(__func__, "saddr", (unsigned char *)saddr, 8);
-	lowpan_raw_dump_inline(__func__, "daddr", (unsigned char *)daddr, 8);
+	raw_dump_inline(__func__, "saddr", (unsigned char *)saddr, 8);
+	raw_dump_inline(__func__, "daddr", (unsigned char *)daddr, 8);
 
 	lowpan_header_compress(skb, dev, type, daddr, saddr, len);
 
@@ -290,8 +259,7 @@ static int process_data(struct sk_buff *skb)
 	u8 iphc0, iphc1;
 	const struct ieee802154_addr *_saddr, *_daddr;
 
-	lowpan_raw_dump_table(__func__, "raw skb data dump", skb->data,
-				skb->len);
+	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
 	/* at least two bytes will be used for the encoding */
 	if (skb->len < 2)
 		goto drop;
@@ -429,7 +397,7 @@ lowpan_fragment_xmit(struct sk_buff *skb, u8 *head,
 	hlen = (type == LOWPAN_DISPATCH_FRAG1) ?
 			LOWPAN_FRAG1_HEAD_SIZE : LOWPAN_FRAGN_HEAD_SIZE;
 
-	lowpan_raw_dump_inline(__func__, "6lowpan fragment header", head, hlen);
+	raw_dump_inline(__func__, "6lowpan fragment header", head, hlen);
 
 	frag = netdev_alloc_skb(skb->dev,
 				hlen + mlen + plen + IEEE802154_MFR_SIZE);
@@ -449,8 +417,7 @@ lowpan_fragment_xmit(struct sk_buff *skb, u8 *head,
 	skb_copy_to_linear_data_offset(frag, mlen + hlen,
 				       skb_network_header(skb) + offset, plen);
 
-	lowpan_raw_dump_table(__func__, " raw fragment dump", frag->data,
-								frag->len);
+	raw_dump_table(__func__, " raw fragment dump", frag->data, frag->len);
 
 	return dev_queue_xmit(frag);
 }
diff --git a/net/ieee802154/6lowpan.h b/net/ieee802154/6lowpan.h
index 535606d..10909e5 100644
--- a/net/ieee802154/6lowpan.h
+++ b/net/ieee802154/6lowpan.h
@@ -232,6 +232,38 @@
 					dest = 16 bit inline */
 #define LOWPAN_NHC_UDP_CS_P_11	0xF3 /* source & dest = 0xF0B + 4bit inline */
 
+#ifdef DEBUG
+/* print data in line */
+static inline void raw_dump_inline(const char *caller, char *msg,
+				   unsigned char *buf, int len)
+{
+	if (msg)
+		pr_debug("%s():%s: ", caller, msg);
+
+	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, buf, len, false);
+}
+
+/* print data in a table format:
+ *
+ * addr: xx xx xx xx xx xx
+ * addr: xx xx xx xx xx xx
+ * ...
+ */
+static inline void raw_dump_table(const char *caller, char *msg,
+				  unsigned char *buf, int len)
+{
+	if (msg)
+		pr_debug("%s():%s:\n", caller, msg);
+
+	print_hex_dump_debug("\t", DUMP_PREFIX_OFFSET, 16, 1, buf, len, false);
+}
+#else
+static inline void raw_dump_table(const char *caller, char *msg,
+				  unsigned char *buf, int len) { }
+static inline void raw_dump_inline(const char *caller, char *msg,
+				   unsigned char *buf, int len) { }
+#endif
+
 static inline int lowpan_fetch_skb_u8(struct sk_buff *skb, u8 *val)
 {
 	if (unlikely(!pskb_may_pull(skb, 1)))
diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 57c0b7a..88e7da5 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -58,32 +58,6 @@
 
 #include "6lowpan.h"
 
-/* print data in line */
-static inline void raw_dump_inline(const char *caller, char *msg,
-				   unsigned char *buf, int len)
-{
-	if (msg)
-		pr_debug("%s():%s: ", caller, msg);
-	print_hex_dump_debug("", DUMP_PREFIX_NONE,
-		       16, 1, buf, len, false);
-}
-
-/*
- * print data in a table format:
- *
- * addr: xx xx xx xx xx xx
- * addr: xx xx xx xx xx xx
- * ...
- */
-static inline void raw_dump_table(const char *caller, char *msg,
-				unsigned char *buf, int len)
-{
-	if (msg)
-		pr_debug("%s():%s:\n", caller, msg);
-	print_hex_dump_debug("\t", DUMP_PREFIX_OFFSET,
-		       16, 1, buf, len, false);
-}
-
 /*
  * Uncompress address function for source and
  * destination address(non-multicast).
-- 
1.8.5.1

