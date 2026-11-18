Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010726;
	b=JuFclMhrLLTdtxJgc2Qp5mBVPv/rogBlvXYlEeeDFj8149sA9LFbRr6vfHRG5vWdnl2+
	 dJAf6oVe9Mk5n8bj5pKo3LHe29E54SCfNyNbUo84QBpeTblvY+fpAkkoBEMo0T71Mc0SG
	 XcCeJdKtqmXuERYB7DQUA3dbNMWwqPnKla9+E86MS5nRqAA3qu1ugj58/V92qjto88ngF
	 XZyHi7UDuyBiJsz1UrAqhHFxd/NeFTdzQK+QMeYQeEeRlXockgmOHOgLt/tXiwYRjvDwi
	 WAjvQ7xyE8hQpgVQQrgCADqDU+sVDfOXpgpfUWvHvEDfa6Rh6yhXCuUjchz+GpcTNww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dgq/hyKLxhd8cBGrgqia6NvVZQnXg0VxfSwO/yMNOCk=;
	b=WzbC2GgWrVh+C0aZHlh/9ZmPYEIzTR/B4F4Jjz/nZ+WVpwagpSnwmeaP+6Le9MAyZycY
	 iGxPL+R8f19ARGBR1SzT73WgXWeR9Tt/5wHZPuB3gHdBXeTKZVQF27+6cVDKM9UyE05I8
	 Ea5lGYziXQEdN9ZLLEXo2MbG0gHiH4AWH8gViwKcPrA9L8QdD2reUWKeccdU70Hsan56I
	 VKIHoMKaGeEjWzHvuawsOtddFLSjaOwFTujrvhq3Ss8+Rmy7NDj/pgsWwgj1irh04lySk
	 ohuOdzW7k0zmCszFHzPAaJzFrwBGuXvJZr9/np5qCifKJ16FHZESTreViER+F1BQmbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nQLxeO9B;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66418606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66418606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nQLxeO9B
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so585191241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010725; x=1795615525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dgq/hyKLxhd8cBGrgqia6NvVZQnXg0VxfSwO/yMNOCk=;
        b=nQLxeO9BIouAdane8B1DNBG/cvVcQHEyy1sUlsRsmjWF2xb8fwCXPZ40y51YuZZot7
         D1klWlrMQa6V0Y6UnWOV42SeDQOKCNh+A8My3KQiGdmIrYwizsnCTd68TtEC0447wYBi
         MqFTTKSPNSbaWPkCZweh6klC/pQcxStkNY9/8pSK5lnHV1Sfvxl25jIt565NoX1Wd+gq
         hnjEzd8z6HjDhMXEEu7gFfJS0nJTqkxxwHevb4R10YltTLdaje7ZWo9PKle2cDuaOUbg
         LvfJ8KlHPOjHJPuWE3PnmJfOL1J1QALqHJMaZFu8pz6oHXFyqP/bz6FnpenpywnMZwD0
         xTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010725; x=1795615525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dgq/hyKLxhd8cBGrgqia6NvVZQnXg0VxfSwO/yMNOCk=;
        b=fpsSQ+BKwQPAx1mS6ZndCFD1i+CgFfq7Urz56UFjKln8PZFXf8wh0vzgEG4g0BAzkp
         93+9y3clIzx3VmtybQnzmezK2SqaEXUpHnAOMQx/gJeICJhBBP1x0EQZKTaAkulP5Ayp
         nagz8/oZEj97YfZ5Jl+ji67uW299zx58WSWNElpYfMxwNS5fCjQW05iYHT4ob0Q/oSRx
         d/LYemINsJBFxbNHFsWyaUQqw9eeLWhumlg9ubbNAZG6lMGc06+iTsYApnx65eyzPpz5
         PtN4ASmWyOKfkp/so5lJrDqqU4drzPTFK0ikT/mc+3BLvEtNc572xxOcATMNevgCt/+S
         +Nkw==
X-Gm-Message-State: APuU4Z8GK+Kf+WAZg0SeDhc3XRXtY4P4ne40VUp85vo6TBLT8nYwbPce
	7huIFjNvlYZmIUZHuCWKeOlho4s3FtIh7AOzR+1itlOKdOR1eNyFTw1EaMNuo69F
X-Gm-Gg: AYBFou0YnNR7mAzkEXsnft0dx4XxdinZqBtBaBL6Hd9jHDp2NIcfRkNjvPG4AWESn9j
	Ay99VS/pTjafLtJOnqR/vkpewoRH3784RmdJWRkWlgYBaWVWXDjjGxYbYxjOIhrUyJCE9pDJjP8
	qv9dVg350kKu2S7975oNqIpIc1xBDu4rozrDnLuvyHKlePKiyytAuZShDhvL3JgqNB3PPqTeY1E
	o/+hzropDUBSZvd6jbPj31nhcvLk0hLmEht5Cg8RPwizIwExQqkBdihCEzlRNFhb4sGFAMsH3Ag
	6myCWRGslZ9Z8f+Gdd5urcXRQ+tRJ5uM5c2FI3rKww1p2F+wXaw6OBxw9q9rJpCKXPE5cikE1kj
	dcruczr7QBRxP8HtE5KdAoPgkpkMqnpTyJla6u+rnB8GCGch3X6nN9MaMvAtGk3D0ubo009JlU+
	sSJht1UTLiWnJqZro2fBB5vvb3ltsHtTJsMgDbPKKBvHj5OFXig8dTgO7gTdavGOc8SgbWpTp+T
	j0MW6GQCwCQewyospHlhX55/PIm+I5r/r4tiWh5zNu4B1Uh2JtB6EjMB4jKVALqmnBczHZri+Ng
	4MeQFNETYchqN4lfu0uq8DWLKaI/LjANZ56h+gowBDpD1doaMYo4CbdaqAq790numaclg3WsmUf
	Yefa+VpDk/Yh9aQLPRIVVc2gXh9TvTiS8ktWt983wAX05tfdXzn4nyNRuort3gjA5SEP8tceAHo
	F6sj0=
X-Received: by 2002:a05:6102:6f06:b0:7d2:d9f8:21cf with SMTP id ada2fe7eead31-7d6ba4c2288mr804942137.29.1795010724749;
        Wed, 18 Nov 2026 06:05:24 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 05/17] Bluetooth: SMP: Serialize link key updates from smp_notify_keys()
Date: Wed, 18 Nov 2026 09:05:06 -0500
Message-ID: <20261118140518.59878-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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

