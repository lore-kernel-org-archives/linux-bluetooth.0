Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: 6lowpan: Converting rwlocks to use RCU
Date: Mon, 27 Oct 2014 16:04:41 +0200
Message-Id: <1414418683-1057-2-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1414418683-1057-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1414418683-1057-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The rwlocks are converted to use RCU. This helps performance as the
irq locks are not needed any more.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 222 +++++++++++++++++++++++++++---------------------
 1 file changed, 127 insertions(+), 95 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index aa6ebbf..a681247 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -53,7 +53,7 @@ struct skb_cb {
  * The list contains struct lowpan_dev elements.
  */
 static LIST_HEAD(bt_6lowpan_devices);
-static DEFINE_RWLOCK(devices_lock);
+static DEFINE_SPINLOCK(devices_lock);
 
 /* If psm is set to 0 (default value), then 6lowpan is disabled.
  * Other values are used to indicate a Protocol Service Multiplexer
@@ -67,6 +67,7 @@ static struct l2cap_chan *listen_chan;
 
 struct lowpan_peer {
 	struct list_head list;
+	struct rcu_head rcu;
 	struct l2cap_chan *chan;
 
 	/* peer addresses in various formats */
@@ -86,6 +87,13 @@ struct lowpan_dev {
 	struct delayed_work notify_peers;
 };
 
+static inline void peer_free(struct rcu_head *head)
+{
+	struct lowpan_peer *e = container_of(head, struct lowpan_peer, rcu);
+
+	kfree(e);
+}
+
 static inline struct lowpan_dev *lowpan_dev(const struct net_device *netdev)
 {
 	return netdev_priv(netdev);
@@ -93,13 +101,14 @@ static inline struct lowpan_dev *lowpan_dev(const struct net_device *netdev)
 
 static inline void peer_add(struct lowpan_dev *dev, struct lowpan_peer *peer)
 {
-	list_add(&peer->list, &dev->peers);
+	list_add_rcu(&peer->list, &dev->peers);
 	atomic_inc(&dev->peer_count);
 }
 
 static inline bool peer_del(struct lowpan_dev *dev, struct lowpan_peer *peer)
 {
-	list_del(&peer->list);
+	list_del_rcu(&peer->list);
+	call_rcu(&peer->rcu, peer_free);
 
 	module_put(THIS_MODULE);
 
@@ -114,31 +123,37 @@ static inline bool peer_del(struct lowpan_dev *dev, struct lowpan_peer *peer)
 static inline struct lowpan_peer *peer_lookup_ba(struct lowpan_dev *dev,
 						 bdaddr_t *ba, __u8 type)
 {
-	struct lowpan_peer *peer, *tmp;
+	struct lowpan_peer *peer;
 
 	BT_DBG("peers %d addr %pMR type %d", atomic_read(&dev->peer_count),
 	       ba, type);
 
-	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(peer, &dev->peers, list) {
 		BT_DBG("dst addr %pMR dst type %d",
 		       &peer->chan->dst, peer->chan->dst_type);
 
 		if (bacmp(&peer->chan->dst, ba))
 			continue;
 
-		if (type == peer->chan->dst_type)
+		if (type == peer->chan->dst_type) {
+			rcu_read_unlock();
 			return peer;
+		}
 	}
 
+	rcu_read_unlock();
+
 	return NULL;
 }
 
-static inline struct lowpan_peer *peer_lookup_chan(struct lowpan_dev *dev,
-						   struct l2cap_chan *chan)
+static inline struct lowpan_peer *__peer_lookup_chan(struct lowpan_dev *dev,
+						     struct l2cap_chan *chan)
 {
-	struct lowpan_peer *peer, *tmp;
+	struct lowpan_peer *peer;
 
-	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
+	list_for_each_entry_rcu(peer, &dev->peers, list) {
 		if (peer->chan == chan)
 			return peer;
 	}
@@ -146,12 +161,12 @@ static inline struct lowpan_peer *peer_lookup_chan(struct lowpan_dev *dev,
 	return NULL;
 }
 
-static inline struct lowpan_peer *peer_lookup_conn(struct lowpan_dev *dev,
-						   struct l2cap_conn *conn)
+static inline struct lowpan_peer *__peer_lookup_conn(struct lowpan_dev *dev,
+						     struct l2cap_conn *conn)
 {
-	struct lowpan_peer *peer, *tmp;
+	struct lowpan_peer *peer;
 
-	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
+	list_for_each_entry_rcu(peer, &dev->peers, list) {
 		if (peer->chan->conn == conn)
 			return peer;
 	}
@@ -163,7 +178,7 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_dev *dev,
 						  struct in6_addr *daddr,
 						  struct sk_buff *skb)
 {
-	struct lowpan_peer *peer, *tmp;
+	struct lowpan_peer *peer;
 	struct in6_addr *nexthop;
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	int count = atomic_read(&dev->peer_count);
@@ -174,9 +189,13 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_dev *dev,
 	 * send the packet. If only one peer exists, then we can send the
 	 * packet right away.
 	 */
-	if (count == 1)
-		return list_first_entry(&dev->peers, struct lowpan_peer,
-					list);
+	if (count == 1) {
+		rcu_read_lock();
+		peer = list_first_or_null_rcu(&dev->peers, struct lowpan_peer,
+					      list);
+		rcu_read_unlock();
+		return peer;
+	}
 
 	if (!rt) {
 		nexthop = &lowpan_cb(skb)->gw;
@@ -195,53 +214,57 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_dev *dev,
 
 	BT_DBG("gw %pI6c", nexthop);
 
-	list_for_each_entry_safe(peer, tmp, &dev->peers, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(peer, &dev->peers, list) {
 		BT_DBG("dst addr %pMR dst type %d ip %pI6c",
 		       &peer->chan->dst, peer->chan->dst_type,
 		       &peer->peer_addr);
 
-		if (!ipv6_addr_cmp(&peer->peer_addr, nexthop))
+		if (!ipv6_addr_cmp(&peer->peer_addr, nexthop)) {
+			rcu_read_unlock();
 			return peer;
+		}
 	}
 
+	rcu_read_unlock();
+
 	return NULL;
 }
 
 static struct lowpan_peer *lookup_peer(struct l2cap_conn *conn)
 {
-	struct lowpan_dev *entry, *tmp;
+	struct lowpan_dev *entry;
 	struct lowpan_peer *peer = NULL;
-	unsigned long flags;
 
-	read_lock_irqsave(&devices_lock, flags);
+	rcu_read_lock();
 
-	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
-		peer = peer_lookup_conn(entry, conn);
+	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
+		peer = __peer_lookup_conn(entry, conn);
 		if (peer)
 			break;
 	}
 
-	read_unlock_irqrestore(&devices_lock, flags);
+	rcu_read_unlock();
 
 	return peer;
 }
 
 static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
 {
-	struct lowpan_dev *entry, *tmp;
+	struct lowpan_dev *entry;
 	struct lowpan_dev *dev = NULL;
-	unsigned long flags;
 
-	read_lock_irqsave(&devices_lock, flags);
+	rcu_read_lock();
 
-	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
+	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
 		if (conn->hcon->hdev == entry->hdev) {
 			dev = entry;
 			break;
 		}
 	}
 
-	read_unlock_irqrestore(&devices_lock, flags);
+	rcu_read_unlock();
 
 	return dev;
 }
@@ -264,13 +287,12 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 	u8 iphc0, iphc1;
 	struct lowpan_dev *dev;
 	struct lowpan_peer *peer;
-	unsigned long flags;
 
 	dev = lowpan_dev(netdev);
 
-	read_lock_irqsave(&devices_lock, flags);
-	peer = peer_lookup_chan(dev, chan);
-	read_unlock_irqrestore(&devices_lock, flags);
+	rcu_read_lock();
+	peer = __peer_lookup_chan(dev, chan);
+	rcu_read_unlock();
 	if (!peer)
 		goto drop;
 
@@ -452,7 +474,6 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 	if (ipv6_addr_is_multicast(&ipv6_daddr)) {
 		lowpan_cb(skb)->chan = NULL;
 	} else {
-		unsigned long flags;
 		u8 addr_type;
 
 		/* Get destination BT device from skb.
@@ -463,19 +484,14 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 		BT_DBG("dest addr %pMR type %d IP %pI6c", &addr,
 		       addr_type, &ipv6_daddr);
 
-		read_lock_irqsave(&devices_lock, flags);
 		peer = peer_lookup_ba(dev, &addr, addr_type);
-		read_unlock_irqrestore(&devices_lock, flags);
-
 		if (!peer) {
 			/* The packet might be sent to 6lowpan interface
 			 * because of routing (either via default route
 			 * or user set route) so get peer according to
 			 * the destination address.
 			 */
-			read_lock_irqsave(&devices_lock, flags);
 			peer = peer_lookup_dst(dev, &ipv6_daddr, skb);
-			read_unlock_irqrestore(&devices_lock, flags);
 			if (!peer) {
 				BT_DBG("no such peer %pMR found", &addr);
 				return -ENOENT;
@@ -558,14 +574,13 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct sk_buff *local_skb;
-	struct lowpan_dev *entry, *tmp;
-	unsigned long flags;
+	struct lowpan_dev *entry;
 	int err = 0;
 
-	read_lock_irqsave(&devices_lock, flags);
+	rcu_read_lock();
 
-	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
-		struct lowpan_peer *pentry, *ptmp;
+	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
+		struct lowpan_peer *pentry;
 		struct lowpan_dev *dev;
 
 		if (entry->netdev != netdev)
@@ -573,7 +588,7 @@ static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 
 		dev = lowpan_dev(entry->netdev);
 
-		list_for_each_entry_safe(pentry, ptmp, &dev->peers, list) {
+		list_for_each_entry_rcu(pentry, &dev->peers, list) {
 			int ret;
 
 			local_skb = skb_clone(skb, GFP_ATOMIC);
@@ -590,7 +605,7 @@ static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 		}
 	}
 
-	read_unlock_irqrestore(&devices_lock, flags);
+	rcu_read_unlock();
 
 	return err;
 }
@@ -792,7 +807,6 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 					struct lowpan_dev *dev)
 {
 	struct lowpan_peer *peer;
-	unsigned long flags;
 
 	peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
 	if (!peer)
@@ -815,10 +829,10 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 	 */
 	set_ip_addr_bits(chan->dst_type, (u8 *)&peer->peer_addr.s6_addr + 8);
 
-	write_lock_irqsave(&devices_lock, flags);
+	spin_lock(&devices_lock);
 	INIT_LIST_HEAD(&peer->list);
 	peer_add(dev, peer);
-	write_unlock_irqrestore(&devices_lock, flags);
+	spin_unlock(&devices_lock);
 
 	/* Notifying peers about us needs to be done without locks held */
 	INIT_DELAYED_WORK(&dev->notify_peers, do_notify_peers);
@@ -831,7 +845,6 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 {
 	struct net_device *netdev;
 	int err = 0;
-	unsigned long flags;
 
 	netdev = alloc_netdev(sizeof(struct lowpan_dev), IFACE_NAME_TEMPLATE,
 			      NET_NAME_UNKNOWN, netdev_setup);
@@ -861,10 +874,10 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	(*dev)->hdev = chan->conn->hcon->hdev;
 	INIT_LIST_HEAD(&(*dev)->peers);
 
-	write_lock_irqsave(&devices_lock, flags);
+	spin_lock(&devices_lock);
 	INIT_LIST_HEAD(&(*dev)->list);
-	list_add(&(*dev)->list, &bt_6lowpan_devices);
-	write_unlock_irqrestore(&devices_lock, flags);
+	list_add_rcu(&(*dev)->list, &bt_6lowpan_devices);
+	spin_unlock(&devices_lock);
 
 	return 0;
 
@@ -918,11 +931,10 @@ static void delete_netdev(struct work_struct *work)
 
 static void chan_close_cb(struct l2cap_chan *chan)
 {
-	struct lowpan_dev *entry, *tmp;
+	struct lowpan_dev *entry;
 	struct lowpan_dev *dev = NULL;
 	struct lowpan_peer *peer;
 	int err = -ENOENT;
-	unsigned long flags;
 	bool last = false, removed = true;
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
@@ -937,11 +949,11 @@ static void chan_close_cb(struct l2cap_chan *chan)
 		removed = false;
 	}
 
-	write_lock_irqsave(&devices_lock, flags);
+	spin_lock(&devices_lock);
 
-	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
+	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
 		dev = lowpan_dev(entry->netdev);
-		peer = peer_lookup_chan(dev, chan);
+		peer = __peer_lookup_chan(dev, chan);
 		if (peer) {
 			last = peer_del(dev, peer);
 			err = 0;
@@ -952,13 +964,12 @@ static void chan_close_cb(struct l2cap_chan *chan)
 			       atomic_read(&chan->kref.refcount));
 
 			l2cap_chan_put(chan);
-			kfree(peer);
 			break;
 		}
 	}
 
 	if (!err && last && dev && !atomic_read(&dev->peer_count)) {
-		write_unlock_irqrestore(&devices_lock, flags);
+		spin_unlock(&devices_lock);
 
 		cancel_delayed_work_sync(&dev->notify_peers);
 
@@ -969,7 +980,7 @@ static void chan_close_cb(struct l2cap_chan *chan)
 			schedule_work(&entry->delete_netdev);
 		}
 	} else {
-		write_unlock_irqrestore(&devices_lock, flags);
+		spin_unlock(&devices_lock);
 	}
 
 	return;
@@ -1161,10 +1172,9 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 
 static void disconnect_all_peers(void)
 {
-	struct lowpan_dev *entry, *tmp_dev;
+	struct lowpan_dev *entry;
 	struct lowpan_peer *peer, *tmp_peer, *new_peer;
 	struct list_head peers;
-	unsigned long flags;
 
 	INIT_LIST_HEAD(&peers);
 
@@ -1173,10 +1183,10 @@ static void disconnect_all_peers(void)
 	 * with the same list at the same time.
 	 */
 
-	read_lock_irqsave(&devices_lock, flags);
+	rcu_read_lock();
 
-	list_for_each_entry_safe(entry, tmp_dev, &bt_6lowpan_devices, list) {
-		list_for_each_entry_safe(peer, tmp_peer, &entry->peers, list) {
+	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
+		list_for_each_entry_rcu(peer, &entry->peers, list) {
 			new_peer = kmalloc(sizeof(*new_peer), GFP_ATOMIC);
 			if (!new_peer)
 				break;
@@ -1188,26 +1198,36 @@ static void disconnect_all_peers(void)
 		}
 	}
 
-	read_unlock_irqrestore(&devices_lock, flags);
+	rcu_read_unlock();
 
+	spin_lock(&devices_lock);
 	list_for_each_entry_safe(peer, tmp_peer, &peers, list) {
 		l2cap_chan_close(peer->chan, ENOENT);
-		kfree(peer);
+
+		list_del_rcu(&peer->list);
+		call_rcu(&peer->rcu, peer_free);
+
+		module_put(THIS_MODULE);
 	}
+	spin_unlock(&devices_lock);
 }
 
-static int lowpan_psm_set(void *data, u64 val)
-{
+struct set_psm {
+	struct work_struct work;
 	u16 psm;
+};
 
-	psm = val;
-	if (psm == 0 || psm_6lowpan != psm)
+static void do_psm_set(struct work_struct *work)
+{
+	struct set_psm *set_psm = container_of(work, struct set_psm, work);
+
+	if (set_psm->psm == 0 || psm_6lowpan != set_psm->psm)
 		/* Disconnect existing connections if 6lowpan is
 		 * disabled (psm = 0), or if psm changes.
 		 */
 		disconnect_all_peers();
 
-	psm_6lowpan = psm;
+	psm_6lowpan = set_psm->psm;
 
 	if (listen_chan) {
 		l2cap_chan_close(listen_chan, 0);
@@ -1216,6 +1236,22 @@ static int lowpan_psm_set(void *data, u64 val)
 
 	listen_chan = bt_6lowpan_listen();
 
+	kfree(set_psm);
+}
+
+static int lowpan_psm_set(void *data, u64 val)
+{
+	struct set_psm *set_psm;
+
+	set_psm = kzalloc(sizeof(*set_psm), GFP_KERNEL);
+	if (!set_psm)
+		return -ENOMEM;
+
+	set_psm->psm = val;
+	INIT_WORK(&set_psm->work, do_psm_set);
+
+	schedule_work(&set_psm->work);
+
 	return 0;
 }
 
@@ -1297,19 +1333,18 @@ static ssize_t lowpan_control_write(struct file *fp,
 
 static int lowpan_control_show(struct seq_file *f, void *ptr)
 {
-	struct lowpan_dev *entry, *tmp_dev;
-	struct lowpan_peer *peer, *tmp_peer;
-	unsigned long flags;
+	struct lowpan_dev *entry;
+	struct lowpan_peer *peer;
 
-	read_lock_irqsave(&devices_lock, flags);
+	spin_lock(&devices_lock);
 
-	list_for_each_entry_safe(entry, tmp_dev, &bt_6lowpan_devices, list) {
-		list_for_each_entry_safe(peer, tmp_peer, &entry->peers, list)
+	list_for_each_entry(entry, &bt_6lowpan_devices, list) {
+		list_for_each_entry(peer, &entry->peers, list)
 			seq_printf(f, "%pMR (type %u)\n",
 				   &peer->chan->dst, peer->chan->dst_type);
 	}
 
-	read_unlock_irqrestore(&devices_lock, flags);
+	spin_unlock(&devices_lock);
 
 	return 0;
 }
@@ -1329,9 +1364,8 @@ static const struct file_operations lowpan_control_fops = {
 
 static void disconnect_devices(void)
 {
-	struct lowpan_dev *entry, *tmp, *new_dev;
+	struct lowpan_dev *entry, *new_dev;
 	struct list_head devices;
-	unsigned long flags;
 
 	INIT_LIST_HEAD(&devices);
 
@@ -1340,9 +1374,9 @@ static void disconnect_devices(void)
 	 * devices list.
 	 */
 
-	read_lock_irqsave(&devices_lock, flags);
+	rcu_read_lock();
 
-	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
+	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
 		new_dev = kmalloc(sizeof(*new_dev), GFP_ATOMIC);
 		if (!new_dev)
 			break;
@@ -1350,12 +1384,12 @@ static void disconnect_devices(void)
 		new_dev->netdev = entry->netdev;
 		INIT_LIST_HEAD(&new_dev->list);
 
-		list_add(&new_dev->list, &devices);
+		list_add_rcu(&new_dev->list, &devices);
 	}
 
-	read_unlock_irqrestore(&devices_lock, flags);
+	rcu_read_unlock();
 
-	list_for_each_entry_safe(entry, tmp, &devices, list) {
+	list_for_each_entry(entry, &devices, list) {
 		ifdown(entry->netdev);
 		BT_DBG("Unregistering netdev %s %p",
 		       entry->netdev->name, entry->netdev);
@@ -1368,17 +1402,15 @@ static int device_event(struct notifier_block *unused,
 			unsigned long event, void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
-	struct lowpan_dev *entry, *tmp;
-	unsigned long flags;
+	struct lowpan_dev *entry;
 
 	if (netdev->type != ARPHRD_6LOWPAN)
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_UNREGISTER:
-		write_lock_irqsave(&devices_lock, flags);
-		list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices,
-					 list) {
+		spin_lock(&devices_lock);
+		list_for_each_entry(entry, &bt_6lowpan_devices, list) {
 			if (entry->netdev == netdev) {
 				BT_DBG("Unregistered netdev %s %p",
 				       netdev->name, netdev);
@@ -1387,7 +1419,7 @@ static int device_event(struct notifier_block *unused,
 				break;
 			}
 		}
-		write_unlock_irqrestore(&devices_lock, flags);
+		spin_unlock(&devices_lock);
 		break;
 	}
 
-- 
1.8.3.1

