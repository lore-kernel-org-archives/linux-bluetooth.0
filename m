Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017562;
	b=rQFl+EjzdVu5k3a5w32O/M9vkk16QFOXvd89b+N5sb5rbo/ZA4T9AvxK/5BPQtuL1Z0Y
	 vso2UIWPAqFBqsXvmGdzOaIB7CBk/2D6XIibq4GLuSozANHyWWjG065+ZnvRTYljhzScF
	 pVofm0B8/apalB+7Co4v0uoZJEzaznrdxlDTKemZKLRYKrimSaTPhPeweTF9IDo9WqmMc
	 cfWK86CLULSo1j4sg+QP30uhslXg8j7JEQG19cLbWpULAkU2nH7LF7yX9Ox1KYJRrf6VT
	 8wLKhURUhy5+ornjDhqGkb4y10vrkOX6yemqVaT0tre8R6OO//gXfz8qTonQtCS4e6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dgq/hyKLxhd8cBGrgqia6NvVZQnXg0VxfSwO/yMNOCk=;
	b=OTQ8yricYs3vYXQgb//wiSPyRsSEl929L8v7G1DLNckGfJtUrAA2itd0idjlFd8s88hi
	 Xywv1DvTg6nlyTQbvLk7aLwyM5lRzpDN1PVfln7SBU86/MqoTzc8qs6rpGq1qp0PnJwyW
	 DIBSEhA6T95D3jImRN5vUOShLE9ECJLU+xHpi0p3+ddt+qPJokuQm/QMvdu3iz4YsWJAI
	 3YATlGInD4b3p4grNPncgJFrmoips0uSwd0tVn3YiGeG/bJiISnZ6m3PIQ1fTTBvEm0bH
	 Jo1Y2YYWR6y9ptZ2UMw8BPBYNCahxKFvdy8OVlZnN1nSIs8Xdwv3XBSztsNiB30Nxdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E9uHhzYe;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3699606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3699606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E9uHhzYe
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so649773e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017560; x=1795622360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dgq/hyKLxhd8cBGrgqia6NvVZQnXg0VxfSwO/yMNOCk=;
        b=E9uHhzYevfkUMsUn8HwcsW8RHYkXFUSzdBg5yamGFuvzqhLrvieVyiS+R5Q8DuqbA3
         7YJg3OipC05iD5ChAvxGaoDoU7uG8QKGXfmS6ZLlh7xUl17Ykj10Iiy36Kbh2CquT7A4
         N5Ll4ErVY1D32Z6IJ5iS54E0fKZnmIBPAY90Uhbae4Q5yxVqROUUcwVJ+4+dkeYiOZwh
         Oc214KNypQcNF2/ZpQ1CTdyNmOKuFY08xXviP+e/XT+EElcGM3I6MwP18K+DdY9sBRlN
         Xuv7uqTIfpsYeFkvlMDVdExfU808WPOe4YnpWaV9ADeye+NoWWuUWc1Zw6/aepF6FNSd
         o09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017560; x=1795622360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dgq/hyKLxhd8cBGrgqia6NvVZQnXg0VxfSwO/yMNOCk=;
        b=h5RlIp2bRwXiESc0S2nTldwhQIFrbaYekj7URu+BuSXIQm9/KAxKDErjuWD74SJP1k
         IWppNuNXoUD+EHNyKkvflgQTm77IdR/D9fHAZuR1vSfxySNQnEteryFgGEiYqXPgpGtz
         aVRaJ2TMt41Ik2gMNHOlJ+u7qMhVLq5mXtqj2ZS9HuEPKEE3hMGq01gYB00Sx2x9+Qwd
         dLUT1G8FPP4pxOXIrkQu72JZ56Dx704JbnsdhoaXTsY9M9fQ6vc87APFfHHJu7VXodKU
         MqBmtAC1VGCb+qBO8ucbpK1zJ++cPC3qIuQP46+CZ+v3sQVKByDFb95ldmJTi+tLT94y
         9Jiw==
X-Gm-Message-State: APuU4Z9KwK9Wf3/OfvUV1mt1JmIrHzyOz1VzOCVbhB0JYUxhVXwT2Zyf
	8imNKQPGPiRdBDo6r3qylRaGJ39p2IWFIETX1LHs2pHmlzt7ZF33ux6QtteUGeJl
X-Gm-Gg: AYBFou2qLlUvj9Ku9t10/D9BkXzmmuGh1E9LTJ5AnGfhSUnOrEWTde5gfH+jkBeloaG
	dwstJoka6o/QER2mCz+9V7gZmS7zp02sEyh+v7Kx6iNko9C/jIWGmyRfZ+ECXTIFxCgL8dbp9cd
	L47uUzKkC5ZvKEBYDnDMeffxz+C4QoBp8Z2hnoEkm6GbPXcaeLYe0cvKX9y0H/D638oGVxt8nut
	IctpOI781Yt5mCSXkRkEWBO/3DbX6N+gquqWwy7lGqJGn30SJjJuCDNM/naxeQHQoMtuPXSU6qn
	56gn4tPA4GkJlve55wOzlbMkQTY41GBSq4qO1wzLsNQdwd95KpLN6BucoxwynWlDIOOjFPU230h
	yAIR04MO8eiR9U17u0zHpYgGSwtqDdzlmJUWZcuECfArMKviVbWhTgEFaAxJj6/xq7WAXjqaOQr
	gQeEsNUgdYVhkcoKqlbz49DD5ZOpVDeoRW7ABfDiBqmj4iDwDlowI6djqvGHx06+GENGZwT+/0j
	/LpqWvQSEbU9p+nKFl4hElXxFquxcC8zG63Mdw2MOF2RdrWpAZTmsbiDAuDodPOmElkLPcNpyLU
	pLSVFWdh84MKLgBuZZ4sFLN8wJQlMQ1SG1hgZF2vfTsRpNALRpnkwAUuHBYqIKyQhPBaMG2HgVz
	8A1iIb4IEgyDMWnA+YFnHdI4Upl5S0nO6WdsztEOS8snl26mXElq1ZxyLjFMwrsUSBMPQzWACwq
	6XnXU=
X-Received: by 2002:a05:6122:4d0d:b0:5ea:aedd:6077 with SMTP id 71dfb90a1353d-5ee646b7711mr979196e0c.5.1795017560574;
        Wed, 18 Nov 2026 07:59:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 05/17] Bluetooth: SMP: Serialize link key updates from smp_notify_keys()
Date: Wed, 18 Nov 2026 10:59:02 -0500
Message-ID: <20261118155914.178050-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

smp_notify_keys() runs from the L2CAP RX path without hdev->lock, yet
hci_add_link_key() and the debug key removal modify hdev->link_keys and
dereference entries returned by hci_find_link_key(), so a concurrent
unpair or Load Link Keys can free the entry being updated.

hdev->lock can't be taken there since it is ordered before the l2cap
channel lock held by the SMP receive path (see smp_user_confirm_reply()).
Add a dedicated link_keys_lock protecting the writers of hdev->link_keys
(add, remove and clear). SMP holds it while it adds the key, notifies
mgmt and removes a debug key, so the key can't go away meanwhile, and
the debug key removed by hci_link_key_notify_evt() is deleted by
reference with hci_del_link_key() since a lookup by address skips the
keys that are blocked.

Reported-by: sashiko.dev (linux-7482a666-d2a0-44a4-9e0d-05354860a5fa)
Fixes: 6a77083af57f ("Bluetooth: Add support for LE SC key generation")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  6 ++++
 net/bluetooth/hci_core.c         | 62 +++++++++++++++++++++++++++++---
 net/bluetooth/hci_event.c        |  3 +-
 net/bluetooth/smp.c              | 11 ++++--
 4 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6e07bf206e4a..543d8d99b295 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -575,6 +575,8 @@ struct hci_dev {
 	struct list_head	accept_list;
 	struct list_head	uuids;
 	struct list_head	link_keys;
+	/* Serializes the writers of link_keys, see hci_add_link_key() */
+	struct mutex		link_keys_lock;
 	struct list_head	long_term_keys;
 	struct list_head	identity_resolving_keys;
 	struct mutex		remote_oob_lock;
@@ -1943,6 +1945,10 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 void hci_uuids_clear(struct hci_dev *hdev);
 
 void hci_link_keys_clear(struct hci_dev *hdev);
+struct link_key *__hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
+				    bdaddr_t *bdaddr, u8 *val, u8 type,
+				    u8 pin_len, bool *persistent);
+void hci_del_link_key(struct hci_dev *hdev, struct link_key *key);
 u8 *hci_conn_key_enc_size(struct hci_conn *conn);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9acfee486be0..a6bf806b9206 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1112,10 +1112,14 @@ void hci_link_keys_clear(struct hci_dev *hdev)
 {
 	struct link_key *key, *tmp;
 
+	mutex_lock(&hdev->link_keys_lock);
+
 	list_for_each_entry_safe(key, tmp, &hdev->link_keys, list) {
 		list_del_rcu(&key->list);
 		kfree_rcu(key, rcu);
 	}
+
+	mutex_unlock(&hdev->link_keys_lock);
 }
 
 void hci_smp_ltks_clear(struct hci_dev *hdev)
@@ -1332,13 +1336,16 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return irk_to_return;
 }
 
-struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
-				  bdaddr_t *bdaddr, u8 *val, u8 type,
-				  u8 pin_len, bool *persistent)
+/* This function requires the caller holds hdev->link_keys_lock */
+struct link_key *__hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
+				    bdaddr_t *bdaddr, u8 *val, u8 type,
+				    u8 pin_len, bool *persistent)
 {
 	struct link_key *key, *old_key;
 	u8 old_key_type;
 
+	lockdep_assert_held(&hdev->link_keys_lock);
+
 	old_key = hci_find_link_key(hdev, bdaddr);
 	if (old_key) {
 		old_key_type = old_key->type;
@@ -1381,6 +1388,26 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 	return key;
 }
 
+/* The writers of hdev->link_keys are serialized with hdev->link_keys_lock
+ * so the list can be modified without hdev->lock (e.g. from SMP, where it
+ * can't be taken after the l2cap channel lock). The returned key is only
+ * safe to use while hdev->lock is held, callers without it must use
+ * __hci_add_link_key() and keep hdev->link_keys_lock while using the key.
+ */
+struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
+				  bdaddr_t *bdaddr, u8 *val, u8 type,
+				  u8 pin_len, bool *persistent)
+{
+	struct link_key *key;
+
+	mutex_lock(&hdev->link_keys_lock);
+	key = __hci_add_link_key(hdev, conn, bdaddr, val, type, pin_len,
+				 persistent);
+	mutex_unlock(&hdev->link_keys_lock);
+
+	return key;
+}
+
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 type, u8 authenticated,
 			    u8 tk[16], u8 enc_size, __le16 ediv, __le64 rand)
@@ -1442,18 +1469,44 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *key;
 
+	mutex_lock(&hdev->link_keys_lock);
+
 	key = hci_find_link_key(hdev, bdaddr);
-	if (!key)
+	if (!key) {
+		mutex_unlock(&hdev->link_keys_lock);
 		return -ENOENT;
+	}
 
 	BT_DBG("%s removing %pMR", hdev->name, bdaddr);
 
 	list_del_rcu(&key->list);
 	kfree_rcu(key, rcu);
 
+	mutex_unlock(&hdev->link_keys_lock);
+
 	return 0;
 }
 
+/* Remove a key previously returned by hci_add_link_key(), unlike
+ * hci_remove_link_key() this also works for keys that are blocked.
+ */
+void hci_del_link_key(struct hci_dev *hdev, struct link_key *key)
+{
+	struct link_key *k;
+
+	mutex_lock(&hdev->link_keys_lock);
+
+	list_for_each_entry(k, &hdev->link_keys, list) {
+		if (k == key) {
+			list_del_rcu(&key->list);
+			kfree_rcu(key, rcu);
+			break;
+		}
+	}
+
+	mutex_unlock(&hdev->link_keys_lock);
+}
+
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
 	struct smp_ltk *k, *tmp;
@@ -2606,6 +2659,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	hdev->def_page_scan_window = 0x0012;
 
 	mutex_init(&hdev->lock);
+	mutex_init(&hdev->link_keys_lock);
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
 	mutex_init(&hdev->remote_oob_lock);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 419a7e674850..7908d920c67f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5336,8 +5336,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
 	 */
 	if (key->type == HCI_LK_DEBUG_COMBINATION &&
 	    !hci_dev_test_flag(hdev, HCI_KEEP_DEBUG_KEYS)) {
-		list_del_rcu(&key->list);
-		kfree_rcu(key, rcu);
+		hci_del_link_key(hdev, key);
 		goto unlock;
 	}
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f8f86b8f73f0..88cd86f742a6 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1097,8 +1097,13 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		else
 			type = HCI_LK_UNAUTH_COMBINATION_P256;
 
-		key = hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
-				       smp->link_key, type, 0, &persistent);
+		/* hdev->lock can't be taken here since it is ordered before
+		 * the l2cap channel lock held by the caller.
+		 */
+		mutex_lock(&hdev->link_keys_lock);
+
+		key = __hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
+					 smp->link_key, type, 0, &persistent);
 		if (key) {
 			mgmt_new_link_key(hdev, key, persistent);
 
@@ -1111,6 +1116,8 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 				kfree_rcu(key, rcu);
 			}
 		}
+
+		mutex_unlock(&hdev->link_keys_lock);
 	}
 }
 
-- 
2.56.0

