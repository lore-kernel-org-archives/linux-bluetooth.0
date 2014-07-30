Return-Path: <cyrus@holtmann.org>
From: Martin Townsend <mtownsend1973@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org
Cc: Martin Townsend <martin.townsend@xsilon.com>
Subject: [PATCH 2/2] Change lowpan_rcv so skb is freed within function and fix return values.
Date: Wed, 30 Jul 2014 15:55:05 +0100
Message-Id: <1406732105-17500-3-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1406732105-17500-1-git-send-email-martin.townsend@xsilon.com>
References: <1406732105-17500-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently it is up to the functions below lowpan_rcv to free the skb on error
conditions.  This patch now removes all the UAPI error codes and process data
now returns -1 if there is a problem.  In this scenario lowpan_rcv will free
the skb and return NET_RX_DROP.  This also fixes the problem where
NET_RX_SUCCESS is returned on error

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 include/net/6lowpan.h         |  2 +-
 net/6lowpan/iphc.c            | 35 ++++++++++++++++++-----------------
 net/bluetooth/6lowpan.c       | 17 ++++++++---------
 net/ieee802154/6lowpan_rtnl.c | 39 +++++++++++++++++++--------------------
 4 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 995cce86..561defe 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -424,7 +424,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 
 typedef int (*skb_delivery_cb)(struct sk_buff *skb);
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
+int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
 		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
 		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
 		u8 iphc0, u8 iphc1, skb_delivery_cb skb_deliver);
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index b4bb27c..61b5206 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -119,17 +119,17 @@ static int uncompress_addr(struct sk_buff *skb,
 			break;
 		default:
 			pr_debug("Invalid addr_type set\n");
-			return -EINVAL;
+			return -1;
 		}
 		break;
 	default:
 		pr_debug("Invalid address mode value: 0x%x\n", address_mode);
-		return -EINVAL;
+		return -1;
 	}
 
 	if (fail) {
 		pr_debug("Failed to fetch skb data\n");
-		return -EIO;
+		return -1;
 	}
 
 	raw_dump_inline(NULL, "Reconstructed ipv6 addr is",
@@ -158,10 +158,10 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
 	case LOWPAN_IPHC_ADDR_03:
 		/* TODO */
 		netdev_warn(skb->dev, "SAM value 0x%x not supported\n", sam);
-		return -EINVAL;
+		return -1;
 	default:
 		pr_debug("Invalid sam value: 0x%x\n", sam);
-		return -EINVAL;
+		return -1;
 	}
 
 	raw_dump_inline(NULL,
@@ -179,10 +179,10 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 
 	new = skb_copy_expand(skb, sizeof(struct ipv6hdr),
 			      skb_tailroom(skb), GFP_ATOMIC);
-	kfree_skb(skb);
-
 	if (!new)
-		return -ENOMEM;
+		return -1;
+
+	kfree_skb(skb);
 
 	skb_push(new, sizeof(struct ipv6hdr));
 	skb_reset_network_header(new);
@@ -196,6 +196,8 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 		       new->data, new->len);
 
 	stat = deliver_skb(new);
+	if (stat == -1)
+		stat = NET_RX_DROP;
 
 	kfree_skb(new);
 
@@ -245,12 +247,12 @@ lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 		break;
 	default:
 		pr_debug("DAM value has a wrong value: 0x%x\n", dam);
-		return -EINVAL;
+		return -1;
 	}
 
 	if (fail) {
 		pr_debug("Failed to fetch skb data\n");
-		return -EIO;
+		return -1;
 	}
 
 	raw_dump_inline(NULL, "Reconstructed ipv6 multicast addr is",
@@ -329,13 +331,13 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 
 	return 0;
 err:
-	return -EINVAL;
+	return -1;
 }
 
 /* TTL uncompression values */
 static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
+int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
 			const u8 *saddr, const u8 saddr_type,
 			const u8 saddr_len, const u8 *daddr,
 			const u8 daddr_type, const u8 daddr_len,
@@ -344,6 +346,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	struct ipv6hdr hdr = {};
 	u8 tmp, num_context = 0;
 	int err;
+	struct sk_buff *skb = *skb_inout;
 
 	raw_dump_table(__func__, "raw skb data dump uncompressed",
 		       skb->data, skb->len);
@@ -474,11 +477,10 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		 */
 		new = skb_copy_expand(skb, sizeof(struct udphdr),
 				      skb_tailroom(skb), GFP_ATOMIC);
-		kfree_skb(skb);
-
 		if (!new)
-			return -ENOMEM;
+			goto drop;
 
+		kfree_skb(skb);
 		skb = new;
 
 		skb_push(skb, sizeof(struct udphdr));
@@ -507,8 +509,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	return skb_deliver(skb, &hdr, dev, deliver_skb);
 
 drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	return -1;
 }
 EXPORT_SYMBOL_GPL(lowpan_process_data);
 
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f5df93f..cf8290f 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -204,7 +204,7 @@ static int give_skb_to_upper(struct sk_buff *skb)
 
 	skb_cp = skb_copy(skb, GFP_ATOMIC);
 	if (!skb_cp)
-		return -ENOMEM;
+		return -1;
 
 	ret = netif_rx(skb_cp);
 	if (ret < 0) {
@@ -215,7 +215,7 @@ static int give_skb_to_upper(struct sk_buff *skb)
 	return ret;
 }
 
-static int process_data(struct sk_buff *skb, struct net_device *netdev,
+static int process_data(struct sk_buff **skb_inout, struct net_device *netdev,
 			struct l2cap_chan *chan)
 {
 	const u8 *saddr, *daddr;
@@ -223,6 +223,7 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
 	struct lowpan_dev *dev;
 	struct lowpan_peer *peer;
 	unsigned long flags;
+	struct sk_buff *skb = *skb_inout;
 
 	dev = lowpan_dev(netdev);
 
@@ -245,7 +246,7 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
 	if (lowpan_fetch_skb_u8(skb, &iphc1))
 		goto drop;
 
-	return lowpan_process_data(skb, netdev,
+	return lowpan_process_data(skb_inout, netdev,
 				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
 				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
 				   iphc0, iphc1, give_skb_to_upper);
@@ -259,7 +260,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		    struct l2cap_chan *chan)
 {
 	struct sk_buff *local_skb;
-	int ret;
+	int ret = NET_RX_SUCCESS;
 
 	if (!netif_running(dev))
 		goto drop;
@@ -301,20 +302,18 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 				goto drop;
 
 			ret = process_data(local_skb, dev, chan);
-			if (ret != NET_RX_SUCCESS)
+			if (ret == -1)
 				goto drop;
 
 			dev->stats.rx_bytes += skb->len;
 			dev->stats.rx_packets++;
-
-			kfree_skb(skb);
 			break;
 		default:
-			break;
+			goto drop;
 		}
 	}
 
-	return NET_RX_SUCCESS;
+	return ret;
 
 drop:
 	dev->stats.rx_dropped++;
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 637caa6..897d0fd 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -154,7 +154,7 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb)
 		if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
 			skb_cp = skb_copy(skb, GFP_ATOMIC);
 			if (!skb_cp) {
-				stat = -ENOMEM;
+				stat = -1;
 				break;
 			}
 
@@ -166,11 +166,13 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb)
 	return stat;
 }
 
-static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
+static int process_data(struct sk_buff **skb_inout, 
+		        const struct ieee802154_hdr *hdr)
 {
 	u8 iphc0, iphc1;
 	struct ieee802154_addr_sa sa, da;
 	void *sap, *dap;
+	struct sk_buff *skb = *skb_inout;
 
 	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
 	/* at least two bytes will be used for the encoding */
@@ -196,14 +198,13 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 	else
 		dap = &da.hwaddr;
 
-	return lowpan_process_data(skb, skb->dev, sap, sa.addr_type,
+	return lowpan_process_data(skb_inout, skb->dev, sap, sa.addr_type,
 				   IEEE802154_ADDR_LEN, dap, da.addr_type,
 				   IEEE802154_ADDR_LEN, iphc0, iphc1,
 				   lowpan_give_skb_to_devices);
 
 drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	return -1;
 }
 
 static int lowpan_set_address(struct net_device *dev, void *p)
@@ -484,37 +485,35 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb_pull(skb, 1);
 
 		ret = lowpan_give_skb_to_devices(skb);
-		if (ret == NET_RX_DROP)
-			goto drop;
 	} else {
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
-			ret = process_data(skb, &hdr);
-			if (ret == NET_RX_DROP)
-				goto drop;
+			ret = process_data(&skb, &hdr);
 			break;
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
-				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
-					goto drop;
-			}
+				ret = process_data(&skb, &hdr);
+			} else {
+				ret = NET_RX_SUCCESS;
+ 			}
 			break;
 		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
 			if (ret == 1) {
-				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
-					goto drop;
-			}
+				ret = process_data(&skb, &hdr);
+			} else {
+				ret = NET_RX_SUCCESS;
+ 			}
 			break;
 		default:
-			break;
+			goto drop_skb;
 		}
 	}
 
-	return NET_RX_SUCCESS;
+	if (ret != -1)
+		return ret;
+
 drop_skb:
 	kfree_skb(skb);
 drop:
-- 
1.9.1

