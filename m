Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C052F37
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482185; cv=pass; b=XCSSCSni5Hm/eTzLHRC6DDUB6DxnkptL2cXV3BsUQN7cGGcBp9SPhcsfB8tgNsjmT1V1uQailEC9j9Gdq1nTz1rLAzjVtfIug6dOyENgqnBVdDXs6kd8OlLgkdtKkEdUR6HKxjEN865teKdRInvDZyDG7AziFC13kN5T4bgAjWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482185; c=relaxed/simple;
	bh=3T7LzSrgmUzzuvvQkSOF2QuO0M9G0OwTi3cLa+S4chY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRzRWA7PCKT8XOzhge09I6lDZi3siLeDCMSlhrXaAZcLlAi/YJ/EkBwP4pSpSOu+FsTpjjRjZetNiyBnrrgy5JJsyFJnXhZT99AEvBm046+wVp8n0eNZt6E+WOTl+MXjE3yKBe0LvqkqV3awym3tKfwf9aeOLZttruvdqdXQFO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nnu56DR1; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nnu56DR1"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGDr0K7tz49Q5g;
	Sun, 21 Sep 2025 22:16:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilUKpzP+YRBAtFyIReLjM5+2sfZ+OmpSUb9nUFp0vqM=;
	b=nnu56DR1p60Qo13Pki8LmPKwG6KaUVdObYmu9FPbXFehbSNFJETAnq6zWjeTXsZc4TNajg
	9TUWBmpy16mBIMJAfot2J2RWmFIKv0STh+ajVQ4OyTHIbmDrP5V+DtH0Nw8Oo24Ap22Xxh
	WyEcwHOnjm5TlkMG2U2OTuF+WBGpRwy5ZhYrnWHXVaNF12rbJuQsYqWvt3imqHbi0RdiB4
	1/UDwyrbqSrOUVjah0tDF1QWK4W8EN455XDmqdfjruX7mm4Zl6mxWx8l7K/iGa+eLlVSYt
	yytswKJojzXYCDWL/SzaHYldFNI8M+KgrL7XjWWzDE14z0ivEnweTCud3+spXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilUKpzP+YRBAtFyIReLjM5+2sfZ+OmpSUb9nUFp0vqM=;
	b=a4b6DfKLSj9GMW1S8FEq7aE/uWaq7iOP3J7cYBKziHRckDr0G19Pvjbs5QUrjTP/R2Qjyg
	2JdGhdGERRdqCVYmnagebgrJSgPDbQKAgVpa4Wesz+VngLRDzEkrLP8xFCqi+sSS4qiXOM
	+Qnk5V/nMTI+6fjB6Qs4JkA1c78uoWQd8KWgLCT+9TWLmDlPfmJ+GU0Gg0wYrSF+NgbkQ2
	2D8DZrRbbKOQ6BtkUuZm5ibHz+oZjCZorbCkWdSxwLGzHi7w/CuEk7Ohzzpc0W3jOmXlqi
	+GOZfDc6+vmuSN7kTUU6M7Scdl9jzqArzctK2lEnZoGbwUmYBI+XY523NZW12g==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482172; a=rsa-sha256;
	cv=none;
	b=i1ELXKOUKLGKVo+HXpXO5/EtQY0VzwhI+OuuWYqjyyItmlQvg+IcvtTKKPtQNGWNUggzR+
	aKO3SM06NyHBT03o/iwyHL0ZWr3pa7FhZ5RlSNwdB933JiDUEBCI3xxd1NsLoJa8qhY5Jy
	PnO90sqMo1W5vmfnxjYh6g+v+1wLNrCZTWVizNpDpJWmb2kPSIhha9AsvglefGLcefyj4u
	a/AyRNY/g8XZ1yTzS7PT+x5LAmncHiRcCT/DU6TiyuuwuKKLfbtlEcjTH6xT25ly6NIeaP
	7+AonERElHxiKILPnQmCHBvwoSnuwI9AKEBjULyDFLQTxYXhyP2Ye5NeDaXeig==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 15/24] Bluetooth: lookup hci_conn on RX path on protocol side
Date: Sun, 21 Sep 2025 22:15:59 +0300
Message-ID: <0cf70209fd963e621aeb6c204d24a97c078c57af.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lock/lookup/unlock pattern in the packet RX path is unsafe. The lock
needs to be held as long as the hci_conn is used.

The critical section varies somewhat between protocols, so pass handle
to the protocol recv handler, and do conn lookup there.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h | 20 +++++++---
 net/bluetooth/hci_core.c         | 64 ++++++++------------------------
 net/bluetooth/iso.c              | 30 ++++++++++++---
 net/bluetooth/l2cap_core.c       | 24 +++++++++---
 net/bluetooth/sco.c              | 35 ++++++++++++-----
 5 files changed, 99 insertions(+), 74 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 68a5c3214cfe..1e9b27b3b108 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -856,11 +856,12 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, __u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
+int sco_recv_scodata(struct hci_dev *hdev, __u16 handle, struct sk_buff *skb);
 #else
 static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  __u8 *flags)
@@ -868,23 +869,30 @@ static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return 0;
 }
 
-static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+static inline int sco_recv_scodata(struct hci_dev *hdev, __u16 handle,
+				   struct sk_buff *skb)
 {
+	kfree_skb(skb);
+	return 0;
 }
 #endif
 
 #if IS_ENABLED(CONFIG_BT_LE)
 int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int iso_recv(struct hci_dev *hdev, __u16 handle, struct sk_buff *skb,
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
+static inline int iso_recv(struct hci_dev *hdev, __u16 handle,
+			   struct sk_buff *skb, u16 flags)
 {
+	kfree_skb(skb);
+	return 0;
 }
 #endif
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f106586cc5a3..35483f614a1c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3842,13 +3842,14 @@ static void hci_tx_work(struct work_struct *work)
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
@@ -3860,36 +3861,24 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3901,34 +3890,25 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3938,22 +3918,10 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
 }
 
 static bool hci_req_is_complete(struct hci_dev *hdev)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index f5a9a13317df..541e71aef6bd 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2301,14 +2301,31 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	iso_conn_del(hcon, bt_to_errno(reason));
 }
 
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int iso_recv(struct hci_dev *hdev, __u16 handle, struct sk_buff *skb,
+	     u16 flags)
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
+	if (!conn) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	hci_dev_unlock(hdev);
 
 	pb     = hci_iso_flags_pb(flags);
 	ts     = hci_iso_flags_ts(flags);
@@ -2364,7 +2381,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			hci_skb_pkt_status(skb) = flags & 0x03;
 			hci_skb_pkt_seqnum(skb) = sn;
 			iso_recv_frame(conn, skb);
-			return;
+			goto done;
 		}
 
 		if (pb == ISO_SINGLE) {
@@ -2442,6 +2459,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
+done:
+	iso_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb iso_cb = {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 805c752ac0a9..9370b7bd226a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7509,13 +7509,23 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
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
 
@@ -7524,13 +7534,14 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 	conn = l2cap_conn_hold_unless_zero(conn);
 
-	hci_dev_unlock(hcon->hdev);
-
 	if (!conn) {
+		hci_dev_unlock(hdev);
 		kfree_skb(skb);
-		return;
+		return -ENOENT;
 	}
 
+	hci_dev_unlock(hdev);
+
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
 
 	mutex_lock(&conn->lock);
@@ -7642,6 +7653,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 unlock:
 	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d382d980fd9a..b5746e4caf20 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1451,22 +1451,39 @@ static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	sco_conn_del(hcon, bt_to_errno(reason));
 }
 
-void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+int sco_recv_scodata(struct hci_dev *hdev, __u16 handle, struct sk_buff *skb)
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
+	conn = hcon->sco_data;
+	if (!conn) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	sco_conn_hold(conn);
+	hci_dev_unlock(hdev);
 
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

