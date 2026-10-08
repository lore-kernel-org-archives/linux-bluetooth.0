Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4B3644CF
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 04:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791433681; cv=none; b=M0wtPa2cP3e0W4NA8l/CigMlDIrV5QadnoylnjOQojxeJK3EbeMCOCpqrMqwctJtcAQKcjVpEexuAdH7d5BQ1IkEnKZnD3ZNpsVWP9qzsXpRQgfXxsU1gZSwBHPRAC9E6RUqR5n0qhqaKMrQf5/MpsnriN98BqypoY2lGqphAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791433681; c=relaxed/simple;
	bh=8yxs7YfzqvRVtKhBlK7Og0qPenjCv6X/6aJgf1antmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dgIN0QT70rapshePw4lxlXpolLrZY/cdAFfI09dKAn0zjsnUv0iioNzWWPTAef+O7ByuKP7jyf2TVucao/WR1y+n31D1eWUT7Np6cpGh6jQrFbnBGTudjSLdhorQiI9SYQuFYbLcwkRLTyNiJqFdEe0Nhj5DWUpgboknv5OBrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0pPywgs; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0pPywgs"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd1e069cb19so175313a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 21:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791433679; x=1792038479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZ778jZsa/l446uvpFqFZ0Ls/7AJyjZNff1uctiZNtk=;
        b=o0pPywgsOKUmeXzknQXH7kuIJh/IZK5y1/Fxhobje8t2HC0YhxpNfgGTh2aCpVvaEM
         7mLXrnY4STfMPTsEJn88GzIXsiyTO65NLA0TC3NRzxARTA0ewUuujiYNHVRr+vfATBte
         6CdOmHgzikifc7IkFY5iBu2wfVDRkodZYj/4GCuJJlwusl8ScliR42B8CizGaNKWIWbq
         L1K353qqHI5yGBcG/J/HVLHnlPtEpk+Letf9Ks/Fa/a4QmRpzpxjimipmlKUctHVJEds
         +9giLFYP5LCbhHdRZfEp4a56JJ6eQF49Z38/zB9Mtco8GeBfmrCVUPZM91gU1SMmtzUb
         0C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791433679; x=1792038479;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AZ778jZsa/l446uvpFqFZ0Ls/7AJyjZNff1uctiZNtk=;
        b=ukoPqm5jbeRXqvMb76KJYdRy3dXYu5epT04jF4nqPK41OXUXNeoK+kUGIFJfClJaVA
         HC0N6m+NuzYxAAJwEXc+sk+dzkhIthRm3bbrlI7qfFhZElbUbtQ+uW5hcHJfaborAfzr
         cKEnOOOZ6LZGnLUKM0xQsNAMInsbPUDdzITqcEM1CwLxgkpDwQhMQqnmZPOlZyBx1KhD
         frVqHN4TeNcj5EiMLi2SxOgDtRO14dqPEKi2sEczGfu9SHYpP2cxL5UqwLcfkIXN3hXk
         IUPcv7pXFv7wvRK4F49rNaZ3LEw8thkd/zvv5GeSvNt1Bx7OLjXB+2pD5Cumz3JO0q3u
         TSrw==
X-Gm-Message-State: AFq9FYLVPq+cNkIF/tewf6xpA00P3kMyxfe/f9dLtlmZ/4KC+u/rSoTt
	wzZ7l72ZOyW2TUWmQJ3PCnOXY1NhhQts/Pu6bcxuyQsxnNygCNgRhX+F
X-Gm-Gg: AYBFou2KvWZn9JQSRiA/yAY2zA6yXFUgRqvcQANJPaJuCVPMhDGIqFrd3SCBvh5jYp9
	4BEoraN/2tZagvWVbjfCsnmCw6sA4EOq4pCLpgnlT7FmXWCN5kVnwWrEG6PP38Fxs/n/3HrvPPo
	bvtxaH8zPzpF30TwwDQRIkR7Wejz+L6gYhqCQGFB2gFY2I3l3Q71yHuWo0V0G6tNfrVEKL7r8uG
	RwW9cdVXyA4wKvo9umm/zviKnToAlxuDRlQXes3+XLpAP342OsFVOZE4hiE0vKfiwlv4sIaox12
	Nq8Ca1RS1tHa1H2qI59tqq8KDQ6AXSTeCo0uXojfvdrv/ZZx9iGm4EYcVvmWvW5LLCYcIh0TNaP
	efjW5gY7Bf0/N12+p9hQ+dAgmHChKusixdEwAkr5FHwtMPbTBjNBbsqENWRsZx0ljV/6HjgHqqi
	FSfESz+0Z0lv+gG7CRiZJoHn2K9ue66w1Top8J0gbBD1vt/D9q8sRQPVAZ71UAc8v+Xw==
X-Received: by 2002:a17:90b:1e48:b0:3a2:aec0:6bc2 with SMTP id 98e67ed59e1d1-3a8a11974b2mr4050881a91.53.1791433679554;
        Wed, 07 Oct 2026 21:27:59 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aa0cbea8d3sm2319217a91.16.2026.10.07.21.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 21:27:59 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: 6LoWPAN: Serialize multicast sends with peer removal
Date: Thu,  8 Oct 2026 12:27:52 +0800
Message-Id: <pm-bluetooth-objects-candidate-0001-v6-7494fb26092a1231b75b@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A peer's channel must remain alive until send_mcast_pkt() finishes using
it. The multicast walk protects the lowpan_peer with RCU, but peer_del()
defers only the peer allocation. On disconnect, l2cap_chan_del() drops
the connection-list reference, chan_close_cb() removes the peer and drops
the original channel reference, and l2cap_conn_del() drops its temporary
reference. A ready channel can then be freed while multicast transmit
still holds the peer, causing send_pkt() to write chan->data after free.
Another peer can keep the interface up, so the last-peer shutdown does
not drain this transmission.

Hold devices_lock across the multicast walk and send_pkt() calls so that
peer removal cannot release the channel reference until the send finishes.
Use the bottom-half-safe variants for all devices_lock critical sections
because transmit runs in softirq context. This prevents transmit from
interrupting a process-context lock holder on the same CPU and deadlocking.
The LE send path uses atomic allocations and does not acquire the channel
or connection mutexes, preserving the existing lock order and teardown
sequence.

The reported access and release path were:

        [Thu Oct  1 11:52:32 2026] BUG: KASAN: slab-use-after-free in
    send_pkt+0x2c5/0x300
        [Thu Oct  1 11:52:32 2026] Write of size 8 at addr ffff88810be0f4a0
     by task python3/535
    [...]
    [Thu Oct  1 11:52:32 2026] Freed by task 502:
    [...]
    [Thu Oct  1 11:52:32 2026]  l2cap_chan_put+0x273/0x3a0
    [Thu Oct  1 11:52:32 2026]  l2cap_conn_del+0x36d/0x770
    [Thu Oct  1 11:52:32 2026]  l2cap_disconn_cfm+0x87/0xd0
    [Thu Oct  1 11:52:32 2026]  hci_disconn_complete_evt+0x319/0xa30
    [...]

Fixes: 90305829635d ("Bluetooth: 6lowpan: Converting rwlocks to use RCU")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 836add41f5..8732132c47 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -471,6 +471,11 @@
 	struct lowpan_btle_dev *entry;
 	int err = 0;
 
+	/*
+	 * Peer removal drops the channel reference, so RCU alone is not
+	 * enough.
+	 */
+	spin_lock_bh(&devices_lock);
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
@@ -502,6 +507,7 @@
 	}
 
 	rcu_read_unlock();
+	spin_unlock_bh(&devices_lock);
 
 	return err;
 }
@@ -657,10 +663,10 @@
 
 	lowpan_iphc_uncompress_eui48_lladdr(&peer->peer_addr, peer->lladdr);
 
-	spin_lock(&devices_lock);
+	spin_lock_bh(&devices_lock);
 	INIT_LIST_HEAD(&peer->list);
 	peer_add(dev, peer);
-	spin_unlock(&devices_lock);
+	spin_unlock_bh(&devices_lock);
 
 	/* Notifying peers about us needs to be done without locks held */
 	if (new_netdev)
@@ -695,17 +701,17 @@
 	(*dev)->hdev = chan->conn->hcon->hdev;
 	INIT_LIST_HEAD(&(*dev)->peers);
 
-	spin_lock(&devices_lock);
+	spin_lock_bh(&devices_lock);
 	INIT_LIST_HEAD(&(*dev)->list);
 	list_add_rcu(&(*dev)->list, &bt_6lowpan_devices);
-	spin_unlock(&devices_lock);
+	spin_unlock_bh(&devices_lock);
 
 	err = lowpan_register_netdev(netdev, LOWPAN_LLTYPE_BTLE);
 	if (err < 0) {
 		BT_INFO("register_netdev failed %d", err);
-		spin_lock(&devices_lock);
+		spin_lock_bh(&devices_lock);
 		list_del_rcu(&(*dev)->list);
-		spin_unlock(&devices_lock);
+		spin_unlock_bh(&devices_lock);
 		free_netdev(netdev);
 		goto out;
 	}
@@ -788,7 +794,7 @@
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
 
-	spin_lock(&devices_lock);
+	spin_lock_bh(&devices_lock);
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
 		dev = lowpan_btle_dev(entry->netdev);
@@ -808,7 +814,7 @@
 	}
 
 	if (!err && last && dev && !atomic_read(&dev->peer_count)) {
-		spin_unlock(&devices_lock);
+		spin_unlock_bh(&devices_lock);
 
 		cancel_delayed_work_sync(&dev->notify_peers);
 
@@ -817,7 +823,7 @@
 		INIT_WORK(&entry->delete_netdev, delete_netdev);
 		schedule_work(&entry->delete_netdev);
 	} else {
-		spin_unlock(&devices_lock);
+		spin_unlock_bh(&devices_lock);
 	}
 }
 
@@ -918,18 +924,18 @@
 
 	BT_DBG("conn %p dst type %u", conn, dst_type);
 
-	spin_lock(&devices_lock);
+	spin_lock_bh(&devices_lock);
 
 	peer = lookup_peer(conn);
 	if (!peer) {
-		spin_unlock(&devices_lock);
+		spin_unlock_bh(&devices_lock);
 		return -ENOENT;
 	}
 
 	chan = peer->chan;
 	l2cap_chan_hold(chan);
 
-	spin_unlock(&devices_lock);
+	spin_unlock_bh(&devices_lock);
 
 	BT_DBG("peer %p chan %p", peer, chan);
 
@@ -1053,7 +1059,7 @@
 
 		nchans = 0;
 
-		spin_lock(&devices_lock);
+		spin_lock_bh(&devices_lock);
 
 		list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
 			list_for_each_entry_rcu(peer, &entry->peers, list) {
@@ -1070,7 +1076,7 @@
 		}
 
 done:
-		spin_unlock(&devices_lock);
+		spin_unlock_bh(&devices_lock);
 
 		for (i = 0; i < nchans; ++i) {
 			l2cap_chan_close_unlocked(chans[i], ENOENT);
@@ -1195,7 +1201,7 @@
 	struct lowpan_btle_dev *entry;
 	struct lowpan_peer *peer;
 
-	spin_lock(&devices_lock);
+	spin_lock_bh(&devices_lock);
 
 	list_for_each_entry(entry, &bt_6lowpan_devices, list) {
 		list_for_each_entry(peer, &entry->peers, list)
@@ -1203,7 +1209,7 @@
 				   &peer->chan->dst, peer->chan->dst_type);
 	}
 
-	spin_unlock(&devices_lock);
+	spin_unlock_bh(&devices_lock);
 
 	return 0;
 }
@@ -1269,7 +1275,7 @@
 
 	switch (event) {
 	case NETDEV_UNREGISTER:
-		spin_lock(&devices_lock);
+		spin_lock_bh(&devices_lock);
 		list_for_each_entry(entry, &bt_6lowpan_devices, list) {
 			if (entry->netdev == netdev) {
 				BT_DBG("Unregistered netdev %s %p",
@@ -1278,7 +1284,7 @@
 				break;
 			}
 		}
-		spin_unlock(&devices_lock);
+		spin_unlock_bh(&devices_lock);
 		break;
 	}
 
