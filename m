Return-Path: <cyrus@holtmann.org>
Message-ID: <1399384509.2316.28.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH 3/3] Bluetooth: 6LoWPAN: Use connected oriented channel
 instead of fixed one
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 06 May 2014 16:55:09 +0300
In-Reply-To: <0319CACA-1EEC-4928-9C06-688937728B21@holtmann.org>
References: 
	<1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1399282285-32743-4-git-send-email-jukka.rissanen@linux.intel.com>
	 <0319CACA-1EEC-4928-9C06-688937728B21@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ma, 2014-05-05 at 19:11 -0700, Marcel Holtmann wrote:
> Hi Jukka,
> 
> > Create a CoC dynamically instead of one fixed channel for communication
> > to peer devices.
> > 
> > Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> > ---
> > include/net/bluetooth/l2cap.h |   3 +-
> > net/bluetooth/6lowpan.c       | 470 ++++++++++++++++++++++++++----------------
> > net/bluetooth/6lowpan.h       |  19 +-
> > net/bluetooth/l2cap_core.c    |  19 +-
> > 4 files changed, 308 insertions(+), 203 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index 4abdcb2..ddf0b35 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -137,7 +137,6 @@ struct l2cap_conninfo {
> > #define L2CAP_FC_L2CAP		0x02
> > #define L2CAP_FC_CONNLESS	0x04
> > #define L2CAP_FC_A2MP		0x08
> > -#define L2CAP_FC_6LOWPAN        0x3e /* reserved and temporary value */
> > 
> > /* L2CAP Control Field bit masks */
> > #define L2CAP_CTRL_SAR			0xC000
> > @@ -244,6 +243,7 @@ struct l2cap_conn_rsp {
> > #define L2CAP_PSM_SDP		0x0001
> > #define L2CAP_PSM_RFCOMM	0x0003
> > #define L2CAP_PSM_3DSP		0x0021
> > +#define L2CAP_PSM_6LOWPAN	0x003e
> 
> since we have no officially assigned value, please mark this one as temporary as well. It might be actually a good idea to allow providing this value via debugfs.

Sure, via debugfs it is then.

> 
> > 
> > /* channel identifier */
> > #define L2CAP_CID_SIGNALING	0x0001
> > @@ -626,6 +626,7 @@ struct l2cap_conn {
> > 
> > 	struct sk_buff_head	pending_rx;
> > 	struct work_struct	pending_rx_work;
> > +	struct work_struct	pending_6lowpan_work;
> 
> Please start thinking on how we can reach the level that bluetooth_6lowpan.ko can be its own module. So all 6loWPAN specific pieces should be externally to l2cap_conn.

The 6lowpan work_struct was needed so that we do not call 6lowpan stuff
with locking active, so this should probably still be here even if we
have a separate 6lowpan module?

> 
> > 
> > 	__u8			disc_reason;
> > 
> > diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> > index adb3ea0..f885836 100644
> > --- a/net/bluetooth/6lowpan.c
> > +++ b/net/bluetooth/6lowpan.c
> > @@ -1,5 +1,5 @@
> > /*
> > -   Copyright (c) 2013 Intel Corp.
> > +   Copyright (c) 2014 Intel Corp.
> 
> Make it 2013-2014. the 2013 copyright is not magically going away ;)
> 
> > 
> >    This program is free software; you can redistribute it and/or modify
> >    it under the terms of the GNU General Public License version 2 and
> > @@ -29,12 +29,14 @@
> > 
> > #include "../ieee802154/6lowpan.h" /* for the compression support */
> > 
> > +static struct l2cap_chan *chan_create(struct l2cap_conn *conn);
> > +
> > #define IFACE_NAME_TEMPLATE "bt%d"
> > #define EUI64_ADDR_LEN 8
> > 
> > struct skb_cb {
> > 	struct in6_addr addr;
> > -	struct l2cap_conn *conn;
> > +	struct l2cap_chan *chan;
> > };
> > #define lowpan_cb(skb) ((struct skb_cb *)((skb)->cb))
> > 
> > @@ -50,7 +52,7 @@ static DEFINE_RWLOCK(devices_lock);
> > 
> > struct lowpan_peer {
> > 	struct list_head list;
> > -	struct l2cap_conn *conn;
> > +	struct l2cap_chan *chan;
> > 
> > 	/* peer addresses in various formats */
> > 	unsigned char eui64_addr[EUI64_ADDR_LEN];
> > @@ -102,12 +104,26 @@ static inline struct lowpan_peer *peer_lookup_ba(struct lowpan_dev *dev,
> > 
> > 	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
> > 		BT_DBG("addr %pMR type %d",
> > -		       &peer->conn->hcon->dst, peer->conn->hcon->dst_type);
> > +		       &peer->chan->conn->hcon->dst,
> > +		       peer->chan->conn->hcon->dst_type);
> > 
> > -		if (bacmp(&peer->conn->hcon->dst, ba))
> > +		if (bacmp(&peer->chan->conn->hcon->dst, ba))
> > 			continue;
> > 
> > -		if (type == peer->conn->hcon->dst_type)
> > +		if (type == peer->chan->conn->hcon->dst_type)
> > +			return peer;
> > +	}
> 
> I wonder if we need simple accessor helpers for BD_ADDR and BD_ADDR type. The dereference chain looks scary.

Sure


> 
> > +
> > +	return NULL;
> > +}
> > +
> > +static inline struct lowpan_peer *peer_lookup_chan(struct lowpan_dev *dev,
> > +						   struct l2cap_chan *chan)
> > +{
> > +	struct lowpan_peer *peer, *tmp;
> > +
> > +	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
> > +		if (peer->chan == chan)
> > 			return peer;
> > 	}
> > 
> > @@ -120,7 +136,7 @@ static inline struct lowpan_peer *peer_lookup_conn(struct lowpan_dev *dev,
> > 	struct lowpan_peer *peer, *tmp;
> > 
> > 	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
> > -		if (peer->conn == conn)
> > +		if (peer->chan->conn == conn)
> > 			return peer;
> > 	}
> > 
> > @@ -185,7 +201,7 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
> > }
> > 
> > static int process_data(struct sk_buff *skb, struct net_device *netdev,
> > -			struct l2cap_conn *conn)
> > +			struct l2cap_chan *chan)
> > {
> > 	const u8 *saddr, *daddr;
> > 	u8 iphc0, iphc1;
> > @@ -196,7 +212,7 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
> > 	dev = lowpan_dev(netdev);
> > 
> > 	read_lock_irqsave(&devices_lock, flags);
> > -	peer = peer_lookup_conn(dev, conn);
> > +	peer = peer_lookup_chan(dev, chan);
> > 	read_unlock_irqrestore(&devices_lock, flags);
> > 	if (!peer)
> > 		goto drop;
> > @@ -225,7 +241,7 @@ drop:
> > }
> > 
> > static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> > -		    struct l2cap_conn *conn)
> > +		    struct l2cap_chan *chan)
> > {
> > 	struct sk_buff *local_skb;
> > 	int ret;
> > @@ -269,7 +285,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> > 			if (!local_skb)
> > 				goto drop;
> > 
> > -			ret = process_data(local_skb, dev, conn);
> > +			ret = process_data(local_skb, dev, chan);
> > 			if (ret != NET_RX_SUCCESS)
> > 				goto drop;
> > 
> > @@ -291,135 +307,27 @@ drop:
> > }
> > 
> > /* Packet from BT LE device */
> > -int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb)
> > +static int bt_6lowpan_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
> > {
> > 	struct lowpan_dev *dev;
> > 	struct lowpan_peer *peer;
> > 	int err;
> > 
> > -	peer = lookup_peer(conn);
> > +	peer = lookup_peer(chan->conn);
> > 	if (!peer)
> > 		return -ENOENT;
> > 
> > -	dev = lookup_dev(conn);
> > +	dev = lookup_dev(chan->conn);
> > 	if (!dev || !dev->netdev)
> > 		return -ENOENT;
> > 
> > -	err = recv_pkt(skb, dev->netdev, conn);
> > +	err = recv_pkt(skb, dev->netdev, chan);
> > +
> > 	BT_DBG("recv pkt %d", err);
> > 
> > 	return err;
> > }
> > 
> > -static inline int skbuff_copy(void *msg, int len, int count, int mtu,
> > -			      struct sk_buff *skb, struct net_device *dev)
> > -{
> > -	struct sk_buff **frag;
> > -	int sent = 0;
> > -
> > -	memcpy(skb_put(skb, count), msg, count);
> > -
> > -	sent += count;
> > -	msg  += count;
> > -	len  -= count;
> > -
> > -	dev->stats.tx_bytes += count;
> > -	dev->stats.tx_packets++;
> > -
> > -	raw_dump_table(__func__, "Sending", skb->data, skb->len);
> > -
> > -	/* Continuation fragments (no L2CAP header) */
> > -	frag = &skb_shinfo(skb)->frag_list;
> > -	while (len > 0) {
> > -		struct sk_buff *tmp;
> > -
> > -		count = min_t(unsigned int, mtu, len);
> > -
> > -		tmp = bt_skb_alloc(count, GFP_ATOMIC);
> > -		if (!tmp)
> > -			return -ENOMEM;
> > -
> > -		*frag = tmp;
> > -
> > -		memcpy(skb_put(*frag, count), msg, count);
> > -
> > -		raw_dump_table(__func__, "Sending fragment",
> > -			       (*frag)->data, count);
> > -
> > -		(*frag)->priority = skb->priority;
> > -
> > -		sent += count;
> > -		msg  += count;
> > -		len  -= count;
> > -
> > -		skb->len += (*frag)->len;
> > -		skb->data_len += (*frag)->len;
> > -
> > -		frag = &(*frag)->next;
> > -
> > -		dev->stats.tx_bytes += count;
> > -		dev->stats.tx_packets++;
> > -	}
> > -
> > -	return sent;
> > -}
> > -
> > -static struct sk_buff *create_pdu(struct l2cap_conn *conn, void *msg,
> > -				  size_t len, u32 priority,
> > -				  struct net_device *dev)
> > -{
> > -	struct sk_buff *skb;
> > -	int err, count;
> > -	struct l2cap_hdr *lh;
> > -
> > -	/* FIXME: This mtu check should be not needed and atm is only used for
> > -	 * testing purposes
> > -	 */
> > -	if (conn->mtu > (L2CAP_LE_MIN_MTU + L2CAP_HDR_SIZE))
> > -		conn->mtu = L2CAP_LE_MIN_MTU + L2CAP_HDR_SIZE;
> > -
> > -	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
> > -
> > -	BT_DBG("conn %p len %zu mtu %d count %d", conn, len, conn->mtu, count);
> > -
> > -	skb = bt_skb_alloc(count + L2CAP_HDR_SIZE, GFP_ATOMIC);
> > -	if (!skb)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	skb->priority = priority;
> > -
> > -	lh = (struct l2cap_hdr *)skb_put(skb, L2CAP_HDR_SIZE);
> > -	lh->cid = cpu_to_le16(L2CAP_FC_6LOWPAN);
> > -	lh->len = cpu_to_le16(len);
> > -
> > -	err = skbuff_copy(msg, len, count, conn->mtu, skb, dev);
> > -	if (unlikely(err < 0)) {
> > -		kfree_skb(skb);
> > -		BT_DBG("skbuff copy %d failed", err);
> > -		return ERR_PTR(err);
> > -	}
> > -
> > -	return skb;
> > -}
> > -
> > -static int conn_send(struct l2cap_conn *conn,
> > -		     void *msg, size_t len, u32 priority,
> > -		     struct net_device *dev)
> > -{
> > -	struct sk_buff *skb;
> > -
> > -	skb = create_pdu(conn, msg, len, priority, dev);
> > -	if (IS_ERR(skb))
> > -		return -EINVAL;
> > -
> > -	BT_DBG("conn %p skb %p len %d priority %u", conn, skb, skb->len,
> > -	       skb->priority);
> > -
> > -	hci_send_acl(conn->hchan, skb, ACL_START);
> > -
> > -	return 0;
> > -}
> > -
> > static void get_dest_bdaddr(struct in6_addr *ip6_daddr,
> > 			    bdaddr_t *addr, u8 *addr_type)
> > {
> > @@ -466,7 +374,7 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
> > 	if (ipv6_addr_is_multicast(&hdr->daddr)) {
> > 		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
> > 		       sizeof(struct in6_addr));
> > -		lowpan_cb(skb)->conn = NULL;
> > +		lowpan_cb(skb)->chan = NULL;
> > 	} else {
> > 		unsigned long flags;
> > 
> > @@ -490,7 +398,7 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
> > 
> > 		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
> > 		       sizeof(struct in6_addr));
> > -		lowpan_cb(skb)->conn = peer->conn;
> > +		lowpan_cb(skb)->chan = peer->chan;
> > 	}
> > 
> > 	saddr = dev->netdev->dev_addr;
> > @@ -499,14 +407,32 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
> > }
> > 
> > /* Packet to BT LE device */
> > -static int send_pkt(struct l2cap_conn *conn, const void *saddr,
> > +static int send_pkt(struct l2cap_chan *chan, const void *saddr,
> > 		    const void *daddr, struct sk_buff *skb,
> > 		    struct net_device *netdev)
> > {
> > -	raw_dump_table(__func__, "raw skb data dump before fragmentation",
> > -		       skb->data, skb->len);
> > +	struct kvec iv;
> > +	struct msghdr msg;
> > +	int err;
> > +
> > +	iv.iov_base = skb->data;
> > +	iv.iov_len = skb->len;
> > +
> > +	memset(&msg, 0, sizeof(msg));
> > +
> > +	msg.msg_iov = (struct iovec *) &iv;
> > +	msg.msg_iovlen = 1;
> > +
> > +	chan->data = skb->sk;
> 
> This assignment here is scary. Why?

The idea was to remember the senders socket so that we can do the voodoo
magic in suspend cb. I seem to have missed the logic behind the suspend
stuff :(


> 
> > +
> > +	err = l2cap_chan_send(chan, &msg, skb->len, 0);
> 
> so this here pretty much proofs my point. I think l2cap_chan_send needs to change to take a single buffer only. Single vector IOV are pretty much useless. We just push it into a single vector for no apparent reason. Lets just hand over the SKB itself to L2CAP core. Then we even have proper reference counting there.
> 
> > +	if (err > 0) {
> > +		netdev->stats.tx_bytes += err;
> > +		netdev->stats.tx_packets++;
> > +		err = 0;
> > +	}
> > 
> > -	return conn_send(conn, skb->data, skb->len, 0, netdev);
> > +	return err;
> > }
> > 
> > static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
> > @@ -529,7 +455,7 @@ static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
> > 		list_for_each_entry_safe(pentry, ptmp, &dev->peers, list) {
> > 			local_skb = skb_clone(skb, GFP_ATOMIC);
> > 
> > -			send_pkt(pentry->conn, netdev->dev_addr,
> > +			send_pkt(pentry->chan, netdev->dev_addr,
> > 				 pentry->eui64_addr, local_skb, netdev);
> > 
> > 			kfree_skb(local_skb);
> > @@ -567,8 +493,8 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
> > 		BT_DBG("xmit from %s to %pMR (%pI6c) peer %p", netdev->name,
> > 		       &addr, &lowpan_cb(skb)->addr, peer);
> > 
> > -		if (peer && peer->conn)
> > -			err = send_pkt(peer->conn, netdev->dev_addr,
> > +		if (peer && peer->chan)
> > +			err = send_pkt(peer->chan, netdev->dev_addr,
> > 				       eui64_addr, skb, netdev);
> > 	}
> > 	dev_kfree_skb(skb);
> > @@ -664,23 +590,40 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
> > 	return test_bit(HCI_CONN_6LOWPAN, &hcon->flags);
> > }
> > 
> > -static int add_peer_conn(struct l2cap_conn *conn, struct lowpan_dev *dev)
> > +static struct l2cap_chan *chan_open(struct l2cap_chan *pchan)
> > +{
> > +	struct l2cap_chan *chan;
> > +
> > +	chan = chan_create(pchan->conn);
> > +	if (!chan)
> > +		return NULL;
> > +
> > +	chan->remote_mps = chan->omtu;
> > +	chan->mps = chan->omtu;
> > +
> > +	chan->state = BT_CONNECTED;
> > +
> > +	return chan;
> > +}
> > +
> > +static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
> > +					struct lowpan_dev *dev)
> > {
> > 	struct lowpan_peer *peer;
> > 	unsigned long flags;
> > 
> > 	peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
> > 	if (!peer)
> > -		return -ENOMEM;
> > +		return NULL;
> > 
> > -	peer->conn = conn;
> > +	peer->chan = chan;
> > 	memset(&peer->peer_addr, 0, sizeof(struct in6_addr));
> > 
> > 	/* RFC 2464 ch. 5 */
> > 	peer->peer_addr.s6_addr[0] = 0xFE;
> > 	peer->peer_addr.s6_addr[1] = 0x80;
> > -	set_addr((u8 *)&peer->peer_addr.s6_addr + 8, conn->hcon->dst.b,
> > -	         conn->hcon->dst_type);
> > +	set_addr((u8 *)&peer->peer_addr.s6_addr + 8, chan->conn->hcon->dst.b,
> > +	         chan->conn->hcon->dst_type);
> > 
> > 	memcpy(&peer->eui64_addr, (u8 *)&peer->peer_addr.s6_addr + 8,
> > 	       EUI64_ADDR_LEN);
> > @@ -701,33 +644,17 @@ static int add_peer_conn(struct l2cap_conn *conn, struct lowpan_dev *dev)
> > 	INIT_DELAYED_WORK(&dev->notify_peers, do_notify_peers);
> > 	schedule_delayed_work(&dev->notify_peers, msecs_to_jiffies(100));
> > 
> > -	return 0;
> > +	return peer->chan;
> > }
> > 
> > -/* This gets called when BT LE 6LoWPAN device is connected. We then
> > - * create network device that acts as a proxy between BT LE device
> > - * and kernel network stack.
> > - */
> > -int bt_6lowpan_add_conn(struct l2cap_conn *conn)
> > +static int setup_netdev(struct l2cap_conn *conn, struct lowpan_dev **dev)
> > {
> > -	struct lowpan_peer *peer = NULL;
> > -	struct lowpan_dev *dev;
> > 	struct net_device *netdev;
> > 	int err = 0;
> > 	unsigned long flags;
> > 
> > -	if (!is_bt_6lowpan(conn->hcon))
> > -		return 0;
> > -
> > -	peer = lookup_peer(conn);
> > -	if (peer)
> > -		return -EEXIST;
> > -
> > -	dev = lookup_dev(conn);
> > -	if (dev)
> > -		return add_peer_conn(conn, dev);
> > -
> > -	netdev = alloc_netdev(sizeof(*dev), IFACE_NAME_TEMPLATE, netdev_setup);
> > +	netdev = alloc_netdev(sizeof(struct lowpan_dev), IFACE_NAME_TEMPLATE,
> > +			      netdev_setup);
> > 	if (!netdev)
> > 		return -ENOMEM;
> > 
> > @@ -748,24 +675,49 @@ int bt_6lowpan_add_conn(struct l2cap_conn *conn)
> > 	       netdev->ifindex, &conn->hcon->dst, &conn->hcon->src);
> > 	set_bit(__LINK_STATE_PRESENT, &netdev->state);
> > 
> > -	dev = netdev_priv(netdev);
> > -	dev->netdev = netdev;
> > -	dev->hdev = conn->hcon->hdev;
> > -	INIT_LIST_HEAD(&dev->peers);
> > +	*dev = netdev_priv(netdev);
> > +	(*dev)->netdev = netdev;
> > +	(*dev)->hdev = conn->hcon->hdev;
> > +	INIT_LIST_HEAD(&(*dev)->peers);
> > 
> > 	write_lock_irqsave(&devices_lock, flags);
> > -	INIT_LIST_HEAD(&dev->list);
> > -	list_add(&dev->list, &bt_6lowpan_devices);
> > +	INIT_LIST_HEAD(&(*dev)->list);
> > +	list_add(&(*dev)->list, &bt_6lowpan_devices);
> > 	write_unlock_irqrestore(&devices_lock, flags);
> > 
> > -	ifup(netdev);
> > -
> > -	return add_peer_conn(conn, dev);
> > +	return 0;
> > 
> > out:
> > 	return err;
> > }
> > 
> > +static inline void bt_6lowpan_chan_ready_cb(struct l2cap_chan *chan)
> > +{
> > +	struct lowpan_dev *dev;
> > +
> > +	dev = lookup_dev(chan->conn);
> > +
> > +	BT_DBG("chan %p conn %p dev %p", chan, chan->conn, dev);
> > +
> > +	if (!dev) {
> > +		if (setup_netdev(chan->conn, &dev) < 0) {
> > +			l2cap_chan_del(chan, -ENOENT);
> > +			return;
> > +		}
> > +	}
> > +
> > +	add_peer_chan(chan, dev);
> > +	ifup(dev->netdev);
> > +}
> > +
> > +static inline
> > +struct l2cap_chan *bt_6lowpan_chan_new_connection_cb(struct l2cap_chan *chan)
> > +{
> > +	BT_DBG("chan %p", chan);
> > +
> > +	return chan_open(chan);
> > +}
> > +
> > static void delete_netdev(struct work_struct *work)
> > {
> > 	struct lowpan_dev *entry = container_of(work, struct lowpan_dev,
> > @@ -776,26 +728,38 @@ static void delete_netdev(struct work_struct *work)
> > 	/* The entry pointer is deleted in device_event() */
> > }
> > 
> > -int bt_6lowpan_del_conn(struct l2cap_conn *conn)
> > +static void bt_6lowpan_chan_close_cb(struct l2cap_chan *chan)
> > {
> > 	struct lowpan_dev *entry, *tmp;
> > 	struct lowpan_dev *dev = NULL;
> > 	struct lowpan_peer *peer;
> > 	int err = -ENOENT;
> > 	unsigned long flags;
> > -	bool last = false;
> > +	bool last = false, removed = true;
> > +
> > +	BT_DBG("chan %p conn %p", chan, chan->conn);
> > +
> > +	if (chan->conn && chan->conn->hcon) {
> > +		if (!is_bt_6lowpan(chan->conn->hcon))
> > +			return;
> > 
> > -	if (!conn || !is_bt_6lowpan(conn->hcon))
> > -		return 0;
> > +		/*
> > +		 * If conn is set, then the netdev is also there and we should
> > +		 * remove it.
> > +		 */
> > +		removed = false;
> > +	}
> > 
> > 	write_lock_irqsave(&devices_lock, flags);
> > 
> > 	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
> > 		dev = lowpan_dev(entry->netdev);
> > -		peer = peer_lookup_conn(dev, conn);
> > +		peer = peer_lookup_chan(dev, chan);
> > 		if (peer) {
> > 			last = peer_del(dev, peer);
> > 			err = 0;
> > +			BT_DBG("dev %p removing %speer %p", dev,
> > +			       last ? "last " : "1 ", peer);
> > 			break;
> > 		}
> > 	}
> > @@ -805,16 +769,166 @@ int bt_6lowpan_del_conn(struct l2cap_conn *conn)
> > 
> > 		cancel_delayed_work_sync(&dev->notify_peers);
> > 
> > -		/* bt_6lowpan_del_conn() is called with hci dev lock held which
> > -		 * means that we must delete the netdevice in worker thread.
> > -		 */
> > -		INIT_WORK(&entry->delete_netdev, delete_netdev);
> > -		schedule_work(&entry->delete_netdev);
> > +		if (!removed) {
> > +			INIT_WORK(&entry->delete_netdev, delete_netdev);
> > +			schedule_work(&entry->delete_netdev);
> > +		}
> > 	} else {
> > 		write_unlock_irqrestore(&devices_lock, flags);
> > 	}
> > 
> > -	return err;
> > +	return;
> > +}
> > +
> > +static void bt_6lowpan_chan_state_change_cb(struct l2cap_chan *chan, int state,
> > +					    int err)
> > +{
> > +	BT_DBG("chan %p conn %p", chan, chan->conn);
> > +}
> > +
> > +static struct sk_buff *bt_6lowpan_chan_alloc_skb_cb(struct l2cap_chan *chan,
> > +						    unsigned long len, int nb)
> > +{
> > +	return bt_skb_alloc(len, GFP_ATOMIC);
> > +}
> > +
> > +static void bt_6lowpan_chan_suspend_cb(struct l2cap_chan *chan)
> > +{
> > +	struct sock *sk = chan->data;
> > +
> > +	BT_DBG("chan %p conn %p sk %p", chan, chan->conn, sk);
> > +
> > +	if (!sk)
> > +		return;
> > +
> > +	set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
> > +	sk->sk_state_change(sk);
> > +}
> > +
> > +static void bt_6lowpan_chan_resume_cb(struct l2cap_chan *chan)
> > +{
> > +	struct sock *sk = chan->data;
> > +
> > +	BT_DBG("chan %p conn %p sk %p", chan, chan->conn, sk);
> > +
> > +	if (!sk)
> > +		return;
> > +
> > +	clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
> > +	sk->sk_state_change(sk);
> > +}
> 
> Why are you messing with socket states here for suspend/resume. These should be internal states to 6loWPAN since it is essentially there to stall IPv6 packets. Involving the socket makes no sense here. You do now have a socket in the first place. Where is this socket coming from?

Took the similar code from l2cap_sock.c so I seem to have missed the
logic in this voodoo code. I will rework this.

> 
> > +
> > +static long bt_l2cap_chan_get_sndtimeo(struct l2cap_chan *chan)
> > +{
> > +	return msecs_to_jiffies(1000);
> > +}
> 
> Why is this needed. You do not have a socket? Do we have this specific timeout handling with LE L2CAP connection oriented channels? We should default to proper defaults or errors if this is not needed.

Hmm, I clearly remember needing this callback, otherwise the connection
was dropped immediately. I will recheck this one.

> 
> > +
> > +static struct l2cap_ops bt_6lowpan_chan_ops = {
> > +	.name = "L2CAP 6LoWPAN channel",
> > +	.recv = bt_6lowpan_chan_recv_cb,
> > +	.close = bt_6lowpan_chan_close_cb,
> > +	.state_change = bt_6lowpan_chan_state_change_cb,
> > +	.alloc_skb = bt_6lowpan_chan_alloc_skb_cb,
> > +	.new_connection = bt_6lowpan_chan_new_connection_cb,
> > +	.suspend = bt_6lowpan_chan_suspend_cb,
> > +	.resume = bt_6lowpan_chan_resume_cb,
> > +	.ready = bt_6lowpan_chan_ready_cb,
> > +	.get_sndtimeo = bt_l2cap_chan_get_sndtimeo,
> > +
> > +	/* Not implemented for 6LoWPAN */
> > +	.defer = l2cap_chan_no_defer,
> > +	.teardown = l2cap_chan_no_teardown,
> > +	.set_shutdown = l2cap_chan_no_set_shutdown,
> 
> please keep them in order as L2CAP socket does it. No need to mention that they are not implemented. The _no_ version of the empty helpers do that just fine.
> 
> > +};
> > +
> > +static struct l2cap_chan *chan_create(struct l2cap_conn *conn)
> > +{
> > +	struct l2cap_chan *chan;
> > +
> > +	chan = l2cap_chan_create();
> > +	if (!chan)
> > +		return NULL;
> > +
> > +	l2cap_chan_set_defaults(chan);
> > +	skb_queue_head_init(&chan->tx_q);
> 
> I now wonder why the channel creation need to repeat the init of tx_q.

Copied the initialization code from other part of the bt subsystem, so
there might be some cruft left in this part.

> 
> > +
> > +	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
> > +	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
> > +	chan->remote_max_tx = chan->max_tx;
> > +	chan->remote_tx_win = chan->tx_win;
> > +	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
> > +	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
> 
> Do we have to repeat the default here? Isn’t l2cap_chan_set_defaults already doing that?

I will recheck what is needed.


> 
> > +	chan->mode = L2CAP_MODE_LE_FLOWCTL;
> > +	chan->conf_state = 0;
> 
> This one as well. Defaults should be in place. If not we need to fix the other code first to make sure we are clear here. Users of l2cap_ops should be as simple as possible.
> 
> > +	chan->omtu = chan->imtu = 65535;
> 
> Personally I do not like the a = b = c assignments. Just use single assignments here.
> 
> > +	chan->ops = &bt_6lowpan_chan_ops;
> > +
> > +	return chan;
> > +}
> > +
> > +static struct l2cap_chan *bt_6lowpan_channel_create(struct l2cap_conn *conn)
> > +{
> > +	struct lowpan_peer *peer;
> > +
> > +	if (!is_bt_6lowpan(conn->hcon))
> > +		return NULL;
> > +
> > +	BT_DBG("conn %p", conn);
> > +
> > +	peer = lookup_peer(conn);
> > +	if (peer) {
> > +		BT_DBG("6LoWPAN connection and channel already exists");
> > +		return NULL;
> > +	}
> > +
> > +	return chan_create(conn);
> > +}
> > +
> > +static inline __u8 bdaddr_type(struct hci_conn *hcon, __u8 type)
> > +{
> > +	if (hcon->type == LE_LINK) {
> > +		if (type == ADDR_LE_DEV_PUBLIC)
> > +			return BDADDR_LE_PUBLIC;
> > +		else
> > +			return BDADDR_LE_RANDOM;
> > +	}
> > +
> > +	return BDADDR_BREDR;
> > +}
> > +
> > +void bt_6lowpan_check(struct l2cap_conn *conn)
> > +{
> > +	struct hci_conn *hcon = conn->hcon;
> > +	struct l2cap_chan *pchan;
> > +	u8 dst_type;
> > +	int err;
> > +
> > +	dst_type = bdaddr_type(hcon, hcon->dst_type);
> > +
> > +	BT_DBG("conn %p dst type %d", conn, dst_type);
> > +
> > +	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst, dst_type))
> > +		return;
> > +
> > +	pchan = bt_6lowpan_channel_create(conn);
> > +	if (!pchan)
> > +		return;
> > +
> > +	if (test_bit(HCI_CONN_6LOWPAN_ROLE_NODE, &conn->hcon->flags)) {
> > +		pchan->state = BT_LISTEN;
> > +		pchan->src_type = bdaddr_type(hcon, hcon->src_type);
> > +
> > +		err = l2cap_add_psm(pchan, &hcon->src,
> > +				    cpu_to_le16(L2CAP_PSM_6LOWPAN));
> > +		if (err) {
> > +			BT_ERR("psm cannot be added err %d", err);
> > +			return;
> > +		}
> > +	} else {
> > +		err = l2cap_chan_connect(pchan, L2CAP_PSM_6LOWPAN, 0,
> > +					 &hcon->dst, dst_type);
> > +		BT_DBG("chan %p err %d", pchan, err);
> > +	}
> > }
> 
> So I am thinking that just creating the 6loWPAN connection whenever we connect a LE link is not a good idea. Better have a debugfs trigger to manually create it. I am thinking the following:
> 
> 	/sys/kernel/debug/bluetooth/hci0/6lowpan
> 
> 	pam <val>			# sets PSM, 0 for disable (default)
> 	connect <addr> <type>		# connect 6loWPAN channel
> 	disconnect <addr> <type>	# disconnect 6loWPAN channel
> 
> When reading that file it will show you the active 6loWPAN connections. This also means that all the hci_dev and hci_conn flags can go away and it is kept internally inside bluetooth_6lowpan.ko module.

Sure.

> 
> That will be pretty close to an API that we want to expose via mgmt at some point.
> 
> > static int device_event(struct notifier_block *unused,
> > diff --git a/net/bluetooth/6lowpan.h b/net/bluetooth/6lowpan.h
> > index 5d281f1..1ba7af1 100644
> > --- a/net/bluetooth/6lowpan.h
> > +++ b/net/bluetooth/6lowpan.h
> > @@ -1,5 +1,5 @@
> > /*
> > -   Copyright (c) 2013 Intel Corp.
> > +   Copyright (c) 2014 Intel Corp.
> 
> Same as above, 2013-2014.
> 
> > 
> >    This program is free software; you can redistribute it and/or modify
> >    it under the terms of the GNU General Public License version 2 and
> > @@ -19,29 +19,16 @@
> > #include <net/bluetooth/l2cap.h>
> > 
> > #if IS_ENABLED(CONFIG_BT_6LOWPAN)
> > -int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb);
> > -int bt_6lowpan_add_conn(struct l2cap_conn *conn);
> > -int bt_6lowpan_del_conn(struct l2cap_conn *conn);
> > int bt_6lowpan_init(void);
> > void bt_6lowpan_cleanup(void);
> > +void bt_6lowpan_check(struct l2cap_conn *conn);
> > #else
> > -static int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb)
> > -{
> > -	return -EOPNOTSUPP;
> > -}
> > -static int bt_6lowpan_add_conn(struct l2cap_conn *conn)
> > -{
> > -	return -EOPNOTSUPP;
> > -}
> > -int bt_6lowpan_del_conn(struct l2cap_conn *conn)
> > -{
> > -	return -EOPNOTSUPP;
> > -}
> > static int bt_6lowpan_init(void)
> > {
> > 	return -EOPNOTSUPP;
> > }
> > static void bt_6lowpan_cleanup(void) { }
> > +void bt_6lowpan_check(struct l2cap_conn *conn) { }
> > #endif
> 
> With bluetooth_6lowpan.ko this should go away completely.
> 
> > #endif /* __6LOWPAN_H */
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 528b38a..ef46498 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1454,8 +1454,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
> > 
> > 	BT_DBG("");
> > 
> > -	bt_6lowpan_add_conn(conn);
> > -
> > 	/* Check if we have socket listening on cid */
> > 	pchan = l2cap_global_chan_by_scid(BT_LISTEN, L2CAP_CID_ATT,
> > 					  &hcon->src, &hcon->dst);
> > @@ -1530,6 +1528,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
> > 
> > 	mutex_unlock(&conn->chan_lock);
> > 
> > +	queue_work(hcon->hdev->workqueue, &conn->pending_6lowpan_work);
> > 	queue_work(hcon->hdev->workqueue, &conn->pending_rx_work);
> > }
> > 
> > @@ -6945,10 +6944,6 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
> > 			l2cap_conn_del(conn->hcon, EACCES);
> > 		break;
> > 
> > -	case L2CAP_FC_6LOWPAN:
> > -		bt_6lowpan_recv(conn, skb);
> > -		break;
> > -
> > 	default:
> > 		l2cap_data_channel(conn, cid, skb);
> > 		break;
> > @@ -6967,6 +6962,15 @@ static void process_pending_rx(struct work_struct *work)
> > 		l2cap_recv_frame(conn, skb);
> > }
> > 
> > +static void process_pending_6lowpan(struct work_struct *work)
> > +{
> > +	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
> > +					       pending_6lowpan_work);
> > +	BT_DBG("");
> > +
> > +	bt_6lowpan_check(conn);
> > +}
> > +
> > static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
> > {
> > 	struct l2cap_conn *conn = hcon->l2cap_data;
> > @@ -7024,6 +7028,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
> > 
> > 	skb_queue_head_init(&conn->pending_rx);
> > 	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
> > +	INIT_WORK(&conn->pending_6lowpan_work, process_pending_6lowpan);
> > 
> > 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
> > 
> > @@ -7257,8 +7262,6 @@ void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
> > {
> > 	BT_DBG("hcon %p reason %d", hcon, reason);
> > 
> > -	bt_6lowpan_del_conn(hcon->l2cap_data);
> > -
> > 	l2cap_conn_del(hcon, bt_to_errno(reason));
> > }
> 
> Regards
> 
> Marcel
> 


Cheers,
Jukka
