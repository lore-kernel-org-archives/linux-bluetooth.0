Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632C4B5409
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005178; cv=none; b=uFmvN7KOBf1RbobeHLLkPCrW4zvkCrVRi3VlZML+10/gIaucykEHcloJD0830m46cuVVxuK7vOLSIOfLMfSSgbVTy1TyhNCGS1h13j5qRYmohz8gzUI3hMR6K3RUzisJ2VWGfHFWYFimQOlA/6opMePUHP7BH7Drx6R+HTvknGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005178; c=relaxed/simple;
	bh=8gYOgwL82gLctBDUo5hY0Mf4FC393MJ0QflOqBAlaI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bffaN5P5CM7qGjPiF86A6jxo9RSflroGpzpLKENYXoSdD3D9J4KUfbYpxzn+pGgzyVF4Skxbwegcd3DTk/LZseDUYVMBxt/+5hYbDUkIB4BuV63asvmChZD4RPvJiTA2jCDNOV565C5Z0QUcNKomsPgrIbQyKnvw1LZs8XDoWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYLmtnvG; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYLmtnvG"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e2254dso463999b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005175; x=1790609975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQQ4QUI52Sa5O7i3Cjz9FO5zM2Do0eGarq+pPmIyhnc=;
        b=HYLmtnvGDt3N+3cD67nR65l6U43wDXTEls/J77w1RchPea2tivAOmkXBY75Abb+sxN
         keb0QTVZgrzT9fm1II3gK6HLS8y5LwIb8ADpHtM1O59APPt5EQC+KW8jlOzwaXRdp0/l
         icQLd2VEOwNf336swQ95wNEKHw9+tCpk5zHmm1j8cqep/j22eJ7J+7qrAnmefqs3Z2eu
         WxiSKpw5GVeRW0v3lz8qTm7EheNFWKqkcPGRNKj8zn8Gl2/hLFSkDUIcYWpdQUTgu1uw
         yhDI1BLDL1sqkABd58AGmiVeqkS8iYMvCHE8XvEyDlkrTjjQkmO/HxLcPOVUsYZyX34R
         earA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005175; x=1790609975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQQ4QUI52Sa5O7i3Cjz9FO5zM2Do0eGarq+pPmIyhnc=;
        b=IHWQS2qvMkTaWYsZlrvpXe7XOFRuHPzVezLwVZZqxcWaGeySmo4sIKQ7n47GowsE64
         FiunG4bwflZa86a7fjceDHbloS6iexcGoZib0XX87ueHGEEoDTJbr+3SpDIR6TXW6euX
         LlGyrrbGVmLc6OKM6BPZPAP4ARB/Ye3m2dxB1EBTAdoZrOh1zDytgixMbFxCYICyQfn+
         Ef8TpNmwzkkeZETu28kOuj+TUEZ1dEcQFVSipzfQq3Qzv63XttoKAaPM/WHFbN09U/Wf
         uhuF6zK5rujmghMtmhqvwZmd+qBJKd/WNh9u8K9saGUb/BxVni+i4DhPJgrJXh/6og+L
         wU5A==
X-Forwarded-Encrypted: i=1; AKwUvBzsVwN0tz4nd0iPBRuHCfbnzKkF21jHIXoMtr1nBjoFT7XUOiqp3lNZ7mVV8QUxJuJUb7ry41x4aS98+x03Rwg=@vger.kernel.org
X-Gm-Message-State: AFuF++mb96jpzzhWjKGEmgBjPHxjSPNu4wChdcfD+AEj062ptTSQKi++
	DBZMxIjQjI0qwvLq09uf6bJQeIc7empOqDeoKgaqBakUmmjGBN97qf+P
X-Gm-Gg: AYBFou0nqeBIKeR4uBX+C5oqsXylT6G9NA/g2ZpyuE1+9+JQCKENug3TxQqeWNSCofI
	k5R6GlOLzIw2DsW2dn91w7cU/QdMru8pdh59Qq2EN+jukiXK93Y9fensOwuPaI5dvLxSUlEUsqA
	1zo/66XDogzO+mgWv4IB//xRM1yMxWqlEmpHkzo/IcMz//ccKYmEgbBE+Fgwt8mT84gBnEEIxXj
	b/J0r4OGga6KO7a1ac4Dv4gNSzLK/rHXM3K0GPbtX0aYqimPxD5XQUeRQrfnI2hdB30Qd3v/rzx
	6bYKeCwK+ksf84miX4t4FXS7tYLfrhJ/jHrHcpZUQomvUtyw811FPtV7QdHl32YdBA6N5Qaa9pX
	3RiDe/XCUAdf8ZcgIUIVdCXaUn4zOoe0Is6ADmFEVjfkecZmdtAJ6JSAE8Vq7i1t6Me+oBkzrTV
	LFB5M363/rcKrApa6WiSKeO1wPHsvNFuK1qsX5rsBijzuLBK1AzxNDvj++fX3nxk4VEw==
X-Received: by 2002:a05:6a00:148f:b0:869:86ae:e94f with SMTP id d2e1a72fcca58-87bbef82b42mr18320b3a.4.1790005174987;
        Mon, 21 Sep 2026 08:39:34 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm3448186b3a.2.2026.09.21.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:39:34 -0700 (PDT)
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
Subject: [PATCH 5/5] Bluetooth: 6lowpan: quiesce peers before channel deletion
Date: Mon, 21 Sep 2026 23:39:02 +0800
Message-Id: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-5@gmail.com>
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

6LoWPAN removes a peer and drops its channel reference from the close
callback. A transmitter which already observed the RCU-published peer
can still use the freed channel. Keeping the allocation alive alone is
insufficient: a transmitter which passed the deletion check can enqueue
a packet after L2CAP has purged the transmit queue.

Move peer cleanup to teardown, before FLAG_DEL and the transmit purge.
Mark the channel closed, unlink the peer under devices_lock, then drop
the lock and wait for network RCU readers with synchronize_net(). Free
the peer and release the initial channel reference only after those
transmitters have returned. Queue last-peer network-device deletion
before releasing the channel's ownership reference.

Disabling 6LoWPAN must also close the listener before sweeping existing
peers. Otherwise a request holding the old listener can publish a child
after the sweep. Serialize the transition with set_lock: requests which
complete admission before listener teardown are included in the sweep,
and requests which reach the closed listener are rejected.

The transmit/removal race produced this report:

    [   59.413897] BUG: KASAN: slab-use-after-free in send_pkt+0x3b1/0x3e0
    [   59.415014] Write of size 8 at addr ffff88810cf0e4a0 by task python3/583
    [ ... report excerpt omitted ... ]
    [   59.490444] Freed by task 504:
    [ ... report excerpt omitted ... ]
    [   59.493046]  kfree+0x307/0x580
    [   59.493497]  l2cap_chan_put+0x273/0x3a0
    [   59.494020]  l2cap_disconnect_req+0x613/0x890
    [ ... report excerpt omitted ... ]

Fixes: 6b8d4a6a0314 ("Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/6lowpan.c | 64 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 5c49dc146086..60d2c6d1be99 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -61,7 +61,6 @@ enum {
 
 struct lowpan_peer {
 	struct list_head list;
-	struct rcu_head rcu;
 	struct l2cap_chan *chan;
 
 	/* peer addresses in various formats */
@@ -100,7 +99,6 @@ static inline bool peer_del(struct lowpan_btle_dev *dev,
 			    struct lowpan_peer *peer)
 {
 	list_del_rcu(&peer->list);
-	kfree_rcu(peer, rcu);
 
 	if (atomic_dec_and_test(&dev->peer_count)) {
 		BT_DBG("last peer");
@@ -776,16 +774,15 @@ static void delete_netdev(struct work_struct *work)
 	/* The entry pointer is deleted by the netdev destructor. */
 }
 
-static void chan_close_cb(struct l2cap_chan *chan)
+static void chan_teardown_cb(struct l2cap_chan *chan, int err)
 {
 	struct lowpan_btle_dev *entry;
 	struct lowpan_btle_dev *dev = NULL;
-	struct lowpan_peer *peer;
-	int err = -ENOENT;
+	struct lowpan_peer *peer = NULL;
 	bool last = false;
-	bool queued;
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
+	chan->state = BT_CLOSED;
 
 	spin_lock(&devices_lock);
 
@@ -794,7 +791,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
 		peer = __peer_lookup_chan(dev, chan);
 		if (peer) {
 			last = peer_del(dev, peer);
-			err = 0;
 
 			BT_DBG("dev %p removing %speer %p", dev,
 			       last ? "last " : "1 ", peer);
@@ -802,19 +798,28 @@ static void chan_close_cb(struct l2cap_chan *chan)
 		}
 	}
 
-	if (!err && last && dev && !atomic_read(&dev->peer_count)) {
-		spin_unlock(&devices_lock);
+	spin_unlock(&devices_lock);
 
-		cancel_delayed_work_sync(&dev->notify_peers);
+	if (peer) {
+		/* ndo_start_xmit() holds network RCU while using peer->chan. */
+		synchronize_net();
+		kfree(peer);
 
-		ifdown(dev->netdev);
+		if (last && dev) {
+			bool queued;
 
-		queued = schedule_module_work(&entry->delete_netdev,
-					      delete_netdev, THIS_MODULE);
-		WARN_ON_ONCE(!queued);
-	} else {
-		spin_unlock(&devices_lock);
+			cancel_delayed_work_sync(&dev->notify_peers);
+
+			ifdown(dev->netdev);
+
+			queued = schedule_module_work(&entry->delete_netdev,
+						      delete_netdev, THIS_MODULE);
+			WARN_ON_ONCE(!queued);
+		}
 	}
+
+	if (test_and_clear_bit(FLAG_RELEASE_CREATOR, &chan->flags))
+		l2cap_chan_put(chan);
 }
 
 static void chan_state_change_cb(struct l2cap_chan *chan, int state, int err)
@@ -873,6 +878,9 @@ static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)
 static int chan_new_connection_cb(struct l2cap_chan *chan,
 				  struct l2cap_chan *new_chan)
 {
+	if (chan->state != BT_LISTEN)
+		return -EINVAL;
+
 	if (!l2cap_chan_set_ops(new_chan, &bt_6lowpan_chan_ops, THIS_MODULE))
 		return -ENODEV;
 
@@ -880,19 +888,11 @@ static int chan_new_connection_cb(struct l2cap_chan *chan,
 	return 0;
 }
 
-static void chan_teardown_cb(struct l2cap_chan *chan, int err)
-{
-	chan->state = BT_CLOSED;
-
-	if (test_and_clear_bit(FLAG_RELEASE_CREATOR, &chan->flags))
-		l2cap_chan_put(chan);
-}
-
 static const struct l2cap_ops bt_6lowpan_chan_ops = {
 	.name			= "L2CAP 6LoWPAN channel",
 	.new_connection		= chan_new_connection_cb,
 	.recv			= chan_recv_cb,
-	.close			= chan_close_cb,
+	.close			= l2cap_chan_no_close,
 	.state_change		= chan_state_change_cb,
 	.ready			= chan_ready_cb,
 	.resume			= chan_resume_cb,
@@ -1103,20 +1103,22 @@ static void disconnect_all_peers(void)
 
 static void do_enable_set(bool flag)
 {
-	if (!flag || enable_6lowpan != flag)
-		/* Disconnect existing connections if 6lowpan is
-		 * disabled
-		 */
-		disconnect_all_peers();
+	bool disconnect;
+
+	mutex_lock(&set_lock);
 
+	disconnect = !flag || enable_6lowpan != flag;
 	enable_6lowpan = flag;
 
-	mutex_lock(&set_lock);
 	if (listen_chan) {
 		l2cap_chan_close_unlocked(listen_chan, 0);
 		l2cap_chan_put(listen_chan);
+		listen_chan = NULL;
 	}
 
+	if (disconnect)
+		disconnect_all_peers();
+
 	listen_chan = bt_6lowpan_listen();
 	mutex_unlock(&set_lock);
 }
-- 
2.43.0

