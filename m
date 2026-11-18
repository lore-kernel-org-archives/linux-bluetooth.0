Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029088;
	b=z75zagEiD1Kn/J4/oQmqFBuD2eoV8jm+RjUnUSzzWfQWlImIn1lGnm8GhuJkqdWubOgK
	 YvKfFdd00v4yu1g1VxblOKhROw2nn++v5TQRe5v5PYsEI/a3aSGOshSsUjK0sN2PtxYV+
	 dqYUEXfyIrXR7L6tU0TJwWcPxa7FfiXBsi8tTIMSr+mlbghCW7oDDUflAESfhPg6QS2o4
	 YC1NXZVEWOdyO/XriJ9ukxx0Lbbx0IuB/ox7NZl2YrIEr08MOXQQ1U7EkMrHKuI0AUA9c
	 qcoHRjb1VIAP/Qp+x3tABN2h/5LFmIG5UtUFuFtYdhEMsAKg40g/rjZG3gf16+QDBtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dgq/hyKLxhd8cBGrgqia6NvVZQnXg0VxfSwO/yMNOCk=;
	b=X3lrF6GGD3xS6Fes5iilybc87pFWY9Hg0DZ+wPVmHRGDtqh58actCmBz+Zxw8L/a+FXS
	 nWYsaNj/LfhOJcM52ayi6JyQBpKy8rFyaRu7h5D5DmGEBJlZrJLHso/hXoBh5n0wsoGvH
	 y4FAbbamZKMUzo/nlfK0Oa0PCYrfSQ9AjOM+LenIacdvfr9JAUSIvbEtkb0lbQS/3/nqY
	 1ZPnZ3FK8ja+iVAQjTk6B0ht4VRjTI0seMdXPUG+n6+3wgkY7/m9bTrBofPZYUr3DO08v
	 wyWjp0lN644kYMmzZICNhjZk/NkXbn3bznoj60HiOuKwDK5T+JlWzEp575LGL5NAOUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RRqwVGT1;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B9606A331
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E52B9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RRqwVGT1
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d2eba2b74aso716746137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029087; x=1795633887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dgq/hyKLxhd8cBGrgqia6NvVZQnXg0VxfSwO/yMNOCk=;
        b=RRqwVGT1tGMjaxlIYnCYGFa6CFsQQnVTEyPj7Ojoi3ylcC/A2EPICOUW8KDEG7Ruf/
         UxQfK6w0rpN3Bz744nM9SR/jrsTz1VTvZdzxTIcWW1yLnErslvpt9pFC7oYnzh8ad+iL
         vFik4fG2WIrdt2uhdEYJjClsBGeC7kBcMVLaG6deI6kJdwZ9n8i6Nl/rlsUfzqd6m8xP
         B7tnmd+S5P6uTlezyUp4mHec1mIv5BKvgLoLGd/S8flbY03xME4Gn4c8zlmigcrmGT1B
         tuKltR71vgCfkeoziMrEoaFAYd3vTCVTTXZ+zGYT/s/hRgZRH/pbCBVjt8pp0i78vJRq
         7F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029087; x=1795633887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dgq/hyKLxhd8cBGrgqia6NvVZQnXg0VxfSwO/yMNOCk=;
        b=tiUudgQ+ts5NoUE7ENHWCMCPT1M60CDjbameAoMqYMrcIgaFJ4/Np+7Bfo0QyoknJj
         SK+owm1abmCEheGkZsgk5IxHAPuv8Qc36bcwiSrUZFXERwClENtNF2O54Kw13k8A9Zc3
         02zM/E+t2WnHs26I3IOX3Iq1ULW7F7dDQWOy9/bLvYHur3iPGNH/dxEBEBZ7Mvxr+2Lo
         bCmCqW8psMyyqtN5lnH1TD83y155jXNNKQPg/Um7SK6ZDHaGpnjcrF5KiacRcECq1tg/
         1YCKsF010UpLHPwzTbTJ9AusQFz4o6vD2O6sTjiUZDd588JJuYFIYSwVfsjHz2erUqZ6
         Vk3A==
X-Gm-Message-State: APuU4Z95ttCsoGLdpZwn4iJki09Aku2BqvrRkFFUv4zsSAnxa7+YKwaz
	EqxGMO/cX1x95rqFkNOPN4n+KuVdc3tf25FN4t8I7hYZFQ15/x8o+7HhyE/NYzla
X-Gm-Gg: AYBFou3Iv6+sxV+OvpOPKI9xEBzioe7m//Rz8LN+fjjf1olGkEj9aEWjWLWaXrUQgRf
	ScdJ8SJvheKp7crxh+lU2oi7IUimkiksJCc8gXUBBiaqfLJ8exTrJGROLtseAQre7iNszQRsLIO
	gyXOtcI+sjXqAX8SMwKWmVXr5tJHW3hnk6+GQe+S+AfSnn9Ti375FgezbxoJBYFLGrQRe6e1YpF
	uTRM+ignIZADs92JgRWH7SlQ7cWYjvRNNY1mtj/2sZ1yEER0AvZgXA//DYElDwHDD1oywyzVIq6
	KsKZsAt/yMt5T+arskbSttlaMMA9h7TYpTfDSxOL63kRlXU9uthFirNZ1F4G/70mO+sM0YzPWQr
	Hcter0TxmQC/RNwpkKfa5Xf5PTaMrjzzSfL5qoEHS5HzeoEcnogCKJ7YREFqdmKW5H8Ln8wEy4z
	PFkd1gEwgUzF46deilRwtuO+jP1fXcixG/F56hwG6zGzFpbolOio66TMxCt0pynZ6bPfXGUEeOI
	ZRHd2tF7et1QJgGrIgF8p75PRRjuroOcegBHqdTz+2/nf64244BTfpNpyS1izl0JWN51rzeJuxQ
	9bK4pemvaBq+iOxSTuoDLTOAf2x58zdV1sTFpt7YkbfHwu4eWFc+WGMfXlVhIEPh0th6mL6NURF
	Z5UPrYjUe172n+FhoDSBYd6HAyO1Mfbdf9xF0XDzlCVRmd6+ab6Qg8/avcaqbCsxLzx6vc/oL2+
	JB3Wo=
X-Received: by 2002:a05:6102:160c:b0:7d2:cf82:1a5f with SMTP id ada2fe7eead31-7d6ba495b05mr1698874137.24.1795029086667;
        Wed, 18 Nov 2026 11:11:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 05/17] Bluetooth: SMP: Serialize link key updates from smp_notify_keys()
Date: Wed, 18 Nov 2026 14:11:06 -0500
Message-ID: <20261118191118.318779-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
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

