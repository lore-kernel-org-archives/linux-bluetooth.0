Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ACE3264DA;
	Sun, 16 Aug 2026 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786875999; cv=pass; b=Q3Yq1cjGE0PRyy3Ylo2XvvAoBkYJIbB7VOxWRl20C0XPbO40+K8KW/nWDijOnutHpdeov5r4jqe8xRMO08EWVkqbaRJUx6FH8HZEKoD3J9CptcwwMCpxK5nzf+tTzN/FuGmsbz4Laec00YfEq41XxlWrXussrQDnP3qVgDdcXy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786875999; c=relaxed/simple;
	bh=d3eWd1pm1CveoBkP3yDDmVQs75UWHTdEuSBqkX7aIaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ql+3vQuIFBA4FIjxZpaR5xffy8FwB98YLf+AbXTyqv56+DCH/x89b8jsQM6ttD4wLQBQ6mUTI/PsFFyBzXkJKWP0TLL5f691j+9n720gTZR4ICqsAPbp6KnfAHEuxrRuGtMlupiv+foftf12GrwwKEDT4ebG0+oJDK7ynNTPQP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LkB+XRcq; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LkB+XRcq"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::de01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hNBvp5wRBzyc2;
	Sun, 16 Aug 2026 13:26:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786875991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n8IjqfqtC9ohUOYe2rEBiyqTmmuDoCIFxkxjsSs37fk=;
	b=LkB+XRcqi8tBmLsSucB/QtO41zl/NFfuAs9FR/gpZi82DBwcvzofEwmHjYfabdaqUqm+/e
	qyH5JU3bZSROe9hPBGAF5Kn9pZQh/IWUmuhEdI4NO5VKDdLXp3c88XNjR3O0b+XzuCzgh6
	xRLo9dAyY3MsN1fERttp/1tQggMuv8I=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786875991;
	b=Cm6KuEbEgOWDZNFzayZ7UIjZUDuaKmg61VWk1yMlEAREzRKv0/vqabkhtquuRCJL0qrFPW
	slYActGHVaPvgRCHAQ0kpizN4mEhjyitiD+P2pvyJu/MJSL3GvFLPEZPIpamainOSuCZhN
	JTLo7NW09Ano6RS6vt1yu+1cebQRMOI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786875991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n8IjqfqtC9ohUOYe2rEBiyqTmmuDoCIFxkxjsSs37fk=;
	b=S8GzddydiRZeHWkhfyKe2Sg7gEhKb33kdU0lIHkBcwRruHJPRBSDyMYHv3no3N8oRSyMbA
	BgZQd7H4ek9+U0lht/WAPfyLHTVNchC9MDS5B9xydrwUE5Sy7+Krp5TdE0FvT5N9qvS15R
	w8wBWxqu2hOUbFGd5FljsUr4IZb72iQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Bluetooth: hci_core: add lockdep check to hci_conn lookups
Date: Sun, 16 Aug 2026 13:26:21 +0300
Message-ID: <2be38d111362590f45776a0bc114f7890906ead9.1786875148.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add lockdep check for RCU || hdev->lock in hci_conn_hash lookups that
return hci_conn pointer, as dereferencing that without locks can be
TOCTOU issue. It used to be several callsites did not hold appropriate
locks.

The check is equivalent to removing rcu_read_lock() and doing instead
list_for_each_entry_rcu(c, &h->list, list, lockdep_is_held(&hdev->lock))
Although there should not be any remaining callsites without locks,
don't remove the rcu_read_lock() for now, and just add the warning here.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    resend:
    - no changes

 include/net/bluetooth/hci_core.h | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4105c446ca98..c12cd6873f65 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1030,6 +1030,9 @@ static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
 static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
+
+	lockdep_assert_held(&hdev->lock);
+
 	list_add_tail_rcu(&c->list, &h->list);
 	switch (c->type) {
 	case ACL_LINK:
@@ -1060,6 +1063,8 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 
+	lockdep_assert_held(&hdev->lock);
+
 	list_del_rcu(&c->list);
 	synchronize_rcu();
 
@@ -1088,6 +1093,15 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	}
 }
 
+#ifdef CONFIG_PROVE_RCU
+#define HCI_CONN_HASH_LOCKDEP_CHECK(hdev)				\
+	RCU_LOCKDEP_WARN(!lockdep_is_held(&(hdev)->lock) &&		\
+			 !rcu_read_lock_held(),				\
+			 "suspicious hci_conn locking")
+#else
+#define HCI_CONN_HASH_LOCKDEP_CHECK(hdev) do { } while (0 && (hdev))
+#endif
+
 static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
@@ -1169,6 +1183,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1191,6 +1207,8 @@ hci_conn_hash_lookup_create_pa_sync(struct hci_dev *hdev)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1217,6 +1235,8 @@ hci_conn_hash_lookup_per_adv_bis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1241,6 +1261,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1260,6 +1282,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1281,6 +1305,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_role(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1302,6 +1328,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1328,6 +1356,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1360,6 +1390,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_cig(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1383,6 +1415,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1407,6 +1441,8 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1431,6 +1467,8 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle, __u16 state,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1454,6 +1492,8 @@ hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8 big)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1477,6 +1517,8 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1546,6 +1588,8 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-- 
2.55.0

