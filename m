Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B109298CBD
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102783; cv=none; b=ppJyFs4xuYu7OrDAels/ekh5ccAPFgpqQOxDhqascdk3dDY53U8SsK8Owd0ULMzkIodJidKy2KPMF/8twuTPzLHF7uGXTW67CYv4y4NnBW+UJuZUhlGbnun1+QK3zSmFQ0li3ryEWD53gIFhhimHot3YUoi878cE9QSzyk5EonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102783; c=relaxed/simple;
	bh=TkeS566MDajReDfuaFU1ldGv1YLV7mVEYG+7/1hbiKE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j5qylAz04wAHxwcUro8ze/pFP/s5BnxM2Jmrqk2YT1huVUp+vgup4x8RzcJuX4ZV/SZgbQEMZk5CfHeoxerobkMWimTmZLN+/RXzCjOWFvSiBNsvEcpIa31dOBfpqUi84J7jXc6aWK1LbyrpXz6MB3OveSNSxVYXEmT6K+nhQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAaLBTfD; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAaLBTfD"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5235d7f9599so2033438e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741102780; x=1741707580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=po1a4F6MdDvvaNqTi3HJHoZR2pHAIfLB0VrZU0oRn7E=;
        b=DAaLBTfDGOp0hxcPwnULYw60E/1P6/NbS3a4x+6DUz7jKR3C0s+zHyqCepJf1a05ON
         7Y/Nd+B7vNNTXkRsCvtgxIw8RZ2gKD1k18zj+4g6kOq/YOL0hW0r3Kij2gLgc/Exferi
         mUvDOgjTCcsQnT2i6pBVEhkaEBgKJOmMLgr2NDlR1Qj3rN9jqcoiBr54/qOnr1mgjh3j
         CsoJQpNLtD9s8zFEqywDTO5Lgf5cmKSIrQdQdUb90+so4MFcZiTBaXRX3c3xZXEFuWk0
         4BO+AHJfyHkY260hF5mIun4WlI9zB2+elzpow8FL1CGJNWykwUvkm9EpGCOBtZIpxoGJ
         jOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102780; x=1741707580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=po1a4F6MdDvvaNqTi3HJHoZR2pHAIfLB0VrZU0oRn7E=;
        b=ZGTLjjS+4NmqUVYmtdEV9LO3EJRh9P/AOMkSi2ZfCs9VKoUxoGqVIY02OXAV1jjgWv
         ZgjGwOdOSvaxVs0RGHDZAKVg41ApsS1W561mdfJVVA6XQRRahvWNZEPXPYgAvpa2qOnh
         LSxHec6bd0w2vCp9AMOibXgqaY+j9w39Nnfta0Lv5yAYQ9pMkJFPTF7zlmIP+QopZ0cU
         C0P/hNgImu8bC3w+Hrvigi1BJpPfXx62MGbRAa4knuFm3Dr/b9TICnmCtES5erlU7VZo
         cmCtwDnBf5rnQVp+kOmdBBaHvvtNhi10h+t6IdrMdbpRNL/KEi/i453xIIHOXsTtA4qe
         2+1w==
X-Gm-Message-State: AOJu0YwE7A+yVjaJY4wTngP+VGYoWYcHgY0refhe3Xm2zAnDhjT5IL1J
	gXeGrbM+CbOuovfXn2Za+n+kMsI68aFHwPD3R97NI2keoQ+0llOup4HT1Q==
X-Gm-Gg: ASbGncvYBzIXNMbPTqdpSzgtDhnAyXl49cC1O1d7TY2RZEbNP/blorHcJrMT/PpchwK
	Z/3FvdnCdsTcnd7qrbaOBEug5SnvR8x1JtMl6QkbRiaJHg5jirf2VkpWqNNQrTjqdsOGuU6DKwU
	Fjjv9h6ui5aNFqis0YBHVNIxa6eBIUPq3iAvKtTeW8yvKzT517swzoL5MVju9LBPFcXPGMIuFf5
	xloumjt6L4NgNilRXNC5DLjcM6VG/Bk3awZKK/CSYWzfAwl8r8bNwEG6sbIOvxs51hycc/3t8X/
	CIMM6YlkLsJLkn4ROM1X1qgVumfSXsCIgN0KB31KTU9JkCNSShFUGhYDdbzT4AqHF3xHnClQpoL
	z/3dbSofZsJ3DzA==
X-Google-Smtp-Source: AGHT+IFUTmTI8udAqoj5rHs/n6puyfMy7CJMaC4CsUkJ2a42HF2KMGHhztnfflY1pxks8ArUz8nUVg==
X-Received: by 2002:a05:6102:3e86:b0:4ba:9923:fa57 with SMTP id ada2fe7eead31-4c0449530acmr10985162137.15.1741102779430;
        Tue, 04 Mar 2025 07:39:39 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c0f01ce947sm2004729137.25.2025.03.04.07.39.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:39:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Revert "Bluetooth: hci_core: Fix sleeping function called from invalid context"
Date: Tue,  4 Mar 2025 10:39:34 -0500
Message-ID: <20250304153934.112156-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reverts commit 4d94f05558271654670d18c26c912da0c1c15549 which has
problems (see [1]) and is no longer needed since 581dd2dc168f
("Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating")
has reworked the code where the original bug has been found.

[1] Link: https://lore.kernel.org/linux-bluetooth/877c55ci1r.wl-tiwai@suse.de/T/#t
Fixes: 4d94f0555827 ("Bluetooth: hci_core: Fix sleeping function called from invalid context")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 108 +++++++++++--------------------
 net/bluetooth/hci_core.c         |  10 ++-
 net/bluetooth/iso.c              |   6 --
 net/bluetooth/l2cap_core.c       |  12 ++--
 net/bluetooth/rfcomm/core.c      |   6 --
 net/bluetooth/sco.c              |  12 ++--
 6 files changed, 57 insertions(+), 97 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2f320eeddfec..7966db4038cc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -804,6 +804,7 @@ struct hci_conn_params {
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
+extern struct mutex hci_cb_list_lock;
 
 #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev_flags)
 #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->dev_flags)
@@ -2014,47 +2015,24 @@ struct hci_cb {
 
 	char *name;
 
-	bool (*match)		(struct hci_conn *conn);
 	void (*connect_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*disconn_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
-				 __u8 encrypt);
+								__u8 encrypt);
 	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
 };
 
-static inline void hci_cb_lookup(struct hci_conn *conn, struct list_head *list)
-{
-	struct hci_cb *cb, *cpy;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
-		if (cb->match && cb->match(conn)) {
-			cpy = kmalloc(sizeof(*cpy), GFP_ATOMIC);
-			if (!cpy)
-				break;
-
-			*cpy = *cb;
-			INIT_LIST_HEAD(&cpy->list);
-			list_add_rcu(&cpy->list, list);
-		}
-	}
-	rcu_read_unlock();
-}
-
 static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
+	struct hci_cb *cb;
 
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
-
-	list_for_each_entry_safe(cb, tmp, &list, list) {
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
 		if (cb->connect_cfm)
 			cb->connect_cfm(conn, status);
-		kfree(cb);
 	}
+	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->connect_cfm_cb)
 		conn->connect_cfm_cb(conn, status);
@@ -2062,43 +2040,22 @@ static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 
 static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
 {
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
+	struct hci_cb *cb;
 
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
-
-	list_for_each_entry_safe(cb, tmp, &list, list) {
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
 		if (cb->disconn_cfm)
 			cb->disconn_cfm(conn, reason);
-		kfree(cb);
 	}
+	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->disconn_cfm_cb)
 		conn->disconn_cfm_cb(conn, reason);
 }
 
-static inline void hci_security_cfm(struct hci_conn *conn, __u8 status,
-				    __u8 encrypt)
-{
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
-
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
-
-	list_for_each_entry_safe(cb, tmp, &list, list) {
-		if (cb->security_cfm)
-			cb->security_cfm(conn, status, encrypt);
-		kfree(cb);
-	}
-
-	if (conn->security_cfm_cb)
-		conn->security_cfm_cb(conn, status);
-}
-
 static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 {
+	struct hci_cb *cb;
 	__u8 encrypt;
 
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
@@ -2106,11 +2063,20 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 
 	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
 
-	hci_security_cfm(conn, status, encrypt);
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->security_cfm)
+			cb->security_cfm(conn, status, encrypt);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
 }
 
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 {
+	struct hci_cb *cb;
 	__u8 encrypt;
 
 	if (conn->state == BT_CONFIG) {
@@ -2137,38 +2103,40 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 			conn->sec_level = conn->pending_sec_level;
 	}
 
-	hci_security_cfm(conn, status, encrypt);
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->security_cfm)
+			cb->security_cfm(conn, status, encrypt);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
 }
 
 static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
+	struct hci_cb *cb;
 
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
-
-	list_for_each_entry_safe(cb, tmp, &list, list) {
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
 		if (cb->key_change_cfm)
 			cb->key_change_cfm(conn, status);
-		kfree(cb);
 	}
+	mutex_unlock(&hci_cb_list_lock);
 }
 
 static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 								__u8 role)
 {
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
+	struct hci_cb *cb;
 
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
-
-	list_for_each_entry_safe(cb, tmp, &list, list) {
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
 		if (cb->role_switch_cfm)
 			cb->role_switch_cfm(conn, status, role);
-		kfree(cb);
 	}
+	mutex_unlock(&hci_cb_list_lock);
 }
 
 static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e7ec12437c8b..012fc107901a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -57,6 +57,7 @@ DEFINE_RWLOCK(hci_dev_list_lock);
 
 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
+DEFINE_MUTEX(hci_cb_list_lock);
 
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
@@ -2972,7 +2973,9 @@ int hci_register_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	list_add_tail_rcu(&cb->list, &hci_cb_list);
+	mutex_lock(&hci_cb_list_lock);
+	list_add_tail(&cb->list, &hci_cb_list);
+	mutex_unlock(&hci_cb_list_lock);
 
 	return 0;
 }
@@ -2982,8 +2985,9 @@ int hci_unregister_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	list_del_rcu(&cb->list);
-	synchronize_rcu();
+	mutex_lock(&hci_cb_list_lock);
+	list_del(&cb->list);
+	mutex_unlock(&hci_cb_list_lock);
 
 	return 0;
 }
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 44acddf58a0c..0cb52a3308ba 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2187,11 +2187,6 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return HCI_LM_ACCEPT;
 }
 
-static bool iso_match(struct hci_conn *hcon)
-{
-	return hcon->type == ISO_LINK || hcon->type == LE_LINK;
-}
-
 static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
 	if (hcon->type != ISO_LINK) {
@@ -2373,7 +2368,6 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 static struct hci_cb iso_cb = {
 	.name		= "ISO",
-	.match		= iso_match,
 	.connect_cfm	= iso_connect_cfm,
 	.disconn_cfm	= iso_disconn_cfm,
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d21267261a5e..7b4adab353cf 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7182,11 +7182,6 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 	return NULL;
 }
 
-static bool l2cap_match(struct hci_conn *hcon)
-{
-	return hcon->type == ACL_LINK || hcon->type == LE_LINK;
-}
-
 static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct hci_dev *hdev = hcon->hdev;
@@ -7194,6 +7189,9 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	struct l2cap_chan *pchan;
 	u8 dst_type;
 
+	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
+		return;
+
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
 	if (status) {
@@ -7258,6 +7256,9 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
 
 static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
+	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
+		return;
+
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	l2cap_conn_del(hcon, bt_to_errno(reason));
@@ -7565,7 +7566,6 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 static struct hci_cb l2cap_cb = {
 	.name		= "L2CAP",
-	.match		= l2cap_match,
 	.connect_cfm	= l2cap_connect_cfm,
 	.disconn_cfm	= l2cap_disconn_cfm,
 	.security_cfm	= l2cap_security_cfm,
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4c56ca5a216c..ad5177e3a69b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2134,11 +2134,6 @@ static int rfcomm_run(void *unused)
 	return 0;
 }
 
-static bool rfcomm_match(struct hci_conn *hcon)
-{
-	return hcon->type == ACL_LINK;
-}
-
 static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 {
 	struct rfcomm_session *s;
@@ -2185,7 +2180,6 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 
 static struct hci_cb rfcomm_cb = {
 	.name		= "RFCOMM",
-	.match		= rfcomm_match,
 	.security_cfm	= rfcomm_security_cfm
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ed6846864ea9..5d1bc0d6aee0 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1407,13 +1407,11 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return lm;
 }
 
-static bool sco_match(struct hci_conn *hcon)
-{
-	return hcon->type == SCO_LINK || hcon->type == ESCO_LINK;
-}
-
 static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
+		return;
+
 	BT_DBG("hcon %p bdaddr %pMR status %u", hcon, &hcon->dst, status);
 
 	if (!status) {
@@ -1430,6 +1428,9 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 {
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
+		return;
+
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	sco_conn_del(hcon, bt_to_errno(reason));
@@ -1455,7 +1456,6 @@ void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 
 static struct hci_cb sco_cb = {
 	.name		= "SCO",
-	.match		= sco_match,
 	.connect_cfm	= sco_connect_cfm,
 	.disconn_cfm	= sco_disconn_cfm,
 };
-- 
2.48.1

