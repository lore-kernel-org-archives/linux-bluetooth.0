Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE04CA795
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005175; cv=none; b=Dxf2v6l5zXnofRMWxzIb8qNEd3ceMzimq32RtAA5ff/Aes8MLJEGfeUCrA9Ayvxk9Vcz6h+KU5U8C8TrjH4uhZBlljpCnBeXG7AHAEVI1unXs58kEpzXifUhDJ9UDGvvqBMSs/0kEiUTJiINdKMFvLM+M1uMBIWyepkUNvLg0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005175; c=relaxed/simple;
	bh=RGsXweNLYSt5iBVvkA+azD+iGKH56TkTGcXPIwSmtcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t3KTGXW3aup0bhHdPZCUjV4IWAslrbBsdnN/Mq9eDUnrO218GRjTw+auYHKfjDM/lScpOMQWv5rjo7s8z+IqijC+2MFEiVXzpsueGpOWOttoZD4cen3QyKBAJygxsSBEKmVxNlYlKb/bxTlqBHcXq4PBWgyO2kHImV3L3Z6rAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W57xejGz; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W57xejGz"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86868f7707dso1668933b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005170; x=1790609970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BfUEoOdPgaQ8YyR2hDF8OszYSiHTNY3qANom129NxFg=;
        b=W57xejGz504xZL8xRUK3wn6NQzLn9USfMgk92O/PNGfnN/eMmS+vyHkXt5yl7GS5AH
         I92Jn7Th+2QnRS7B15WePTA3YxNYRUQOHaGX6BIEjDbtdz1qJkHreDreiVu2wnuCJ37L
         0ni2EPr/Jj1aYPhDcMz7d9pBfVeqsvbswik0F/wlQOYntlgENdXPHfQawMNk0Oi+cs3z
         NkAaZa3vrYG7yVtjSesmu1L07iHyxNFrstq3aCBrLlwdLtuCbfgPTQOTr/c58tMonEgI
         GCb3UHoKu9uDNgBp/XKdDKhRL3HEVAE3J4Ais1nd0q+s/HIDBz4asFwCzfhZxsP5q/0z
         fvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005170; x=1790609970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BfUEoOdPgaQ8YyR2hDF8OszYSiHTNY3qANom129NxFg=;
        b=GKp4i+0qkOdQur8CqJZjDdslqAxiAhe+VjP7DKocUDu2CnqPUHj5N6Ki2pPbCMFdjN
         aTn9/cKpMAYe7DTpOJz3uqR/RG5D4YUNokfEf/8Yu0ejrzYXnaHJmWmrUjehm3fZEmXO
         dHKwQa2Yhqyh2FxZHRH7q3q6VJWJ5bJNm0eAHiYVOkyYfMJ64p/WSp7OmrfOx1DJIa54
         5s7NQSnYWJcBAf11Mkgc0iPq0V+2/M6fiyXATTC37QzejsNMwcc5yDP+jhVDD3Q7Oy+H
         LlYkx9n/7DXU63AV6A+66RHRcSgJvxZj+dEzA1Nk8IaWiQGughsftDcFF+7ktr0LGAxr
         GYfg==
X-Forwarded-Encrypted: i=1; AKwUvBye1IqMUjLf3qYyZUYUsFiNsJK3MocJ/Wa+zYZzqNQasrj/q7dA+O+YrhOy7/dkKFQjwpv6JAgONdQ+7G/CIUY=@vger.kernel.org
X-Gm-Message-State: AFuF++n6YMDsggnyIdeQ4q+5H+9y76R+ayQiYhupKeMRSWsnt9inOdEh
	BiULo/H0BpvvVgFv0ZVs2WhPrZwGbJLE9Xa2u84tUm5EkonGOA+v/RL0
X-Gm-Gg: AYBFou09wGX240ebgPuAEvBIpmgrDQSmMWm07SmouAeeEbTopQcBdfus61f31E5wBLL
	LbGmPApcZOfzS4TgLXQ9PCvkLcuCPo7jRQS1OccvfiAvIB/SAgNVOKak84d1Nt/2/WziHKDlhSO
	r8P+3602HezoTK2IGWgNQzgyQ647xPk3bWwqrRfTVms1BqW9i2XGsPYoALbhdApLQ0gDmV+GmNv
	wOeXwptRDludoMIFwY2RMlSuh96wsotRmXXWF64npEVrB7SSFFdEn+YivQffbOOBUF3OGDfmBoJ
	UxC1NEB9NA5qC4lA0pFF3E5RWYBnpi1adEP57Bm1Yxt7jwz2mJaeQnJ3/4rnhhBV4TgDSoDb5Hd
	y5g3YSkKyj0OHDg3zA8VICOs8U1SK5EUyi4mM/y0Z9P+fZ8JdW8BU7u0Vc7pNSY0wDlxkD/58ep
	ZehgHRkZLyhjXZTFG9eLFjrWvdcYQbq/5IyeiZ1XrqZlBFEQ0I1rTbqcJzgMRfQKhP3Q==
X-Received: by 2002:a05:6a00:b49:b0:871:b1b0:e495 with SMTP id d2e1a72fcca58-874dc4f31aemr15536113b3a.15.1790005170033;
        Mon, 21 Sep 2026 08:39:30 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm3448186b3a.2.2026.09.21.08.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:39:29 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marco Elver <elver@google.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 4/5] Bluetooth: 6lowpan: handle channel setup failure and callback lifetime
Date: Mon, 21 Sep 2026 23:39:01 +0800
Message-Id: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-4@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
References: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

L2CAP marks a channel connected before invoking its ready callback.
6LoWPAN can then fail to allocate or publish a peer, leaving an unusable
connected channel or a network device without a peer. Deletion before
peer publication also leaks the channel's initial reference: close only
releases it after finding a peer.

The peer's module reference ends too early as well. Removing the last
peer releases it while the close callback is still executing, allowing
bluetooth_6lowpan to be unloaded before that callback returns. Deferred
network-device deletion also needs protection through callback return.

Let ready return an error and handle it in the LE CoC and ECRED request
and response paths. Allocate the peer before setting up a network device,
and publish it before bringing the device up. Track ownership of the
initial reference explicitly and release it once from teardown, even
when no peer was published. Hold separate request-handler references
through rollback, unlock and response construction.

Hold the operations owner's module reference for accepted and outgoing
channels until channel destruction. Keep the listener itself unpinned so
module exit can close it; check BT_LISTEN under the parent lock and take
a temporary owner reference before invoking new_connection. Use
module-owned work for deferred network-device deletion.

A close/unload race produced this instruction-fetch fault:

    [  101.222759] BUG: unable to handle page fault for address: ffffffffc040199f
    [  101.224102] #PF: supervisor instruction fetch in kernel mode
    [  101.225119] #PF: error_code(0x0010) - not-present page
    [  101.226980] Oops: Oops: 0010 [#1] SMP KASAN NOPTI
    [... omitted ...]
    [  101.232306] Workqueue: hci1 hci_rx_work
    [  101.233015] RIP: 0010:0xffffffffc040199f
    [  101.233780] Code: Unable to access opcode bytes at 0xffffffffc0401975.
    [... omitted ...]
    [  101.275265] Modules linked in: [last unloaded: bluetooth_6lowpan(O)]
    [  101.276117] CR2: ffffffffc040199f
    [... omitted ...]
    [  101.287138] Kernel panic - not syncing: Fatal exception

Fixes: 6b8d4a6a0314 ("Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 include/net/bluetooth/l2cap.h | 10 +++-
 net/bluetooth/6lowpan.c       | 86 ++++++++++++++++++++------------
 net/bluetooth/l2cap_core.c    | 94 +++++++++++++++++++++++++++++------
 net/bluetooth/l2cap_sock.c    |  6 ++-
 net/bluetooth/smp.c           |  4 +-
 5 files changed, 148 insertions(+), 52 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b4af087a0a81..7194dc570ee8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -611,6 +611,8 @@ struct l2cap_chan {
 
 	void			*data;
 	const struct l2cap_ops	*ops;
+	struct module		*ops_owner;
+	bool			ops_owner_pinned;
 	bool			timers_stopped; /* protected by conn->timer_lock */
 	struct mutex		lock;
 };
@@ -669,7 +671,7 @@ struct l2cap_ops {
 					__must_hold(&chan->lock);
 	void			(*state_change) (struct l2cap_chan *chan,
 						 int state, int err);
-	void			(*ready) (struct l2cap_chan *chan)
+	int			(*ready)(struct l2cap_chan *chan)
 					__must_hold(&chan->lock)
 					__must_hold(&chan->conn->lock);
 	void			(*defer) (struct l2cap_chan *chan);
@@ -764,6 +766,7 @@ enum {
 	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
+	FLAG_RELEASE_CREATOR,
 	FLAG_DEL,
 };
 
@@ -948,8 +951,9 @@ static inline void l2cap_chan_no_close(struct l2cap_chan *chan)
 {
 }
 
-static inline void l2cap_chan_no_ready(struct l2cap_chan *chan)
+static inline int l2cap_chan_no_ready(struct l2cap_chan *chan)
 {
+	return 0;
 }
 
 static inline void l2cap_chan_no_state_change(struct l2cap_chan *chan,
@@ -994,6 +998,8 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 struct l2cap_chan *l2cap_chan_create(void);
+bool l2cap_chan_set_ops(struct l2cap_chan *chan,
+			const struct l2cap_ops *ops, struct module *owner);
 void l2cap_chan_close_unlocked(struct l2cap_chan *chan, int reason)
 	__must_not_hold(&chan->lock);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 836add41f5d1..5c49dc146086 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -52,6 +52,7 @@ static bool enable_6lowpan;
  */
 static struct l2cap_chan *listen_chan;
 static DEFINE_MUTEX(set_lock);
+static const struct l2cap_ops bt_6lowpan_chan_ops;
 
 enum {
 	LOWPAN_PEER_CLOSING,
@@ -78,7 +79,7 @@ struct lowpan_btle_dev {
 	struct list_head peers;
 	atomic_t peer_count; /* number of items in peers list */
 
-	struct work_struct delete_netdev;
+	struct module_work delete_netdev;
 	struct delayed_work notify_peers;
 };
 
@@ -101,8 +102,6 @@ static inline bool peer_del(struct lowpan_btle_dev *dev,
 	list_del_rcu(&peer->list);
 	kfree_rcu(peer, rcu);
 
-	module_put(THIS_MODULE);
-
 	if (atomic_dec_and_test(&dev->peer_count)) {
 		BT_DBG("last peer");
 		return true;
@@ -641,16 +640,10 @@ static struct l2cap_chan *chan_create(void)
 	return chan;
 }
 
-static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
-					struct lowpan_btle_dev *dev,
-					bool new_netdev)
+static void add_peer_chan(struct l2cap_chan *chan,
+			  struct lowpan_btle_dev *dev,
+			  struct lowpan_peer *peer, bool new_netdev)
 {
-	struct lowpan_peer *peer;
-
-	peer = kzalloc_obj(*peer, GFP_ATOMIC);
-	if (!peer)
-		return NULL;
-
 	peer->chan = chan;
 
 	baswap((void *)peer->lladdr, &chan->dst);
@@ -666,8 +659,6 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 	if (new_netdev)
 		INIT_DELAYED_WORK(&dev->notify_peers, do_notify_peers);
 	schedule_delayed_work(&dev->notify_peers, msecs_to_jiffies(100));
-
-	return peer->chan;
 }
 
 static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
@@ -721,30 +712,37 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
 	return err;
 }
 
-static inline void chan_ready_cb(struct l2cap_chan *chan)
+static inline int chan_ready_cb(struct l2cap_chan *chan)
 	__must_hold(&chan->lock)
 	__must_hold(&chan->conn->lock)
 {
 	struct lowpan_btle_dev *dev;
+	struct lowpan_peer *peer;
 	bool new_netdev = false;
+	int err;
+
+	peer = kzalloc_obj(*peer, GFP_ATOMIC);
+	if (!peer)
+		return -ENOMEM;
 
 	dev = lookup_dev(chan->conn);
 
 	BT_DBG("chan %p conn %p dev %p", chan, chan->conn, dev);
 
 	if (!dev) {
-		if (setup_netdev(chan, &dev) < 0) {
-			l2cap_chan_del(chan, -ENOENT);
-			return;
-		}
+		err = setup_netdev(chan, &dev);
+		if (err < 0)
+			goto free_peer;
 		new_netdev = true;
 	}
 
-	if (!try_module_get(THIS_MODULE))
-		return;
-
-	add_peer_chan(chan, dev, new_netdev);
+	add_peer_chan(chan, dev, peer, new_netdev);
 	ifup(dev->netdev);
+	return 0;
+
+free_peer:
+	kfree(peer);
+	return err;
 }
 
 static void unregister_dev(struct lowpan_btle_dev *dev)
@@ -771,7 +769,7 @@ static void delete_netdev(struct work_struct *work)
 {
 	struct lowpan_btle_dev *entry = container_of(work,
 						     struct lowpan_btle_dev,
-						     delete_netdev);
+						     delete_netdev.work);
 
 	unregister_dev(entry);
 
@@ -785,6 +783,7 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	struct lowpan_peer *peer;
 	int err = -ENOENT;
 	bool last = false;
+	bool queued;
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
 
@@ -799,10 +798,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 			BT_DBG("dev %p removing %speer %p", dev,
 			       last ? "last " : "1 ", peer);
-			BT_DBG("chan %p orig refcnt %u", chan,
-			       kref_read(&chan->kref));
-
-			l2cap_chan_put(chan);
 			break;
 		}
 	}
@@ -814,8 +809,9 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 		ifdown(dev->netdev);
 
-		INIT_WORK(&entry->delete_netdev, delete_netdev);
-		schedule_work(&entry->delete_netdev);
+		queued = schedule_module_work(&entry->delete_netdev,
+					      delete_netdev, THIS_MODULE);
+		WARN_ON_ONCE(!queued);
 	} else {
 		spin_unlock(&devices_lock);
 	}
@@ -874,8 +870,27 @@ static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)
 	return L2CAP_CONN_TIMEOUT;
 }
 
+static int chan_new_connection_cb(struct l2cap_chan *chan,
+				  struct l2cap_chan *new_chan)
+{
+	if (!l2cap_chan_set_ops(new_chan, &bt_6lowpan_chan_ops, THIS_MODULE))
+		return -ENODEV;
+
+	set_bit(FLAG_RELEASE_CREATOR, &new_chan->flags);
+	return 0;
+}
+
+static void chan_teardown_cb(struct l2cap_chan *chan, int err)
+{
+	chan->state = BT_CLOSED;
+
+	if (test_and_clear_bit(FLAG_RELEASE_CREATOR, &chan->flags))
+		l2cap_chan_put(chan);
+}
+
 static const struct l2cap_ops bt_6lowpan_chan_ops = {
 	.name			= "L2CAP 6LoWPAN channel",
+	.new_connection		= chan_new_connection_cb,
 	.recv			= chan_recv_cb,
 	.close			= chan_close_cb,
 	.state_change		= chan_state_change_cb,
@@ -885,7 +900,7 @@ static const struct l2cap_ops bt_6lowpan_chan_ops = {
 	.get_sndtimeo		= chan_get_sndtimeo_cb,
 	.alloc_skb		= chan_alloc_skb_cb,
 
-	.teardown		= l2cap_chan_no_teardown,
+	.teardown		= chan_teardown_cb,
 	.defer			= l2cap_chan_no_defer,
 	.set_shutdown		= l2cap_chan_no_set_shutdown,
 };
@@ -899,7 +914,12 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 	if (!chan)
 		return -EINVAL;
 
-	chan->ops = &bt_6lowpan_chan_ops;
+	if (!l2cap_chan_set_ops(chan, &bt_6lowpan_chan_ops, THIS_MODULE)) {
+		l2cap_chan_put(chan);
+		return -ENODEV;
+	}
+
+	set_bit(FLAG_RELEASE_CREATOR, &chan->flags);
 
 	err = l2cap_chan_connect(chan, cpu_to_le16(L2CAP_PSM_IPSP), 0,
 				 addr, dst_type, L2CAP_CONN_TIMEOUT);
@@ -952,7 +972,9 @@ static struct l2cap_chan *bt_6lowpan_listen(void)
 	if (!chan)
 		return NULL;
 
+	/* The listener is closed by module_exit(), so it must not self-pin. */
 	chan->ops = &bt_6lowpan_chan_ops;
+	chan->ops_owner = THIS_MODULE;
 	chan->state = BT_LISTEN;
 	chan->src_type = BDADDR_LE_PUBLIC;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0df7bda54473..f6a87a44d8a6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -481,9 +481,27 @@ struct l2cap_chan *l2cap_chan_create(void)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_create);
 
+bool l2cap_chan_set_ops(struct l2cap_chan *chan,
+			const struct l2cap_ops *ops, struct module *owner)
+{
+	if (WARN_ON_ONCE(chan->ops_owner))
+		return false;
+
+	if (!try_module_get(owner))
+		return false;
+
+	chan->ops = ops;
+	chan->ops_owner = owner;
+	chan->ops_owner_pinned = true;
+	return true;
+}
+EXPORT_SYMBOL_GPL(l2cap_chan_set_ops);
+
 static void l2cap_chan_destroy(struct kref *kref)
 {
 	struct l2cap_chan *chan = container_of(kref, struct l2cap_chan, kref);
+	struct module *ops_owner = chan->ops_owner;
+	bool ops_owner_pinned = chan->ops_owner_pinned;
 
 	BT_DBG("chan %p", chan);
 
@@ -495,6 +513,8 @@ static void l2cap_chan_destroy(struct kref *kref)
 		l2cap_conn_put(chan->conn);
 
 	kfree(chan);
+	if (ops_owner_pinned)
+		module_put(ops_owner);
 }
 
 void l2cap_chan_hold(struct l2cap_chan *c)
@@ -1352,7 +1372,7 @@ void l2cap_send_conn_req(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ, sizeof(req), &req);
 }
 
-static void l2cap_chan_ready(struct l2cap_chan *chan)
+static int l2cap_chan_ready(struct l2cap_chan *chan)
 	__must_hold(&chan->lock)
 	__must_hold(&chan->conn->lock)
 {
@@ -1361,7 +1381,7 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 	 * procedure is complete.
 	 */
 	if (chan->state == BT_CONNECTED)
-		return;
+		return 0;
 
 	/* This clears all conf flags, including CONF_NOT_COMPLETE */
 	chan->conf_state = 0;
@@ -1377,7 +1397,7 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 
 	chan->state = BT_CONNECTED;
 
-	chan->ops->ready(chan);
+	return chan->ops->ready(chan);
 }
 
 static void l2cap_le_connect(struct l2cap_chan *chan)
@@ -4241,10 +4261,20 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 	__must_hold(&pchan->lock)
 {
 	struct l2cap_chan *chan;
+	struct module *owner;
+
+	if (pchan->state != BT_LISTEN)
+		return NULL;
+
+	owner = pchan->ops_owner;
+	if (!try_module_get(owner))
+		return NULL;
 
 	chan = l2cap_chan_create();
-	if (!chan)
+	if (!chan) {
+		module_put(owner);
 		return NULL;
+	}
 
 	l2cap_chan_lock(chan);
 
@@ -4260,10 +4290,12 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 		l2cap_chan_del(chan, 0);
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
+		module_put(owner);
 		return NULL;
 	}
 
 	l2cap_chan_unlock(chan);
+	module_put(owner);
 
 	return chan;
 }
@@ -5011,7 +5043,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	struct hci_conn *hcon = conn->hcon;
 	u16 dcid, mtu, mps, credits, result;
 	struct l2cap_chan *chan;
-	int err, sec_level;
+	int err, ready_err, sec_level;
 
 	if (cmd_len < sizeof(*rsp))
 		return -EPROTO;
@@ -5056,7 +5088,11 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 		chan->omtu = mtu;
 		chan->remote_mps = mps;
 		chan->tx_credits = credits;
-		l2cap_chan_ready(chan);
+		ready_err = l2cap_chan_ready(chan);
+		if (ready_err < 0) {
+			l2cap_send_disconn_req(chan, -ready_err);
+			l2cap_chan_del(chan, -ready_err);
+		}
 		break;
 
 	case L2CAP_CR_LE_AUTHENTICATION:
@@ -5180,9 +5216,10 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 {
 	struct l2cap_le_conn_req *req = (struct l2cap_le_conn_req *) data;
 	struct l2cap_le_conn_rsp rsp;
-	struct l2cap_chan *chan, *pchan;
+	struct l2cap_chan *chan, *chan_ref = NULL, *pchan;
 	u16 dcid, scid, credits, mtu, mps;
 	__le16 psm;
+	int err;
 	u8 result;
 
 	if (cmd_len != sizeof(*req))
@@ -5260,6 +5297,9 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
+	/* ->ready() may delete the channel. */
+	l2cap_chan_hold(chan);
+	chan_ref = chan;
 	l2cap_chan_lock(chan);
 
 	lockdep_assert_held(&chan->conn->lock);
@@ -5293,18 +5333,26 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		result = L2CAP_CR_PEND;
 		chan->ops->defer(chan);
 	} else {
-		l2cap_chan_ready(chan);
-		result = L2CAP_CR_LE_SUCCESS;
+		err = l2cap_chan_ready(chan);
+		if (err < 0) {
+			l2cap_chan_del(chan, -err);
+			chan = NULL;
+			dcid = 0;
+			credits = 0;
+			result = L2CAP_CR_LE_NO_MEM;
+		} else {
+			result = L2CAP_CR_LE_SUCCESS;
+		}
 	}
 
-	l2cap_chan_unlock(chan);
+	l2cap_chan_unlock(chan_ref);
 
 response_unlock:
 	l2cap_chan_unlock(pchan);
 	l2cap_chan_put(pchan);
 
 	if (result == L2CAP_CR_PEND)
-		return 0;
+		goto done;
 
 response:
 	if (chan) {
@@ -5321,6 +5369,10 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_LE_CONN_RSP, sizeof(rsp), &rsp);
 
+done:
+	if (chan_ref)
+		l2cap_chan_put(chan_ref);
+
 	return 0;
 }
 
@@ -5385,7 +5437,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	u16 mtu, mps;
 	__le16 psm;
 	u8 result, rsp_len = 0;
-	int i, num_scid = 0;
+	int err, i, num_scid = 0;
 	bool defer = false;
 
 	if (!enable_ecred)
@@ -5493,6 +5545,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
+		/* ->ready() may delete the channel. */
+		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
 
 		lockdep_assert_held(&chan->conn->lock);
@@ -5527,10 +5581,16 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			defer = true;
 			chan->ops->defer(chan);
 		} else {
-			l2cap_chan_ready(chan);
+			err = l2cap_chan_ready(chan);
+			if (err < 0) {
+				l2cap_chan_del(chan, -err);
+				pdu->dcid[i] = 0;
+				result = L2CAP_CR_LE_NO_MEM;
+			}
 		}
 
 		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
 	}
 
 unlock:
@@ -5558,7 +5618,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	struct hci_conn *hcon = conn->hcon;
 	u16 mtu, mps, credits, result;
 	struct l2cap_chan *chan, *tmp;
-	int err = 0, sec_level;
+	int err = 0, ready_err, sec_level;
 	int i = 0;
 
 	if (cmd_len < sizeof(*rsp))
@@ -5673,7 +5733,11 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			chan->omtu = mtu;
 			chan->remote_mps = mps;
 			chan->tx_credits = credits;
-			l2cap_chan_ready(chan);
+			ready_err = l2cap_chan_ready(chan);
+			if (ready_err < 0) {
+				l2cap_send_disconn_req(chan, -ready_err);
+				l2cap_chan_del(chan, -ready_err);
+			}
 			break;
 		}
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 278adb05c4c9..7a631581950f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1825,13 +1825,13 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 	return skb;
 }
 
-static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
+static int l2cap_sock_ready_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 	struct sock *parent;
 
 	if (!sk)
-		return;
+		return 0;
 
 	lock_sock(sk);
 
@@ -1846,6 +1846,8 @@ static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
 		parent->sk_data_ready(parent);
 
 	release_sock(sk);
+
+	return 0;
 }
 
 static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0badb93a5725..28e32e8cf3b6 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3155,7 +3155,7 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 	smp_distribute_keys(smp);
 }
 
-static void smp_ready_cb(struct l2cap_chan *chan)
+static int smp_ready_cb(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
@@ -3172,6 +3172,8 @@ static void smp_ready_cb(struct l2cap_chan *chan)
 
 	if (hcon->type == ACL_LINK && test_bit(HCI_CONN_ENCRYPT, &hcon->flags))
 		bredr_pairing(chan);
+
+	return 0;
 }
 
 static int smp_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
-- 
2.43.0

