Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [RFC v4 3/6] Bluetooth: Initial skeleton code for BT 6LoWPAN
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1384337495-9043-4-git-send-email-jukka.rissanen@linux.intel.com>
Date: Thu, 14 Nov 2013 16:58:52 +0900
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <818ED5A5-9C14-480A-B081-05CEF38E31ED@holtmann.org>
References: <1384337495-9043-1-git-send-email-jukka.rissanen@linux.intel.com> <1384337495-9043-4-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> include/net/bluetooth/l2cap.h |   1 +
> net/bluetooth/6lowpan.c       | 544 ++++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/6lowpan.h       |  26 ++
> net/bluetooth/Makefile        |   2 +-
> net/bluetooth/l2cap_core.c    |  22 +-
> 5 files changed, 593 insertions(+), 2 deletions(-)
> create mode 100644 net/bluetooth/6lowpan.c
> create mode 100644 net/bluetooth/6lowpan.h
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 5132990..c28ac0d 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -133,6 +133,7 @@ struct l2cap_conninfo {
> #define L2CAP_FC_L2CAP		0x02
> #define L2CAP_FC_CONNLESS	0x04
> #define L2CAP_FC_A2MP		0x08
> +#define L2CAP_FC_6LOWPAN        0x3e

can you add a comment here that 0x3e is the reserved value and temporary. Just to make it clear to everybody looking and using this code.

> /* L2CAP Control Field bit masks */
> #define L2CAP_CTRL_SAR			0xC000
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> new file mode 100644
> index 0000000..85754e2
> --- /dev/null
> +++ b/net/bluetooth/6lowpan.c
> @@ -0,0 +1,544 @@
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
> +#include <linux/bitops.h>
> +#include <linux/if_arp.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +
> +#include <net/ipv6.h>
> +#include <net/ip6_route.h>
> +#include <net/addrconf.h>
> +
> +#include <net/af_ieee802154.h>

What are we using this one for? Just curious.

> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/l2cap.h>
> +
> +#include "../ieee802154/6lowpan.h" /* for the compression defines */
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
> +struct peer {

Maybe lowpan_peer is a better name. peer sounds a bit too general.

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
> +	int peer_count;

What are we using the peer_count for? Would a kref be useful?

> +};
> +
> +static inline struct lowpan_info *lowpan_info(const struct net_device *dev)
> +{
> +	return netdev_priv(dev);
> +}
> +
> +static inline void peer_add(struct lowpan_info *info, struct peer *peer)
> +{
> +	list_add(&peer->list, &info->peers);
> +	info->peer_count++;
> +}
> +
> +static inline void peer_del(struct lowpan_info *info, struct peer *peer)
> +{
> +	list_del(&peer->list);
> +	info->peer_count--;
> +	if (info->peer_count < 0) {
> +		BT_ERR("peer count underflow");
> +		info->peer_count = 0;
> +	}
> +}
> +
> +static inline struct peer *peer_lookup_ba(struct lowpan_info *info,
> +						__u8 type, bdaddr_t *ba)

You need to get the coding style fixed here. Please make sure you clean these up.

In addition, I think we used the order of BD_ADDR first and then address type. Check what we do in the core and in SMP. I just want to make sure that we do this consistently.

> +{
> +	struct peer *peer, *tmp;
> +
> +	BT_DBG("peers %d addr %pMR type %d", info->peer_count, ba, type);
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
> +static inline struct peer *peer_lookup_conn(struct lowpan_info *info,
> +						struct l2cap_conn *conn)
> +{
> +	struct peer *peer, *tmp;
> +
> +	list_for_each_entry_safe(peer, tmp, &info->peers, list) {
> +		if (peer->conn == conn)
> +			return peer;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct peer *lookup_peer(struct l2cap_conn *conn,
> +				struct lowpan_info **dev)
> +{
> +	struct lowpan_dev *entry, *tmp;
> +	struct peer *peer = NULL;
> +
> +	write_lock(&devices_lock);
> +
> +	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
> +		struct lowpan_info *info = lowpan_info(entry->dev);
> +
> +		if (dev)
> +			*dev = info;
> +
> +		peer = peer_lookup_conn(info, conn);
> +		if (peer)
> +			break;

Don’t we want to move the *dev assignment only when we find a match?

> +	}
> +
> +	write_unlock(&devices_lock);
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
> +				unsigned char *buf, int len)
> +{
> +	if (msg)
> +		pr_debug("%s():%s:\n", caller, msg);
> +	print_hex_dump_debug("\t", DUMP_PREFIX_OFFSET,
> +		       16, 1, buf, len, false);
> +}
> +
> +static int recv_pkt(struct sk_buff *skb, struct net_device *dev)
> +{
> +	kfree_skb(skb);
> +	return NET_RX_DROP;
> +}
> +
> +/* Packet from BT LE device */
> +int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	struct lowpan_info *info = NULL;
> +	struct peer *peer;
> +	int err = -ENOENT;
> +
> +	peer = lookup_peer(conn, &info);
> +	if (!peer)
> +		return -ENOENT;
> +
> +	if (info && info->net) {
> +		err = recv_pkt(skb, info->net, conn);
> +		BT_DBG("recv pkt %d", err);
> +	}

	} else {
		err = -ENOENT;
	}

And remove the assignment at the top.

Can info really be ever NULL?

> +
> +	return err;
> +}
> +
> +static void do_send(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	BT_DBG("conn %p, skb %p len %d priority %u", conn, skb, skb->len,
> +	       skb->priority);
> +
> +	return;

Remove the return here. That is against the coding style.

> +}
> +
> +static int conn_send(struct l2cap_conn *conn,
> +			void *msg, size_t len, u32 priority,
> +			struct net_device *dev)
> +{
> +	struct sk_buff *skb = {0};

No idea how the {0} works here. I am not sure we really should be doing that. Why do we need that? And how do we ensure that not accidentally call a kfree_skb() on it.

> +
> +	do_send(conn, skb);
> +	return 0;
> +}
> +
> +/* Packet to BT LE device */
> +static int send_pkt(struct l2cap_conn *conn, const void *saddr,
> +		const void *daddr, struct sk_buff *skb,
> +		struct net_device *dev)
> +{
> +	raw_dump_table(__func__, "raw skb data dump before fragmentation",
> +				skb->data, skb->len);
> +
> +	return conn_send(conn, skb->data, skb->len, 0, dev);
> +}

Within this patch, I can not really see the point in having 3 function to just do the send. Hope in the final code it makes sense.

> +
> +static int send_mcast_pkt(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct sk_buff *local_skb;
> +	struct lowpan_dev *entry, *tmp;
> +	int err = 0;
> +
> +	write_lock(&devices_lock);
> +
> +	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
> +		struct peer *pentry, *ptmp;
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
> +					pentry->eui64_addr,
> +					local_skb, dev);
> +
> +			kfree_skb(local_skb);
> +		}
> +	}
> +
> +	write_unlock(&devices_lock);
> +
> +	return err;
> +}
> +
> +static netdev_tx_t xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	int err = -ENOENT;
> +	unsigned char *eui64_addr;
> +	struct lowpan_info *info;
> +	struct peer *peer;
> +	bdaddr_t addr;
> +	u8 addr_type;
> +
> +	if (ipv6_addr_is_multicast(&lowpan_cb(skb)->addr)) {
> +		/*
> +		 * We need to send the packet to every device
> +		 * behind this interface.
> +		 */
> +		err = send_mcast_pkt(skb, dev);
> +	} else {
> +		get_dest_bdaddr(&lowpan_cb(skb)->addr, &addr, &addr_type);
> +		eui64_addr = lowpan_cb(skb)->addr.s6_addr + 8;
> +		info = lowpan_info(dev);
> +
> +		write_lock(&devices_lock);
> +		peer = peer_lookup_ba(info, addr_type, &addr);
> +		write_unlock(&devices_lock);
> +
> +		BT_DBG("xmit from %s to %pMR (%pI6c), peer %p", dev->name,
> +			&addr, &lowpan_cb(skb)->addr, peer);
> +
> +		if (peer && peer->conn)
> +			err = send_pkt(peer->conn,
> +					dev->dev_addr,
> +					eui64_addr,
> +					skb,
> +					dev);

This breaking looks excessive. Do we need it? Does it not fit on two lines?

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
> +	.ndo_start_xmit		= xmit,
> +};
> +
> +static void netdev_setup(struct net_device *dev)
> +{
> +	dev->addr_len		= EUI64_ADDR_LEN;
> +	dev->type		= ARPHRD_RAWIP;
> +
> +	dev->hard_header_len	= 0;
> +	dev->needed_tailroom	= 0;
> +	dev->mtu		= IPV6_MIN_MTU;
> +	dev->tx_queue_len	= 0;
> +	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT;
> +	dev->watchdog_timeo	= 0;
> +
> +	dev->netdev_ops		= &netdev_ops;
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
> +	/*
> +	 * Universal/local bit set, RFC 4291
> +	 */
> +	if (addr_type == BDADDR_LE_PUBLIC)
> +		eui[0] |= 1;
> +	else
> +		eui[0] &= ~1;
> +}
> +
> +static void set_dev_addr(struct net_device *net, bdaddr_t *addr,
> +			u8 addr_type)
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
> +/*
> + * This gets called when BT LE 6LoWPAN device is connected. We then
> + * create network device that acts as a proxy between BT LE device
> + * and kernel network stack.
> + */
> +int bt_6lowpan_add_conn(struct l2cap_conn *conn)
> +{
> +	struct lowpan_info *dev = NULL;
> +	struct peer *peer = NULL;
> +	struct net_device *net;
> +	struct lowpan_dev *entry;
> +	int err = 0;
> +
> +	peer = lookup_peer(conn, &dev);
> +	if (peer)
> +		return -EEXIST;
> +
> +	/*
> +	 * If net device exists already, just add route.
> +	 */
> +	if (dev && !peer)
> +		goto add_peer;
> +
> +	net = alloc_netdev(sizeof(struct lowpan_info), IFACE_NAME_TEMPLATE,
> +			netdev_setup);
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
> +	entry = kzalloc(sizeof(struct lowpan_dev), GFP_KERNEL);
> +	if (!entry) {
> +		unregister_netdev(net);
> +		return -ENOMEM;
> +	}
> +
> +	entry->dev = net;
> +
> +	write_lock(&devices_lock);
> +	INIT_LIST_HEAD(&entry->list);
> +	list_add(&entry->list, &bt_6lowpan_devices);
> +	write_unlock(&devices_lock);
> +
> +	ifup(net);
> +
> +add_peer:
> +	peer = kzalloc(sizeof(struct peer), GFP_KERNEL);
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
> +
> +	write_lock(&devices_lock);
> +	INIT_LIST_HEAD(&peer->list);
> +	peer_add(dev, peer);
> +	write_unlock(&devices_lock);
> +
> +	netdev_notify_peers(dev->net); /* send neighbour adv at startup */
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
> +	struct peer *peer;
> +	int err = -ENOENT;
> +
> +	write_lock(&devices_lock);
> +
> +	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
> +		info = lowpan_info(entry->dev);
> +		peer = peer_lookup_conn(info, conn);
> +		if (peer) {
> +			peer_del(info, peer);
> +			err = 0;
> +			break;
> +		}
> +	}
> +
> +	write_unlock(&devices_lock);
> +
> +	if (!err && info && info->peer_count == 0) {
> +		/*
> +		 * This function is called with hci dev lock held which means
> +		 * that we must delete the netdevice in worker thread.
> +		 */
> +		INIT_WORK(&entry->delete_netdev, delete_netdev);
> +		schedule_work(&entry->delete_netdev);
> +	}
> +
> +	return err;
> +}
> +
> +static int device_event(struct notifier_block *unused,
> +				unsigned long event, void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct lowpan_dev *entry, *tmp;
> +
> +	if (dev->type != ARPHRD_RAWIP)
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_UNREGISTER:
> +		write_lock(&devices_lock);
> +		list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices,
> +					list) {
> +			if (entry->dev == dev) {
> +				list_del(&entry->list);
> +				kfree(entry);
> +				break;
> +			}
> +		}
> +		write_unlock(&devices_lock);
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
> index 6a791e7..80cb215 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -10,6 +10,6 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
> 
> bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
> 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
> -	a2mp.o amp.o
> +	a2mp.o amp.o 6lowpan.o
> 
> subdir-ccflags-y += -D__CHECK_ENDIAN__
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 4af3821..155485f 100644
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
> @@ -6473,6 +6474,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
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
> @@ -6510,6 +6515,11 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
> 	return exact ? lm1 : lm2;
> }
> 
> +static bool is_bt_6lowpan(struct hci_conn *hcon)
> +{
> +	return false;
> +}
> +
> void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
> {
> 	struct l2cap_conn *conn;
> @@ -6518,8 +6528,12 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
> 
> 	if (!status) {
> 		conn = l2cap_conn_add(hcon);
> -		if (conn)
> +		if (conn) {
> 			l2cap_conn_ready(conn);
> +
> +			if (is_bt_6lowpan(hcon))
> +				bt_6lowpan_add_conn(conn);
> +		}

At the end, is this not the only location that checks if 6loWPAN is enabled? I would not bother with the is_bt_6lowpan helper and just do it right away in bt_6lowpan_add_conn.

> 	} else {
> 		l2cap_conn_del(hcon, bt_to_errno(status));
> 	}
> @@ -6540,6 +6554,9 @@ void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
> {
> 	BT_DBG("hcon %p reason %d", hcon, reason);
> 
> +	if (is_bt_6lowpan(hcon))
> +		bt_6lowpan_del_conn(hcon->l2cap_data);
> +

Same here. Do it inside bt_6lowpan_del_conn.

> 	l2cap_conn_del(hcon, bt_to_errno(reason));
> }
> 
> @@ -6817,11 +6834,14 @@ int __init l2cap_init(void)
> 	l2cap_debugfs = debugfs_create_file("l2cap", 0444, bt_debugfs,
> 					    NULL, &l2cap_debugfs_fops);
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

