Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH v8 4/5] Bluetooth: Enable 6LoWPAN support for BT LE devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386689689-26550-5-git-send-email-jukka.rissanen@linux.intel.com>
Date: Wed, 11 Dec 2013 02:02:09 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <72321562-3727-4040-AECB-456DFC2277E4@holtmann.org>
References: <1386689689-26550-1-git-send-email-jukka.rissanen@linux.intel.com> <1386689689-26550-5-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> This is initial version of
> http://tools.ietf.org/html/draft-ietf-6lo-btle-00
> 
> By default the 6LoWPAN support is not activated and user
> needs to tweak /sys/kernel/debug/bluetooth/hci0/6lowpan
> file.
> 
> The kernel needs IPv6 support before 6LoWPAN is usable.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> include/net/bluetooth/hci.h      |   1 +
> include/net/bluetooth/hci_core.h |   1 +
> include/net/bluetooth/l2cap.h    |   1 +
> net/bluetooth/6lowpan.c          | 880 +++++++++++++++++++++++++++++++++++++++
> net/bluetooth/6lowpan.h          |  26 ++
> net/bluetooth/Makefile           |   6 +-
> net/bluetooth/hci_event.c        |   3 +
> net/bluetooth/l2cap_core.c       |  12 +
> 8 files changed, 929 insertions(+), 1 deletion(-)
> create mode 100644 net/bluetooth/6lowpan.c
> create mode 100644 net/bluetooth/6lowpan.h
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index cc2da73..5dc3d90 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -131,6 +131,7 @@ enum {
> 	HCI_PERIODIC_INQ,
> 	HCI_FAST_CONNECTABLE,
> 	HCI_BREDR_ENABLED,
> +	HCI_6LOWPAN_ENABLED,
> };
> 
> /* A mask for the flags that are supposed to remain when a reset happens
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b796161..f2f0cf5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -448,6 +448,7 @@ enum {
> 	HCI_CONN_SSP_ENABLED,
> 	HCI_CONN_POWER_SAVE,
> 	HCI_CONN_REMOTE_OOB,
> +	HCI_CONN_6LOWPAN,
> };
> 
> static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index e149e99..dbc4a89 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -136,6 +136,7 @@ struct l2cap_conninfo {
> #define L2CAP_FC_L2CAP		0x02
> #define L2CAP_FC_CONNLESS	0x04
> #define L2CAP_FC_A2MP		0x08
> +#define L2CAP_FC_6LOWPAN        0x3e /* reserved and temporary value */
> 
> /* L2CAP Control Field bit masks */
> #define L2CAP_CTRL_SAR			0xC000
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> new file mode 100644
> index 0000000..5da0f99
> --- /dev/null
> +++ b/net/bluetooth/6lowpan.c
> @@ -0,0 +1,880 @@
> +/*
> +   Copyright (c) 2013 Intel Corp.
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 and
> +   only version 2 as published by the Free Software Foundation.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +*/
> +
> +#include <linux/version.h>
> +#include <linux/if_arp.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +
> +#include <net/ipv6.h>
> +#include <net/ip6_route.h>
> +#include <net/addrconf.h>
> +
> +#include <net/af_ieee802154.h> /* to get the address type */
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/l2cap.h>
> +
> +#include "../ieee802154/6lowpan.h" /* for the compression support */
> +
> +#define IFACE_NAME_TEMPLATE "bt%d"
> +#define EUI64_ADDR_LEN 8
> +
> +struct skb_cb {
> +	struct in6_addr addr;
> +	struct l2cap_conn *conn;
> +};
> +#define lowpan_cb(skb) ((struct skb_cb *)((skb)->cb))
> +
> +/*
> + * The devices list contains those devices that we are acting
> + * as a proxy. The BT 6LoWPAN device is a virtual device that
> + * connects to the Bluetooth LE device. The real connection to
> + * BT device is done via l2cap layer. There exists one
> + * virtual device / one BT 6LoWPAN network (=hciX device).
> + * The list contains struct lowpan_dev elements.
> + */
> +static LIST_HEAD(bt_6lowpan_devices);
> +static DEFINE_RWLOCK(devices_lock);
> +
> +struct lowpan_dev {
> +	struct net_device *dev;
> +	struct work_struct delete_netdev;
> +	struct list_head list;
> +};
> +
> +struct lowpan_peer {
> +	struct list_head list;
> +	struct l2cap_conn *conn;
> +
> +	/* peer addresses in various formats */
> +	unsigned char eui64_addr[EUI64_ADDR_LEN];
> +	struct in6_addr peer_addr;
> +};
> +
> +struct lowpan_info {
> +	struct net_device *net;
> +	struct list_head peers;
> +	atomic_t peer_count; /* number of items in peers list */
> +
> +	struct delayed_work notify_peers;
> +};
> +
> +static inline struct lowpan_info *lowpan_info(const struct net_device *dev)
> +{
> +	return netdev_priv(dev);
> +}
> +
> +static inline void peer_add(struct lowpan_info *info, struct lowpan_peer *peer)
> +{
> +	list_add(&peer->list, &info->peers);
> +	atomic_inc(&info->peer_count);
> +}
> +
> +static inline bool peer_del(struct lowpan_info *info, struct lowpan_peer *peer)
> +{
> +	list_del(&peer->list);
> +
> +	if (atomic_dec_and_test(&info->peer_count)) {
> +		BT_DBG("last peer");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static inline struct lowpan_peer *peer_lookup_ba(struct lowpan_info *info,
> +						 bdaddr_t *ba, __u8 type)
> +{
> +	struct lowpan_peer *peer, *tmp;
> +
> +	BT_DBG("peers %d addr %pMR type %d", atomic_read(&info->peer_count),
> +					     ba, type);
> +
> +	list_for_each_entry_safe(peer, tmp, &info->peers, list) {
> +		BT_DBG("addr %pMR type %d",
> +			&peer->conn->hcon->dst, peer->conn->hcon->dst_type);
> +
> +		if (!bacmp(&peer->conn->hcon->dst, ba))
> +			return peer;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline struct lowpan_peer *peer_lookup_conn(struct lowpan_info *info,
> +						   struct l2cap_conn *conn)
> +{
> +	struct lowpan_peer *peer, *tmp;
> +
> +	list_for_each_entry_safe(peer, tmp, &info->peers, list) {
> +		if (peer->conn == conn)
> +			return peer;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct lowpan_peer *lookup_peer(struct l2cap_conn *conn,
> +				       struct lowpan_info **dev)
> +{
> +	struct lowpan_dev *entry, *tmp;
> +	struct lowpan_peer *peer = NULL;
> +	unsigned long flags;
> +
> +	read_lock_irqsave(&devices_lock, flags);
> +
> +	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
> +		struct lowpan_info *info = lowpan_info(entry->dev);
> +
> +		peer = peer_lookup_conn(info, conn);
> +		if (peer) {
> +			if (dev)
> +				*dev = info;
> +			break;
> +		}
> +	}
> +
> +	read_unlock_irqrestore(&devices_lock, flags);
> +
> +	return peer;
> +}
> +
> +/* print data in line */
> +static inline void raw_dump_inline(const char *caller, char *msg,
> +				   unsigned char *buf, int len)
> +{
> +	if (msg)
> +		pr_debug("%s():%s: ", caller, msg);
> +	print_hex_dump_debug("", DUMP_PREFIX_NONE,
> +		       16, 1, buf, len, false);

please fix the indentation here to comply with the coding style.

> +}
> +
> +/*
> + * print data in a table format:
> + *
> + * addr: xx xx xx xx xx xx
> + * addr: xx xx xx xx xx xx
> + * ...
> + */
> +static inline void raw_dump_table(const char *caller, char *msg,
> +				  unsigned char *buf, int len)
> +{
> +	if (msg)
> +		pr_debug("%s():%s:\n", caller, msg);
> +	print_hex_dump_debug("\t", DUMP_PREFIX_OFFSET,
> +		       16, 1, buf, len, false);

Same here.

> +}
> +
> +static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct sk_buff *skb_cp;
> +	int ret;
> +
> +	skb_cp = skb_copy(skb, GFP_ATOMIC);
> +	if (!skb_cp)
> +		return -ENOMEM;
> +
> +	ret = netif_rx(skb_cp);
> +
> +	BT_DBG("receive skb %d", ret);
> +	if (ret < 0)
> +		return NET_RX_DROP;
> +
> +	return ret;
> +}
> +
> +static int process_data(struct sk_buff *skb, struct net_device *dev,
> +			struct l2cap_conn *conn)
> +{
> +	const u8 *saddr, *daddr;
> +	u8 iphc0, iphc1;
> +	struct lowpan_info *info;
> +	struct lowpan_peer *peer;
> +	unsigned long flags;
> +
> +	info = lowpan_info(dev);
> +
> +	read_lock_irqsave(&devices_lock, flags);
> +	peer = peer_lookup_conn(info, conn);
> +	read_unlock_irqrestore(&devices_lock, flags);
> +	if (!peer)
> +		return -EINVAL;

Are we not leaking the skb here?

> +
> +	saddr = peer->eui64_addr;
> +	daddr = info->net->dev_addr;
> +
> +	/* at least two bytes will be used for the encoding */
> +	if (skb->len < 2)
> +		goto drop;
> +
> +	if (lowpan_fetch_skb_u8(skb, &iphc0))
> +		goto drop;
> +
> +	if (lowpan_fetch_skb_u8(skb, &iphc1))
> +		goto drop;
> +
> +	return lowpan_process_data(skb, dev,
> +				saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
> +				daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
> +				iphc0, iphc1, give_skb_to_upper);

The indentation seems wrong here as well.

> +
> +drop:
> +	kfree_skb(skb);
> +	return -EINVAL;
> +}
> +
> +static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> +		    struct l2cap_conn *conn)
> +{
> +	struct sk_buff *local_skb;
> +
> +	if (!netif_running(dev))
> +		goto drop;
> +
> +	if (dev->type != ARPHRD_6LOWPAN)
> +		goto drop;
> +
> +	/* check that it's our buffer */
> +	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
> +		/* Copy the packet so that the IPv6 header is
> +		 * properly aligned.
> +		 */
> +		local_skb = skb_copy_expand(skb, NET_SKB_PAD - 1,
> +					    skb_tailroom(skb), GFP_ATOMIC);
> +		if (!local_skb)
> +			goto drop;
> +
> +		local_skb->protocol = htons(ETH_P_IPV6);
> +		local_skb->pkt_type = PACKET_HOST;
> +
> +		skb_reset_network_header(local_skb);
> +		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
> +
> +		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
> +			kfree_skb(local_skb);
> +			goto drop;
> +		}
> +
> +		dev->stats.rx_bytes += skb->len;
> +		dev->stats.rx_packets++;
> +
> +		kfree_skb(local_skb);
> +		kfree_skb(skb);
> +	} else {
> +		switch (skb->data[0] & 0xe0) {
> +		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> +			local_skb = skb_clone(skb, GFP_ATOMIC);
> +			if (!local_skb)
> +				goto drop;
> +			if (process_data(local_skb, dev, conn)
> +							!= NET_RX_SUCCESS)
> +				goto drop;
> +
> +			dev->stats.rx_bytes += skb->len;
> +			dev->stats.rx_packets++;
> +
> +			kfree_skb(skb);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return NET_RX_SUCCESS;
> +
> +drop:
> +	kfree_skb(skb);
> +	return NET_RX_DROP;
> +}
> +
> +/* Packet from BT LE device */
> +int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	struct lowpan_info *info = NULL;
> +	struct lowpan_peer *peer;
> +	int err;
> +
> +	peer = lookup_peer(conn, &info);
> +	if (!peer)
> +		return -ENOENT;
> +
> +	if (!info->net)
> +		return -ENOENT;
> +
> +	err = recv_pkt(skb, info->net, conn);
> +	BT_DBG("recv pkt %d", err);
> +
> +	return err;
> +}
> +
> +static void do_send(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	BT_DBG("conn %p, skb %p len %d priority %u", conn, skb, skb->len,
> +	       skb->priority);
> +
> +	hci_send_acl(conn->hchan, skb, ACL_START);
> +}
> +
> +static inline int skbuff_copy(void *msg, int len, int count, int mtu,
> +			      struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct sk_buff **frag;
> +	int sent = 0;
> +
> +	memcpy(skb_put(skb, count), msg, count);
> +
> +	sent += count;
> +	msg  += count;
> +	len  -= count;
> +
> +	dev->stats.tx_bytes += count;
> +	dev->stats.tx_packets++;
> +
> +	raw_dump_table(__func__, "Sending", skb->data, skb->len);
> +
> +	/* Continuation fragments (no L2CAP header) */
> +	frag = &skb_shinfo(skb)->frag_list;
> +	while (len > 0) {
> +		struct sk_buff *tmp;
> +
> +		count = min_t(unsigned int, mtu, len);
> +
> +		tmp = bt_skb_alloc(count, GFP_ATOMIC);
> +		if (IS_ERR(tmp))
> +			return PTR_ERR(tmp);
> +
> +		*frag = tmp;
> +
> +		memcpy(skb_put(*frag, count), msg, count);
> +
> +		raw_dump_table(__func__, "Sending fragment",
> +					(*frag)->data, count);

You need to indent this properly.

> +
> +		(*frag)->priority = skb->priority;
> +
> +		sent += count;
> +		msg  += count;
> +		len  -= count;
> +
> +		skb->len += (*frag)->len;
> +		skb->data_len += (*frag)->len;
> +
> +		frag = &(*frag)->next;
> +
> +		dev->stats.tx_bytes += count;
> +		dev->stats.tx_packets++;
> +	}
> +
> +	return sent;
> +}
> +
> +static struct sk_buff *create_pdu(struct l2cap_conn *conn, void *msg,
> +				  size_t len, u32 priority,
> +				  struct net_device *dev)
> +{
> +	struct sk_buff *skb;
> +	int err, count;
> +	struct l2cap_hdr *lh;
> +
> +	/*
> +	 * XXX: This mtu check should be not needed and atm is only used for
> +	 * testing purposes
> +	 */

Please use the correct style for multi-line comments. And I prefer using FIXME instead of XXX.

> +	if (conn->mtu > (L2CAP_LE_MIN_MTU + L2CAP_HDR_SIZE))
> +		conn->mtu = L2CAP_LE_MIN_MTU + L2CAP_HDR_SIZE;
> +
> +	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
> +
> +	BT_DBG("conn %p len %zu mtu %d count %d", conn, len, conn->mtu, count);
> +
> +	skb = bt_skb_alloc(count + L2CAP_HDR_SIZE, GFP_ATOMIC);
> +	if (IS_ERR(skb))
> +		return skb;
> +
> +	skb->priority = priority;
> +
> +	lh = (struct l2cap_hdr *)skb_put(skb, L2CAP_HDR_SIZE);
> +	lh->cid = cpu_to_le16(L2CAP_FC_6LOWPAN);
> +	lh->len = cpu_to_le16(len);
> +
> +	err = skbuff_copy(msg, len, count, conn->mtu, skb, dev);
> +	if (unlikely(err < 0)) {
> +		kfree_skb(skb);
> +		BT_DBG("skbuff copy %d failed", err);
> +		return ERR_PTR(err);
> +	}
> +
> +	return skb;
> +}
> +
> +static int conn_send(struct l2cap_conn *conn,
> +		     void *msg, size_t len, u32 priority,
> +		     struct net_device *dev)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = create_pdu(conn, msg, len, priority, dev);
> +	if (IS_ERR(skb))
> +		return -EINVAL;
> +
> +	do_send(conn, skb);
> +	return 0;
> +}
> +
> +static void get_dest_bdaddr(struct in6_addr *ip6_daddr,
> +			    bdaddr_t *addr, u8 *addr_type)
> +{
> +	u8 *eui64;
> +
> +	eui64 = ip6_daddr->s6_addr + 8;
> +
> +	addr->b[0] = eui64[7];
> +	addr->b[1] = eui64[6];
> +	addr->b[2] = eui64[5];
> +	addr->b[3] = eui64[2];
> +	addr->b[4] = eui64[1];
> +	addr->b[5] = eui64[0];
> +
> +	addr->b[5] ^= 2;
> +
> +	/* Set universal/local bit to 0 */
> +	if (addr->b[5] & 1) {
> +		addr->b[5] &= ~1;
> +		*addr_type = BDADDR_LE_PUBLIC;
> +	} else
> +		*addr_type = BDADDR_LE_RANDOM;

Use else { } here as well. If one branch uses it, both should use it.

> +}
> +
> +static int header_create(struct sk_buff *skb, struct net_device *dev,
> +		         unsigned short type, const void *_daddr,
> +		         const void *_saddr, unsigned int len)
> +{
> +	struct ipv6hdr *hdr;
> +	struct lowpan_info *info;
> +	struct lowpan_peer *peer;
> +	bdaddr_t addr, *any = BDADDR_ANY;
> +	u8 *saddr, *daddr = any->b;
> +	u8 addr_type;
> +
> +	if (type != ETH_P_IPV6)
> +		return -EINVAL;
> +
> +	hdr = ipv6_hdr(skb);
> +
> +	info = lowpan_info(dev);
> +
> +	if (ipv6_addr_is_multicast(&hdr->daddr)) {
> +		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
> +		       sizeof(struct in6_addr));
> +		lowpan_cb(skb)->conn = NULL;
> +	} else {
> +		unsigned long flags;
> +
> +		/*
> +		 * Get destination BT device from skb.
> +		 * If there is no such peer then discard the packet.
> +		 */
> +		get_dest_bdaddr(&hdr->daddr, &addr, &addr_type);
> +
> +		BT_DBG("dest addr %pMR type %d", &addr, addr_type);
> +
> +		read_lock_irqsave(&devices_lock, flags);
> +		peer = peer_lookup_ba(info, &addr, addr_type);
> +		read_unlock_irqrestore(&devices_lock, flags);
> +
> +		if (!peer) {
> +			BT_DBG("no such peer %pMR found", &addr);
> +			return -ENOENT;
> +		}
> +
> +		daddr = peer->eui64_addr;
> +
> +		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
> +						sizeof(struct in6_addr));
> +		lowpan_cb(skb)->conn = peer->conn;
> +	}
> +
> +	saddr = info->net->dev_addr;
> +
> +	return lowpan_header_compress(skb, dev, type, daddr, saddr, len);
> +}
> +
> +/* Packet to BT LE device */
> +static int send_pkt(struct l2cap_conn *conn, const void *saddr,
> +		    const void *daddr, struct sk_buff *skb,
> +		    struct net_device *dev)
> +{
> +	raw_dump_table(__func__, "raw skb data dump before fragmentation",
> +				skb->data, skb->len);

Indentation.

> +
> +	return conn_send(conn, skb->data, skb->len, 0, dev);
> +}
> +
> +static int send_mcast_pkt(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct sk_buff *local_skb;
> +	struct lowpan_dev *entry, *tmp;
> +	int err = 0;
> +	unsigned long flags;
> +
> +	read_lock_irqsave(&devices_lock, flags);
> +
> +	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
> +		struct lowpan_peer *pentry, *ptmp;
> +		struct lowpan_info *info;
> +
> +		if (entry->dev != dev)
> +			continue;
> +
> +		info = lowpan_info(entry->dev);
> +
> +		list_for_each_entry_safe(pentry, ptmp, &info->peers, list) {
> +			local_skb = skb_clone(skb, GFP_ATOMIC);
> +
> +			err = send_pkt(pentry->conn, dev->dev_addr,
> +				       pentry->eui64_addr,
> +				       local_skb, dev);
> +
> +			kfree_skb(local_skb);
> +		}
> +	}
> +
> +	read_unlock_irqrestore(&devices_lock, flags);
> +
> +	return err;
> +}
> +
> +static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	int err = -ENOENT;
> +	unsigned char *eui64_addr;
> +	struct lowpan_info *info;
> +	struct lowpan_peer *peer;
> +	bdaddr_t addr;
> +	u8 addr_type;
> +
> +	if (ipv6_addr_is_multicast(&lowpan_cb(skb)->addr)) {
> +		/*
> +		 * We need to send the packet to every device
> +		 * behind this interface.
> +		 */

Multi-line comment style.

> +		err = send_mcast_pkt(skb, dev);
> +	} else {
> +		unsigned long flags;
> +
> +		get_dest_bdaddr(&lowpan_cb(skb)->addr, &addr, &addr_type);
> +		eui64_addr = lowpan_cb(skb)->addr.s6_addr + 8;
> +		info = lowpan_info(dev);
> +
> +		read_lock_irqsave(&devices_lock, flags);
> +		peer = peer_lookup_ba(info, &addr, addr_type);
> +		read_unlock_irqrestore(&devices_lock, flags);
> +
> +		BT_DBG("xmit from %s to %pMR (%pI6c), peer %p", dev->name,
> +			&addr, &lowpan_cb(skb)->addr, peer);
> +
> +		if (peer && peer->conn)
> +			err = send_pkt(peer->conn, dev->dev_addr, eui64_addr,
> +					skb, dev);
> +	}
> +	dev_kfree_skb(skb);
> +
> +	if (err)
> +		BT_DBG("ERROR: xmit failed (%d)", err);
> +
> +	return (err < 0) ? NET_XMIT_DROP : err;
> +}
> +
> +static const struct net_device_ops netdev_ops = {
> +	.ndo_start_xmit		= bt_xmit,
> +};
> +
> +static struct header_ops header_ops = {
> +	.create	= header_create,
> +};
> +
> +static void netdev_setup(struct net_device *dev)
> +{
> +	dev->addr_len		= EUI64_ADDR_LEN;
> +	dev->type		= ARPHRD_6LOWPAN;
> +
> +	dev->hard_header_len	= 0;
> +	dev->needed_tailroom	= 0;
> +	dev->mtu		= IPV6_MIN_MTU;
> +	dev->tx_queue_len	= 0;
> +	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT;
> +	dev->watchdog_timeo	= 0;
> +
> +	dev->netdev_ops		= &netdev_ops;
> +	dev->header_ops		= &header_ops;
> +	dev->destructor		= free_netdev;
> +}
> +
> +static struct device_type bt_type = {
> +	.name	= "bluetooth",
> +};
> +
> +static void set_addr(u8 *eui, u8 *addr, u8 addr_type)
> +{
> +	/* addr is the BT address in little-endian format */
> +	eui[0] = addr[5];
> +	eui[1] = addr[4];
> +	eui[2] = addr[3];
> +	eui[3] = 0xFF;
> +	eui[4] = 0xFE;
> +	eui[5] = addr[2];
> +	eui[6] = addr[1];
> +	eui[7] = addr[0];
> +
> +	eui[0] ^= 2;
> +
> +	/* Universal/local bit set, RFC 4291 */
> +	if (addr_type == BDADDR_LE_PUBLIC)
> +		eui[0] |= 1;
> +	else
> +		eui[0] &= ~1;
> +}
> +
> +static void set_dev_addr(struct net_device *net, bdaddr_t *addr,
> +		         u8 addr_type)
> +{
> +	net->addr_assign_type = NET_ADDR_PERM;
> +	set_addr(net->dev_addr, addr->b, addr_type);
> +	net->dev_addr[0] ^= 2;
> +}
> +
> +static void ifup(struct net_device *net)
> +{
> +	int err;
> +
> +	rtnl_lock();
> +	err = dev_open(net);
> +	if (err < 0)
> +		BT_INFO("iface %s cannot be opened (%d)", net->name, err);
> +	rtnl_unlock();
> +}
> +
> +static void do_notify_peers(struct work_struct *work)
> +{
> +	struct lowpan_info *info = container_of(work, struct lowpan_info,
> +						notify_peers.work);
> +
> +	netdev_notify_peers(info->net); /* send neighbour adv at startup */
> +}
> +
> +static bool is_bt_6lowpan(struct hci_conn *hcon)
> +{
> +	if (hcon->type != LE_LINK)
> +		return false;
> +
> +	return test_bit(HCI_CONN_6LOWPAN, &hcon->flags);
> +}
> +
> +/*
> + * This gets called when BT LE 6LoWPAN device is connected. We then
> + * create network device that acts as a proxy between BT LE device
> + * and kernel network stack.
> + */
> +int bt_6lowpan_add_conn(struct l2cap_conn *conn)
> +{
> +	struct lowpan_info *dev = NULL;
> +	struct lowpan_peer *peer = NULL;
> +	struct net_device *net;
> +	struct lowpan_dev *entry;
> +	int err = 0;
> +	unsigned long flags;
> +
> +	if (!is_bt_6lowpan(conn->hcon))
> +		return 0;
> +
> +	peer = lookup_peer(conn, &dev);
> +	if (peer)
> +		return -EEXIST;
> +
> +	if (dev && !peer)
> +		goto add_peer;
> +
> +	net = alloc_netdev(sizeof(struct lowpan_info), IFACE_NAME_TEMPLATE,
> +		           netdev_setup);
> +	if (!net)
> +		return -ENOMEM;
> +
> +	dev = netdev_priv(net);
> +	dev->net = net;
> +	INIT_LIST_HEAD(&dev->peers);
> +
> +	set_dev_addr(net, &conn->hcon->src, conn->hcon->src_type);
> +
> +	net->netdev_ops = &netdev_ops;
> +	SET_NETDEV_DEV(net, &conn->hcon->dev);
> +	SET_NETDEV_DEVTYPE(net, &bt_type);
> +
> +	err = register_netdev(net);
> +	if (err < 0) {
> +		BT_INFO("register_netdev failed %d", err);
> +		free_netdev(net);
> +		goto out;
> +	}
> +
> +	BT_DBG("ifindex %d peer bdaddr %pMR my addr %pMR",
> +		net->ifindex, &conn->hcon->dst, &conn->hcon->src);
> +	set_bit(__LINK_STATE_PRESENT, &net->state);
> +
> +	entry = kzalloc(sizeof(struct lowpan_dev), GFP_ATOMIC);
> +	if (!entry) {
> +		unregister_netdev(net);
> +		return -ENOMEM;
> +	}
> +
> +	entry->dev = net;
> +
> +	write_lock_irqsave(&devices_lock, flags);
> +	INIT_LIST_HEAD(&entry->list);
> +	list_add(&entry->list, &bt_6lowpan_devices);
> +	write_unlock_irqrestore(&devices_lock, flags);
> +
> +	ifup(net);
> +
> +add_peer:
> +	peer = kzalloc(sizeof(struct lowpan_peer), GFP_ATOMIC);
> +	if (!peer)
> +		return -ENOMEM;
> +
> +	peer->conn = conn;
> +	memset(&peer->peer_addr, 0, sizeof(struct in6_addr));
> +
> +	/* RFC 2464 ch. 5 */
> +	peer->peer_addr.s6_addr[0] = 0xFE;
> +	peer->peer_addr.s6_addr[1] = 0x80;
> +	set_addr((u8 *)&peer->peer_addr.s6_addr + 8, conn->hcon->dst.b,
> +		conn->hcon->dst_type);
> +
> +	memcpy(&peer->eui64_addr, (u8 *)&peer->peer_addr.s6_addr + 8,
> +		EUI64_ADDR_LEN);
> +	peer->eui64_addr[0] ^= 2; /* second bit-flip (Universe/Local)
> +				   * is done according RFC2464
> +				   */
> +
> +	raw_dump_inline(__func__, "peer IPv6 address",
> +			(unsigned char *)&peer->peer_addr, 16);
> +	raw_dump_inline(__func__, "peer EUI64 address", peer->eui64_addr, 8);
> +
> +	write_lock_irqsave(&devices_lock, flags);
> +	INIT_LIST_HEAD(&peer->list);
> +	peer_add(dev, peer);
> +	write_unlock_irqrestore(&devices_lock, flags);
> +
> +	/*
> +	 * Notifying peers about us needs to be done without locks held
> +	 */

Single line comment.

> +	INIT_DELAYED_WORK(&dev->notify_peers, do_notify_peers);
> +	schedule_delayed_work(&dev->notify_peers, msecs_to_jiffies(100));
> +
> +out:
> +	return err;
> +}
> +
> +static void delete_netdev(struct work_struct *work)
> +{
> +	struct lowpan_dev *entry = container_of(work, struct lowpan_dev,
> +						delete_netdev);
> +
> +	unregister_netdev(entry->dev);
> +
> +	/* The entry pointer is deleted in device_event() */
> +}
> +
> +int bt_6lowpan_del_conn(struct l2cap_conn *conn)
> +{
> +	struct lowpan_dev *entry, *tmp;
> +	struct lowpan_info *info = NULL;
> +	struct lowpan_peer *peer;
> +	int err = -ENOENT;
> +	unsigned long flags;
> +	bool last = false;
> +
> +	if (!is_bt_6lowpan(conn->hcon))
> +		return 0;
> +
> +	write_lock_irqsave(&devices_lock, flags);
> +
> +	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
> +		info = lowpan_info(entry->dev);
> +		peer = peer_lookup_conn(info, conn);
> +		if (peer) {
> +			last = peer_del(info, peer);
> +			err = 0;
> +			break;
> +		}
> +	}
> +
> +	if (!err && last && info && !atomic_read(&info->peer_count)) {
> +		write_unlock_irqrestore(&devices_lock, flags);
> +
> +		cancel_delayed_work_sync(&info->notify_peers);
> +
> +		/*
> +		 * bt_6lowpan_del_conn() is called with hci dev lock held which
> +		 * means that we must delete the netdevice in worker thread.
> +		 */

Multi-line comment style.

> +		INIT_WORK(&entry->delete_netdev, delete_netdev);
> +		schedule_work(&entry->delete_netdev);
> +	} else
> +		write_unlock_irqrestore(&devices_lock, flags);
> +
> +	return err;
> +}
> +
> +static int device_event(struct notifier_block *unused,
> +			unsigned long event, void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct lowpan_dev *entry, *tmp;
> +	unsigned long flags;
> +
> +	if (dev->type != ARPHRD_6LOWPAN)
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_UNREGISTER:
> +		write_lock_irqsave(&devices_lock, flags);
> +		list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices,
> +					list) {
> +			if (entry->dev == dev) {
> +				list_del(&entry->list);
> +				kfree(entry);
> +				break;
> +			}
> +		}
> +		write_unlock_irqrestore(&devices_lock, flags);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block bt_6lowpan_dev_notifier = {
> +	.notifier_call = device_event,
> +};
> +
> +int bt_6lowpan_init(void)
> +{
> +	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
> +}
> +
> +void bt_6lowpan_cleanup(void)
> +{
> +	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
> +}
> diff --git a/net/bluetooth/6lowpan.h b/net/bluetooth/6lowpan.h
> new file mode 100644
> index 0000000..680eac8
> --- /dev/null
> +++ b/net/bluetooth/6lowpan.h
> @@ -0,0 +1,26 @@
> +/*
> +   Copyright (c) 2013 Intel Corp.
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 and
> +   only version 2 as published by the Free Software Foundation.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +*/
> +
> +#ifndef __6LOWPAN_H
> +#define __6LOWPAN_H
> +
> +#include <linux/skbuff.h>
> +#include <net/bluetooth/l2cap.h>
> +
> +int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb);
> +int bt_6lowpan_add_conn(struct l2cap_conn *conn);
> +int bt_6lowpan_del_conn(struct l2cap_conn *conn);
> +int bt_6lowpan_init(void);
> +void bt_6lowpan_cleanup(void);
> +
> +#endif /* __6LOWPAN_H */
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index 6a791e7..cc6827e 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -10,6 +10,10 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
> 
> bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
> 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
> -	a2mp.o amp.o
> +	a2mp.o amp.o 6lowpan.o
> +
> +ifeq ($(CONFIG_IEEE802154_6LOWPAN),)
> +  bluetooth-y +=  ../ieee802154/6lowpan_iphc.o
> +endif
> 
> subdir-ccflags-y += -D__CHECK_ENDIAN__
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 5fb3df6..5f81245 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3533,6 +3533,9 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	conn->handle = __le16_to_cpu(ev->handle);
> 	conn->state = BT_CONNECTED;
> 
> +	if (test_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags))
> +		set_bit(HCI_CONN_6LOWPAN, &conn->flags);
> +
> 	hci_conn_add_sysfs(conn);
> 
> 	hci_proto_connect_cfm(conn, ev->status);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ae0054c..e97248d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -40,6 +40,7 @@
> #include "smp.h"
> #include "a2mp.h"
> #include "amp.h"
> +#include "6lowpan.h"
> 
> bool disable_ertm;
> 
> @@ -1468,6 +1469,8 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
> 
> 	BT_DBG("");
> 
> +	bt_6lowpan_add_conn(conn);
> +
> 	/* Check if we have socket listening on cid */
> 	pchan = l2cap_global_chan_by_scid(BT_LISTEN, L2CAP_CID_ATT,
> 					  &hcon->src, &hcon->dst);
> @@ -7093,6 +7096,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
> 			l2cap_conn_del(conn->hcon, EACCES);
> 		break;
> 
> +	case L2CAP_FC_6LOWPAN:
> +		bt_6lowpan_recv(conn, skb);
> +		break;
> +
> 	default:
> 		l2cap_data_channel(conn, cid, skb);
> 		break;
> @@ -7160,6 +7167,8 @@ void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
> {
> 	BT_DBG("hcon %p reason %d", hcon, reason);
> 
> +	bt_6lowpan_del_conn(hcon->l2cap_data);
> +
> 	l2cap_conn_del(hcon, bt_to_errno(reason));
> }
> 
> @@ -7441,11 +7450,14 @@ int __init l2cap_init(void)
> 	debugfs_create_u16("l2cap_le_default_mps", 0466, bt_debugfs,
> 			   &le_default_mps);
> 
> +	bt_6lowpan_init();
> +
> 	return 0;
> }
> 
> void l2cap_exit(void)
> {
> +	bt_6lowpan_cleanup();
> 	debugfs_remove(l2cap_debugfs);
> 	l2cap_cleanup_sockets();
> }

Regards

Marcel

