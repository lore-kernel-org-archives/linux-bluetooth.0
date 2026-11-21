Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245081;
	b=f+qpkK4vsRV8ssiM+rNVGd1ZTdr1lkL1VKXctRlVw7YkpnSLqkER2XlrmZz2lwFds51k
	 tNWp53DjoR+GWah4zru0lZCklHMw/mHLjYlltC4rpq7NYy6rHqyi9JISLgqlO7f0tjkyC
	 Dz+uUMYGrXIQzxnWbG7zoCSVtheXKmO8euyZvfNe0eDbTuFUXVAMm7OOoAXXAXI/XndVo
	 zpoEwFLe4UqZWcs7Qxs4hNIEtoVL+2CUKDl1xAczr+O70MzNKiKy+CqJwsli/Vm5MHXH4
	 9aKyoE0bgfx23H4aKaQDCjI/P9Ag1Y5wX3vdT7XokZmCda70XBdNjrLqSslzrMYGb0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mna01FbMGtAeqEvxV+09r17BXVHQSxvuerCcr1g0HpI=;
	b=NWjNfDFxzajH5c0SZrjc8q6nuDkNrNHGo4EEFkX8Umj+uzLr8TgAlZv+ySAEmdAirkmZ
	 BYr8XBwEvg8sVjrLV85CeOFd5D5u2gx/tMXyASjMKY++xyYmNOkvcaw5q/ZAWivFf1Vdb
	 p4I56A1cUjc+n2Xn9dR9XZC1kw3fLKvH0keg751c+NGwy60vUZlpTjXthQ9hcyRanXaVC
	 S7G+at3Du/+GjseuEBod24X89qMKMyGiPWJiytRz6l6Ab0t3J1zti9/PXrLJm3wDgIvtA
	 M5CCTf8PRh90daMEIKcT/OJM02kuPSk7BpE33mjorC5Wc2qC+BVConY2NUaiulP/0bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xTIGyOY1;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11602606A331
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11602606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xTIGyOY1
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso906519a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795245080; x=1795849880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mna01FbMGtAeqEvxV+09r17BXVHQSxvuerCcr1g0HpI=;
        b=xTIGyOY1M1QQyKYB6+vKmsIqR09C4ArDOBpdjvFpj5R4B6lT5BkAisOoewu5yCsOiC
         6EbbIW0ip6aRnor6T7pFJjzPt3go8R2PcelYiuP9+L3CBpFXercz37+qYwZcnsmQhSj+
         kh5rRaCSlEYqpVeTF9pCGFfDNFyQJ/j0hPA1XHVHz6ac3j36f/4U6bY8YsjHOQNXsYm9
         ho7mlG/oANSdbrKswxiZERDWC2In8wvTtu4s1L4JHRLZ5juCxvHkbP3yVMlcr5GPUy9G
         So2ZyWQu2DjksCgIA8b0+c0rA4l5N1YF84ASPb5D+tJRhE/UmTkHqSaHRKuZe9rwjRYX
         kJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245080; x=1795849880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mna01FbMGtAeqEvxV+09r17BXVHQSxvuerCcr1g0HpI=;
        b=NkcIYYCil1mrreSZtKXmxvvBMn3lQfhjxe8di6O04EpeDVOcq/GSPyDQd85GyI53cm
         LE7uilgNY9VCkeS5ZeyTFUtC1ZPl51pYjWUSkYs2KFTOegISOWhoQWPyDMnuJIMDSsX3
         KMt+HZO42oAoNDLsZNRlXmqcSleASEa7yE/Sb9vIhYi/5gHYX156n38VMagXwAPrGLzi
         LLhufTLyOfO3XBP1YMx6myWAFWnIe5xY0YzlLH/Zsi5uIEizNRmSwhr5nYu81FXxDsM+
         86sROuKWqXbTLYwomq4BTCGxnLndvgVVToH3kbDPqaANIn6h4whH3g+r9mrxWfUqk1W8
         ZnPw==
X-Gm-Message-State: APuU4Z9J7pRfzPvGTx9DjhOtnz+GGxN4VaMGkjIURx3vveNuOVqhDKVA
	QpS8zR/8Wc+sfn3k5rPml64SElvVK+/O+0Uvs0MfrRNusAHeX70BfAkp
X-Gm-Gg: AZFdTZcce84CHmosuKMBrijFiOHMQ5gIjRxZGs8vV9IqSz3Rl4RUxxlk0M85pAM1Ddu
	2qgPOgP0p3xt1XNRdXJjmWuFONVs0lSp17xSGYEZPCXHrWXLK2tkfQ3JMA+OOmkXRvEzNSF3chX
	IRMiQXzfSYlq9tqfNsvQEMH4yf9WDbujWjDECyyhAQzAHWEzk7ZrNfQvU7prj30QL/bn517Nznc
	bwi/WIdymF9/n5jO7S8rb0kUYPatIy4z5QmKzoIFQD+LPyZ3gIRnzRJU2e3EI6W2amllS7bEFra
	k47ogYp1SSbiGX4puWIbRHLHoht8cxDmg+TN0H7NEUytKPLZV1vyvmQ9pWiOSlMRFXNqe4A5hlA
	XQ+kWrkdt2dHTrggq2pjljMZ9MeAh64jv+YFtqU0QukbP9PkjpbDXU3nnvklXLxcTxqjix/rshW
	mHSjFAAcGqk3Fent69rJeBODrFIAlVavVaK+9Luo+y2BJpqiOoLBo07FV7JFNMPBejUvJhrhUnL
	NLUZAtnawajRoYyEwBdcWI8yif3KZUodoiD60PyS4HoOrImUX7RSYAobdMhkVRv/6qvJj0WOAH5
	6Q2Cr6UWSzNJRsCwD28GMWcr
X-Received: by 2002:a17:90b:5289:b0:3ac:c005:cf07 with SMTP id 98e67ed59e1d1-3b41c92c416mr5762251a91.42.1795245080324;
        Fri, 20 Nov 2026 23:11:20 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d11753sm10614548a91.5.2026.11.20.23.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:11:20 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/2] Bluetooth: 6lowpan: Hold RTNL across adapter lookup and use
Date: Sat, 21 Nov 2026 15:11:09 +0800
Message-Id: <pm-bluetooth-objects-candidate-0228-v10-f6ced931e2322aa5c7b3-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0228-v10-f6ced931e2322aa5c7b3-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0228-v10-f6ced931e2322aa5c7b3-0@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lookup_dev() returns a borrowed adapter after dropping RCU. The last
peer's asynchronous deletion can unregister and free its netdevice while
a later ready callback uses that pointer:

  Ready callback                    Deletion worker
  lookup_dev()
  leave RCU
                                    lock RTNL
                                    unregister the netdevice
                                    remove the adapter from the list
  ifup(): wait for RTNL
                                    unlock RTNL and release storage
  open the stale netdevice

Take RTNL before lookup and retain it through peer publication and
device open. Use lowpan_register_netdevice() because registration now
runs with RTNL held, and remove the nested lock from ifup(). Deletion
cannot revoke the adapter between its lookup and last ready-callback use.

The excerpt below retains the headline and stack traces.

KASAN report as below:

    Oops: Oops: 0000 [#1] SMP KASAN NOPTI

    Workqueue: hci1 hci_rx_work
    RIP: 0010:dev_addr_check+0x4e/0x260

    Call Trace:
     <TASK>
     __dev_open+0xa8/0x6d0
     ? __pfx___dev_open+0x10/0x10
     netif_open+0xde/0x140
     ? __pfx_netif_open+0x10/0x10
     dev_open+0xb9/0x180
     chan_ready_cb+0x420/0xf90
     ? __pfx_chan_ready_cb+0x10/0x10
     ? lockdep_init_map_type+0x5c/0x230
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? l2cap_chan_put+0x48/0x3a0
     l2cap_le_connect_req+0xccd/0x11a0
     ? __pfx_l2cap_le_connect_req+0x10/0x10
     l2cap_recv_frame+0x467f/0x8830
     ? kfree_skbmem+0x15e/0x1d0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_l2cap_recv_frame+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? l2cap_recv_acldata+0x1eb/0x10e0
     ? __pfx___mutex_lock+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_unlock_slowpath+0x147/0x920
     ? __pfx_l2cap_conn_hold_unless_zero+0x10/0x10
     ? __pfx_hci_conn_enter_active_mode+0x10/0x10
     ? l2cap_recv_acldata+0x13d/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     l2cap_recv_acldata+0xe9f/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_rx_work+0x5a6/0xf00
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    RIP: 0010:dev_addr_check+0x4e/0x260

Fixes: 18722c247023 ("Bluetooth: Enable 6LoWPAN support for BT LE devices")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/6lowpan.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 68ca2f49dadc9..f01eb68cbf5a9 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -597,11 +597,11 @@ static void ifup(struct net_device *netdev)
 {
 	int err;
 
-	rtnl_lock();
+	ASSERT_RTNL();
+
 	err = dev_open(netdev, NULL);
 	if (err < 0)
 		BT_INFO("iface %s cannot be opened (%d)", netdev->name, err);
-	rtnl_unlock();
 }
 
 static void ifdown(struct net_device *netdev)
@@ -706,7 +706,7 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
 	list_add_rcu(&(*dev)->list, &bt_6lowpan_devices);
 	spin_unlock(&devices_lock);
 
-	err = lowpan_register_netdev(netdev, LOWPAN_LLTYPE_BTLE);
+	err = lowpan_register_netdevice(netdev, LOWPAN_LLTYPE_BTLE);
 	if (err < 0) {
 		BT_INFO("register_netdev failed %d", err);
 		spin_lock(&devices_lock);
@@ -735,12 +735,16 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 	struct lowpan_btle_dev *dev;
 	bool new_netdev = false;
 
+	/* Protect the device lookup and use against unregister. */
+	rtnl_lock();
+
 	dev = lookup_dev(chan->conn);
 
 	BT_DBG("chan %p conn %p dev %p", chan, chan->conn, dev);
 
 	if (!dev) {
 		if (setup_netdev(chan, &dev) < 0) {
+			rtnl_unlock();
 			l2cap_chan_del(chan, -ENOENT);
 			return;
 		}
@@ -748,10 +752,13 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 	}
 
 	if (!try_module_get(THIS_MODULE))
-		return;
+		goto out;
 
 	add_peer_chan(chan, dev, new_netdev);
 	ifup(dev->netdev);
+
+out:
+	rtnl_unlock();
 }
 
 static void unregister_dev(struct lowpan_btle_dev *dev)
@@ -763,7 +770,7 @@ static void unregister_dev(struct lowpan_btle_dev *dev)
 	 *
 	 * rtnl_lock -> put_device(parent) -> hci_release_dev ->
 	 * destroy_workqueue -> hci_rx_work -> l2cap_recv_acldata ->
-	 * chan_ready_cb -> ifup -> rtnl_lock
+	 * chan_ready_cb -> rtnl_lock
 	 *
 	 * However, hci_rx_work is disabled in hci_unregister_dev, so this
 	 * should not occur. Make lockdep happy by postponing hdev release after
