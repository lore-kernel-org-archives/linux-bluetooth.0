Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590844E040
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520213; cv=none; b=Y+G+JGfQk1w2d0L+fvjAkLwFPXO8RDakwYdHflkqF0morkrpCvLjXxQrJB6RyZt/RLENbZZpSvnDEo8UmU/NbbvANXay0qO87qswzRCCn0XMxjSatZR/ZICaS4Wi9kvGVA4pm9DhGYRNzrlPud9WmfX+GQvwglkttzbOdESEzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520213; c=relaxed/simple;
	bh=WJHz5n5qO43gssAYd0RpXe5VUYFm9L7jP/Y3eZfA1OY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dkQtGFnN2qtfGux3w1Eo9kODQyhehuzq3h6XzRdqswUrmyIssJYRby5YWFHlI/mRVD/Ijskx37LCcn3x2EQgf9lxhuztnURPr5zbbRuT1Px1Fn26ZhXyVptzobWNEXp2XzF9BLrIeKPx3cIEzLg7NavksxKNak/W+iJBw8jZlBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLv+NiJQ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLv+NiJQ"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2ba21d32776so30718565ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778520209; x=1779125009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XwWVQu8XVyE46tCIzrpzjGbbrMxOv7xyn045m50uP+M=;
        b=RLv+NiJQNVAg9+Y91TDEdQyn5+L5A3pA08TrV/69EM7y35/zwqHokEDwOOL19g+ZQf
         hu1BPNeqjZ/jfpz8/EiOzr9rUBBrUNkP4fEcqogkQ66YIrjHch+y5Qip8Xy+eEHriQK6
         AtVTPWFNkzO/a1mlxEU69Jl+ACj9Y1Iun78ikjh7ZN3UFGl41Za37+CS9/5hr7Lno6mR
         yRB787YrAibUpDKmmU/9D+m1Ss6RhBjZrHiiig5ZUB47YM6WR+tAGLYNS6L/kdfW1I8g
         OTQRODTyi3wKbTCCVamXprk2G5tbcXQg7J6+bBBLViU5PPsNGOb45+xju0ezBtwK08NW
         c7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520209; x=1779125009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwWVQu8XVyE46tCIzrpzjGbbrMxOv7xyn045m50uP+M=;
        b=daYOdqQN2e48wuw6pYNKUCmqcI1pqd/es0BE7lfAkAm0UVtphkf62njuN5v8pw1fK5
         x1sVO9ppphbgtBoKP1zYX19MxUcQRzNkG6NjlkC2B/wzxultIfu+pXCmpRc3/KaXeU/s
         QYDWJESe3htEJKyyf6vzJFfjVPnRBsDrW9Pd8qP9SNQNomrZqeEk0gvbfUkKS5fLFJ93
         3dhfAPwzpOaJrNQ2C5gzQj/qq93ZRKJIQjmnYNBHD7EiG/NCBurT1uHKD5ZZFlcTq8d2
         6EZBT3nzBoPYPDN6btoqWuA5Wh/POWHSM6CKHj9EBripdEsUIBZG4Fw/NDdrHGIUjx8W
         qLQA==
X-Gm-Message-State: AOJu0YzeOnS9dM7O64DkW35+Hq2579QXeh8qPuDOpuziX+nrzJwGCdOi
	D3xpS1hkEDBxwLVntaF3o6uJ5NOzqX2KRH7ziZVnGLF7hD6edwpnpX4/
X-Gm-Gg: Acq92OHxhof1urugHqQAy3GcpJ2pgI3qQXbh9jhUCT8eFFsPm9/jy/rIqfb8GpYEAq5
	vKHcw6zapHnyuIfZFGZ9Q5ZuJPP8IqglOctXYm60rsy9HtJbpY+atNoC2HzicpnOwHTO7GhnFFV
	izRtJEh9fu4SyKehWJj0YHhRAfCiM4q1oALedxZs2aYLI0zS0lN6rKNSzO9nrf5r3PcBbuN9uBA
	hKyh0+bIV+3/3G2jpNb8g/Gs+/c1ehIU+QCzH96AKsXL36wBB7UbdUDcKVOV9cNL51qWU6kIopm
	QFSzx8vDzJ2yM75Ol4tmXzuGAU7GdCnh9DNms7gB3LzXCTURbu6gwX1weyRklNugs6rcP0yfSri
	CduHdFZQfPwOQud9/J7u3FfH6cyWsXXfNyFqrSjtJ3YHWpDGO3EktHH47ttBzxzTtvpCH7ZWUF2
	gJgMBsNCJRtQQZit9dzLERY9n0bJ03gRQ=
X-Received: by 2002:a17:902:ef09:b0:2bc:b80f:6782 with SMTP id d9443c01a7336-2bcb80f6998mr64244835ad.11.1778520208822;
        Mon, 11 May 2026 10:23:28 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d3ff52sm110938825ad.26.2026.05.11.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:23:28 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hillf Danton <hdanton@sina.com>,
	zerocling0077@gmail.com,
	2045gemini@gmail.com
Subject: [PATCH v3] Bluetooth: 6lowpan: Fix peer and channel lifetime during teardown
Date: Tue, 12 May 2026 01:23:10 +0800
Message-Id: <20260511172310.3723421-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A 6LoWPAN peer keeps a protocol-owned L2CAP channel reference in
peer->chan. chan_close_cb() removes the peer from the RCU list when the
channel is closed, but the old code also dropped that channel reference
before the peer object stopped being observable by in-flight RCU readers.

The buggy scenario involves two paths, with each column showing the order
within that path:

  close path:                            lookup/transmit path:
  l2cap_conn_del() or another            setup_header(), send_mcast_pkt(),
  close path holds a temporary           bt_6lowpan_disconnect(), or
  channel reference                      chan_recv_cb() observes a peer

  l2cap_chan_del() drops the             the reader leaves the RCU read
  connection-owned channel reference     side critical section, or keeps
                                         using peer->chan inside it

  chan_close_cb() removes the peer       the reader reads channel fields,
  from the peer list                     locks the channel, or sends
                                         through peer->chan

  the old chan_close_cb() dropped
  the peer-owned channel reference

  the close caller releases its
  temporary channel reference

If the close path consumes the peer-owned channel reference before a
reader finishes with peer->chan, the reader can use a freed l2cap_chan.
The lookup helpers that returned raw peer pointers after rcu_read_unlock()
also let callers outlive the peer object's kfree_rcu() lifetime.

Give lowpan_peer its own refcount and make RCU lookups acquire a peer
reference before returning a peer to code that runs outside the read-side
critical section. Keep the peer-owned L2CAP channel reference attached to
the peer until the last peer reference is dropped.

The last peer put can happen from an RCU callback or from the network
transmit path, so do not drop the final L2CAP channel reference directly
from lowpan_peer_put(). Queue final peer destruction to a dedicated
workqueue and release the channel and module references there. Store the
peer, rather than a temporary channel reference, in the skb control block
for unicast transmit, and put the peer after the send path is done.
Multicast continues to use peer->chan only while it is inside the RCU
read-side critical section.

Wait for queued RCU callbacks and peer-destroy work during module exit so
asynchronous peer destruction cannot outlive the module text.

Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
 net/bluetooth/6lowpan.c | 128 ++++++++++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 23a229ab6..7a1b0d7b0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -9,6 +9,8 @@
 #include <linux/etherdevice.h>
 #include <linux/module.h>
 #include <linux/debugfs.h>
+#include <linux/refcount.h>
+#include <linux/workqueue.h>
 
 #include <net/ipv6.h>
 #include <net/ip6_route.h>
@@ -29,10 +31,12 @@ static struct dentry *lowpan_control_debugfs;
 
 #define IFACE_NAME_TEMPLATE "bt%d"
 
+struct lowpan_peer;
+
 struct skb_cb {
 	struct in6_addr addr;
 	struct in6_addr gw;
-	struct l2cap_chan *chan;
+	struct lowpan_peer *peer;
 };
 #define lowpan_cb(skb) ((struct skb_cb *)((skb)->cb))
 
@@ -52,6 +56,7 @@ static bool enable_6lowpan;
  */
 static struct l2cap_chan *listen_chan;
 static DEFINE_MUTEX(set_lock);
+static struct workqueue_struct *lowpan_peer_wq;
 
 enum {
 	LOWPAN_PEER_CLOSING,
@@ -61,6 +66,8 @@ enum {
 struct lowpan_peer {
 	struct list_head list;
 	struct rcu_head rcu;
+	struct work_struct destroy_work;
+	refcount_t refcnt;
 	struct l2cap_chan *chan;
 
 	/* peer addresses in various formats */
@@ -95,13 +102,39 @@ static inline void peer_add(struct lowpan_btle_dev *dev,
 	atomic_inc(&dev->peer_count);
 }
 
+static inline bool lowpan_peer_get_unless_zero(struct lowpan_peer *peer)
+{
+	return refcount_inc_not_zero(&peer->refcnt);
+}
+
+static void lowpan_peer_destroy(struct work_struct *work)
+{
+	struct lowpan_peer *peer = container_of(work, struct lowpan_peer,
+						destroy_work);
+
+	l2cap_chan_put(peer->chan);
+	kfree(peer);
+	module_put(THIS_MODULE);
+}
+
+static void lowpan_peer_put(struct lowpan_peer *peer)
+{
+	if (refcount_dec_and_test(&peer->refcnt))
+		queue_work(lowpan_peer_wq, &peer->destroy_work);
+}
+
+static void lowpan_peer_put_rcu(struct rcu_head *rcu)
+{
+	struct lowpan_peer *peer = container_of(rcu, struct lowpan_peer, rcu);
+
+	lowpan_peer_put(peer);
+}
+
 static inline bool peer_del(struct lowpan_btle_dev *dev,
 			    struct lowpan_peer *peer)
 {
 	list_del_rcu(&peer->list);
-	kfree_rcu(peer, rcu);
-
-	module_put(THIS_MODULE);
+	call_rcu(&peer->rcu, lowpan_peer_put_rcu);
 
 	if (atomic_dec_and_test(&dev->peer_count)) {
 		BT_DBG("last peer");
@@ -179,7 +212,8 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 		       &peer->chan->dst, peer->chan->dst_type,
 		       &peer->peer_addr);
 
-		if (!ipv6_addr_cmp(&peer->peer_addr, nexthop)) {
+		if (!ipv6_addr_cmp(&peer->peer_addr, nexthop) &&
+		    lowpan_peer_get_unless_zero(peer)) {
 			rcu_read_unlock();
 			return peer;
 		}
@@ -189,7 +223,8 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 	neigh = __ipv6_neigh_lookup(dev->netdev, nexthop);
 	if (neigh) {
 		list_for_each_entry_rcu(peer, &dev->peers, list) {
-			if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN)) {
+			if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN) &&
+			    lowpan_peer_get_unless_zero(peer)) {
 				neigh_release(neigh);
 				rcu_read_unlock();
 				return peer;
@@ -212,8 +247,9 @@ static struct lowpan_peer *lookup_peer(struct l2cap_conn *conn)
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
 		peer = __peer_lookup_conn(entry, conn);
-		if (peer)
+		if (peer && lowpan_peer_get_unless_zero(peer))
 			break;
+		peer = NULL;
 	}
 
 	rcu_read_unlock();
@@ -361,8 +397,10 @@ static int chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -ENOENT;
 
 	dev = lookup_dev(chan->conn);
-	if (!dev || !dev->netdev)
+	if (!dev || !dev->netdev) {
+		lowpan_peer_put(peer);
 		return -ENOENT;
+	}
 
 	err = recv_pkt(skb, dev->netdev, peer);
 	if (err) {
@@ -370,6 +408,8 @@ static int chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 		err = -EAGAIN;
 	}
 
+	lowpan_peer_put(peer);
+
 	return err;
 }
 
@@ -380,6 +420,8 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 	struct ipv6hdr *hdr;
 	struct lowpan_btle_dev *dev;
 	struct lowpan_peer *peer;
+	struct l2cap_chan *chan;
+	u8 peer_lladdr[ETH_ALEN];
 	u8 *daddr;
 	int err, status = 0;
 
@@ -388,9 +430,9 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 	dev = lowpan_btle_dev(netdev);
 
 	memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));
+	lowpan_cb(skb)->peer = NULL;
 
 	if (ipv6_addr_is_multicast(&ipv6_daddr)) {
-		lowpan_cb(skb)->chan = NULL;
 		daddr = NULL;
 	} else {
 		BT_DBG("dest IP %pI6c", &ipv6_daddr);
@@ -406,10 +448,13 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 			return -ENOENT;
 		}
 
-		daddr = peer->lladdr;
-		*peer_addr = peer->chan->dst;
-		*peer_addr_type = peer->chan->dst_type;
-		lowpan_cb(skb)->chan = peer->chan;
+		chan = peer->chan;
+		memcpy(peer_lladdr, peer->lladdr, ETH_ALEN);
+		*peer_addr = chan->dst;
+		*peer_addr_type = chan->dst_type;
+		lowpan_cb(skb)->peer = peer;
+
+		daddr = peer_lladdr;
 
 		status = 1;
 	}
@@ -417,8 +462,13 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 	lowpan_header_compress(skb, netdev, daddr, dev->netdev->dev_addr);
 
 	err = dev_hard_header(skb, netdev, ETH_P_IPV6, NULL, NULL, 0);
-	if (err < 0)
+	if (err < 0) {
+		if (lowpan_cb(skb)->peer) {
+			lowpan_peer_put(lowpan_cb(skb)->peer);
+			lowpan_cb(skb)->peer = NULL;
+		}
 		return err;
+	}
 
 	return status;
 }
@@ -486,6 +536,10 @@ static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 			int ret;
 
 			local_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!local_skb) {
+				err = -ENOMEM;
+				continue;
+			}
 
 			BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p",
 			       netdev->name,
@@ -529,11 +583,17 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	}
 
 	if (err) {
-		if (lowpan_cb(skb)->chan) {
+		struct lowpan_peer *peer = lowpan_cb(skb)->peer;
+
+		if (peer) {
+			struct l2cap_chan *chan = peer->chan;
+
 			BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p",
 			       netdev->name, &addr, addr_type,
-			       &lowpan_cb(skb)->addr, lowpan_cb(skb)->chan);
-			err = send_pkt(lowpan_cb(skb)->chan, skb, netdev);
+			       &lowpan_cb(skb)->addr, chan);
+			err = send_pkt(chan, skb, netdev);
+			lowpan_peer_put(peer);
+			lowpan_cb(skb)->peer = NULL;
 		} else {
 			err = -ENOENT;
 		}
@@ -649,6 +709,8 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 	if (!peer)
 		return NULL;
 
+	INIT_WORK(&peer->destroy_work, lowpan_peer_destroy);
+	refcount_set(&peer->refcnt, 1);
 	peer->chan = chan;
 
 	baswap((void *)peer->lladdr, &chan->dst);
@@ -822,8 +884,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
 			       last ? "last " : "1 ", peer);
 			BT_DBG("chan %p orig refcnt %u", chan,
 			       kref_read(&chan->kref));
-
-			l2cap_chan_put(chan);
 			break;
 		}
 	}
@@ -938,6 +998,7 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 {
 	struct lowpan_peer *peer;
+	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p dst type %u", conn, dst_type);
 
@@ -945,11 +1006,14 @@ static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 	if (!peer)
 		return -ENOENT;
 
-	BT_DBG("peer %p chan %p", peer, peer->chan);
+	chan = peer->chan;
+
+	BT_DBG("peer %p chan %p", peer, chan);
 
-	l2cap_chan_lock(peer->chan);
-	l2cap_chan_close(peer->chan, ENOENT);
-	l2cap_chan_unlock(peer->chan);
+	l2cap_chan_lock(chan);
+	l2cap_chan_close(chan, ENOENT);
+	l2cap_chan_unlock(chan);
+	lowpan_peer_put(peer);
 
 	return 0;
 }
@@ -1189,6 +1253,7 @@ static ssize_t lowpan_control_write(struct file *fp,
 			peer = lookup_peer(conn);
 			if (peer) {
 				BT_DBG("6LoWPAN connection already exists");
+				lowpan_peer_put(peer);
 				return -EALREADY;
 			}
 
@@ -1320,6 +1385,12 @@ static struct notifier_block bt_6lowpan_dev_notifier = {
 
 static int __init bt_6lowpan_init(void)
 {
+	int err;
+
+	lowpan_peer_wq = alloc_ordered_workqueue("bt_6lowpan_peer", 0);
+	if (!lowpan_peer_wq)
+		return -ENOMEM;
+
 	lowpan_enable_debugfs = debugfs_create_file_unsafe("6lowpan_enable",
 							   0644, bt_debugfs,
 							   NULL,
@@ -1328,7 +1399,14 @@ static int __init bt_6lowpan_init(void)
 						     bt_debugfs, NULL,
 						     &lowpan_control_fops);
 
-	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
+	err = register_netdevice_notifier(&bt_6lowpan_dev_notifier);
+	if (err) {
+		debugfs_remove(lowpan_enable_debugfs);
+		debugfs_remove(lowpan_control_debugfs);
+		destroy_workqueue(lowpan_peer_wq);
+	}
+
+	return err;
 }
 
 static void __exit bt_6lowpan_exit(void)
@@ -1346,6 +1424,8 @@ static void __exit bt_6lowpan_exit(void)
 	disconnect_devices();
 
 	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
+	rcu_barrier();
+	destroy_workqueue(lowpan_peer_wq);
 }
 
 module_init(bt_6lowpan_init);
-- 
2.43.0

