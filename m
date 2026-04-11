Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8E1A681D
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775927556; cv=pass; b=uYUZ259NdQg4m7VF7cNn2Kjj6NJiogo1/UrbOGR29xzqSr4y2mgCD6rOtYwDB/vxH++6YpDvaE5eKxN+1j53qzwEjCy0yCdoI6AQp92/RFEgFEcrluqatf9gbsOOevKiYzH9v9QifL2moabxVhwHQjnVyT/ImgH8ErncZ4SWHVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775927556; c=relaxed/simple;
	bh=9z/ryWCURgJTV2crBl7XG4SLwnNlb/hoZE2CIjgi/Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFSKdnCE9pJxT+q5QngXs2ClGy18st8Y7kaK35n+BuFns/9QfwFp4Wgi4ExmXMROlrrX3PpiA/K83lKXSgh8rNVZO800lhHrxPDmggR1LQtKhRGsDaNCCY7RO4PGiSTd5fLxQsrHNFAhSvW+w/WOLIGxHyALkZX1etadvvUjy8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=imfKOePN; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="imfKOePN"
Received: from monolith.lan (mobile-access-2e844b-114.dhcp.inet.fi [46.132.75.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ftKwq0d2Nz49Pyf;
	Sat, 11 Apr 2026 20:12:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1775927547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TWUKd2RZpQ1tY7/RP4sSkWSRH/cnXFlpYAHuQXkjdnM=;
	b=imfKOePNotNbEI8mO6pMifLho24mf+H6ouROIGxE+IfmpnNYcHkwkV3xCaDD4/eqA6WaVd
	wt1gSTMjXxIDlxj6VUxC9OMzYMvR4Uv0J6qe437+slCcqirtVMi+2qhhdy7EZJnAPbUYXl
	5+dRif6X14MvJTsmoXiVQoJjE9y5TWcmQDIs1we4pfYIn01wS87Q1sRatKT+ATbJzv7Njn
	aHRwAMvk/+W/4aRAhcbYECB7yH8tq+wdaGmwz9hCKxHfnG591wPKyqwjUp4xa/88NjLA0K
	2RC2pMFGR4Cugg3XsrDCxEXy+TBFaqzK7u6zYZvATATbblDUqgSU8p6jbwSJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1775927547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TWUKd2RZpQ1tY7/RP4sSkWSRH/cnXFlpYAHuQXkjdnM=;
	b=TV9ruYK7GUS2+uOFJ/WYEIWmBnmRBDbmGh5Cv4Oxd4V0u2FIdGSEah6k9jocNpMP75tcSr
	eb9BlX8K9FvRAjhOl30YnDe9jq/9MQT7RWzyjxrQ35/BLIl/tDCTPaarXMFkISkEQmMs3L
	9Ck5shuK4JrepB9Ob0mhkzZIdoZSDT76m1K+7wssabYHjMT76RwXZpTvwwnMpRGOfTO0zW
	L+toiSo0r2Cg45+TlvMPIJAwh9CaW60sAxldwArtmK/s3MsF/pf7axmIPfEO0BODcUG5eS
	SpvrNhPip+HKkrw+XmJEXQ/A6kz60Le6vX08yCydi/49znDjLbMB71nP0meelQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1775927547;
	b=VVyIIFaefKHU70aP4usN9rGCSw0D+nBydyMzcf6G97KivTKkuJLcbN8Y4gdU+3hJJXog15
	0w6d0elNcZwRMK6yzYrwfz4um0oel3kwVKnuQ6XXWPWmTSPR15btf+960QPz7DIiEO8Y81
	DsyqOVWnaLWEmD71p+K6vXQiF4VY51MPjj9xB97wRfZEoB9My/qay4OUXq+pcD9DxqET31
	G30aQl+tgI2QHpgpcl8c9NGDjBpR3s14eR5PpqpCqLBBh5V/dxxTvb0Hrm9eF6FemDn6g9
	HwRQEqZPCtDnOGx310P83oZLFgQI8dT1bNIXl7pezMsOBC9/tpsi38zLHArxOA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister
Date: Sat, 11 Apr 2026 20:12:22 +0300
Message-ID: <fec5396d32d1ad2c3c097d39c67b8b7a2ef7d1bc.1775927513.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6lowpan.c has theoretically conflicting lock orderings, which lockdep
complains about:

    a) rtnl_lock > hdev->workqueue

    from 6lowpan.c:delete_netdev -> rtnl_lock -> device_del
    -> put_device(parent) -> hci_release_dev -> destroy_workqueue

    b) hdev->workqueue > l2cap_conn->lock > chan->lock > rtnl_lock

    from hci_rx_work -> 6lowpan.c:chan_ready_cb
    -> lowpan_register_netdev, ifup -> rtnl_lock

Actual deadlock appears not possible, as hci_rx_work is disabled and
l2cap_conn flushed already on hdev unregister. Hence, do minimal thing
to make lockdep happy by breaking chain a) by holding hdev refcount
until after netdev put in 6lowpan.c.

Fixes the lockdep complaint:
WARNING: possible circular locking dependency detected.
kworker/0:1/11 is trying to acquire lock:
ffff8880023b3940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x8b/0x130
but task is already holding lock:
ffffffff95e4f9c0 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30
Workqueue: events delete_netdev

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Not very pretty, however breaking the theoretical cyclic locking chain
    in a proper way is more complicated as for b) we need to handle
    l2cap_chan going away in the middle of netdev setup, and for a) removing
    hdev as parent device maybe has some side effects.

 net/bluetooth/6lowpan.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2f03b780b40d..bd7f80c7e21e 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -758,13 +758,33 @@ static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
 	return chan;
 }
 
+static void unregister_dev(struct lowpan_btle_dev *dev)
+{
+	struct hci_dev *hdev = READ_ONCE(dev->hdev);
+
+	/* If netdev holds last reference to hci_dev (its parent device), this
+	 * leads to theoretical cyclic locking on lowpan_unregister_netdev:
+	 *
+	 * rtnl_lock -> put_device(parent) -> hci_release_dev ->
+	 * destroy_workqueue -> hci_rx_work -> l2cap_recv_acldata ->
+	 * chan_ready_cb -> ifup -> rtnl_lock
+	 *
+	 * However, hci_rx_work is disabled in hci_unregister_dev, so this
+	 * should not occur. Make lockdep happy by postponing hdev release after
+	 * netdev put.
+	 */
+	hci_dev_hold(hdev);
+	lowpan_unregister_netdev(dev->netdev);
+	hci_dev_put(hdev);
+}
+
 static void delete_netdev(struct work_struct *work)
 {
 	struct lowpan_btle_dev *entry = container_of(work,
 						     struct lowpan_btle_dev,
 						     delete_netdev);
 
-	lowpan_unregister_netdev(entry->netdev);
+	unregister_dev(entry);
 
 	/* The entry pointer is deleted by the netdev destructor. */
 }
@@ -1261,7 +1281,7 @@ static void disconnect_devices(void)
 		ifdown(entry->netdev);
 		BT_DBG("Unregistering netdev %s %p",
 		       entry->netdev->name, entry->netdev);
-		lowpan_unregister_netdev(entry->netdev);
+		unregister_dev(entry);
 		kfree(entry);
 	}
 }
-- 
2.53.0

