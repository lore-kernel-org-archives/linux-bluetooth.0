Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D22749C0
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713053; cv=pass; b=YF7JtGo9JBqjHU8TzDYCjvSMW7uUWHGXjfdByrYPKiWyLaCEqjiFp4a/kalgJB0WWSPkrGpjVJMazFixsQCZaZuX6CEDKdXJTh+EsexHISpeyGsVdi+HI8kKdnEc1MdsC8Cw/yjJVL1eT9QXkPQHpvT62HwEYdUMn5Yos+qgqKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713053; c=relaxed/simple;
	bh=xC2OGUSQC2MBW6pcyf00NWS0cE8V5weZlf4og1M9+lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foNPeJ4q3hIxXZfHHGdEE0/GuAWG4DqL41Se68XLdgNeYYTX7UCiht1uz9wz6V+53Xah0mVVuV4qxuNjQ8Afxr1x1JWOf0DcPWnCk29U5TXYwB5kB2eXYTWxAWZXDCbxfGnt386lSAkQVkX6AitmAPZRESEMCvNb8AcmpD7oJgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=E/Vw3Qne; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="E/Vw3Qne"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cNnnq3wPfzySL;
	Sat, 13 Sep 2025 00:37:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1757713040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Hj6QvR0U8VAAGoop8sOtMsBxWOMfx5K0GSPe5d5iM4=;
	b=E/Vw3Qnetfo+AMUR6ATTmtC3DNnN+FhoElaPCf3kOMN7cFDLNyY4hc/X/wW82eZ12DXm/j
	6EGBpMvxft1tgbYLf0fDtTganS3/WzKiADoGteA17Kw1/G2MqBp0uApfLmHnt8G+bU9joX
	s8H7izAqpqoFysCLW775WothvjeICWM=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1757713040; a=rsa-sha256; cv=none;
	b=SN8VMUvmkWQr+MS3Ms0sb5a4ex5lUz0KAKPGXPFsqs7Oo1yrm2B3A87rJuZUIICt/Zfgav
	bHNeWdg8NG8Z+XQjdnk+PEiP89UvlkUIeYfIwWda4EI7vgNaDkQNewXnPVEYpbDiYXZdTP
	mctmidVS0R2vWgprQFUVyM2JloeGBAw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1757713040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Hj6QvR0U8VAAGoop8sOtMsBxWOMfx5K0GSPe5d5iM4=;
	b=Pqj7dfny47xRMetapP1Dsz76he92TMtwB9WtOwag4vXxUbxWMj/3HS6249dyD6ZbGw4gv/
	ObVqYh83rJ/ukHJyc/PEZ0sc8Ck/FyRJVuBUaRtac9n+o+iZwM57ZRtlMYZzgaVeKjJdyH
	LLLPsEYvzTLSDt/LhBwGmvgf5DwC49A=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 1/2] Bluetooth: hci_core: add lockdep check to hci_conn_hash lookups
Date: Sat, 13 Sep 2025 00:37:11 +0300
Message-ID: <7fed0c48a73265242c440611825888c096c4c93a.1757712988.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using conn_hash lookup functions that return hci_conn*,
hdev->lock/rcu_read_lock shall cover dereferencing and other usage of
the returned conn. Cf. BUG!!! in Documentation/RCU/whatisRCU.rst

This makes builds with CONFIG_PROVE_RCU emit lockdep splats if these
functions are called without appropriate locks.

The lookup functions actually should not call rcu_read_lock(), but do
list_for_each_entry_rcu(c, &h->list, list, lockdep_is_held(&hdev->lock))
leaving locking to the caller. However, for now just emit lockdep
warning but don't change locking here to not change behavior in existing
callsites.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    There's been several syzkaller concurrency bugs vs. hci_conn* locking.
    
    It's probably a good idea to add these lockdep warnings in the
    hci_conn_hash functions, and to fix up whatever they reveal.
    
    It used to be that hci_conn* handling was mostly single-threaded and all
    this was unnecessary, however now that we are doing hci_conn_del() and
    other things in hci_sync from different concurrent workqueue, locking is
    needed or it gets dangerous...
    
    RFC since probably callsites should be fixed before this.  I have an
    unfinished patch series that fixes up the lockdep splats these checks
    generate.  The locking in hci_sync seems a bit harder to deal with,
    maybe needs some redesign there.
    
    General pattern should be
    
        hci_dev_lock(hdev); /* or rcu_read_lock() */
        conn = hci_conn_hash_lookup_xxx(hdev, ...);
        if (!conn) {
            hci_dev_unlock(hdev);
            return -ENOENT;
        }
        do_something(stuff);
        hci_dev_unlock(hdev);
    
    or
    
        rcu_read_lock();
        conn = hci_conn_hash_lookup_xxx(hdev, ...);
        if (conn)
            hci_conn_get(conn);
        rcu_read_unlock();
        if (!conn)
            return -ENOENT;
        do_something_carefully(conn);
        hci_conn_put(conn);

 include/net/bluetooth/hci_core.h | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 66523b74f828..0a77813fef1f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1060,6 +1060,18 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	}
 }
 
+/* TODO: later on, remove all rcu_read_lock() in lookups and use instead
+ * list_for_each_entry_rcu(c, &h->list, list, lockdep_is_held(&hdev->lock))
+ */
+#ifdef CONFIG_PROVE_RCU
+#define HCI_CONN_HASH_LOCKDEP_CHECK(hdev)				\
+	RCU_LOCKDEP_WARN(!lockdep_is_held(&(hdev)->lock) &&		\
+			 !rcu_read_lock_held(),				\
+			 "wrong hci_conn* locking")
+#else
+#define HCI_CONN_HASH_LOCKDEP_CHECK(hdev) do { } while (0 && (hdev))
+#endif
+
 static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
@@ -1141,6 +1153,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1163,6 +1177,8 @@ hci_conn_hash_lookup_create_pa_sync(struct hci_dev *hdev)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1189,6 +1205,8 @@ hci_conn_hash_lookup_per_adv_bis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1213,6 +1231,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1232,6 +1252,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1253,6 +1275,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1279,6 +1303,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1311,6 +1337,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_cig(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1334,6 +1362,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1358,6 +1388,8 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1382,6 +1414,8 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle, __u16 state,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1405,6 +1439,8 @@ hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8 big)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1428,6 +1464,8 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1497,6 +1535,8 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-- 
2.51.0

