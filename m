Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941865;
	b=yjNl99tT2uXHSarsBc0XxxexfIMy7OyLDSVbVhR8uy9s0gL/8lr2u+1dpvvKqCgH3oiI
	 qYxqqJ6eJdBPWDVScTRtaHZUo2o+joSUqt59sDu2ZJUWyA93AZuZ+aXMOt3L4+RAti5IM
	 VTJx5NZlMULT38dP2kVBq3wEUG1+vhnz3HWCXSOgrsHjfCiVD+UCgJZD3oTS3vivcUXJx
	 NciigPn5e8iV22rd+KEw1gkCAIQ2P01dfWFBxPQOx3kUzrVFkJfZR1JHplYZg3hQvWzes
	 VH/oGwQCtpK4iDccoAfE0XHfovF48Y0s8DXvGJSg7W9dvFfYu5XB2iIMtYAiwhZdoBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PSFgyhi8a48lghlyEZkOu4gKwE/+Uz634dZYZCGE+/g=;
	b=Ru2kC312xN53V7pMF1lDERrk63tlii9E+d0oHxG0Pb9VjBWq9hHHQOk9HsvLiTxtf0dx
	 zT6Z/d3MBwGIbByk/tqULLDaxFO4DT9WHhiZBZCyc0m/gq9/ssJkD6pBx0Pw0DoVBkI+W
	 cfkrtwR5ylJjAtiufBXbichWFkghRMNJxj2ZS7KhXE2i1OIrax9FomfjIq4kPsIc7zxAw
	 rq+UdU453vg1ABILWZmkUekufMB39LLi+i7DPuAQhQQP+9fpI1OyUiHnZRm/a6oJuzaPj
	 Yh2NC2HCzh9uEGuvVM/B1KoouFOm1rX9kRu1wNtw8HrahpIxZzbLpopAcsB0tPiW8DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C1dzgBYT;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151F606A881
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4151F606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C1dzgBYT
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-980c4258105so84181241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941864; x=1795546664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PSFgyhi8a48lghlyEZkOu4gKwE/+Uz634dZYZCGE+/g=;
        b=C1dzgBYTDuSQJyiiOJ57+o1Y5dXZFyzwud19Fto55CVjs+T5cfFmaRD9vXAeyAFkUj
         iu1ApThdj+ctxHVjsr5fDoQu4dl8LNRnEU98iwmf/6GgtIb6mV06zRStIYErm5VXvA5F
         rgh6pHtEwdxyG9U0qY8AMuMJs4wcC2U5Xjznpyn/DLccVbzNh7e3utKToISqL/CBBfgS
         F21Go9IvIw/UM9nqM3zzTbvyXSIm8hc2vynhmRBth7wV2p9QNSW0ytBEYAvPHPhCNM82
         7A7Ni8CQkfuS/gW7klyGiUTa/q80vjPT75Uwtrf0bhSpOCg///R73hkZQUkbZnIMl11j
         rO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941864; x=1795546664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PSFgyhi8a48lghlyEZkOu4gKwE/+Uz634dZYZCGE+/g=;
        b=fTS3LGVF24gEgR2U1tSWvuKmbO9tIo7edLkN1qgoVV15qZv0TioGd3P2+KwfpprxqK
         M0xotF0ZlOwoBV+UhYHv4VIyZ/C8mBQhKvbnwNWQj2czr4UfDAcJ3BkidAV0cGrB7g/o
         UrvR8bQdoM2ARt4P9YJ8GaBZg5tt6HcI9y/nb1Cu4u60lIWynvNltdLpRdjzJeereYEA
         hCiZ0U8rNS9xkOR2uLtL2whLGjc6m2p9yOHHDl/R2npcmrEpX0Io2E+Xaxqx+eRm9Sdj
         X5FlDEwlIv4SeeIzf3K//sx0hROMJVOJ7/qt+yE3LUqM6resa8X44A6EyZIRUfhd6T7C
         3+8g==
X-Gm-Message-State: APuU4Z8tJArYNvhiS+XYgYXD5yiHSCAaxW6Sa6vWCTCe0Lff2VT97dxV
	SuzCqT45bwk5N3F/8CnuP2inwc34XpvZVwNvEZQUMuonGPu9UKgWmWBRBoZPdA==
X-Gm-Gg: AYBFou25Dhh9U8H2WSOga3bmTshdFTEdyvoqMnuBst2/svBnZMjhSePZeq3qptXO8EP
	AaIaiqKVrsZuFvv9JvLNqSr8fqWXiGMd/VCt6c855Ihlhe20oXS/Y2TSS2KAzFa2mkxf+envyk3
	WpXGMtr1o7CoPBNTl13GaUn1h7KAljX0GIwBn5hQqJu+ZMX3C0yyRfaU7yUWofjbv2Reo28I1xL
	yGcQUloShyuVIFZutQlWSy6sENOv1K2oMJh3Od3g9gZuIG/7RhOi27p9EETXueshX5sEz50XeKI
	Nw0lJSKq1EU7V31it03EC6FKZZwoAVZ5MvecSt7DhOCp1LXE2bVdqvRDE+FAD/alTQJXcOsMd3v
	ikdEVWR2fQth1Sbrzpi+GJHHxTj+cfCvTi7IHZCPB8fF/tlRgSEbVcBpVD/6IMTy47JlTzr7Wem
	X+P3m7iTuQRKuCeFlh2rH/sM1uP0sVghNd2ZSfqMdvDbKtebxtkxvc23SsZv59uOJD6tFtUs8D3
	StvVfljjThgIihKsMXO1rLzb3m7ZPaVsoDA6Z4nlcnnkxzzmqMlfn8bjo8tBrOPbZUD4dmLCVRA
	//FsGWYEnSjJwAhfb2kGLpdJcA9/Qy1GfOZGSsdrPBQOBIkOp5EfvQ6ZJucX5I73ZemzGXyaZ/r
	zcf9FWUvZVfG9KJrpLiIuqdVXqatyM4wjgSSSPwJ9CynpzUQAHiGbKhvtRogvmaiTz4SkEfWQsZ
	iN4Cs=
X-Received: by 2002:a05:6102:604b:b0:7c1:7ca9:94bf with SMTP id ada2fe7eead31-7d64d78d499mr4850259137.19.1794941864081;
        Tue, 17 Nov 2026 10:57:44 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 05/16] Bluetooth: SMP: Serialize link key updates from smp_notify_keys()
Date: Tue, 17 Nov 2026 13:57:26 -0500
Message-ID: <20261117185737.3758255-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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
(add, remove and clear), keep the returned key under RCU in SMP and remove
debug keys by address through hci_remove_link_key().

Reported-by: sashiko.dev (linux-7482a666-d2a0-44a4-9e0d-05354860a5fa)
Fixes: 6a77083af57f ("Bluetooth: Add support for LE SC key generation")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_core.c         | 40 ++++++++++++++++++++++++++++----
 net/bluetooth/hci_event.c        |  3 +--
 net/bluetooth/smp.c              | 11 +++++++--
 4 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6e07bf206e4a..40bec3808000 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -575,6 +575,7 @@ struct hci_dev {
 	struct list_head	accept_list;
 	struct list_head	uuids;
 	struct list_head	link_keys;
+	struct mutex		link_keys_lock;
 	struct list_head	long_term_keys;
 	struct list_head	identity_resolving_keys;
 	struct mutex		remote_oob_lock;
@@ -1943,6 +1944,9 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 void hci_uuids_clear(struct hci_dev *hdev);
 
 void hci_link_keys_clear(struct hci_dev *hdev);
+struct link_key *__hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
+				    bdaddr_t *bdaddr, u8 *val, u8 type,
+				    u8 pin_len, bool *persistent);
 u8 *hci_conn_key_enc_size(struct hci_conn *conn);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9acfee486be0..d543526a3622 100644
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
@@ -1381,6 +1388,24 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 	return key;
 }
 
+/* Can be called without hdev->lock (e.g. from SMP, where it can't be taken
+ * after the l2cap channel lock), the writers of hdev->link_keys are
+ * serialized with their own lock.
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
@@ -1442,15 +1467,21 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
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
 
@@ -2606,6 +2637,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	hdev->def_page_scan_window = 0x0012;
 
 	mutex_init(&hdev->lock);
+	mutex_init(&hdev->link_keys_lock);
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
 	mutex_init(&hdev->remote_oob_lock);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 419a7e674850..e93ecb4016ae 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5336,8 +5336,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
 	 */
 	if (key->type == HCI_LK_DEBUG_COMBINATION &&
 	    !hci_dev_test_flag(hdev, HCI_KEEP_DEBUG_KEYS)) {
-		list_del_rcu(&key->list);
-		kfree_rcu(key, rcu);
+		hci_remove_link_key(hdev, &ev->bdaddr);
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

