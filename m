Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80DD313277;
	Mon,  3 Nov 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194611; cv=pass; b=APcPAbFe5BZxtUbGcOxeCqYu7Eo8LH63q1rTVqyP59tskr7gKBbv4mp9vT5xPvplPenweBXkhHRzP7XciE9lp32aSQwrzvV2HFC/3VLmcBmSe7l28pQldWPR8xPmapFYW8uk+Dwfq3TWn8yr3+Ku7cH5ViovwrRYt3yFfsoAVu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194611; c=relaxed/simple;
	bh=D1tB6JYuyZk4uVaEWc2GtRyWQBJKnPs9Mp+QTE88+oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQO6K38rPXRuo+NxR0KWT/HDlwzrgmhUvs58cp0LsXwYSxY1qLRHdc/lTPB1iws7D6I4Bfv4fVqSKaYgGCD5oo0DlRy32Aw5JtTomgKHwg0P5o8iximAV2qbbQo98jjArWplnm93AABj5kdZoc4S3IjDKCjEwW36apK4eNp7Nec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=H5NOEtyo; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="H5NOEtyo"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d0g9h0ShgzyWQ;
	Mon,  3 Nov 2025 20:29:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762194600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6/asGlqcdTbmDKjZY7chBfvl4HfPDgjOb+0LtTrdkM=;
	b=H5NOEtyokV73kk8H5p1Zlm+KhbUo/9c2TZchhqP9ke7KqKy8ckn3I4E5TYNKuoDkqmk40G
	GnZegnzB6OouR0Myfgy4D0C8NR5UxhsT4GUvFz2Kcsll787+6Y/71EGKuJFulRF9e0bQHx
	jHzIttAgHVmyR849XYbiS2LcbpthO5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762194600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6/asGlqcdTbmDKjZY7chBfvl4HfPDgjOb+0LtTrdkM=;
	b=LId+uI3k9yNq/qULwbzZEriBMdwGRKOoXvGuTm7B9GcVStEPuLIR1FaYwKklwXUfGOZDzW
	rJxxbjKLfnnNVC41TE+QkKjVPaCLgVNCksp7uDMNnz0AW6wqG/ufaoYzZ8SlwghbNIPZDC
	yF45mXfR4YpHBLy1xshOuZt/VF0NW00=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762194600; a=rsa-sha256; cv=none;
	b=bAjLNBEKKF+FpNFs59U65sPaKjVqkbrqcb0GL6UzPng5b/2TafK0/x/2EfIwZOcp8VlKX0
	Taerh39Z97Z0B+zovhoGEyY9XCM7+eRoRExg398DHEqGKJQKs6Hyq7wJsVbOg+nVqXmaFd
	wyzBfqLpD0oRgZ+F2rcAHp4YbKDEdtQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
Date: Mon,  3 Nov 2025 20:29:49 +0200
Message-ID: <4e1e28ef5ea5d7783185eb43f7bdc02aaf569e16.1762194056.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
References: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

disconnect_all_peers() calls sleeping function (l2cap_chan_close) under
spinlock.  Holding the lock doesn't actually do any good -- we work on a
local copy of the list, and the lock doesn't protect against peer->chan
having already been freed.

Fix by taking refcounts of peer->chan instead.  Clean up the code and
old comments a bit.

Take devices_lock instead of RCU, because the kfree_rcu();
l2cap_chan_put(); construct in chan_close_cb() does not guarantee
peer->chan is necessarily valid in RCU.

Also take l2cap_chan_lock() which is required for l2cap_chan_close().

Log: (bluez 6lowpan-tester Client Connect - Disable)
------
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:575
...
<TASK>
...
l2cap_send_disconn_req (net/bluetooth/l2cap_core.c:938 net/bluetooth/l2cap_core.c:1495)
...
? __pfx_l2cap_chan_close (net/bluetooth/l2cap_core.c:809)
do_enable_set (net/bluetooth/6lowpan.c:1048 net/bluetooth/6lowpan.c:1068)
------

Fixes: 90305829635d ("Bluetooth: 6lowpan: Converting rwlocks to use RCU")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - Take devices_lock instead of RCU and use l2cap_chan_hold(). The
      unless_zero() variant is not correct here, as peer->chan l2cap_chan
      does not wait for RCU when its refcount hits 0.

 net/bluetooth/6lowpan.c | 74 +++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 0d8c2e2e9a6c..588d7e94e606 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -53,6 +53,11 @@ static bool enable_6lowpan;
 static struct l2cap_chan *listen_chan;
 static DEFINE_MUTEX(set_lock);
 
+enum {
+	LOWPAN_PEER_CLOSING,
+	LOWPAN_PEER_MAXBITS
+};
+
 struct lowpan_peer {
 	struct list_head list;
 	struct rcu_head rcu;
@@ -61,6 +66,8 @@ struct lowpan_peer {
 	/* peer addresses in various formats */
 	unsigned char lladdr[ETH_ALEN];
 	struct in6_addr peer_addr;
+
+	DECLARE_BITMAP(flags, LOWPAN_PEER_MAXBITS);
 };
 
 struct lowpan_btle_dev {
@@ -1014,41 +1021,52 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 static void disconnect_all_peers(void)
 {
 	struct lowpan_btle_dev *entry;
-	struct lowpan_peer *peer, *tmp_peer, *new_peer;
-	struct list_head peers;
+	struct lowpan_peer *peer;
+	int nchans;
 
-	INIT_LIST_HEAD(&peers);
-
-	/* We make a separate list of peers as the close_cb() will
-	 * modify the device peers list so it is better not to mess
-	 * with the same list at the same time.
+	/* l2cap_chan_close() cannot be called from RCU, and lock ordering
+	 * chan->lock > devices_lock prevents taking write side lock, so copy
+	 * then close.
 	 */
 
 	rcu_read_lock();
-
-	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
-		list_for_each_entry_rcu(peer, &entry->peers, list) {
-			new_peer = kmalloc(sizeof(*new_peer), GFP_ATOMIC);
-			if (!new_peer)
-				break;
-
-			new_peer->chan = peer->chan;
-			INIT_LIST_HEAD(&new_peer->list);
-
-			list_add(&new_peer->list, &peers);
-		}
-	}
-
+	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list)
+		list_for_each_entry_rcu(peer, &entry->peers, list)
+			clear_bit(LOWPAN_PEER_CLOSING, peer->flags);
 	rcu_read_unlock();
 
-	spin_lock(&devices_lock);
-	list_for_each_entry_safe(peer, tmp_peer, &peers, list) {
-		l2cap_chan_close(peer->chan, ENOENT);
+	do {
+		struct l2cap_chan *chans[32];
+		int i;
 
-		list_del_rcu(&peer->list);
-		kfree_rcu(peer, rcu);
-	}
-	spin_unlock(&devices_lock);
+		nchans = 0;
+
+		spin_lock(&devices_lock);
+
+		list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
+			list_for_each_entry_rcu(peer, &entry->peers, list) {
+				if (test_and_set_bit(LOWPAN_PEER_CLOSING,
+						     peer->flags))
+					continue;
+
+				l2cap_chan_hold(peer->chan);
+				chans[nchans++] = peer->chan;
+
+				if (nchans >= ARRAY_SIZE(chans))
+					goto done;
+			}
+		}
+
+done:
+		spin_unlock(&devices_lock);
+
+		for (i = 0; i < nchans; ++i) {
+			l2cap_chan_lock(chans[i]);
+			l2cap_chan_close(chans[i], ENOENT);
+			l2cap_chan_unlock(chans[i]);
+			l2cap_chan_put(chans[i]);
+		}
+	} while (nchans);
 }
 
 struct set_enable {
-- 
2.51.1

