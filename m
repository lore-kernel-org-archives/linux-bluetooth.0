Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B502F6179;
	Sat,  1 Nov 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998990; cv=pass; b=W/eRxnpJITuB5MeTZ0+JSwayCaiXEn8OrCwATD+VfAADL0kEBu3zDeP9PFrjJFxR0DU8jOxtVQxZKQE19XeKpG8YS1uRveCJPZko+vUe7A6RmIraeYlCXehVc+CKtTkpWWTNXZCjpeutKcqd8M7pP9zs2tbpLXEqAi70cz63xuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998990; c=relaxed/simple;
	bh=POBYKPjz+HjPdNm1RGyl0i9MVjsXU1hPNfD6ENXLYfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxI2ryfG79Fp6F0ISrVuNjq2tU/ebmkRUllyd0CBxfJ5DHE+P97yaHMSctt9oUGK6rSWiIfSwY/T0k/LPjN7VM+jnLnLt+w9fpdo7TjghWJgmWn1o5HL/syDBiTsRZUleVQ5gMasXxmqnSfEtYoGwEMtaUjqaGxjBnKPWNOT9Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=UekZp21W; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=WyECfwsD; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="UekZp21W";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="WyECfwsD"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4czGqh070Yz49PyD;
	Sat,  1 Nov 2025 14:09:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1761998976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciJLRxCGAN9L4RCpr1nkQTsT25MWPZtGIl9nybisvQo=;
	b=UekZp21W51190QayawxGU8msc4vNyybEWg6n2R1SLVKCtv7yk/Te6lcnLJ9eH/HAX5HSzi
	aFc0oOHacR5jU8q+q0kchKXkpmqlnKtHqEds09k7jTkmyVdyPpeTZezGJgxxO1OL/eQCgd
	2BiiwejcBVoMSIwaiQq1hYm35MAY9nsXyr0Fs+eq/gtnAlen/Y+JD0oNfVvUdvUXzqxsgy
	5pHPz8Tt7VpYWWtVD/6cQhbNWdNxb2+vqAr2/cIFMLuxaUtnq50/WZShjK/v2zX+82aWsy
	RT5Dn8KtQw6hfvTKdBsPq4h6PBEvv7YyPuHhkCKYQuxt9TWMFkNSQiQkEttFPg==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4czGqW1XqQzyxF;
	Sat,  1 Nov 2025 14:09:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1761998968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciJLRxCGAN9L4RCpr1nkQTsT25MWPZtGIl9nybisvQo=;
	b=WyECfwsDECOxTBPgMwvP7SK8rBuxjpKzvh86HTGhhSiZH8uPZktLrTxmSSb74j4wzMSzgi
	dSyBW51w2LTLSmP/YrYUC6DLpdG8UIcZmsRiiV36Rl997W0GjpIBiKJekGWUfOT942ngw5
	+ZZ1c3PcC/mi3X8Fw/Wo9L/GebP/lts=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1761998968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciJLRxCGAN9L4RCpr1nkQTsT25MWPZtGIl9nybisvQo=;
	b=IOWtuQXXjiin07+WAD1NCqtskCQCt8lFVVrda2IsAyG9rBMRyBgVShfsyELLU56wzi3x4H
	N61YY0rXEBEfsjAyrvMletb5e666mF5vfVD4Navu8FMw3I4m0vZeo5CBsXV3wpeRjGyHSu
	i9hl/yR++o+wCq2N7aTTXN4XTHul+3c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1761998968; a=rsa-sha256; cv=none;
	b=Ts4nvjCK9eKho7u3aAn1vPEStKsmzi50rg+4UXra2e3RB09fcWxxuX6zxEJ7huZxj/GLco
	8WlR03TWQ2ZN8iGklvyd6A5siH2VtACVwMp2N7971zRxw4FUc0QMGRmAaY8fZK1Qq5lxOC
	WWZmjJ8imL3Zkot4yFXXzx9hNIXa+9w=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	jukka.rissanen@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
Date: Sat,  1 Nov 2025 14:09:13 +0200
Message-ID: <8736a4ce03f143b7a63cb99ab425e5403eafa9e4.1761998763.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
References: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
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
 net/bluetooth/6lowpan.c | 78 ++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 0d8c2e2e9a6c..f64bc4dc2b54 100644
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
@@ -1014,41 +1021,56 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
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
+		struct l2cap_chan *chans[64];
+		int i;
 
-		list_del_rcu(&peer->list);
-		kfree_rcu(peer, rcu);
-	}
-	spin_unlock(&devices_lock);
+		nchans = 0;
+
+		rcu_read_lock();
+
+		list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
+			list_for_each_entry_rcu(peer, &entry->peers, list) {
+				struct l2cap_chan *chan;
+
+				if (test_and_set_bit(LOWPAN_PEER_CLOSING,
+						     peer->flags))
+					continue;
+
+				chan = l2cap_chan_hold_unless_zero(peer->chan);
+				if (!chan)
+					continue;
+
+				chans[nchans++] = chan;
+				if (nchans >= ARRAY_SIZE(chans))
+					goto done;
+			}
+		}
+
+done:
+		rcu_read_unlock();
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

