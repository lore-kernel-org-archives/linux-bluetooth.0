Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66127E7EC
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594604; cv=pass; b=Ou5YSTdFK5vbCoZjleVZUfuRqAX91cxEhPhudK3cm7eYJYjrRclN+49w0VN83xVeclx+9RpdgJOD2mObzvFSz6Kkvlo/tyRvzsB42Ogn3bg3Tn844KEWFPAZ26ymxgyQofuNeYGKfJz4C45ADe2KSp921pRqWht5g0O/mlwp0oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594604; c=relaxed/simple;
	bh=2hXH9P9X7hTfPqyDM6s51hzOSJZwRFTQyZ0o6yhivS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUtQBri9oMk7Dkkbe9rXIleTnYbT0ES4bkkMpMCxodSWmjuhGMQYjRG2HyQDBArBPF6T6q0KG5HKUW0B4oQVDzazjYswTMezq+o+PEYXC62jirEDlzOkJRvnfLgyLOR6z3GkwpZSIq6AQKzkFcHH3SYeuXrO3dkz0j+fz3+Tfdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=okcXuLWL; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="okcXuLWL"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cf9df20mTzyRk;
	Sat,  4 Oct 2025 19:16:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759594598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ah4Q9PIcPv4LrBb/6PtXQhbmnqsHEOitWzqmwFXK2Ek=;
	b=okcXuLWLfDFhw/RInjNQAfLEHUKqwnSS9fqNBnsDcVg+AwsI3B/QPbTd8qYfLaYyHibDle
	3HvseSS1BapBqvAPmxcK3J3IGOytxm5mkw9RikCEc56EQPzcEXDeLaBNj7jeiGf1grEVyZ
	tGjMOz5XBx7SgW7/DU2Nugzn8Lq7KIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759594598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ah4Q9PIcPv4LrBb/6PtXQhbmnqsHEOitWzqmwFXK2Ek=;
	b=A0WTuP3TIa43UqH1aipbzKEcjtHoqlfNmxTgv8/463I9hPF3Kc24Avv6oEEYLs5Zdm4e4n
	159wKqC5yV+QZD79MnoNMnYz1mPHmeMuOYYfkERYkmNxTknX2yqLQAScnU2moOFG4ytXAM
	EaY+LdTIwbM4jhgOriBzI4xAby5PLOQ=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759594598; a=rsa-sha256; cv=none;
	b=w/PNasMdYhyTNO/0kFpvl9JKmOmJQlxAzohG+Mc6h/ZLYXfe307u/HsYC69LMsKnDkoSK3
	nTaIjodhFz1M4B2WBqmJSPYGYKY4kuglchWjYBlGCFooM0AYh6GOWIlR8bXmCh/iCzxoaV
	HaG+T0UWoqWfmfWlA7Rv9Ft9VYNzswE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: hci_core: lookup hci_conn on RX path on protocol side
Date: Sat,  4 Oct 2025 19:16:32 +0300
Message-ID: <7800021eedeb9a335091e88a9547eaa98777bb82.1759594217.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hdev lock/lookup/unlock/use pattern in the packet RX path doesn't
ensure hci_conn* is not concurrently modified/deleted. This locking
appears to be leftover from before conn_hash started using RCU
commit bf4c63252490b ("Bluetooth: convert conn hash to RCU")
and not clear if it had purpose since then.

Currently, there are code paths that delete hci_conn* from elsewhere
than the ordered hdev->workqueue where the RX work runs in. E.g.
commit 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
introduced some of these, and there probably were a few others before
it.  It's better to do the locking so that even if these run
concurrently no UAF is possible.

Move the lookup of hci_conn and associated socket-specific conn to
protocol recv handlers, and do them within a single critical section
to cover hci_conn* usage and lookup.

Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This patch only fixes races concerning hci_conn access on RX path.
    
    What still looks suspicious here is data races on sco_data and iso_data.
    
    Eg. sco_conn_free() holds no lock when it sets conn->hcon->sco_data = NULL;
    so things like
    
    Task 1: conn = LOAD(hcon->sco_data)
        Task 2: sco_conn_put(same conn)
        Task 2: STORE(hcon->sco_data, NULL)
        Task 2: kfree(conn)
    Task 1: sco_conn_hold_unless_zero(conn) -> UAF
    
    IIUC *_hold_unless_zero is meant to be used with RCU or rwlock.
    
    In L2CAP access to hcon->l2cap_data is protected by hdev->lock
    (except in l2cap_disconn_ind see
    https://lore.kernel.org/linux-bluetooth/68e12ad7.050a0220.bce5e.000e.GAE@google.com/ )

 include/net/bluetooth/hci_core.h | 20 ++++++---
 net/bluetooth/hci_core.c         | 73 +++++++++++---------------------
 net/bluetooth/iso.c              | 30 ++++++++++---
 net/bluetooth/l2cap_core.c       | 23 +++++++---
 net/bluetooth/sco.c              | 35 +++++++++++----
 5 files changed, 108 insertions(+), 73 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2924c2bf2a98..6ccc00153d2f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -856,11 +856,12 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
+int sco_recv_scodata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb);
 #else
 static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  __u8 *flags)
@@ -868,23 +869,30 @@ static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return 0;
 }
 
-static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+static inline int sco_recv_scodata(struct hci_dev *hdev, u16 handle,
+				   struct sk_buff *skb)
 {
+	kfree_skb(skb);
+	return -ENOENT;
 }
 #endif
 
 #if IS_ENABLED(CONFIG_BT_LE)
 int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+	     u16 flags);
 #else
 static inline int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  __u8 *flags)
 {
 	return 0;
 }
-static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
-			    u16 flags)
+
+static inline int iso_recv(struct hci_dev *hdev, u16 handle,
+			   struct sk_buff *skb, u16 flags)
 {
+	kfree_skb(skb);
+	return -ENOENT;
 }
 #endif
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3418d7b964a1..31fc853080a3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3832,13 +3832,14 @@ static void hci_tx_work(struct work_struct *work)
 static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_acl_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "ACL packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3850,36 +3851,27 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hdev->stat.acl_rx++;
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
-
-	if (conn) {
-		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
-
-		/* Send to upper protocol */
-		l2cap_recv_acldata(conn, skb, flags);
-		return;
-	} else {
+	err = l2cap_recv_acldata(hdev, handle, skb, flags);
+	if (err == -ENOENT)
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
 			   handle);
-	}
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "ACL packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_sco_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "SCO packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3891,34 +3883,28 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hdev->stat.sco_rx++;
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
+	hci_skb_pkt_status(skb) = flags & 0x03;
 
-	if (conn) {
-		/* Send to upper protocol */
-		hci_skb_pkt_status(skb) = flags & 0x03;
-		sco_recv_scodata(conn, skb);
-		return;
-	} else {
+	err = sco_recv_scodata(hdev, handle, skb);
+	if (err == -ENOENT)
 		bt_dev_err_ratelimited(hdev, "SCO packet for unknown connection handle %d",
 				       handle);
-	}
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "SCO packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_iso_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "ISO packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3928,22 +3914,13 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
 		   handle, flags);
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
-
-	if (!conn) {
+	err = iso_recv(hdev, handle, skb, flags);
+	if (err == -ENOENT)
 		bt_dev_err(hdev, "ISO packet for unknown connection handle %d",
 			   handle);
-		goto drop;
-	}
-
-	/* Send to upper protocol */
-	iso_recv(conn, skb, flags);
-	return;
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "ISO packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 static bool hci_req_is_complete(struct hci_dev *hdev)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 954e1916506b..e81bee686df9 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2308,14 +2308,31 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	iso_conn_del(hcon, bt_to_errno(reason));
 }
 
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 {
-	struct iso_conn *conn = hcon->iso_data;
+	struct hci_conn *hcon;
+	struct iso_conn *conn;
 	struct skb_shared_hwtstamps *hwts;
 	__u16 pb, ts, len, sn;
 
-	if (!conn)
-		goto drop;
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	conn = iso_conn_hold_unless_zero(hcon->iso_data);
+	hcon = NULL;
+
+	hci_dev_unlock(hdev);
+
+	if (!conn) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	pb     = hci_iso_flags_pb(flags);
 	ts     = hci_iso_flags_ts(flags);
@@ -2371,7 +2388,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			hci_skb_pkt_status(skb) = flags & 0x03;
 			hci_skb_pkt_seqnum(skb) = sn;
 			iso_recv_frame(conn, skb);
-			return;
+			goto done;
 		}
 
 		if (pb == ISO_SINGLE) {
@@ -2449,6 +2466,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
+done:
+	iso_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb iso_cb = {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 805c752ac0a9..318374a579e9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7509,13 +7509,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
 	return c;
 }
 
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int l2cap_recv_acldata(struct hci_dev *hdev, uint16_t handle,
+		       struct sk_buff *skb, u16 flags)
 {
+	struct hci_conn *hcon;
 	struct l2cap_conn *conn;
 	int len;
 
-	/* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
-	hci_dev_lock(hcon->hdev);
+	/* Lock hdev for hci_conn, and race on l2cap_data vs. l2cap_conn_del */
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	hci_conn_enter_active_mode(hcon, BT_POWER_FORCE_ACTIVE_OFF);
 
 	conn = hcon->l2cap_data;
 
@@ -7523,12 +7534,13 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		conn = l2cap_conn_add(hcon);
 
 	conn = l2cap_conn_hold_unless_zero(conn);
+	hcon = NULL;
 
-	hci_dev_unlock(hcon->hdev);
+	hci_dev_unlock(hdev);
 
 	if (!conn) {
 		kfree_skb(skb);
-		return;
+		return -EINVAL;
 	}
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
@@ -7642,6 +7654,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 unlock:
 	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ab0cf442d57b..298c2a9ab4df 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1458,22 +1458,39 @@ static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	sco_conn_del(hcon, bt_to_errno(reason));
 }
 
-void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+int sco_recv_scodata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb)
 {
-	struct sco_conn *conn = hcon->sco_data;
+	struct hci_conn *hcon;
+	struct sco_conn *conn;
 
-	if (!conn)
-		goto drop;
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	conn = sco_conn_hold_unless_zero(hcon->sco_data);
+	hcon = NULL;
+
+	hci_dev_unlock(hdev);
+
+	if (!conn) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	BT_DBG("conn %p len %u", conn, skb->len);
 
-	if (skb->len) {
+	if (skb->len)
 		sco_recv_frame(conn, skb);
-		return;
-	}
+	else
+		kfree_skb(skb);
 
-drop:
-	kfree_skb(skb);
+	sco_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb sco_cb = {
-- 
2.51.0

