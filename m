Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D15275872
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482101; cv=pass; b=U+5oWS7+zKwZ14ECGGPcXrOeZPx7pBGKVn5l7cu5SiQryDbTJFmaLz+t8zmsziS5TolXfA75r4NrxyPHCaAuNLSxig2bbiIMv8fUSSZEttTgXfd41ko2PIIYOA39CU2X+1N9hblG5YoAKWFfyim+74C4rrZftl6NtHOahgJQ0xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482101; c=relaxed/simple;
	bh=v8TJwGOuy68GEeb8FeBm6TGN4zIPD5OWtt1sQ5oeUxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR9YXK+RRMctfAzm3x79qPVgF5oazHxcCH1W/Oer6tPdAkdt/F+NKbh2mrR/744f021irXsxWTL+lFmd1TFsPdwDgGtfyRG7IMTjHttCZPpL1eB3VjGvbTuWe5f8UK6UbnjIGMXyBDoQQyXdDIQQQLkNiKL2btqO0M7g+kBq0fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=QEQL1D0h; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="QEQL1D0h"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCF0tTFz10Fb;
	Sun, 21 Sep 2025 22:14:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Wfo7rjAMqx7bFb7kWVywivsY2g41WIozW8EKhDOOKs=;
	b=QEQL1D0h4zyfYZeCfNzd+zYDbVnyYDn1veHdG9OqJKb10LvEVHP99loq/ZI1aBpwhYLqQi
	ah8yJRRGU+LoXBeK3YQtl3lLddzlLAN4tKHYIdL9IhTMDshZyWOfjgwl6Ihow4eoBlLjpj
	/EIitIm3liQIfJ7WqfAJGhfQDJp0yIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Wfo7rjAMqx7bFb7kWVywivsY2g41WIozW8EKhDOOKs=;
	b=nvp6uAfKvMUlGS6OGDDOPbsof/0UK1EYoFE/YGnf+obqkoHKDW6TdThJsyq3OLbH4+R3yJ
	gMTAHd1/qT807EWtNdyFNbK5vtoXUX6HYgOEdTGPzZ67Ssl/0Lk1hAzEjqa1LEEWggK16V
	ueRVogBhd7tVUXWUhJE4zZ5SunErTes=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482089; a=rsa-sha256; cv=none;
	b=u0sYNKWXecnoNOZ4Xsx/oNZ5qc3j2TaWmvOgzkdEyuwT7kaUFZKS38ApOXltx955cHhZnz
	yXZdIoEl/lWBmz4IGL1HQtHSH+6gkUByT+PzmVR2Ov+IzY3tw8upERxs8mazToRQZT6GQZ
	U/3qmKZY0CzwNWWHlubxmytsDE9XBDc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 11/24] Bluetooth: hci_core: add lockdep check to hci_conn_hash lookups
Date: Sun, 21 Sep 2025 22:14:26 +0300
Message-ID: <f76d0c07ec1927ce8c097f3895a785fddef11266.1758481869.git.pav@iki.fi>
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

Callers of conn_hash lookup functions that return hci_conn*, shall hold
hdev->lock/rcu_read_lock covering dereferencing and other usage of the
returned conn. Cf. BUG!!! in Documentation/RCU/whatisRCU.rst

This makes builds with CONFIG_PROVE_RCU emit lockdep splats if these
functions are called without appropriate locks.

The lookup functions actually should instead not do rcu_read_lock() but
list_for_each_entry_rcu(c, &h->list, list, lockdep_is_held(&hdev->lock))
leaving locking to the caller. However, for now just emit lockdep
warning, in case there are remaining unconverted callsites.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    There's been several UAF from hci_conn* being deleted concurrently.
    
    It's probably a good idea to add these lockdep warnings in the
    hci_conn_hash functions, and to fix up whatever they reveal.
    
    RFC since probably should fix the issues these reveal...  I have an
    unfinished patch series that fixes up the lockdep splats these checks
    generate.
    
    Locking in hci_sync maybe needs some redesign there.
    
    General pattern is just
    
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
        do_something(conn);
        hci_conn_put(conn);

 include/net/bluetooth/hci_core.h | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2924c2bf2a98..b0f2adfdd5b4 100644
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
@@ -1253,6 +1275,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_role(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1274,6 +1298,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1300,6 +1326,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1332,6 +1360,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_cig(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1355,6 +1385,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1379,6 +1411,8 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1403,6 +1437,8 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle, __u16 state,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1426,6 +1462,8 @@ hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8 big)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1449,6 +1487,8 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1518,6 +1558,8 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-- 
2.51.0

