Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 5/8] Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400837248-12179-6-git-send-email-jukka.rissanen@linux.intel.com>
Date: Sat, 24 May 2014 22:04:12 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BF841E7C-706C-42C4-BEA6-E2A6C64066CE@holtmann.org>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com> <1400837248-12179-6-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Create a CoC dynamically instead of one fixed channel for communication
> to peer devices.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> include/net/bluetooth/hci.h   |   1 -
> include/net/bluetooth/l2cap.h |   1 -
> net/bluetooth/6lowpan.c       | 757 +++++++++++++++++++++++++++++++-----------
> net/bluetooth/6lowpan.h       |  47 ---
> net/bluetooth/hci_core.c      |  46 +--
> net/bluetooth/hci_event.c     |   3 -
> net/bluetooth/l2cap_core.c    |  19 +-
> 7 files changed, 575 insertions(+), 299 deletions(-)
> delete mode 100644 net/bluetooth/6lowpan.h
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 16587dc..3f95aba 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -139,7 +139,6 @@ enum {
> 	HCI_PERIODIC_INQ,
> 	HCI_FAST_CONNECTABLE,
> 	HCI_BREDR_ENABLED,
> -	HCI_6LOWPAN_ENABLED,
> 	HCI_LE_SCAN_INTERRUPTED,
> };

we also need to make sure to remove the flag from hci_conn.

> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 3980b81..510c6ab 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -137,7 +137,6 @@ struct l2cap_conninfo {
> #define L2CAP_FC_L2CAP		0x02
> #define L2CAP_FC_CONNLESS	0x04
> #define L2CAP_FC_A2MP		0x08
> -#define L2CAP_FC_6LOWPAN        0x3e /* reserved and temporary value */
> 
> /* L2CAP Control Field bit masks */
> #define L2CAP_CTRL_SAR			0xC000
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index adb3ea0..3390b7b 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -1,5 +1,5 @@
> /*
> -   Copyright (c) 2013 Intel Corp.
> +   Copyright (c) 2013-2014 Intel Corp.
> 
>    This program is free software; you can redistribute it and/or modify
>    it under the terms of the GNU General Public License version 2 and
> @@ -14,6 +14,7 @@
> #include <linux/if_arp.h>
> #include <linux/netdevice.h>
> #include <linux/etherdevice.h>
> +#include <linux/debugfs.h>
> 
> #include <net/ipv6.h>
> #include <net/ip6_route.h>
> @@ -25,16 +26,20 @@
> #include <net/bluetooth/hci_core.h>
> #include <net/bluetooth/l2cap.h>
> 
> -#include "6lowpan.h"
> -
> #include "../ieee802154/6lowpan.h" /* for the compression support */
> 
> +#define VERSION "1.0"
> +
> +static struct dentry *lowpan_debugfs;
> +static struct l2cap_chan *chan_create(struct l2cap_conn *conn);
> +
> #define IFACE_NAME_TEMPLATE "bt%d"
> #define EUI64_ADDR_LEN 8
> 
> struct skb_cb {
> 	struct in6_addr addr;
> -	struct l2cap_conn *conn;
> +	struct l2cap_chan *chan;
> +	int status;
> };
> #define lowpan_cb(skb) ((struct skb_cb *)((skb)->cb))
> 
> @@ -48,9 +53,15 @@ struct skb_cb {
> static LIST_HEAD(bt_6lowpan_devices);
> static DEFINE_RWLOCK(devices_lock);
> 
> +/* If psm is set to 0 (default value), then 6lowpan is disabled.
> + * Other values are used to indicate a Protocol Service Multiplexer
> + * value for 6lowpan.
> + */
> +static u16 psm_6lowpan;
> +
> struct lowpan_peer {
> 	struct list_head list;
> -	struct l2cap_conn *conn;
> +	struct l2cap_chan *chan;
> 
> 	/* peer addresses in various formats */
> 	unsigned char eui64_addr[EUI64_ADDR_LEN];
> @@ -101,13 +112,26 @@ static inline struct lowpan_peer *peer_lookup_ba(struct lowpan_dev *dev,
> 	       ba, type);
> 
> 	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
> -		BT_DBG("addr %pMR type %d",
> -		       &peer->conn->hcon->dst, peer->conn->hcon->dst_type);
> +		BT_DBG("dst addr %pMR dst type %d",
> +		       &peer->chan->dst, peer->chan->dst_type);
> 
> -		if (bacmp(&peer->conn->hcon->dst, ba))
> +		if (bacmp(&peer->chan->dst, ba))
> 			continue;
> 
> -		if (type == peer->conn->hcon->dst_type)
> +		if (type == peer->chan->dst_type)
> +			return peer;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline struct lowpan_peer *peer_lookup_chan(struct lowpan_dev *dev,
> +						   struct l2cap_chan *chan)
> +{
> +	struct lowpan_peer *peer, *tmp;
> +
> +	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
> +		if (peer->chan == chan)
> 			return peer;
> 	}
> 
> @@ -120,7 +144,7 @@ static inline struct lowpan_peer *peer_lookup_conn(struct lowpan_dev *dev,
> 	struct lowpan_peer *peer, *tmp;
> 
> 	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
> -		if (peer->conn == conn)
> +		if (peer->chan->conn == conn)
> 			return peer;
> 	}
> 
> @@ -185,7 +209,7 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
> }
> 
> static int process_data(struct sk_buff *skb, struct net_device *netdev,
> -			struct l2cap_conn *conn)
> +			struct l2cap_chan *chan)
> {
> 	const u8 *saddr, *daddr;
> 	u8 iphc0, iphc1;
> @@ -196,7 +220,7 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
> 	dev = lowpan_dev(netdev);
> 
> 	read_lock_irqsave(&devices_lock, flags);
> -	peer = peer_lookup_conn(dev, conn);
> +	peer = peer_lookup_chan(dev, chan);
> 	read_unlock_irqrestore(&devices_lock, flags);
> 	if (!peer)
> 		goto drop;
> @@ -225,7 +249,7 @@ drop:
> }
> 
> static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> -		    struct l2cap_conn *conn)
> +		    struct l2cap_chan *chan)
> {
> 	struct sk_buff *local_skb;
> 	int ret;
> @@ -269,7 +293,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> 			if (!local_skb)
> 				goto drop;
> 
> -			ret = process_data(local_skb, dev, conn);
> +			ret = process_data(local_skb, dev, chan);
> 			if (ret != NET_RX_SUCCESS)
> 				goto drop;
> 
> @@ -286,140 +310,33 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> 	return NET_RX_SUCCESS;
> 
> drop:
> +	dev->stats.rx_dropped++;
> 	kfree_skb(skb);
> 	return NET_RX_DROP;
> }
> 
> /* Packet from BT LE device */
> -int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb)
> +static int bt_6lowpan_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
> {
> 	struct lowpan_dev *dev;
> 	struct lowpan_peer *peer;
> 	int err;
> 
> -	peer = lookup_peer(conn);
> +	peer = lookup_peer(chan->conn);
> 	if (!peer)
> 		return -ENOENT;
> 
> -	dev = lookup_dev(conn);
> +	dev = lookup_dev(chan->conn);
> 	if (!dev || !dev->netdev)
> 		return -ENOENT;
> 
> -	err = recv_pkt(skb, dev->netdev, conn);
> +	err = recv_pkt(skb, dev->netdev, chan);
> +
> 	BT_DBG("recv pkt %d", err);
> 
> 	return err;
> }
> 
> -static inline int skbuff_copy(void *msg, int len, int count, int mtu,
> -			      struct sk_buff *skb, struct net_device *dev)
> -{
> -	struct sk_buff **frag;
> -	int sent = 0;
> -
> -	memcpy(skb_put(skb, count), msg, count);
> -
> -	sent += count;
> -	msg  += count;
> -	len  -= count;
> -
> -	dev->stats.tx_bytes += count;
> -	dev->stats.tx_packets++;
> -
> -	raw_dump_table(__func__, "Sending", skb->data, skb->len);
> -
> -	/* Continuation fragments (no L2CAP header) */
> -	frag = &skb_shinfo(skb)->frag_list;
> -	while (len > 0) {
> -		struct sk_buff *tmp;
> -
> -		count = min_t(unsigned int, mtu, len);
> -
> -		tmp = bt_skb_alloc(count, GFP_ATOMIC);
> -		if (!tmp)
> -			return -ENOMEM;
> -
> -		*frag = tmp;
> -
> -		memcpy(skb_put(*frag, count), msg, count);
> -
> -		raw_dump_table(__func__, "Sending fragment",
> -			       (*frag)->data, count);
> -
> -		(*frag)->priority = skb->priority;
> -
> -		sent += count;
> -		msg  += count;
> -		len  -= count;
> -
> -		skb->len += (*frag)->len;
> -		skb->data_len += (*frag)->len;
> -
> -		frag = &(*frag)->next;
> -
> -		dev->stats.tx_bytes += count;
> -		dev->stats.tx_packets++;
> -	}
> -
> -	return sent;
> -}
> -
> -static struct sk_buff *create_pdu(struct l2cap_conn *conn, void *msg,
> -				  size_t len, u32 priority,
> -				  struct net_device *dev)
> -{
> -	struct sk_buff *skb;
> -	int err, count;
> -	struct l2cap_hdr *lh;
> -
> -	/* FIXME: This mtu check should be not needed and atm is only used for
> -	 * testing purposes
> -	 */
> -	if (conn->mtu > (L2CAP_LE_MIN_MTU + L2CAP_HDR_SIZE))
> -		conn->mtu = L2CAP_LE_MIN_MTU + L2CAP_HDR_SIZE;
> -
> -	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
> -
> -	BT_DBG("conn %p len %zu mtu %d count %d", conn, len, conn->mtu, count);
> -
> -	skb = bt_skb_alloc(count + L2CAP_HDR_SIZE, GFP_ATOMIC);
> -	if (!skb)
> -		return ERR_PTR(-ENOMEM);
> -
> -	skb->priority = priority;
> -
> -	lh = (struct l2cap_hdr *)skb_put(skb, L2CAP_HDR_SIZE);
> -	lh->cid = cpu_to_le16(L2CAP_FC_6LOWPAN);
> -	lh->len = cpu_to_le16(len);
> -
> -	err = skbuff_copy(msg, len, count, conn->mtu, skb, dev);
> -	if (unlikely(err < 0)) {
> -		kfree_skb(skb);
> -		BT_DBG("skbuff copy %d failed", err);
> -		return ERR_PTR(err);
> -	}
> -
> -	return skb;
> -}
> -
> -static int conn_send(struct l2cap_conn *conn,
> -		     void *msg, size_t len, u32 priority,
> -		     struct net_device *dev)
> -{
> -	struct sk_buff *skb;
> -
> -	skb = create_pdu(conn, msg, len, priority, dev);
> -	if (IS_ERR(skb))
> -		return -EINVAL;
> -
> -	BT_DBG("conn %p skb %p len %d priority %u", conn, skb, skb->len,
> -	       skb->priority);
> -
> -	hci_send_acl(conn->hchan, skb, ACL_START);
> -
> -	return 0;
> -}
> -
> static void get_dest_bdaddr(struct in6_addr *ip6_daddr,
> 			    bdaddr_t *addr, u8 *addr_type)
> {
> @@ -466,7 +383,7 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
> 	if (ipv6_addr_is_multicast(&hdr->daddr)) {
> 		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
> 		       sizeof(struct in6_addr));
> -		lowpan_cb(skb)->conn = NULL;
> +		lowpan_cb(skb)->chan = NULL;
> 	} else {
> 		unsigned long flags;
> 
> @@ -490,7 +407,7 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
> 
> 		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
> 		       sizeof(struct in6_addr));
> -		lowpan_cb(skb)->conn = peer->conn;
> +		lowpan_cb(skb)->chan = peer->chan;
> 	}
> 
> 	saddr = dev->netdev->dev_addr;
> @@ -499,14 +416,32 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
> }
> 
> /* Packet to BT LE device */
> -static int send_pkt(struct l2cap_conn *conn, const void *saddr,
> -		    const void *daddr, struct sk_buff *skb,
> +static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
> 		    struct net_device *netdev)
> {
> -	raw_dump_table(__func__, "raw skb data dump before fragmentation",
> -		       skb->data, skb->len);
> +	int err;
> +
> +	/* Remember the skb so that we can send EAGAIN to the caller if
> +	 * we run out of credits.
> +	 */
> +	chan->data = skb;
> +
> +	err = l2cap_chan_send(chan, skb->data, skb->len, 0, 0);
> +	if (err > 0) {
> +		netdev->stats.tx_bytes += err;
> +		netdev->stats.tx_packets++;
> +		err = 0;
> +	} else if (err <= 0) {
> +		if (err == 0)
> +			err = lowpan_cb(skb)->status;
> +
> +		if (err == -EAGAIN)
> +			netdev->stats.tx_dropped++;
> +		else if (err < 0)
> +			netdev->stats.tx_errors++;
> +	}
> 
> -	return conn_send(conn, skb->data, skb->len, 0, netdev);
> +	return err;
> }
> 
> static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
> @@ -529,8 +464,7 @@ static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
> 		list_for_each_entry_safe(pentry, ptmp, &dev->peers, list) {
> 			local_skb = skb_clone(skb, GFP_ATOMIC);
> 
> -			send_pkt(pentry->conn, netdev->dev_addr,
> -				 pentry->eui64_addr, local_skb, netdev);
> +			send_pkt(pentry->chan, local_skb, netdev);
> 
> 			kfree_skb(local_skb);
> 		}
> @@ -542,7 +476,6 @@ static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
> static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
> {
> 	int err = 0;
> -	unsigned char *eui64_addr;
> 	struct lowpan_dev *dev;
> 	struct lowpan_peer *peer;
> 	bdaddr_t addr;
> @@ -557,7 +490,6 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
> 		unsigned long flags;
> 
> 		get_dest_bdaddr(&lowpan_cb(skb)->addr, &addr, &addr_type);
> -		eui64_addr = lowpan_cb(skb)->addr.s6_addr + 8;
> 		dev = lowpan_dev(netdev);
> 
> 		read_lock_irqsave(&devices_lock, flags);
> @@ -567,9 +499,10 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
> 		BT_DBG("xmit from %s to %pMR (%pI6c) peer %p", netdev->name,
> 		       &addr, &lowpan_cb(skb)->addr, peer);
> 
> -		if (peer && peer->conn)
> -			err = send_pkt(peer->conn, netdev->dev_addr,
> -				       eui64_addr, skb, netdev);
> +		if (peer && peer->chan)
> +			err = send_pkt(peer->chan, skb, netdev);
> +		else
> +			err = -ENOENT;
> 	}
> 	dev_kfree_skb(skb);
> 
> @@ -661,26 +594,46 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
> 	if (hcon->type != LE_LINK)
> 		return false;
> 
> -	return test_bit(HCI_CONN_6LOWPAN, &hcon->flags);
> +	if (!psm_6lowpan)
> +		return false;
> +
> +	return true;
> }
> 
> -static int add_peer_conn(struct l2cap_conn *conn, struct lowpan_dev *dev)
> +static struct l2cap_chan *chan_open(struct l2cap_chan *pchan)
> +{
> +	struct l2cap_chan *chan;
> +
> +	chan = chan_create(pchan->conn);
> +	if (!chan)
> +		return NULL;
> +
> +	chan->remote_mps = chan->omtu;
> +	chan->mps = chan->omtu;
> +
> +	chan->state = BT_CONNECTED;
> +
> +	return chan;
> +}
> +
> +static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
> +					struct lowpan_dev *dev)
> {
> 	struct lowpan_peer *peer;
> 	unsigned long flags;
> 
> 	peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
> 	if (!peer)
> -		return -ENOMEM;
> +		return NULL;
> 
> -	peer->conn = conn;
> +	peer->chan = chan;
> 	memset(&peer->peer_addr, 0, sizeof(struct in6_addr));
> 
> 	/* RFC 2464 ch. 5 */
> 	peer->peer_addr.s6_addr[0] = 0xFE;
> 	peer->peer_addr.s6_addr[1] = 0x80;
> -	set_addr((u8 *)&peer->peer_addr.s6_addr + 8, conn->hcon->dst.b,
> -	         conn->hcon->dst_type);
> +	set_addr((u8 *)&peer->peer_addr.s6_addr + 8, chan->dst.b,
> +		 chan->dst_type);
> 
> 	memcpy(&peer->eui64_addr, (u8 *)&peer->peer_addr.s6_addr + 8,
> 	       EUI64_ADDR_LEN);
> @@ -701,40 +654,24 @@ static int add_peer_conn(struct l2cap_conn *conn, struct lowpan_dev *dev)
> 	INIT_DELAYED_WORK(&dev->notify_peers, do_notify_peers);
> 	schedule_delayed_work(&dev->notify_peers, msecs_to_jiffies(100));
> 
> -	return 0;
> +	return peer->chan;
> }
> 
> -/* This gets called when BT LE 6LoWPAN device is connected. We then
> - * create network device that acts as a proxy between BT LE device
> - * and kernel network stack.
> - */
> -int bt_6lowpan_add_conn(struct l2cap_conn *conn)
> +static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
> {
> -	struct lowpan_peer *peer = NULL;
> -	struct lowpan_dev *dev;
> 	struct net_device *netdev;
> 	int err = 0;
> 	unsigned long flags;
> 
> -	if (!is_bt_6lowpan(conn->hcon))
> -		return 0;
> -
> -	peer = lookup_peer(conn);
> -	if (peer)
> -		return -EEXIST;
> -
> -	dev = lookup_dev(conn);
> -	if (dev)
> -		return add_peer_conn(conn, dev);
> -
> -	netdev = alloc_netdev(sizeof(*dev), IFACE_NAME_TEMPLATE, netdev_setup);
> +	netdev = alloc_netdev(sizeof(struct lowpan_dev), IFACE_NAME_TEMPLATE,
> +			      netdev_setup);
> 	if (!netdev)
> 		return -ENOMEM;
> 
> -	set_dev_addr(netdev, &conn->hcon->src, conn->hcon->src_type);
> +	set_dev_addr(netdev, &chan->src, chan->src_type);
> 
> 	netdev->netdev_ops = &netdev_ops;
> -	SET_NETDEV_DEV(netdev, &conn->hcon->dev);
> +	SET_NETDEV_DEV(netdev, &chan->conn->hcon->dev);
> 	SET_NETDEV_DEVTYPE(netdev, &bt_type);
> 
> 	err = register_netdev(netdev);
> @@ -744,28 +681,54 @@ int bt_6lowpan_add_conn(struct l2cap_conn *conn)
> 		goto out;
> 	}
> 
> -	BT_DBG("ifindex %d peer bdaddr %pMR my addr %pMR",
> -	       netdev->ifindex, &conn->hcon->dst, &conn->hcon->src);
> +	BT_DBG("ifindex %d peer bdaddr %pMR type %d my addr %pMR type %d",
> +	       netdev->ifindex, &chan->dst, chan->dst_type,
> +	       &chan->src, chan->src_type);
> 	set_bit(__LINK_STATE_PRESENT, &netdev->state);
> 
> -	dev = netdev_priv(netdev);
> -	dev->netdev = netdev;
> -	dev->hdev = conn->hcon->hdev;
> -	INIT_LIST_HEAD(&dev->peers);
> +	*dev = netdev_priv(netdev);
> +	(*dev)->netdev = netdev;
> +	(*dev)->hdev = chan->conn->hcon->hdev;
> +	INIT_LIST_HEAD(&(*dev)->peers);
> 
> 	write_lock_irqsave(&devices_lock, flags);
> -	INIT_LIST_HEAD(&dev->list);
> -	list_add(&dev->list, &bt_6lowpan_devices);
> +	INIT_LIST_HEAD(&(*dev)->list);
> +	list_add(&(*dev)->list, &bt_6lowpan_devices);
> 	write_unlock_irqrestore(&devices_lock, flags);
> 
> -	ifup(netdev);
> -
> -	return add_peer_conn(conn, dev);
> +	return 0;
> 
> out:
> 	return err;
> }
> 
> +static inline void bt_6lowpan_chan_ready_cb(struct l2cap_chan *chan)
> +{
> +	struct lowpan_dev *dev;
> +
> +	dev = lookup_dev(chan->conn);
> +
> +	BT_DBG("chan %p conn %p dev %p", chan, chan->conn, dev);
> +
> +	if (!dev) {
> +		if (setup_netdev(chan, &dev) < 0) {
> +			l2cap_chan_del(chan, -ENOENT);
> +			return;
> +		}
> +	}
> +
> +	add_peer_chan(chan, dev);
> +	ifup(dev->netdev);
> +}
> +
> +static inline
> +struct l2cap_chan *bt_6lowpan_chan_new_connection_cb(struct l2cap_chan *chan)
> +{
> +	BT_DBG("chan %p", chan);
> +
> +	return chan_open(chan);
> +}
> +
> static void delete_netdev(struct work_struct *work)
> {
> 	struct lowpan_dev *entry = container_of(work, struct lowpan_dev,
> @@ -776,26 +739,39 @@ static void delete_netdev(struct work_struct *work)
> 	/* The entry pointer is deleted in device_event() */
> }
> 
> -int bt_6lowpan_del_conn(struct l2cap_conn *conn)
> +static void bt_6lowpan_chan_close_cb(struct l2cap_chan *chan)
> {
> 	struct lowpan_dev *entry, *tmp;
> 	struct lowpan_dev *dev = NULL;
> 	struct lowpan_peer *peer;
> 	int err = -ENOENT;
> 	unsigned long flags;
> -	bool last = false;
> +	bool last = false, removed = true;
> +
> +	BT_DBG("chan %p conn %p", chan, chan->conn);
> 
> -	if (!conn || !is_bt_6lowpan(conn->hcon))
> -		return 0;
> +	if (chan->conn && chan->conn->hcon) {
> +		if (!is_bt_6lowpan(chan->conn->hcon))
> +			return;
> +
> +		/*
> +		 * If conn is set, then the netdev is also there and we should
> +		 * not remove it.
> +		 */
> +		removed = false;
> +	}
> 
> 	write_lock_irqsave(&devices_lock, flags);
> 
> 	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
> 		dev = lowpan_dev(entry->netdev);
> -		peer = peer_lookup_conn(dev, conn);
> +		peer = peer_lookup_chan(dev, chan);
> 		if (peer) {
> 			last = peer_del(dev, peer);
> 			err = 0;
> +			BT_DBG("dev %p removing %speer %p", dev,
> +			       last ? "last " : "1 ", peer);
> +			kfree(peer);
> 			break;
> 		}
> 	}
> @@ -805,18 +781,407 @@ int bt_6lowpan_del_conn(struct l2cap_conn *conn)
> 
> 		cancel_delayed_work_sync(&dev->notify_peers);
> 
> -		/* bt_6lowpan_del_conn() is called with hci dev lock held which
> -		 * means that we must delete the netdevice in worker thread.
> -		 */
> -		INIT_WORK(&entry->delete_netdev, delete_netdev);
> -		schedule_work(&entry->delete_netdev);
> +		if (!removed) {
> +			INIT_WORK(&entry->delete_netdev, delete_netdev);
> +			schedule_work(&entry->delete_netdev);
> +		}
> 	} else {
> 		write_unlock_irqrestore(&devices_lock, flags);
> 	}
> 
> +	return;
> +}
> +
> +static void bt_6lowpan_chan_state_change_cb(struct l2cap_chan *chan, int state,
> +					    int err)
> +{
> +	BT_DBG("chan %p conn %p", chan, chan->conn);
> +}
> +
> +static struct sk_buff *bt_6lowpan_chan_alloc_skb_cb(struct l2cap_chan *chan,
> +						    unsigned long len, int nb)
> +{
> +	return bt_skb_alloc(len, GFP_ATOMIC);

Does this have to be GFP_ATOMIC?

> +}
> +
> +static void bt_6lowpan_chan_suspend_cb(struct l2cap_chan *chan)
> +{
> +	struct sk_buff *skb = chan->data;
> +
> +	BT_DBG("chan %p conn %p skb %p", chan, chan->conn, skb);
> +
> +	lowpan_cb(skb)->status = -EAGAIN;
> +}
> +
> +static void bt_6lowpan_chan_resume_cb(struct l2cap_chan *chan)
> +{
> +	struct sk_buff *skb = chan->data;
> +
> +	BT_DBG("chan %p conn %p skb %p", chan, chan->conn, skb);
> +
> +	lowpan_cb(skb)->status = 0;
> +}
> +
> +static long bt_l2cap_chan_get_sndtimeo(struct l2cap_chan *chan)
> +{
> +	return msecs_to_jiffies(1000);
> +}
> +
> +static void bt_6lowpan_chan_teardown_cb(struct l2cap_chan *chan, int err)
> +{
> +	BT_DBG("chan %p conn %p err %d", chan, chan->conn, err);
> +}
> +
> +static struct l2cap_ops bt_6lowpan_chan_ops = {
> +	.name = "L2CAP 6LoWPAN channel",
> +	.new_connection = bt_6lowpan_chan_new_connection_cb,
> +	.recv = bt_6lowpan_chan_recv_cb,
> +	.teardown = bt_6lowpan_chan_teardown_cb,
> +	.close = bt_6lowpan_chan_close_cb,
> +	.state_change = bt_6lowpan_chan_state_change_cb,
> +	.ready = bt_6lowpan_chan_ready_cb,
> +	.resume = bt_6lowpan_chan_resume_cb,
> +	.suspend = bt_6lowpan_chan_suspend_cb,
> +	.get_sndtimeo = bt_l2cap_chan_get_sndtimeo,
> +	.alloc_skb = bt_6lowpan_chan_alloc_skb_cb,
> +
> +	.defer = l2cap_chan_no_defer,
> +	.set_shutdown = l2cap_chan_no_set_shutdown,
> +};
> +
> +static struct l2cap_chan *chan_create(struct l2cap_conn *conn)
> +{
> +	struct l2cap_chan *chan;
> +
> +	chan = l2cap_chan_create();
> +	if (!chan)
> +		return NULL;
> +
> +	l2cap_chan_set_defaults(chan);
> +
> +	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
> +	chan->mode = L2CAP_MODE_LE_FLOWCTL;
> +	chan->omtu = 65535;
> +	chan->imtu = chan->omtu;
> +	chan->ops = &bt_6lowpan_chan_ops;
> +
> +	return chan;
> +}
> +
> +static struct l2cap_chan *bt_6lowpan_channel_create(struct l2cap_conn *conn)
> +{
> +	struct lowpan_peer *peer;
> +
> +	if (!is_bt_6lowpan(conn->hcon))
> +		return NULL;
> +
> +	BT_DBG("conn %p", conn);
> +
> +	peer = lookup_peer(conn);
> +	if (peer) {
> +		BT_DBG("6LoWPAN connection and channel already exists");
> +		return NULL;
> +	}
> +
> +	return chan_create(conn);
> +}
> +
> +static inline __u8 bdaddr_type(__u8 link_type, __u8 type)
> +{
> +	if (link_type == LE_LINK) {
> +		if (type == ADDR_LE_DEV_PUBLIC)
> +			return BDADDR_LE_PUBLIC;
> +		else
> +			return BDADDR_LE_RANDOM;
> +	}
> +
> +	return BDADDR_BREDR;
> +}

This is a bit weird since we only have 6loWPAN support defined for LE links. We might need to just fail early one and then just check the address type.

> +
> +static int bt_6lowpan_connect(struct l2cap_conn *conn, u8 dst_type)
> +{
> +	struct hci_conn *hcon = conn->hcon;
> +	struct l2cap_chan *pchan;
> +	int err;
> +
> +	BT_DBG("conn %p dst %pMR type %d user %d", conn, &hcon->dst,
> +	       hcon->dst_type, dst_type);
> +
> +	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst, hcon->dst_type))
> +		return -EACCES;

Is this handling correct here? I think the hci_blacklist part should be handled inside hci_core and not in the 6loWPAN module. My thinking is that it should be handled before it reaches L2CAP connect.

> +
> +	pchan = bt_6lowpan_channel_create(conn);
> +	if (!pchan)
> +		return -EINVAL;
> +
> +	err = l2cap_chan_connect(pchan, cpu_to_le16(psm_6lowpan), 0,
> +				 &hcon->dst, dst_type);
> +
> +	BT_DBG("chan %p err %d", pchan, err);
> +
> 	return err;
> }
> 
> +static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
> +{
> +	struct lowpan_peer *peer;
> +
> +	BT_DBG("conn %p dst type %d", conn, dst_type);
> +
> +	peer = lookup_peer(conn);
> +	if (!peer)
> +		return -ENOENT;
> +
> +	l2cap_chan_close(peer->chan, ENOENT);
> +
> +	return 0;
> +}
> +
> +static int bt_6lowpan_listen(struct l2cap_conn *conn)
> +{
> +	struct hci_conn *hcon = conn->hcon;
> +	struct l2cap_chan *pchan;
> +	int err;
> +
> +	if (!conn)
> +		return -ENOENT;
> +
> +	pchan = bt_6lowpan_channel_create(conn);
> +	if (!pchan)
> +		return -ENOENT;
> +
> +	pchan->state = BT_LISTEN;
> +	pchan->src_type = bdaddr_type(hcon->type, hcon->src_type);
> +
> +	BT_DBG("psm 0x%04x chan %p src type %d", psm_6lowpan, pchan,
> +	       pchan->src_type);
> +
> +	err = l2cap_add_psm(pchan, &hcon->src,
> +			    cpu_to_le16(psm_6lowpan));
> +	if (err) {
> +		BT_ERR("psm cannot be added err %d", err);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int get_l2cap_conn(struct hci_dev *hdev, char *buf,
> +			  bdaddr_t *addr, u8 *addr_type,
> +			  struct l2cap_conn **conn)
> +{
> +	struct hci_conn *hcon;
> +	int n;
> +
> +	n = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
> +		   &addr->b[5], &addr->b[4], &addr->b[3],
> +		   &addr->b[2], &addr->b[1], &addr->b[0],
> +		   addr_type);
> +
> +	if (n < 7)
> +		return -EINVAL;
> +
> +	hci_dev_lock(hdev);
> +	hcon = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
> +	hci_dev_unlock(hdev);
> +
> +	if (!hcon)
> +		return -ENOENT;
> +
> +	*conn = (struct l2cap_conn *)hcon->l2cap_data;
> +
> +	BT_DBG("conn %p dst %pMR type %d", *conn, &hcon->dst, hcon->dst_type);
> +
> +	return 0;
> +}
> +
> +static void disconnect_all_peers(struct hci_dev *hdev)
> +{
> +	struct lowpan_dev *entry, *tmp_dev;
> +	struct lowpan_peer *peer, *tmp_peer, *new_peer;
> +	struct list_head peers;
> +	unsigned long flags;
> +
> +	INIT_LIST_HEAD(&peers);
> +
> +	/* We make a separate list of peers as the close_cb() will
> +	 * modify the device peers list so it is better not to mess
> +	 * with the same list at the same time.
> +	 */
> +
> +	hci_dev_lock(hdev);
> +
> +	read_lock_irqsave(&devices_lock, flags);
> +
> +	list_for_each_entry_safe(entry, tmp_dev, &bt_6lowpan_devices, list) {
> +		list_for_each_entry_safe(peer, tmp_peer, &entry->peers, list) {
> +			new_peer = kmalloc(sizeof(*new_peer), GFP_ATOMIC);
> +			if (!new_peer)
> +				break;
> +
> +			new_peer->chan = peer->chan;
> +			INIT_LIST_HEAD(&new_peer->list);
> +
> +			list_add(&new_peer->list, &peers);
> +		}
> +	}
> +
> +	read_unlock_irqrestore(&devices_lock, flags);
> +
> +	hci_dev_unlock(hdev);
> +
> +	list_for_each_entry_safe(peer, tmp_peer, &peers, list) {
> +		l2cap_chan_close(peer->chan, ENOENT);
> +		kfree(peer);
> +	}
> +}
> +
> +static ssize_t lowpan_write(struct file *fp, const char __user *user_buffer,
> +			    size_t count, loff_t *position)
> +{
> +	struct seq_file *f = fp->private_data;
> +	struct hci_dev *hdev = f->private;
> +	char buf[32];
> +	size_t buf_size = min(count, sizeof(buf) - 1);
> +	int ret;
> +	bdaddr_t addr;
> +	u8 addr_type;
> +	struct l2cap_conn *conn;
> +
> +	if (copy_from_user(buf, user_buffer, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +
> +	if (memcmp(buf, "psm ", 4) == 0) {
> +		unsigned long value;
> +		u16 psm;
> +
> +		ret = kstrtoul(&buf[4], 0, &value);
> +		if (ret < 0)
> +			return ret;
> +
> +		psm = value;
> +		if (psm == 0 || psm_6lowpan != psm)
> +			/* Disconnect existing connections if 6lowpan is
> +			 * disabled (psm = 0), or if psm changes.
> +			 */
> +			disconnect_all_peers(hdev);
> +
> +		psm_6lowpan = psm;
> +
> +		return count;
> +	}

I get the feeling that we should have one 6lowpan_psm debugfs entry and another one 6lowpan_control.

> +
> +	if (memcmp(buf, "connect ", 8) == 0) {
> +
> +		ret = get_l2cap_conn(hdev, &buf[8], &addr, &addr_type, &conn);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = bt_6lowpan_connect(conn, addr_type);
> +		if (ret < 0)
> +			return ret;
> +
> +		return count;
> +	}
> +
> +	if (memcmp(buf, "disconnect ", 11) == 0) {
> +
> +		ret = get_l2cap_conn(hdev, &buf[11], &addr, &addr_type, &conn);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = bt_6lowpan_disconnect(conn, addr_type);
> +		if (ret < 0)
> +			return ret;
> +
> +		return count;
> +	}
> +
> +	return count;
> +}
> +
> +static int lowpan_show(struct seq_file *f, void *ptr)
> +{
> +	struct hci_dev *hdev = f->private;
> +	struct lowpan_dev *entry, *tmp_dev;
> +	struct lowpan_peer *peer, *tmp_peer;
> +	unsigned long flags;
> +
> +	seq_printf(f, "psm %u\n", psm_6lowpan);

This one makes it even more clearer that the 6lowpan_psm should be its own debugfs file.

> +
> +	hci_dev_lock(hdev);
> +	read_lock_irqsave(&devices_lock, flags);
> +
> +	list_for_each_entry_safe(entry, tmp_dev, &bt_6lowpan_devices, list) {
> +		list_for_each_entry_safe(peer, tmp_peer, &entry->peers, list)
> +			seq_printf(f, "%pMR (type %u)\n",
> +				   &peer->chan->dst, peer->chan->dst_type);
> +	}
> +
> +	read_unlock_irqrestore(&devices_lock, flags);
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}
> +
> +static int lowpan_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, lowpan_show, inode->i_private);
> +}
> +
> +static const struct file_operations lowpan_debugfs_fops = {
> +	.open		= lowpan_open,
> +	.read		= seq_read,
> +	.write		= lowpan_write,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +struct lowpan_check {
> +	struct hci_dev *hdev;
> +	struct work_struct setup_6lowpan;
> +};
> +
> +static void setup_6lowpan(struct work_struct *work)
> +{
> +	struct lowpan_check *check = container_of(work, struct lowpan_check,
> +						  setup_6lowpan);
> +	struct hci_dev *hdev = check->hdev;
> +
> +	kfree(check);
> +
> +	lowpan_debugfs = debugfs_create_file("6lowpan", 0644, hdev->debugfs,
> +					     hdev, &lowpan_debugfs_fops);

You can not use hdev->debugfs here. That is per HCI device. The 6loWPAN debugfs entries should be just global for all devices. Use bt_debugfs here.

Not to mention that you create it twice if you are attaching two controllers to the same system. This will just break horrible.

> +}
> +
> +static void lowpan_connect_hcon(struct hci_conn *hcon)
> +{
> +	struct l2cap_conn *conn = hcon->l2cap_data;
> +
> +	if (!conn || !psm_6lowpan)
> +		return;
> +
> +	bt_6lowpan_listen(conn);
> +}
> +
> +static void lowpan_create_hci(struct hci_dev *hdev)
> +{
> +	struct lowpan_check *check;
> +
> +	check = kmalloc(sizeof(struct lowpan_check), GFP_ATOMIC);
> +	if (!check)
> +		return;
> +
> +	BT_DBG("hdev %p", hdev);
> +
> +	check->hdev = hdev;
> +
> +	INIT_WORK(&check->setup_6lowpan, setup_6lowpan);
> +	schedule_work(&check->setup_6lowpan);
> +}
> +
> static int device_event(struct notifier_block *unused,
> 			unsigned long event, void *ptr)
> {
> @@ -849,12 +1214,24 @@ static struct notifier_block bt_6lowpan_dev_notifier = {
> 	.notifier_call = device_event,
> };
> 
> +static struct hci_cb lowpan_cb = {
> +	.name		= "6LoWPAN",
> +	.create_cfm	= lowpan_create_hci,
> +	.connect_cfm	= lowpan_connect_hcon,
> +};
> +
> int bt_6lowpan_init(void)
> {
> +	hci_register_cb(&lowpan_cb);
> +

Yep. You need to create the 6loWPAN debugfs entries here. Otherwise you can not configure it until the controller is there.

> 	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
> }
> 
> void bt_6lowpan_cleanup(void)
> {
> +	debugfs_remove(lowpan_debugfs);

If you ever attach/remove/attach a controller or attach a second controller, this is your memory leak of the debugfs dentry right here.

> +
> +	hci_unregister_cb(&lowpan_cb);
> +
> 	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
> }

Regards

Marcel

