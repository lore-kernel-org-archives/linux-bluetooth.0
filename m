Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562923BF8F
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763225051; cv=pass; b=XE/6JmahkyBnmnAvet0KVpB44XUnf+WqxigzEwDA5M0vIvLW7qMrovevRQKnWZmm6ojocYVKirPNo/LzpWfZRJOKrX2PMgjV/fDr7rFR9Ze1ZrM74v3nSsR4SeO0Hr6mx2G9O8PNnSUmjs8Eohaxv5i2g3EPW0IcxRw4whB1oXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763225051; c=relaxed/simple;
	bh=99O/VDVtehfwSOk7/om5C2OCjvJ5DfB/frOb0XhILCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcznGZOfyE4kbgTePQqgAao+iHPfsOhV7GvDuoM94ADqCYx090f1amlXp7t0hYCTRF91ffiW3RIRpVdfjN1aF8R5Uj+7Fh14L1nw1AaNmeRWWJ0FyriLLPA9Rj0wakYEzyQ4X39NEUfXECkZTgQMsxym7PZezwGNrFzfEOYSdi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jKJxpFv/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jKJxpFv/"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d80Fw4TNHzySs;
	Sat, 15 Nov 2025 18:44:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763225045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F8lP+9Dg+Yoy21GmTBMM4mEg/OAVR6Rzov2kvvcvRG4=;
	b=jKJxpFv/b3WsSukFQZZVDdTlVc6eUSek6ugFZ0QjXInaMVsHQyDYet9LLMsfnLzngZZ4da
	igzsIm5mr4/P02rZGPidrbugZQejgGLtK6zlIjG9sKAGHfAs68lQZttQhsA+VIQ2GXsWw2
	dlhRW8/SLJl9PAg20XKu4MGw9TWYzbI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763225045;
	b=oMMglLW5PeWLrFekxWIdAv8lhptVaYXejaiAylw0jcoB4jRHbODVe0IKlbMYHKr4mBORMG
	CvrfqKm43rxdV92Oqf/PUqmG0r1eAfqkuzcewaFWO8utsaNpmYcChwU4p5KcINMRKXmxRY
	SLdtmUiuJVdyDQxK2bXYkF++s2Uws5k=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763225045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F8lP+9Dg+Yoy21GmTBMM4mEg/OAVR6Rzov2kvvcvRG4=;
	b=q0f6kKH28UvFIPRcPc5JPKyp9YY7u87oQMlxiCf5PemRhQW6lySZqksNQuxncpdG6g2EXN
	/EhLUabuSqiFMNpjXPxL6qMUlhg8YGKO9gXJtWkiYw3VYeUVjbN8tYWyl9ZHlDoE2Jz9b2
	PXkUkl5ikmbMWnOkW6Wek6soIYaSm68=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	syzbot+d32d77220b92eddd89ad@syzkaller.appspotmail.com
Subject: [PATCH v2] Bluetooth: hci_core: lookup hci_conn on RX path on protocol side
Date: Sat, 15 Nov 2025 18:43:55 +0200
Message-ID: <183db933c90086f465918ac41188d730ac2bab4f.1763224083.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
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

syzkaller has reported a crash that appears to be this issue:

    [Task hdev->workqueue]          [Task 2]
                                    hci_disconnect_all_sync
    l2cap_recv_acldata(hcon)
                                      hci_conn_get(hcon)
                                      hci_abort_conn_sync(hcon)
                                        hci_dev_lock
      hci_dev_lock
                                        hci_conn_del(hcon)
      v-------------------------------- hci_dev_unlock
                                      hci_conn_put(hcon)
      conn = hcon->l2cap_data (UAF)

Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
Reported-by: syzbot+d32d77220b92eddd89ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d32d77220b92eddd89ad
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - uint16_t -> u16 in one case
    - no other changes, resend
    - add syzkaller issue to commit message
    
#syz test

 include/net/bluetooth/hci_core.h | 20 ++++++---
 net/bluetooth/hci_core.c         | 73 +++++++++++---------------------
 net/bluetooth/iso.c              | 30 ++++++++++---
 net/bluetooth/l2cap_core.c       | 23 +++++++---
 net/bluetooth/sco.c              | 35 +++++++++++----
 5 files changed, 108 insertions(+), 73 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9efdefed33c0..858b58206e80 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -857,11 +857,12 @@ extern struct mutex hci_cb_list_lock;
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
@@ -869,23 +870,30 @@ static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
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
index 9f686e5903a1..8c9bd20e0aa7 100644
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
index 14022e4937c2..c538e2ac48fc 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2452,14 +2452,31 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
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
@@ -2515,7 +2532,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			hci_skb_pkt_status(skb) = flags & 0x03;
 			hci_skb_pkt_seqnum(skb) = sn;
 			iso_recv_frame(conn, skb);
-			return;
+			goto done;
 		}
 
 		if (pb == ISO_SINGLE) {
@@ -2593,6 +2610,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
+done:
+	iso_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb iso_cb = {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 35c57657bcf4..07b493331fd7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7510,13 +7510,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
 	return c;
 }
 
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
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
 
@@ -7524,12 +7535,13 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
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
@@ -7643,6 +7655,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 unlock:
 	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e7273dc8a073..828ed56b9de7 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1463,22 +1463,39 @@ static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
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
2.51.1

