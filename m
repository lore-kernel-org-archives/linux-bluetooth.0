Return-Path: <cyrus@holtmann.org>
From: Martin Townsend <mtownsend1973@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org
Cc: Martin Townsend <martin.townsend@xsilon.com>
Subject: [PATCH 1/2] Remove dev parameter from skb_delivery_cb in 6lowpan.
Date: Wed, 30 Jul 2014 15:55:04 +0100
Message-Id: <1406732105-17500-2-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1406732105-17500-1-git-send-email-martin.townsend@xsilon.com>
References: <1406732105-17500-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This parameter is never used by any functions that are passed to
lowpan_process_data which uses this callback.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 include/net/6lowpan.h         | 2 +-
 net/6lowpan/iphc.c            | 2 +-
 net/bluetooth/6lowpan.c       | 4 ++--
 net/ieee802154/6lowpan_rtnl.c | 5 ++---
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 79b530f..995cce86 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -422,7 +422,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 	return skb->len + uncomp_header - ret;
 }
 
-typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
+typedef int (*skb_delivery_cb)(struct sk_buff *skb);
 
 int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index e82c9cc..b4bb27c 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -195,7 +195,7 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 	raw_dump_table(__func__, "raw skb data dump before receiving",
 		       new->data, new->len);
 
-	stat = deliver_skb(new, dev);
+	stat = deliver_skb(new);
 
 	kfree_skb(new);
 
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 5a7f81d..f5df93f 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -197,7 +197,7 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
 	return dev;
 }
 
-static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
+static int give_skb_to_upper(struct sk_buff *skb)
 {
 	struct sk_buff *skb_cp;
 	int ret;
@@ -283,7 +283,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		skb_reset_network_header(local_skb);
 		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
 
-		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
+		if (give_skb_to_upper(local_skb) != NET_RX_SUCCESS) {
 			kfree_skb(local_skb);
 			goto drop;
 		}
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 016b77e..637caa6 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -143,8 +143,7 @@ static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
 			type, (void *)&da, (void *)&sa, 0);
 }
 
-static int lowpan_give_skb_to_devices(struct sk_buff *skb,
-				      struct net_device *dev)
+static int lowpan_give_skb_to_devices(struct sk_buff *skb)
 {
 	struct lowpan_dev_record *entry;
 	struct sk_buff *skb_cp;
@@ -484,7 +483,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		/* Pull off the 1-byte of 6lowpan header. */
 		skb_pull(skb, 1);
 
-		ret = lowpan_give_skb_to_devices(skb, NULL);
+		ret = lowpan_give_skb_to_devices(skb);
 		if (ret == NET_RX_DROP)
 			goto drop;
 	} else {
-- 
1.9.1

