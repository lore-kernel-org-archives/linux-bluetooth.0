Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD025B090;
	Sat, 11 Jul 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783780189; cv=pass; b=A8zqPXMEnIWGq5BEpRJFHhKWOISHXdckG8Isb8QpcVmQbIqmdamWuW/wA652WfScOjRPmvQEFO4ET4+8eW2A+i4ZdZM3Vmga1ZY7gRHoXZgINIiqW/ed/QJDYWHF5Q9XwBGqptYvUIxfsj38jzq60vfyUNYO82RAHGAmS6C5Ves=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783780189; c=relaxed/simple;
	bh=C/UtFAjrAlqRxFhAudeRBsFvnNwpVJ/hcEtkS9WQGdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cwXyGUlaeuIEr1hOS7iEB9gn7bQWTS3y5iGvR7yjSflYOI+r9L9O7KCHIwYhdoWnu6iJNnnlEhCyPt0ZQG4ujHa0+TYH0gX93mK7WPpUNnfgHl/pP+ymj/Zz5Oe1vMJr/pYssBDlNFJ/BBv/VSVscJUIfZ75t1cmjN2nND+zXf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AF4ObZnl; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AF4ObZnl"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gyB0z0JWjz49PxB;
	Sat, 11 Jul 2026 17:29:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783780180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4c1EQukzElznGRHyj2zO5pVYRgIud7up6IZj9QfW+FY=;
	b=AF4ObZnl+NWZ2V1CQ/uShAD6fThW6Q8yZwu7FLQ7Tib+ZkkoX0Po7rAB2/pJfShxuyYlcx
	emNv+Bu3K+nR+7bGHQ1FUN7sy+ee7Ah1NdHsYyJy92DLsjMfd/I0+dhgG/4zM741Q4U7HD
	ySPVDIaRqoiFgH/W49kHDuG9QO8uLdyAzmN/xVl8M76rGOXc7jrxVuTakWwQVTHaQNgODP
	YP0jmGrr+leoTyJdnY87YiqMyU6pTSSZ6kFHQlHd9E7JkGay0fYYjEIfNaykraBo6cMpK0
	s8t3exl295sGIO92/QiMWM4OOInqjmd8/gF+omJpRrec7D92Ebw2MlFjkFD4lg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1783780180;
	b=a99gktwDx73hQ91UOln1jKjH2RD69m+ABYG2P/MrkrB1oUrNNvpQHB/56Djk+OPzTv4dBe
	QaB9hzi6JTTi8M/y4aSxk21xhMxNBrKq3qQsXW1qX/gr7whWRXunzAW9EhNzDHLN0FAvRg
	XzpnoDQiopvUKdumACoB4hGeLvsoZBxBDWlxBEn1IKa4ZoWhOVqA9LUXtIGJcj4uFDrD0H
	yIW7gYl9veGy6jjGWtUJAfPF1LPuOxvkWt/Ih5KGCFGmYETSnidIFsP8t5Al3gQj8dGnkZ
	/BeDtDqjwpvSWIGrG1vbmye8I7oYkQNvtrSGe4bYFJp+fqF7HNzFnd3mYgaUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1783780180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4c1EQukzElznGRHyj2zO5pVYRgIud7up6IZj9QfW+FY=;
	b=kIXsJi/rVYaYDJwM2R0RKjhICtEn6nsTTSuHHY50pCb4V+rEtEwJYKnGz4JuoSlqBWvDVl
	xh9yFSxPoiP6+mr69xqdbNgo8p4Luf+Z8+aP21imqlqhv+vjteeuuW2ijV4ftH1UoGL/W1
	ZqG7fVIE1gKqGZXkjaWX5LjohUHIw0/3U/1ly2zHg8n82BmP9m+M/7AplB5gCdpny4u44r
	yWDPITB6DvqHrHHAIB3nH2fP2ahxHv1MC3d1STNxz/Sd786J/NA18/eLEVbCqcN5UW/XjB
	EE/mCzl8v8SZqosu7u/XQk8299TWEg8uXh36OeL+8+jE5HatisZQTIj/WcQWMA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: add lockdep check to hci_conn lookups
Date: Sat, 11 Jul 2026 17:29:32 +0300
Message-ID: <df21b30ef45a6616b32f79c2133c7c2dc19edcc3.1783779953.git.pav@iki.fi>
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
    The patch series recently merged in bluetooth-next/master added the
    locks at remaining callsites, so we should be able to turn this on.
    
    Unfortunately, Context analysis can't do the RCU || hdev->lock
    check here as it can't OR lock requirements except in __guarded_by,
    so we can only add the lockdep check.
    
    It can however be used for checking the callsites: I added
    __must_hold(&hdev->lock) annotation to the lookups, and manually went
    through the warnings and checked if RCU was held at the callsite.  Based
    on this, I did not find any remaining callsites in current code that
    would emit these lockdep splats.

 include/net/bluetooth/hci_core.h | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e7133ff87fbf..211810788a11 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1012,6 +1012,9 @@ static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
 static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
+
+	lockdep_assert_held(&hdev->lock);
+
 	list_add_tail_rcu(&c->list, &h->list);
 	switch (c->type) {
 	case ACL_LINK:
@@ -1042,6 +1045,8 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 
+	lockdep_assert_held(&hdev->lock);
+
 	list_del_rcu(&c->list);
 	synchronize_rcu();
 
@@ -1070,6 +1075,15 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
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
@@ -1151,6 +1165,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1173,6 +1189,8 @@ hci_conn_hash_lookup_create_pa_sync(struct hci_dev *hdev)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1199,6 +1217,8 @@ hci_conn_hash_lookup_per_adv_bis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1223,6 +1243,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1242,6 +1264,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1263,6 +1287,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_role(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1284,6 +1310,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1310,6 +1338,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1342,6 +1372,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_cig(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1365,6 +1397,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1389,6 +1423,8 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1413,6 +1449,8 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle, __u16 state,
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1436,6 +1474,8 @@ hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8 big)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1459,6 +1499,8 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -1528,6 +1570,8 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-- 
2.55.0

