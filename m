Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B340242A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519958; cv=none; b=oWJD8xlQFEA9s1p+nhrFkxS2Hm0TTxtnrBjoxR2+5FdB1rWtTy6kB51FI3MulXcbbmW2yzZ/cCvLkPpRq7e7C98lcyDyABWB+VMgBNCJvTw8LxfH5Sm2xsK0jca+hpZQGEEzFUY75OwsGCSMEgm6laBZvlU3kD50go3Y6e6Mwd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519958; c=relaxed/simple;
	bh=WJHz5n5qO43gssAYd0RpXe5VUYFm9L7jP/Y3eZfA1OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gz31kPVTM6VFKu9rrhzbve+aX36EjjvLVekUEuP7/QhiC2OBi/FBTqCnaSledWoP7SL/jlaXhQSe+6Cxjsqhzb0rOdHSDC56iDlepJMkBDLX88m7x5nF1BTC5TLjx+WoXmi9xpbIFtBC3Gm4AHTSJ3v6323WSmlVqP951hAcyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4wEKoPY; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4wEKoPY"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2b941cd869cso27950725ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519956; x=1779124756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwWVQu8XVyE46tCIzrpzjGbbrMxOv7xyn045m50uP+M=;
        b=C4wEKoPYuFwMrcqdWHaRnhVdMhGpdshAnLwhCa2t/CpPH/Jq/3eOuQ0nwwUsZasFRK
         r+eTzKMh7cyw2zl+GE51dlOBH7eNOdN4xSlpha5cxyPhSWYvGb0KeJJM4J+M+N6Vt4eS
         x6DxxP+LzgwHH6rOpT+T1v2+du32lOeyFoNomPz7TuattPi79G/kJ0W4m6hbNFFaVdgh
         YiGeqf2sFpzO+fuLDsNbkLq2tSJtAsIh3baBpqUtxvRihS3ocKf1BfL4ph3FOIOVn1z1
         PeCN5MkEmTeAyGQZcW5A0bhkTr+24n/6lwc2j9phq1dkZxy7zDMsHqL5TINEWpfNgQzj
         CBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519956; x=1779124756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwWVQu8XVyE46tCIzrpzjGbbrMxOv7xyn045m50uP+M=;
        b=oRNwED7CRT2o98KOkf2uLIkOktX9v0yZKUjh74w4h+5jjBU5L/x4XJkDYUmUPCy16u
         EH1yTXk4aFc344TujmL/yQODyQvVuLjPKkQXgeqGP6FiMVdat7MLOI/XVtFTghyRLQR+
         lSaCmjpSdVd4MgZ53W4H66vVDCFlwdL2VqROeKC5AzrO5brrHw/5nCLbluEtLGUbdvtO
         jsEMBBOKcqOlwai7ftvvlV3NIGh+0ZXcVm25xys/UvEoFakenoyXHK6snlrngJw+sYax
         rfvtpgJxZhBN4DOccL8nKz6fkIp+MSbv47y3+aNuE5VCshJDGScGAmA0iGkN+gH3G8+G
         prXQ==
X-Gm-Message-State: AOJu0YxcU9pvMDlA76hf9W03nG5a/w1Uro1Jbw99vHb+agLqRzv8iVgZ
	fnHIb5uatyt/WyfuYQGVi22XmWJvl+VUSqhqJa9N9SO7AKPX5PBq4P25
X-Gm-Gg: Acq92OHyeGtrVuRbg88RBOEk1DqrG1kEBlsCOVYJtkClnaTAnlO8ZExC+PTf9LQzDRP
	5zKtPTFe6wY6fvN2fT8JyXHMQ240cPmwuErJH7619Kix7TEq6JYSYwp7SJMW6GIuphz+EFF1prL
	wYF7RQzJdsoJjo2ayrmkVWg1/EIf5Keg/jtQNgKQvY1W59srYRlyxRrxjXIGEdqJCno56HV7z1E
	igaexNUSoj509gfOom7Bf7wgP1Uiba01zl4UmRqtjVqtvtCTYUNk2omRQXox6bbK9GXrvVICGXL
	wEIcRXLxuiX7Bvn8Ja5M2HZJnc6iNt+2rxddPTiKNZnPQcoBiQDue4MvkdKOTG61oRsYSss+jnJ
	hp66Ayp0RBL2Z0sjoQ5v4tbkiB10R56vOcbYe8UlHJgxGXLla+V7dadBu9NhpIPF1ygpxe9x6HG
	tOcnlR0moAkzTVts+gChCDVqJldTuXtKY=
X-Received: by 2002:a17:903:2cd:b0:2b2:4a9a:b149 with SMTP id d9443c01a7336-2ba78e34b7emr257022875ad.9.1778519955711;
        Mon, 11 May 2026 10:19:15 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead938sm115269615ad.73.2026.05.11.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:19:15 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH v3] Bluetooth: 6lowpan: Fix peer and channel lifetime during teardown
Date: Tue, 12 May 2026 01:18:54 +0800
Message-Id: <20260511171854.3712295-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510040424.2054614-1-rollkingzzc@gmail.com>
References: <20260510040424.2054614-1-rollkingzzc@gmail.com>
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

