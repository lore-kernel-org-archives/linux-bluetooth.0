Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9F17BB21
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 May 2026 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778385884; cv=none; b=ClwWwzQyruQyp2Ou0/j4acol8FuNJDNDjFarFzvfXGkfhkqCwSV0TfnfeqD0atuyu/kkh4ebswjgsiPu8AIwSRtJG1hGo7YysBT4iOSB1Qxr+A49gegP3i8Azs+lxQaT5w+BtRQWUZYTASideczokPbVRmu9OnFhNeXPzFaQHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778385884; c=relaxed/simple;
	bh=DibGXqptptJZ9kHm/gQycVYi8xqTgPBS/glyh7PtLuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y26cysWK4QouDMJvN843ywaoWnZYizwzdLsV37Ru8jGwNyUPn9dFSRpR3wPlaHIaZGaPayPXOGtkFZpYh251PSizyQdnX+zv50j4jpq+U14Na6XAWq7J2V+QWX7ttQAzf2JojyFxJ0lR1tdFFGYhOSyxm/SfiMumOxUXukFvWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr3/LwSV; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr3/LwSV"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-834da62e52dso1370298b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 21:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778385881; x=1778990681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf56gFtBIYqa57TpfaKVObEVD6+mxOtaCj0YwP1XuwY=;
        b=Wr3/LwSVkdtdGdOmRCLrWRr2a2ZbSxH+DDy0MMcx3BeriYrteHIsJ2sdYByQj5rTWv
         TUmysqXxwzlM+7SmOpiYIhfjtSUNCuh+YV+J9f+4c12PqG1YBrObcI1pz9BWoOgNcWlO
         GdqL4LVP5vEu9xiylwZBCXNadQkXVifrJ3jhkxLvPyQdyAGWVlzbBwUDZdE1Or6oeLM0
         KFi4InR0JKbe/t3PG6dPi5xVoEYN9tiDb1dP0d/FR6dft5BANTpgQ8HhfEL/cLi3jucj
         mL+8VFyqInQb7LUpblaBH62XFGkZznS0izUFU7lES8hbPkEdVVZVQ2l0Z2oyOVY5U70/
         A5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778385881; x=1778990681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pf56gFtBIYqa57TpfaKVObEVD6+mxOtaCj0YwP1XuwY=;
        b=h+tQ4JuCUFs2DlAbx1PCjknLQ6ZOqO5o9ns1Gw9drixOy0W6RwQmohwmtwz2kJ/cHx
         Xbu2jOTKTOKCyRVfdU/pvJX58/pu6+6MOVoLCg4lI8IAA42Snv+pJxP2FYlj2/Cx62WT
         T4Ihmh6JlbuVUBOj9iEliTsM8v1LpuTUzUWJZsmbdZxLQxTG9S1BNVtUPZbGM+5tgWvg
         b9Q1BX2kHBHpk/01107+VKV12ckEpS0jUORhC9+Ut/B8nFaYp8o3RCLsoqKSjq7BGp8I
         LcFtHW2Kap42cXP/+3aWTMYMFEdB4CFJylKkwQV/uydK8/n0Zs5AmQsUqG9iKsepeHuP
         dmeA==
X-Gm-Message-State: AOJu0YxE5idUADHeGDiVPHDpa9csKQu5OBvvxmO6kZOCJQ66jZ1MJyq5
	Fre8NqB6yY0kFD1FFT0FIiFVFqj8yZfjYfzI8guRN1uvJC1XxJe1UjwY
X-Gm-Gg: Acq92OF+z3971uCv1KwaNQGhqrrtXECrO9ZGW9+0lys0G8dayxlUL3y/3COKJgJDbiD
	5dSICPK9UOv1A9W81VNX9EDS7QH7uN/wSoVdUOWOblevxZk83I1KFJHnpB73MTa544IO8Wru/3Z
	BuG+F7Ce1UogFjTNWjYX9CVpFTsrx1uNN3I1CtZL8boKc/YVZh20oGjDmpqNOBUbos7A8U54EI0
	6X5O15VZO7B66KvjvqfueTV1fh2DSlqVSWOj5+RdRr7MYVYmWH62EojECgxjYQUxcHjg+Ayfzzh
	HlVkaQRa2lnp1L+QWvP7NRqHhP7Ceiz9NQTy0+0syaF2xCzfRB4iBjIGKVxp8WeNUTnS3LZtSEa
	+ohxNLWOUluOYa8BIfcvhZZ/7MAxL/PlOesNcjsLoENAymqtYkXJMkTDfDXsI2K5g7F/4OzKc6a
	uI+kGAeiZjMe6PgrwJUUvsYFeNe5xzNDA=
X-Received: by 2002:a05:6a00:91cf:b0:83b:40c8:6ddf with SMTP id d2e1a72fcca58-83b40c872a7mr13890395b3a.24.1778385880757;
        Sat, 09 May 2026 21:04:40 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdfb0sm15865699b3a.45.2026.05.09.21.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:04:40 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hillf Danton <hdanton@sina.com>,
	zerocling0077@gmail.com,
	hanguidong02@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH v2] Bluetooth: 6lowpan: Fix peer and channel lifetime during teardown
Date: Sun, 10 May 2026 12:04:24 +0800
Message-Id: <20260510040424.2054614-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509173745.413473-1-rollkingzzc@gmail.com>
References: <20260509173745.413473-1-rollkingzzc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6LoWPAN peers keep a protocol-owned L2CAP channel reference in
peer->chan. chan_close_cb() removes the peer from the RCU list when the
channel is closed, but the old code also dropped that channel reference
before the peer object stopped being observable by in-flight RCU readers.

That can leave peer readers with a live lowpan_peer that still points at
an l2cap_chan whose last reference has already been released. Some
lookup helpers also returned raw peer pointers after dropping RCU
protection, so keeping only the channel alive until the RCU callback
still leaves the peer lifetime rules implicit.

Make the peer lifetime explicit. Give each lowpan_peer a refcount, have
RCU lookups take a peer reference before returning a peer outside the
read-side critical section, and make peer_del() only unlink the peer and
schedule an RCU callback to drop the list owner reference after the grace
period. Release the peer-owned L2CAP channel reference and module
reference from the final peer put.

Keep temporary channel references in transmit and disconnect paths that
cache or send through peer->chan after lookup.

The buggy scenario involves two paths, with each column showing the order within that path:

L2CAP peer teardown:                   Concurrent peer reader:
  1. A close path holds a                1. A reader such as
     temporary reference to the             lookup_peer(),
     channel                                peer_lookup_dst(),
                                            send_mcast_pkt(), or
                                            bt_6lowpan_disconnect()
                                            observes the peer
  2. l2cap_chan_del() drops the          2. The reader keeps using the
     connection-owned channel               raw peer or peer->chan after
     reference                              RCU lookup protection ends
  3. chan_close_cb() removes the         3. The reader reads channel
     lowpan_peer from the peer              fields, locks the channel, or
     list                                   sends through the channel
                                            pointer
  4. The old chan_close_cb()
     dropped the peer-owned
     channel reference before the
     peer RCU grace period ended
  5. The close caller releases its
     temporary channel reference

If the reader reaches its channel use after teardown releases the peer-
owned channel reference and the close caller releases its temporary
reference, it can use a freed channel; raw peer returns can also outlive
the peer RCU callback.

lowpan_peer objects remain RCU-observable after peer_del() unlinks them.

Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

---
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2f03b780b40d..7334a78f5bfb 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -9,6 +9,7 @@
 #include <linux/etherdevice.h>
 #include <linux/module.h>
 #include <linux/debugfs.h>
+#include <linux/refcount.h>
 
 #include <net/ipv6.h>
 #include <net/ip6_route.h>
@@ -61,6 +62,7 @@ enum {
 struct lowpan_peer {
 	struct list_head list;
 	struct rcu_head rcu;
+	refcount_t refcnt;
 	struct l2cap_chan *chan;
 
 	/* peer addresses in various formats */
@@ -95,13 +97,33 @@ static inline void peer_add(struct lowpan_btle_dev *dev,
 	atomic_inc(&dev->peer_count);
 }
 
+static inline bool lowpan_peer_get_unless_zero(struct lowpan_peer *peer)
+{
+	return refcount_inc_not_zero(&peer->refcnt);
+}
+
+static void lowpan_peer_put(struct lowpan_peer *peer)
+{
+	if (!refcount_dec_and_test(&peer->refcnt))
+		return;
+
+	l2cap_chan_put(peer->chan);
+	kfree(peer);
+	module_put(THIS_MODULE);
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
@@ -179,7 +201,8 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 		       &peer->chan->dst, peer->chan->dst_type,
 		       &peer->peer_addr);
 
-		if (!ipv6_addr_cmp(&peer->peer_addr, nexthop)) {
+		if (!ipv6_addr_cmp(&peer->peer_addr, nexthop) &&
+		    lowpan_peer_get_unless_zero(peer)) {
 			rcu_read_unlock();
 			return peer;
 		}
@@ -189,7 +212,8 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 	neigh = __ipv6_neigh_lookup(dev->netdev, nexthop);
 	if (neigh) {
 		list_for_each_entry_rcu(peer, &dev->peers, list) {
-			if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN)) {
+			if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN) &&
+			    lowpan_peer_get_unless_zero(peer)) {
 				neigh_release(neigh);
 				rcu_read_unlock();
 				return peer;
@@ -212,8 +236,9 @@ static struct lowpan_peer *lookup_peer(struct l2cap_conn *conn)
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
 		peer = __peer_lookup_conn(entry, conn);
-		if (peer)
+		if (peer && lowpan_peer_get_unless_zero(peer))
 			break;
+		peer = NULL;
 	}
 
 	rcu_read_unlock();
@@ -361,8 +386,10 @@ static int chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -ENOENT;
 
 	dev = lookup_dev(chan->conn);
-	if (!dev || !dev->netdev)
+	if (!dev || !dev->netdev) {
+		lowpan_peer_put(peer);
 		return -ENOENT;
+	}
 
 	err = recv_pkt(skb, dev->netdev, peer);
 	if (err) {
@@ -370,6 +397,8 @@ static int chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 		err = -EAGAIN;
 	}
 
+	lowpan_peer_put(peer);
+
 	return err;
 }
 
@@ -380,6 +409,8 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 	struct ipv6hdr *hdr;
 	struct lowpan_btle_dev *dev;
 	struct lowpan_peer *peer;
+	struct l2cap_chan *chan;
+	u8 peer_lladdr[ETH_ALEN];
 	u8 *daddr;
 	int err, status = 0;
 
@@ -388,9 +419,9 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 	dev = lowpan_btle_dev(netdev);
 
 	memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));
+	lowpan_cb(skb)->chan = NULL;
 
 	if (ipv6_addr_is_multicast(&ipv6_daddr)) {
-		lowpan_cb(skb)->chan = NULL;
 		daddr = NULL;
 	} else {
 		BT_DBG("dest IP %pI6c", &ipv6_daddr);
@@ -406,10 +437,15 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 			return -ENOENT;
 		}
 
-		daddr = peer->lladdr;
-		*peer_addr = peer->chan->dst;
-		*peer_addr_type = peer->chan->dst_type;
-		lowpan_cb(skb)->chan = peer->chan;
+		chan = peer->chan;
+		l2cap_chan_hold(chan);
+		memcpy(peer_lladdr, peer->lladdr, ETH_ALEN);
+		*peer_addr = chan->dst;
+		*peer_addr_type = chan->dst_type;
+		lowpan_cb(skb)->chan = chan;
+		lowpan_peer_put(peer);
+
+		daddr = peer_lladdr;
 
 		status = 1;
 	}
@@ -417,8 +453,13 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 	lowpan_header_compress(skb, netdev, daddr, dev->netdev->dev_addr);
 
 	err = dev_hard_header(skb, netdev, ETH_P_IPV6, NULL, NULL, 0);
-	if (err < 0)
+	if (err < 0) {
+		if (lowpan_cb(skb)->chan) {
+			l2cap_chan_put(lowpan_cb(skb)->chan);
+			lowpan_cb(skb)->chan = NULL;
+		}
 		return err;
+	}
 
 	return status;
 }
@@ -483,15 +524,23 @@ static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 		dev = lowpan_btle_dev(entry->netdev);
 
 		list_for_each_entry_rcu(pentry, &dev->peers, list) {
+			struct l2cap_chan *chan = pentry->chan;
 			int ret;
 
 			local_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!local_skb) {
+				err = -ENOMEM;
+				continue;
+			}
+
+			l2cap_chan_hold(chan);
 
 			BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p",
 			       netdev->name,
-			       &pentry->chan->dst, pentry->chan->dst_type,
-			       &pentry->peer_addr, pentry->chan);
-			ret = send_pkt(pentry->chan, local_skb, netdev);
+			       &chan->dst, chan->dst_type,
+			       &pentry->peer_addr, chan);
+			ret = send_pkt(chan, local_skb, netdev);
+			l2cap_chan_put(chan);
 			if (ret < 0)
 				err = ret;
 
@@ -530,10 +579,14 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	if (err) {
 		if (lowpan_cb(skb)->chan) {
+			struct l2cap_chan *chan = lowpan_cb(skb)->chan;
+
 			BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p",
 			       netdev->name, &addr, addr_type,
-			       &lowpan_cb(skb)->addr, lowpan_cb(skb)->chan);
-			err = send_pkt(lowpan_cb(skb)->chan, skb, netdev);
+			       &lowpan_cb(skb)->addr, chan);
+			err = send_pkt(chan, skb, netdev);
+			l2cap_chan_put(chan);
+			lowpan_cb(skb)->chan = NULL;
 		} else {
 			err = -ENOENT;
 		}
@@ -649,6 +702,7 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 	if (!peer)
 		return NULL;
 
+	refcount_set(&peer->refcnt, 1);
 	peer->chan = chan;
 
 	baswap((void *)peer->lladdr, &chan->dst);
@@ -802,8 +856,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
 			       last ? "last " : "1 ", peer);
 			BT_DBG("chan %p orig refcnt %u", chan,
 			       kref_read(&chan->kref));
-
-			l2cap_chan_put(chan);
 			break;
 		}
 	}
@@ -918,6 +970,7 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 {
 	struct lowpan_peer *peer;
+	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p dst type %u", conn, dst_type);
 
@@ -925,11 +978,16 @@ static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 	if (!peer)
 		return -ENOENT;
 
-	BT_DBG("peer %p chan %p", peer, peer->chan);
+	chan = peer->chan;
+	l2cap_chan_hold(chan);
+
+	BT_DBG("peer %p chan %p", peer, chan);
+	lowpan_peer_put(peer);
 
-	l2cap_chan_lock(peer->chan);
-	l2cap_chan_close(peer->chan, ENOENT);
-	l2cap_chan_unlock(peer->chan);
+	l2cap_chan_lock(chan);
+	l2cap_chan_close(chan, ENOENT);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return 0;
 }
@@ -1169,6 +1227,7 @@ static ssize_t lowpan_control_write(struct file *fp,
 			peer = lookup_peer(conn);
 			if (peer) {
 				BT_DBG("6LoWPAN connection already exists");
+				lowpan_peer_put(peer);
 				return -EALREADY;
 			}
