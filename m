Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B220238C0A
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775931336; cv=pass; b=TAiONA6v8iOR1jxqp93USExyXXycRXy3S/dBF497j25l/nb0JqZb219a98SIT4na9EgnF3G7/s3slJE2FhJGWJYcu++vEdbjVTBSZlkJ8UdCSsWWRx1ngLA/IqDw9AwYNXUyqhhvM823b6kEbDEbSfefa3u6M9Kq5hUDETER4CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775931336; c=relaxed/simple;
	bh=w74YL+VzoUCyHdf5gsHOQVIdyBPapeGYfMWCgEQIW6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvLlyl971RV3MDOdjSLM55L9Ff2PXrC9nDtqEyZqS/tUGVhBLZzlzLLV5fZQLmDD3QFOQMw4C3AKZDTe7+78E+r2kLPhbpdO2Gm+5VV5zk/dQsDXWOns2sjhYnXuGucgZ+9pPb/V65mODgrLxuaWvNOm8mUqjzAC6ymjUskA2zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=WBvYdBFK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="WBvYdBFK"
Received: from monolith.lan (mobile-access-2e844b-114.dhcp.inet.fi [46.132.75.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ftMKR0HwMz49Q80;
	Sat, 11 Apr 2026 21:15:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1775931327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jQlMswpCUdsBDjN/Vh6BWmxAwpfHdXX0IB4rkFRqZxc=;
	b=WBvYdBFKYbnWIu2XsbzpGUPloArXjGcv3+3SEmZyNxH3IuFo5D2e7Bqmh2xaFnfaPywpTI
	q648yW3IQ12VnP909TnPs5DwUtlgV2CLLVcTPYwSQ/iP6bew8A44qcxc3B8akh7srHCsU7
	0OyEVYpH5BwbrQoEOtb5FqE7LdKjTaOrQYJg9Yn7FfazywIT8o2lpFr2HJp8WNi1qCUz/0
	YT0KbfFgKjmSTzSVRRhD2LEKMvXvi9nCxZl3u1+cvvarNHdKsiIsjhQi/QKXzNpr04kGWd
	EMw6BYovJflbuF8+SZaa2BICrA3LRu2doTbIE8EJSf4s0P3nKUwgTlCa2+mcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1775931327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jQlMswpCUdsBDjN/Vh6BWmxAwpfHdXX0IB4rkFRqZxc=;
	b=jfFZLMjq/XW499uVq8+KyeJJLi1luQF97h1q8jOjmEtTJZryRU6XwD0ytJkb+3tqRAnN0Y
	XqHxy/WS91ExqoH11tyQs2nm/jkDROPeTCCOSZaG5ripJvD8+BxQ5HcBoLsLrvwEQOMkjD
	mc9VTnE5+P6jnvzJ1NjPwyarsBcFOBP/2X18a5Weh2RUzoxlTP0fw/UOrJWfgxu3sDcyC0
	pG4IDiPitutLyV9uq93Fy448EfIPDt3uRxQhhoJh1tfT82MHgviJQztZDx4pM18ibP5r4Y
	TrhGxZBqfkmobFVBSDbw+c8ISUvqknN+5h9CS63NgCd/GX3MaZ0GN+ZKf8zLxA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1775931327;
	b=q7Rie1tF2ZECYzTimj/WvtDTYgmSZFQsra2tooaiDOQa1u039tidZKHH229VBYTy1LPeJ1
	QC/1ky1HZmZ/oYOOui7U4SgNGPptNe2C0UwSIAlermFGqcKNyP0t7sKYOug8NhA65txJ3C
	wyTMXNIRAIejA7qrnGadctEF7ZcHs3nW1QDUN422jDlJI8Ne+lLbk0/7QXT7a1miHlO8Oo
	uJHB7eQMAZJ8WEbOj6vW3HsI6cz6iw2fn2g1TNAJBDfQ8caq+px5GKXCffvG23pvLNFpId
	lD7NX/Piov8AI6m16C83uW0cgCb5GqCnqAJ0OncDjmyRHWZ3bUZlBToTVBHl7g==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2] Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister
Date: Sat, 11 Apr 2026 21:15:09 +0300
Message-ID: <afc0037c7237e101b50b68d969cc4202bede5f92.1775931137.git.pav@iki.fi>
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
    v2: initialize new_dev->hdev in disconnect_devices()
    
    Not very pretty, however breaking the theoretical cyclic locking chain
    in a proper way is more complicated as for b) we need to handle
    l2cap_chan going away in the middle of netdev setup, and for a) removing
    hdev as parent device maybe has some side effects.

 net/bluetooth/6lowpan.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2f03b780b40d..23a229ab6a33 100644
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
@@ -1250,6 +1270,7 @@ static void disconnect_devices(void)
 			break;
 
 		new_dev->netdev = entry->netdev;
+		new_dev->hdev = entry->hdev;
 		INIT_LIST_HEAD(&new_dev->list);
 
 		list_add_rcu(&new_dev->list, &devices);
@@ -1261,7 +1282,7 @@ static void disconnect_devices(void)
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

