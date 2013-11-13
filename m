Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4 4/6] Bluetooth: Enable 6LoWPAN support for BT LE devices
Date: Wed, 13 Nov 2013 12:11:33 +0200
Message-Id: <1384337495-9043-5-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1384337495-9043-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1384337495-9043-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 1042 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 1040 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 85754e2..5f0489c 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -11,6 +11,20 @@
    GNU General Public License for more details.
 */
 
+/*
+ * The compression, uncompression and IPv6 packet code
+ * is from net/ieee802154/6lowpan.c with these copyrights
+ *
+ * Copyright 2011, Siemens AG
+ * written by Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
+ *
+ * Based on patches from Jon Smirl <jonsmirl@gmail.com>
+ * Copyright (c) 2011 Jon Smirl <jonsmirl@gmail.com>
+ *
+ * Jon's code is based on 6lowpan implementation for Contiki which is:
+ * Copyright (c) 2008, Swedish Institute of Computer Science.
+ */
+
 #include <linux/version.h>
 #include <linux/bitops.h>
 #include <linux/if_arp.h>
@@ -172,8 +186,574 @@ static inline void raw_dump_table(const char *caller, char *msg,
 		       16, 1, buf, len, false);
 }
 
-static int recv_pkt(struct sk_buff *skb, struct net_device *dev)
+static inline bool fetch_skb(struct sk_buff *skb,
+					void *data, const unsigned int len)
+{
+	if (unlikely(!pskb_may_pull(skb, len)))
+		return true;
+
+	skb_copy_from_linear_data(skb, data, len);
+	skb_pull(skb, len);
+
+	return false;
+}
+
+/*
+ * Uncompress address function for source and
+ * destination address(non-multicast).
+ *
+ * address_mode is sam value or dam value.
+ */
+static int uncompress_addr(struct sk_buff *skb,
+				struct in6_addr *ipaddr,
+				const u8 address_mode,
+				const u8 *lladdr)
+{
+	bool fail;
+
+	switch (address_mode) {
+	case LOWPAN_IPHC_ADDR_00:
+		/* for global link addresses */
+		fail = fetch_skb(skb, ipaddr->s6_addr, 16);
+		break;
+	case LOWPAN_IPHC_ADDR_01:
+		/* fe:80::XXXX:XXXX:XXXX:XXXX */
+		ipaddr->s6_addr[0] = 0xFE;
+		ipaddr->s6_addr[1] = 0x80;
+		fail = fetch_skb(skb, &ipaddr->s6_addr[8], 8);
+		break;
+	case LOWPAN_IPHC_ADDR_02:
+		/* fe:80::ff:fe00:XXXX */
+		ipaddr->s6_addr[0] = 0xFE;
+		ipaddr->s6_addr[1] = 0x80;
+		ipaddr->s6_addr[11] = 0xFF;
+		ipaddr->s6_addr[12] = 0xFE;
+		fail = fetch_skb(skb, &ipaddr->s6_addr[14], 2);
+		break;
+	case LOWPAN_IPHC_ADDR_03:
+		fail = false;
+		/* XXX: support only normal addr (IEEE802154_ADDR_LONG) atm */
+
+		/* fe:80::XXXX:XXXX:XXXX:XXXX
+		 *        \_________________/
+		 *              hwaddr
+		 */
+		ipaddr->s6_addr[0] = 0xFE;
+		ipaddr->s6_addr[1] = 0x80;
+		memcpy(&ipaddr->s6_addr[8], lladdr, EUI64_ADDR_LEN);
+		break;
+	default:
+		pr_debug("Invalid address mode value: 0x%x\n", address_mode);
+		return -EINVAL;
+	}
+
+	if (fail) {
+		pr_debug("Failed to fetch skb data\n");
+		return -EIO;
+	}
+
+	raw_dump_inline(NULL, "Reconstructed ipv6 addr is",
+			ipaddr->s6_addr, 16);
+
+	return 0;
+}
+
+/*
+ * Uncompress address function for source context
+ * based address(non-multicast).
+ */
+static int uncompress_context_based_src_addr(struct sk_buff *skb,
+						struct in6_addr *ipaddr,
+						const u8 sam)
+{
+	switch (sam) {
+	case LOWPAN_IPHC_ADDR_00:
+		/* unspec address ::
+		 * Do nothing, address is already ::
+		 */
+		break;
+	case LOWPAN_IPHC_ADDR_01:
+		/* TODO */
+	case LOWPAN_IPHC_ADDR_02:
+		/* TODO */
+	case LOWPAN_IPHC_ADDR_03:
+		/* TODO */
+		netdev_warn(skb->dev, "SAM value 0x%x not supported\n", sam);
+		return -EINVAL;
+	default:
+		pr_debug("Invalid sam value: 0x%x\n", sam);
+		return -EINVAL;
+	}
+
+	raw_dump_inline(NULL,
+			"Reconstructed context based ipv6 src addr is",
+			ipaddr->s6_addr, 16);
+
+	return 0;
+}
+
+/*
+ * This func is called when the packet from BT LE device
+ * needs to be sent upper layers.
+ */
+static int give_skb_to_upper(struct sk_buff *skb,
+					struct net_device *dev)
+{
+	struct sk_buff *skb_cp;
+	int ret = NET_RX_SUCCESS;
+
+	skb_cp = skb_copy(skb, GFP_ATOMIC);
+	if (!skb_cp) {
+		ret = -ENOMEM;
+	} else {
+		ret = netif_rx(skb_cp);
+
+		BT_DBG("receive skb %d", ret);
+		if (ret < 0)
+			ret = NET_RX_DROP;
+	}
+
+	return ret;
+}
+
+static inline int fetch_skb_u8(struct sk_buff *skb, u8 *val)
+{
+	if (unlikely(!pskb_may_pull(skb, 1)))
+		return -EINVAL;
+
+	*val = skb->data[0];
+	skb_pull(skb, 1);
+
+	return 0;
+}
+
+static inline int fetch_skb_u16(struct sk_buff *skb, u16 *val)
 {
+	if (unlikely(!pskb_may_pull(skb, 2)))
+		return -EINVAL;
+
+	*val = (skb->data[0] << 8) | skb->data[1];
+	skb_pull(skb, 2);
+
+	return 0;
+}
+
+static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
+				struct net_device *dev)
+{
+	struct sk_buff *new;
+	int stat;
+
+	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
+								GFP_ATOMIC);
+	kfree_skb(skb);
+
+	if (!new)
+		return -ENOMEM;
+
+	skb_push(new, sizeof(struct ipv6hdr));
+	skb_reset_network_header(new);
+	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
+
+	new->protocol = htons(ETH_P_IPV6);
+	new->pkt_type = PACKET_HOST;
+	new->dev = dev;
+
+	raw_dump_table(__func__,
+				"raw skb data dump before receiving",
+				new->data, new->len);
+
+	stat = give_skb_to_upper(new, dev);
+
+	kfree_skb(new);
+
+	return stat;
+}
+
+/* Uncompress function for multicast destination address,
+ * when M bit is set.
+ */
+static int
+lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
+		struct in6_addr *ipaddr,
+		const u8 dam)
+{
+	bool fail;
+
+	switch (dam) {
+	case LOWPAN_IPHC_DAM_00:
+		/* 00:  128 bits.  The full address
+		 * is carried in-line.
+		 */
+		fail = fetch_skb(skb, ipaddr->s6_addr, 16);
+		break;
+	case LOWPAN_IPHC_DAM_01:
+		/* 01:  48 bits.  The address takes
+		 * the form ffXX::00XX:XXXX:XXXX.
+		 */
+		ipaddr->s6_addr[0] = 0xFF;
+		fail = fetch_skb(skb, &ipaddr->s6_addr[1], 1);
+		fail |= fetch_skb(skb, &ipaddr->s6_addr[11], 5);
+		break;
+	case LOWPAN_IPHC_DAM_10:
+		/* 10:  32 bits.  The address takes
+		 * the form ffXX::00XX:XXXX.
+		 */
+		ipaddr->s6_addr[0] = 0xFF;
+		fail = fetch_skb(skb, &ipaddr->s6_addr[1], 1);
+		fail |= fetch_skb(skb, &ipaddr->s6_addr[13], 3);
+		break;
+	case LOWPAN_IPHC_DAM_11:
+		/* 11:  8 bits.  The address takes
+		 * the form ff02::00XX.
+		 */
+		ipaddr->s6_addr[0] = 0xFF;
+		ipaddr->s6_addr[1] = 0x02;
+		fail = fetch_skb(skb, &ipaddr->s6_addr[15], 1);
+		break;
+	default:
+		pr_debug("DAM value has a wrong value: 0x%x\n", dam);
+		return -EINVAL;
+	}
+
+	if (fail) {
+		pr_debug("Failed to fetch skb data\n");
+		return -EIO;
+	}
+
+	raw_dump_inline(NULL, "Reconstructed ipv6 multicast addr is",
+				ipaddr->s6_addr, 16);
+
+	return 0;
+}
+
+static int
+uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
+{
+	u8 tmp;
+
+	if (!uh)
+		goto err;
+
+	if (fetch_skb_u8(skb, &tmp))
+		goto err;
+
+	if ((tmp & LOWPAN_NHC_UDP_MASK) == LOWPAN_NHC_UDP_ID) {
+		pr_debug("UDP header uncompression\n");
+		switch (tmp & LOWPAN_NHC_UDP_CS_P_11) {
+		case LOWPAN_NHC_UDP_CS_P_00:
+			memcpy(&uh->source, &skb->data[0], 2);
+			memcpy(&uh->dest, &skb->data[2], 2);
+			skb_pull(skb, 4);
+			break;
+		case LOWPAN_NHC_UDP_CS_P_01:
+			memcpy(&uh->source, &skb->data[0], 2);
+			uh->dest =
+			   skb->data[2] + LOWPAN_NHC_UDP_8BIT_PORT;
+			skb_pull(skb, 3);
+			break;
+		case LOWPAN_NHC_UDP_CS_P_10:
+			uh->source = skb->data[0] + LOWPAN_NHC_UDP_8BIT_PORT;
+			memcpy(&uh->dest, &skb->data[1], 2);
+			skb_pull(skb, 3);
+			break;
+		case LOWPAN_NHC_UDP_CS_P_11:
+			uh->source =
+			   LOWPAN_NHC_UDP_4BIT_PORT + (skb->data[0] >> 4);
+			uh->dest =
+			   LOWPAN_NHC_UDP_4BIT_PORT + (skb->data[0] & 0x0f);
+			skb_pull(skb, 1);
+			break;
+		default:
+			pr_debug("ERROR: unknown UDP format\n");
+			goto err;
+			break;
+		}
+
+		pr_debug("uncompressed UDP ports: src = %d, dst = %d\n",
+			 uh->source, uh->dest);
+
+		/* copy checksum */
+		memcpy(&uh->check, &skb->data[0], 2);
+		skb_pull(skb, 2);
+
+		/*
+		 * UDP lenght needs to be infered from the lower layers
+		 * here, we obtain the hint from the remaining size of the
+		 * frame
+		 */
+		uh->len = htons(skb->len + sizeof(struct udphdr));
+		pr_debug("uncompressed UDP length: src = %d", uh->len);
+	} else {
+		pr_debug("ERROR: unsupported NH format\n");
+		goto err;
+	}
+
+	return 0;
+err:
+	return -EINVAL;
+}
+
+/* TTL uncompression values */
+static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
+
+static int process_data(struct sk_buff *skb, struct net_device *dev,
+			struct l2cap_conn *conn)
+{
+	struct ipv6hdr hdr = {};
+	u8 tmp, iphc0, iphc1, num_context = 0;
+	const u8 *_saddr = NULL, *_daddr = NULL;
+	struct lowpan_info *info;
+	struct peer *peer;
+	int err;
+
+	raw_dump_table(__func__, "raw skb data dump uncompressed",
+				skb->data, skb->len);
+
+	/* at least two bytes will be used for the encoding */
+	if (skb->len < 2)
+		goto drop;
+
+	if (fetch_skb_u8(skb, &iphc0))
+		goto drop;
+
+	info = lowpan_info(dev);
+
+	if (fetch_skb_u8(skb, &iphc1))
+		goto drop;
+
+	write_lock(&devices_lock);
+	peer = peer_lookup_conn(info, conn);
+	write_unlock(&devices_lock);
+	if (!peer)
+		goto drop;
+
+	_saddr = peer->eui64_addr;
+	_daddr = info->net->dev_addr;
+
+	/* another if the CID flag is set */
+	if (iphc1 & LOWPAN_IPHC_CID) {
+		pr_debug("CID flag is set, increase header with one\n");
+		if (fetch_skb_u8(skb, &num_context))
+			goto drop;
+	}
+
+	hdr.version = 6;
+
+	/* Traffic Class and Flow Label */
+	switch ((iphc0 & LOWPAN_IPHC_TF) >> 3) {
+	/*
+	 * Traffic Class and FLow Label carried in-line
+	 * ECN + DSCP + 4-bit Pad + Flow Label (4 bytes)
+	 */
+	case 0: /* 00b */
+		if (fetch_skb_u8(skb, &tmp))
+			goto drop;
+
+		memcpy(&hdr.flow_lbl, &skb->data[0], 3);
+		skb_pull(skb, 3);
+		hdr.priority = ((tmp >> 2) & 0x0f);
+		hdr.flow_lbl[0] = ((tmp >> 2) & 0x30) | (tmp << 6) |
+					(hdr.flow_lbl[0] & 0x0f);
+		break;
+	/*
+	 * Traffic class carried in-line
+	 * ECN + DSCP (1 byte), Flow Label is elided
+	 */
+	case 2: /* 10b */
+		if (fetch_skb_u8(skb, &tmp))
+			goto drop;
+
+		hdr.priority = ((tmp >> 2) & 0x0f);
+		hdr.flow_lbl[0] = ((tmp << 6) & 0xC0) | ((tmp >> 2) & 0x30);
+		break;
+	/*
+	 * Flow Label carried in-line
+	 * ECN + 2-bit Pad + Flow Label (3 bytes), DSCP is elided
+	 */
+	case 1: /* 01b */
+		if (fetch_skb_u8(skb, &tmp))
+			goto drop;
+
+		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
+		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
+		skb_pull(skb, 2);
+		break;
+	/* Traffic Class and Flow Label are elided */
+	case 3: /* 11b */
+		break;
+	default:
+		break;
+	}
+
+	/* Next Header */
+	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0) {
+		/* Next header is carried inline */
+		if (fetch_skb_u8(skb, &(hdr.nexthdr)))
+			goto drop;
+
+		pr_debug("NH flag is set, next header carried inline: %02x\n",
+			 hdr.nexthdr);
+	}
+
+	/* Hop Limit */
+	if ((iphc0 & 0x03) != LOWPAN_IPHC_TTL_I)
+		hdr.hop_limit = lowpan_ttl_values[iphc0 & 0x03];
+	else {
+		if (fetch_skb_u8(skb, &(hdr.hop_limit)))
+			goto drop;
+	}
+
+	/* Extract SAM to the tmp variable */
+	tmp = ((iphc1 & LOWPAN_IPHC_SAM) >> LOWPAN_IPHC_SAM_BIT) & 0x03;
+
+	if (iphc1 & LOWPAN_IPHC_SAC) {
+		/* Source address context based uncompression */
+		pr_debug("SAC bit is set. Handle context based source address.\n");
+		err = uncompress_context_based_src_addr(
+				skb, &hdr.saddr, tmp);
+	} else {
+		/* Source address uncompression */
+		pr_debug("source address stateless compression\n");
+		err = uncompress_addr(skb, &hdr.saddr, tmp, _saddr);
+	}
+
+	/* Check on error of previous branch */
+	if (err)
+		goto drop;
+
+	/* Extract DAM to the tmp variable */
+	tmp = ((iphc1 & LOWPAN_IPHC_DAM_11) >> LOWPAN_IPHC_DAM_BIT) & 0x03;
+
+	/* check for Multicast Compression */
+	if (iphc1 & LOWPAN_IPHC_M) {
+		if (iphc1 & LOWPAN_IPHC_DAC) {
+			pr_debug("dest: context-based mcast compression\n");
+			/* TODO: implement this */
+		} else {
+			err = lowpan_uncompress_multicast_daddr(
+						skb, &hdr.daddr, tmp);
+			if (err)
+				goto drop;
+		}
+	} else {
+		err = uncompress_addr(skb, &hdr.daddr, tmp, _daddr);
+		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
+			tmp, &hdr.daddr);
+		if (err)
+			goto drop;
+	}
+
+	/* UDP data uncompression */
+	if (iphc0 & LOWPAN_IPHC_NH_C) {
+		struct udphdr uh;
+		struct sk_buff *new;
+		if (uncompress_udp_header(skb, &uh))
+			goto drop;
+
+		/*
+		 * replace the compressed UDP head by the uncompressed UDP
+		 * header
+		 */
+		new = skb_copy_expand(skb, sizeof(struct udphdr),
+				      skb_tailroom(skb), GFP_ATOMIC);
+		kfree_skb(skb);
+
+		if (!new)
+			return -ENOMEM;
+
+		skb = new;
+
+		skb_push(skb, sizeof(struct udphdr));
+		skb_reset_transport_header(skb);
+		skb_copy_to_linear_data(skb, &uh, sizeof(struct udphdr));
+
+		raw_dump_table(__func__, "raw UDP header dump",
+				      (u8 *)&uh, sizeof(uh));
+
+		hdr.nexthdr = UIP_PROTO_UDP;
+	}
+
+	hdr.payload_len = htons(skb->len);
+
+	pr_debug("skb headroom size = %d, data length = %d\n",
+		 skb_headroom(skb), skb->len);
+
+	pr_debug("IPv6 header dump:\n\tversion = %d\n\tlength  = %d\n\t"
+		 "nexthdr = 0x%02x\n\thop_lim = %d\n\tdest    = %pI6c\n",
+		hdr.version, ntohs(hdr.payload_len), hdr.nexthdr,
+		hdr.hop_limit, &hdr.daddr);
+
+	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr,
+							sizeof(hdr));
+
+	return skb_deliver(skb, &hdr, dev);
+
+drop:
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
+					struct l2cap_conn *conn)
+{
+	struct sk_buff *local_skb;
+
+	if (!netif_running(dev))
+		goto drop;
+
+	if (dev->type != ARPHRD_RAWIP)
+		goto drop;
+
+	/* check that it's our buffer */
+	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
+		/* Copy the packet so that the IPv6 header is
+		 * properly aligned.
+		 */
+		local_skb = skb_copy_expand(skb, NET_SKB_PAD - 1,
+					    skb_tailroom(skb), GFP_ATOMIC);
+		if (!local_skb)
+			goto drop;
+
+		local_skb->protocol = htons(ETH_P_IPV6);
+		local_skb->pkt_type = PACKET_HOST;
+
+		skb_reset_network_header(local_skb);
+		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
+
+		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
+			kfree_skb(local_skb);
+			goto drop;
+		}
+
+		dev->stats.rx_bytes += skb->len;
+		dev->stats.rx_packets++;
+
+		kfree_skb(local_skb);
+		kfree_skb(skb);
+	} else {
+		switch (skb->data[0] & 0xe0) {
+		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
+			local_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!local_skb)
+				goto drop;
+			if (process_data(local_skb, dev, conn)
+							!= NET_RX_SUCCESS)
+				goto drop;
+
+			dev->stats.rx_bytes += skb->len;
+			dev->stats.rx_packets++;
+
+			kfree_skb(skb);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return NET_RX_SUCCESS;
+
+drop:
 	kfree_skb(skb);
 	return NET_RX_DROP;
 }
@@ -202,19 +782,472 @@ static void do_send(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p, skb %p len %d priority %u", conn, skb, skb->len,
 	       skb->priority);
 
+	hci_send_acl(conn->hchan, skb, ACL_START);
 	return;
 }
 
+static inline int skbuff_copy(void *msg, int len,
+					int count, int mtu,
+					struct sk_buff *skb,
+					struct net_device *dev)
+{
+	struct sk_buff **frag;
+	int sent = 0;
+
+	memcpy(skb_put(skb, count), msg, count);
+
+	sent += count;
+	msg  += count;
+	len  -= count;
+
+	dev->stats.tx_bytes += count;
+	dev->stats.tx_packets++;
+
+	raw_dump_table(__func__, "Sending", skb->data, skb->len);
+
+	/* Continuation fragments (no L2CAP header) */
+	frag = &skb_shinfo(skb)->frag_list;
+	while (len > 0) {
+		struct sk_buff *tmp;
+
+		count = min_t(unsigned int, mtu, len);
+
+		tmp = bt_skb_alloc(count, GFP_KERNEL);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+
+		*frag = tmp;
+
+		memcpy(skb_put(*frag, count), msg, count);
+
+		raw_dump_table(__func__, "Sending fragment",
+					(*frag)->data, count);
+
+		(*frag)->priority = skb->priority;
+
+		sent += count;
+		msg  += count;
+		len  -= count;
+
+		skb->len += (*frag)->len;
+		skb->data_len += (*frag)->len;
+
+		frag = &(*frag)->next;
+
+		dev->stats.tx_bytes += count;
+		dev->stats.tx_packets++;
+	}
+
+	return sent;
+}
+
+static struct sk_buff *create_pdu(struct l2cap_conn *conn,
+					void *msg, size_t len,
+					u32 priority,
+					struct net_device *dev)
+{
+	struct sk_buff *skb;
+	int err, count;
+	struct l2cap_hdr *lh;
+
+	if (conn->mtu > (L2CAP_LE_MIN_MTU + L2CAP_HDR_SIZE))
+		/* XXX: This should be not needed and atm is only used for
+		 * testing purposes */
+		conn->mtu = L2CAP_LE_MIN_MTU + L2CAP_HDR_SIZE;
+
+	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
+
+	BT_DBG("conn %p len %zu mtu %d count %d", conn, len, conn->mtu, count);
+
+	skb = bt_skb_alloc(count + L2CAP_HDR_SIZE, GFP_KERNEL);
+	if (IS_ERR(skb))
+		return skb;
+
+	skb->priority = priority;
+
+	lh = (struct l2cap_hdr *)skb_put(skb, L2CAP_HDR_SIZE);
+	lh->cid = cpu_to_le16(L2CAP_FC_6LOWPAN);
+	lh->len = cpu_to_le16(len);
+
+	err = skbuff_copy(msg, len, count, conn->mtu, skb, dev);
+	if (unlikely(err < 0)) {
+		kfree_skb(skb);
+		BT_DBG("skbuff copy %d failed", err);
+		return ERR_PTR(err);
+	}
+
+	return skb;
+}
+
 static int conn_send(struct l2cap_conn *conn,
 			void *msg, size_t len, u32 priority,
 			struct net_device *dev)
 {
-	struct sk_buff *skb = {0};
+	struct sk_buff *skb;
+
+	skb = create_pdu(conn, msg, len, priority, dev);
+	if (IS_ERR(skb))
+		return -EINVAL;
 
 	do_send(conn, skb);
 	return 0;
 }
 
+static u8 lowpan_compress_addr_64(u8 **hc06_ptr, u8 shift,
+				const struct in6_addr *ipaddr,
+				const unsigned char *lladdr)
+{
+	u8 val = 0;
+
+	if (is_addr_mac_addr_based(ipaddr, lladdr)) {
+		val = 3; /* 0-bits */
+		pr_debug("address compression 0 bits\n");
+	} else if (lowpan_is_iid_16_bit_compressable(ipaddr)) {
+		/* compress IID to 16 bits xxxx::XXXX */
+		memcpy(*hc06_ptr, &ipaddr->s6_addr16[7], 2);
+		*hc06_ptr += 2;
+		val = 2; /* 16-bits */
+		raw_dump_inline(NULL, "Compressed ipv6 addr is (16 bits)",
+			*hc06_ptr - 2, 2);
+	} else {
+		/* do not compress IID => xxxx::IID */
+		memcpy(*hc06_ptr, &ipaddr->s6_addr16[4], 8);
+		*hc06_ptr += 8;
+		val = 1; /* 64-bits */
+		raw_dump_inline(NULL, "Compressed ipv6 addr is (64 bits)",
+			*hc06_ptr - 8, 8);
+	}
+
+	return rol8(val, shift);
+}
+
+static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
+{
+	struct udphdr *uh = udp_hdr(skb);
+
+	if (((uh->source & LOWPAN_NHC_UDP_4BIT_MASK) ==
+				LOWPAN_NHC_UDP_4BIT_PORT) &&
+	    ((uh->dest & LOWPAN_NHC_UDP_4BIT_MASK) ==
+				LOWPAN_NHC_UDP_4BIT_PORT)) {
+		pr_debug("UDP header: both ports compression to 4 bits\n");
+		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_11;
+		**(hc06_ptr + 1) = /* subtraction is faster */
+		   (u8)((uh->dest - LOWPAN_NHC_UDP_4BIT_PORT) +
+		       ((uh->source & LOWPAN_NHC_UDP_4BIT_PORT) << 4));
+		*hc06_ptr += 2;
+	} else if ((uh->dest & LOWPAN_NHC_UDP_8BIT_MASK) ==
+			LOWPAN_NHC_UDP_8BIT_PORT) {
+		pr_debug("UDP header: remove 8 bits of dest\n");
+		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_01;
+		memcpy(*hc06_ptr + 1, &uh->source, 2);
+		**(hc06_ptr + 3) = (u8)(uh->dest - LOWPAN_NHC_UDP_8BIT_PORT);
+		*hc06_ptr += 4;
+	} else if ((uh->source & LOWPAN_NHC_UDP_8BIT_MASK) ==
+			LOWPAN_NHC_UDP_8BIT_PORT) {
+		pr_debug("UDP header: remove 8 bits of source\n");
+		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_10;
+		memcpy(*hc06_ptr + 1, &uh->dest, 2);
+		**(hc06_ptr + 3) = (u8)(uh->source - LOWPAN_NHC_UDP_8BIT_PORT);
+		*hc06_ptr += 4;
+	} else {
+		pr_debug("UDP header: can't compress\n");
+		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_00;
+		memcpy(*hc06_ptr + 1, &uh->source, 2);
+		memcpy(*hc06_ptr + 3, &uh->dest, 2);
+		*hc06_ptr += 5;
+	}
+
+	/* checksum is always inline */
+	memcpy(*hc06_ptr, &uh->check, 2);
+	*hc06_ptr += 2;
+
+	/* skip the UDP header */
+	skb_pull(skb, sizeof(struct udphdr));
+}
+
+static inline int lowpan_fetch_skb_u8(struct sk_buff *skb, u8 *val)
+{
+	if (unlikely(!pskb_may_pull(skb, 1)))
+		return -EINVAL;
+
+	*val = skb->data[0];
+	skb_pull(skb, 1);
+
+	return 0;
+}
+
+static inline int lowpan_fetch_skb_u16(struct sk_buff *skb, u16 *val)
+{
+	if (unlikely(!pskb_may_pull(skb, 2)))
+		return -EINVAL;
+
+	*val = (skb->data[0] << 8) | skb->data[1];
+	skb_pull(skb, 2);
+
+	return 0;
+}
+
+static void get_dest_bdaddr(struct in6_addr *ip6_daddr,
+			bdaddr_t *addr, u8 *addr_type)
+{
+	u8 *eui64;
+
+	eui64 = ip6_daddr->s6_addr + 8;
+
+	addr->b[0] = eui64[7];
+	addr->b[1] = eui64[6];
+	addr->b[2] = eui64[5];
+	addr->b[3] = eui64[2];
+	addr->b[4] = eui64[1];
+	addr->b[5] = eui64[0];
+
+	addr->b[5] ^= 2;
+
+	/* Set universal/local bit to 0 */
+	if (addr->b[5] & 1) {
+		addr->b[5] &= ~1;
+		*addr_type = BDADDR_LE_PUBLIC;
+	} else
+		*addr_type = BDADDR_LE_RANDOM;
+}
+
+static int header_create(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, const void *_daddr,
+			const void *_saddr, unsigned int len)
+{
+	u8 tmp, iphc0, iphc1, *hc06_ptr;
+	struct lowpan_info *info;
+	struct peer *peer;
+	struct ipv6hdr *hdr;
+	bdaddr_t addr, *any = BDADDR_ANY;
+	u8 *saddr, *daddr = any->b;
+	u8 addr_type;
+	u8 head[100] = {0};
+
+	if (type != ETH_P_IPV6)
+		return -EINVAL;
+
+	hdr = ipv6_hdr(skb);
+	hc06_ptr = head + 2;
+
+	pr_debug("IPv6 header dump:\n\tversion = %d\n\tlength  = %d\n"
+		 "\tnexthdr = 0x%02x\n\thop_lim = %d\n\tdest    = %pI6c\n",
+		hdr->version, ntohs(hdr->payload_len), hdr->nexthdr,
+		hdr->hop_limit, &hdr->daddr);
+
+	raw_dump_table(__func__, "raw skb network header dump",
+		skb_network_header(skb), sizeof(struct ipv6hdr));
+
+	info = lowpan_info(dev);
+
+	if (ipv6_addr_is_multicast(&hdr->daddr)) {
+		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
+						sizeof(struct in6_addr));
+		lowpan_cb(skb)->conn = NULL;
+	} else {
+		/*
+		 * Get destination BT device from skb.
+		 * If there is no such peer then discard the packet.
+		 */
+		get_dest_bdaddr(&hdr->daddr, &addr, &addr_type);
+
+		BT_DBG("dest addr %pMR type %d", &addr, addr_type);
+
+		write_lock(&devices_lock);
+		peer = peer_lookup_ba(info, addr_type, &addr);
+		write_unlock(&devices_lock);
+
+		if (!peer) {
+			BT_DBG("no such peer %pMR found", &addr);
+			return -ENOENT;
+		}
+
+		daddr = peer->eui64_addr;
+
+		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
+						sizeof(struct in6_addr));
+		lowpan_cb(skb)->conn = peer->conn;
+	}
+
+	saddr = info->net->dev_addr;
+
+	raw_dump_inline(__func__, "saddr",
+			(unsigned char *)saddr, 8);
+
+	/*
+	 * As we copy some bit-length fields, in the IPHC encoding bytes,
+	 * we sometimes use |=
+	 * If the field is 0, and the current bit value in memory is 1,
+	 * this does not work. We therefore reset the IPHC encoding here
+	 */
+	iphc0 = LOWPAN_DISPATCH_IPHC;
+	iphc1 = 0;
+
+	/* TODO: context lookup */
+
+	raw_dump_inline(__func__, "daddr",
+			(unsigned char *)daddr, 8);
+
+	raw_dump_table(__func__,
+			"sending raw skb network uncompressed packet",
+			skb->data, skb->len);
+
+	/*
+	 * Traffic class, flow label
+	 * If flow label is 0, compress it. If traffic class is 0, compress it
+	 * We have to process both in the same time as the offset of traffic
+	 * class depends on the presence of version and flow label
+	 */
+
+	/* hc06 format of TC is ECN | DSCP , original one is DSCP | ECN */
+	tmp = (hdr->priority << 4) | (hdr->flow_lbl[0] >> 4);
+	tmp = ((tmp & 0x03) << 6) | (tmp >> 2);
+
+	if (((hdr->flow_lbl[0] & 0x0F) == 0) &&
+	     (hdr->flow_lbl[1] == 0) && (hdr->flow_lbl[2] == 0)) {
+		/* flow label can be compressed */
+		iphc0 |= LOWPAN_IPHC_FL_C;
+		if ((hdr->priority == 0) &&
+		   ((hdr->flow_lbl[0] & 0xF0) == 0)) {
+			/* compress (elide) all */
+			iphc0 |= LOWPAN_IPHC_TC_C;
+		} else {
+			/* compress only the flow label */
+			*hc06_ptr = tmp;
+			hc06_ptr += 1;
+		}
+	} else {
+		/* Flow label cannot be compressed */
+		if ((hdr->priority == 0) &&
+		   ((hdr->flow_lbl[0] & 0xF0) == 0)) {
+			/* compress only traffic class */
+			iphc0 |= LOWPAN_IPHC_TC_C;
+			*hc06_ptr = (tmp & 0xc0) | (hdr->flow_lbl[0] & 0x0F);
+			memcpy(hc06_ptr + 1, &hdr->flow_lbl[1], 2);
+			hc06_ptr += 3;
+		} else {
+			/* compress nothing */
+			memcpy(hc06_ptr, &hdr, 4);
+			/* replace the top byte with new ECN | DSCP format */
+			*hc06_ptr = tmp;
+			hc06_ptr += 4;
+		}
+	}
+
+	/* NOTE: payload length is always compressed */
+
+	/* Next Header is compress if UDP */
+	if (hdr->nexthdr == UIP_PROTO_UDP)
+		iphc0 |= LOWPAN_IPHC_NH_C;
+
+	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0) {
+		*hc06_ptr = hdr->nexthdr;
+		hc06_ptr += 1;
+	}
+
+	/*
+	 * Hop limit
+	 * if 1:   compress, encoding is 01
+	 * if 64:  compress, encoding is 10
+	 * if 255: compress, encoding is 11
+	 * else do not compress
+	 */
+	switch (hdr->hop_limit) {
+	case 1:
+		iphc0 |= LOWPAN_IPHC_TTL_1;
+		break;
+	case 64:
+		iphc0 |= LOWPAN_IPHC_TTL_64;
+		break;
+	case 255:
+		iphc0 |= LOWPAN_IPHC_TTL_255;
+		break;
+	default:
+		*hc06_ptr = hdr->hop_limit;
+		hc06_ptr += 1;
+		break;
+	}
+
+	/* source address compression */
+	if (is_addr_unspecified(&hdr->saddr)) {
+		pr_debug("source address is unspecified, setting SAC\n");
+		iphc1 |= LOWPAN_IPHC_SAC;
+	/* TODO: context lookup */
+	} else if (is_addr_link_local(&hdr->saddr)) {
+		iphc1 |= lowpan_compress_addr_64(&hc06_ptr,
+				LOWPAN_IPHC_SAM_BIT, &hdr->saddr, saddr);
+		pr_debug("source address unicast link-local %pI6c "
+			"iphc1 0x%02x\n", &hdr->saddr, iphc1);
+	} else {
+		pr_debug("send the full source address\n");
+		memcpy(hc06_ptr, &hdr->saddr.s6_addr16[0], 16);
+		hc06_ptr += 16;
+	}
+
+	/* destination address compression */
+	if (is_addr_mcast(&hdr->daddr)) {
+		pr_debug("destination address is multicast: ");
+		iphc1 |= LOWPAN_IPHC_M;
+		if (lowpan_is_mcast_addr_compressable8(&hdr->daddr)) {
+			pr_debug("compressed to 1 octet\n");
+			iphc1 |= LOWPAN_IPHC_DAM_11;
+			/* use last byte */
+			*hc06_ptr = hdr->daddr.s6_addr[15];
+			hc06_ptr += 1;
+		} else if (lowpan_is_mcast_addr_compressable32(&hdr->daddr)) {
+			pr_debug("compressed to 4 octets\n");
+			iphc1 |= LOWPAN_IPHC_DAM_10;
+			/* second byte + the last three */
+			*hc06_ptr = hdr->daddr.s6_addr[1];
+			memcpy(hc06_ptr + 1, &hdr->daddr.s6_addr[13], 3);
+			hc06_ptr += 4;
+		} else if (lowpan_is_mcast_addr_compressable48(&hdr->daddr)) {
+			pr_debug("compressed to 6 octets\n");
+			iphc1 |= LOWPAN_IPHC_DAM_01;
+			/* second byte + the last five */
+			*hc06_ptr = hdr->daddr.s6_addr[1];
+			memcpy(hc06_ptr + 1, &hdr->daddr.s6_addr[11], 5);
+			hc06_ptr += 6;
+		} else {
+			pr_debug("using full address\n");
+			iphc1 |= LOWPAN_IPHC_DAM_00;
+			memcpy(hc06_ptr, &hdr->daddr.s6_addr[0], 16);
+			hc06_ptr += 16;
+		}
+	} else {
+		/* TODO: context lookup */
+		if (is_addr_link_local(&hdr->daddr)) {
+			iphc1 |= lowpan_compress_addr_64(&hc06_ptr,
+				LOWPAN_IPHC_DAM_BIT, &hdr->daddr, daddr);
+			pr_debug("dest address unicast link-local %pI6c "
+				"iphc1 0x%02x\n", &hdr->daddr, iphc1);
+		} else {
+			pr_debug("dest address unicast %pI6c\n", &hdr->daddr);
+			memcpy(hc06_ptr, &hdr->daddr.s6_addr16[0], 16);
+			hc06_ptr += 16;
+		}
+	}
+
+	/* UDP header compression */
+	if (hdr->nexthdr == UIP_PROTO_UDP)
+		compress_udp_header(&hc06_ptr, skb);
+
+	head[0] = iphc0;
+	head[1] = iphc1;
+
+	skb_pull(skb, sizeof(struct ipv6hdr));
+
+	memcpy(skb_push(skb, hc06_ptr - head), head, hc06_ptr - head);
+
+	BT_DBG("header len %d skb %u", (int)(hc06_ptr - head), skb->len);
+
+	skb_reset_network_header(skb);
+
+	raw_dump_table(__func__, "raw skb data dump compressed",
+				skb->data, skb->len);
+	return 0;
+}
+
 /* Packet to BT LE device */
 static int send_pkt(struct l2cap_conn *conn, const void *saddr,
 		const void *daddr, struct sk_buff *skb,
@@ -305,6 +1338,10 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_start_xmit		= xmit,
 };
 
+static struct header_ops header_ops = {
+	.create	= header_create,
+};
+
 static void netdev_setup(struct net_device *dev)
 {
 	dev->addr_len		= EUI64_ADDR_LEN;
@@ -318,6 +1355,7 @@ static void netdev_setup(struct net_device *dev)
 	dev->watchdog_timeo	= 0;
 
 	dev->netdev_ops		= &netdev_ops;
+	dev->header_ops		= &header_ops;
 	dev->destructor		= free_netdev;
 }
 
-- 
1.8.3.1

