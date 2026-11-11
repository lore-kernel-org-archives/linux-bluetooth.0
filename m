Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415904;
	b=gLmvbi/9mzXLB1gRJkAhPrOI3RT8bJbxazPZQB7yirbigPSjlVzVtx2mvHiLCz8CLcNx
	 P0GUD0SCPnKF2n4OTbZWVV/06k+ev08GxTfQGReo4vSYSeGt6PYlDKK5JAlxSQwioHxcS
	 ZEitEUrU85SzMMxWnvEsMNGX+2e/lEkUxc3moOsCVC/3cbEx7I2KCiODL7Zx665Dp4RFo
	 gcmkVhnjU7OfVaQNWYua/z+fOdhx+odmc34NMf/TFFba5JjRLH0bZxzq7RbaeIHlNU10T
	 qmufskSpZfxGUIPEO5TVHVuKYvA3fL7GyvR8h4LOga8qPtk6709sQ0IW4MAGB0wlEGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0WErxQIxrkvCSCRSEc49UV6yqIiKdvJ9ql3BIAtrgSU=;
	b=I3wt/C0mwqKIRgMKzkxQk3uezcXW1sAVl2H8wxtCxBVtsF5Ht1Ht1Xw1woQL6wliAGWf
	 WorTQ2pP+T2mZPCr+TarR0MyJtqE/KfZy4AtQ4w7ACQnudf/98rQViEWP+6vFO2QWo0gC
	 +SwBBbrZijn0wz34VAqNI0EqnRGBVRo3NandGtLvoD+MZEgjoScpK96aMwj0AqpjgnX0z
	 UwAbnPBnUPxrFRg9ajcF8JG+iR84DMSVwJlyApJARdpfK+q+m8trH23QemwEhKPJNbi1s
	 E/pl6BxCyVKBlwPY5jOwiA5p/pbhHHYRkkgDXTmaBABC8ddkScKrzPfSEWTMozs2X3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xMjF0SEq;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC23606A896
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC23606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xMjF0SEq
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36e795af1d4so15943eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415903; x=1795020703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0WErxQIxrkvCSCRSEc49UV6yqIiKdvJ9ql3BIAtrgSU=;
        b=xMjF0SEqPUtNq4U7pr2dyoA3gd9pic8fuKRwENpj0SlbEk584HdxlzUDTu40yh+FAn
         Yhol2Ro0NAKHX/JkvXvToxYIK4kb0LBVzLXeBOqcYr7lQ6GRIeo2dXrnZkjCYTA/Oky0
         hIvO9vRyr3asSgXGJy+we8EVsMvsMOHjtaj5b+Ci4KK3JrcPV/JTzZOIL6F5FbE9x8lc
         N4psGJwqTk0ogaoSHksKMwhOf7ooDz/VIxzZomh/iRDH++Cm3xTorfOPuWRlWAgwNIxn
         q6fUqWe2RzRL3ahim1edou8NxdDGW8qHPuMj9KWey4Lt19Egh1LdRnhJ2egGbb8b+cWE
         hz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415903; x=1795020703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0WErxQIxrkvCSCRSEc49UV6yqIiKdvJ9ql3BIAtrgSU=;
        b=RkIBOQFW668F8YeDv1E6g6kkzZ4jmWntn6mekc++sD3X+pFJWnqbzRUMwwna+OmXLx
         DnrHLlfqcTe61gZ1EwezRaGSeUF1YI7vJk1Bdt1a4+K5m6QtMLKFjfcXLCI5mTDOLVL0
         nb0NhClNtQL/3ajM4tdUiJtvlw0r6TQnxcj7U4IIrPzFT+PfAR6nYy4s5rFqdroBaTNe
         25sKmpaThL9xOM9qaAJLK3aQrDevhDZwT0KCrS7d+QB3D/ekzh4BNVevjoyE1irbpCNB
         waLd+K3U4jmfVMTH+NBlM7Glyy5RxVu+OJ6jU706TGGFiXgnS/IQlyXZoAsAZBydn2dS
         fndg==
X-Gm-Message-State: APuU4Z+K2fILzXoYUe9r7G5bPa6m1h9q91SaWwWMRHrKtVI9M+cVJifQ
	0WxRk5+xFFckjdEAXH3L35wlCfU5W31NQUDRqf90Lmxieb3MmEl6yYpR1jBr2EHelHQ=
X-Gm-Gg: AYBFou0u9CXbfecYWemwX0Y9hzRLZCgJVU6LbJ9qbiWTToBrLTHO44xt9ES+OEKNrEc
	dJsbeSsQJGVr69PpjEtuuY9TMO+f+kHsXISKRS9TLRG+FzeAKmba19XiR8ch4fNYSTzxeIjh6JQ
	jppYRD1x0byPngPCqptRFHs7oFcslw6ceoHdF1TTDIkXhfN3U9+ixoKBEhkdw3aRAGQTXThq7it
	4rzGAH3vNxSD0yWafbcVhlH80Mh/VUgrMxMnfqRkp+8F7uKZiUtQDfRLJZc/XMq/vvh6Ay6hjk4
	QpwHipO8oxRlRAP0hvYjGt1f24Ur6NpJpS1n3KhDV0sQQzpsVjX5gjrogYf1gdBsB/D93xor3E3
	qsGDmcZuWckfft6joRnhARYK6S6MeLoSYseD42Gz4J7VeezmSXGnKVLXe7EN0ImtzfLUvQLZ/Yy
	6RMjxqqyeU2fIHu8C6wrKb+XYs9eEcAb4YqQUoSSZsKqZHd5BPbzusLPy7mLpyzaRWzYdqsGQA+
	EF/dvRCNWQ+/Vy4/RiCFRSf68LydQkhkeCwsbV0cLH8kqhW9CsUIw6kv6va3ZmYfkJQF6IHGHd6
	ffWXFA2jAXFkuQe4Qg04kbuLg2LaBopndfS0jgtiWrIlkEGdVO2ijsZ69bCwM2KszCs6dFMXvQA
	=
X-Received: by 2002:a05:7300:c7c4:b0:377:3984:5cb with SMTP id 5a478bee46e88-377e15ef441mr20508eec.17.1794415902567;
        Wed, 11 Nov 2026 08:51:42 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17119793eec.11.2026.11.11.08.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:51:41 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH v3 4/4] Bluetooth: hci_event: Find the owner of a terminated adv set
Date: Wed, 11 Nov 2026 16:51:33 +0000
Message-ID: <20261111165133.827594-5-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111165133.827594-1-weihong.guan@gmail.com>
References: <20261111165133.827594-1-weihong.guan@gmail.com>
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

hci_le_ext_adv_term_evt() looks the instance up by the event's handle,
but when the controller supports a single advertising set,
hci_add_adv_instance() gives instance 1 handle 0x00, which is also the
handle of Global Advertising. For instance 1 the event then finds no
instance, and:

 - a connection from it gets hdev->random_addr as its responder
   address, rather than the instance's random address, which SMP then
   checks against;
 - the connection stores handle 0x00 in conn->adv_instance, which is
   later restored as hdev->cur_adv_instance, so after the disconnection
   instance 0 is re-enabled rather than instance 1;
 - when the set terminates with an error, instance 0 is removed rather
   than instance 1, so instance 1 stays with no
   MGMT_EV_ADVERTISING_REMOVED.

Find the instance owning the set: for handle 0x00 the instance enabled
on it, as hci_le_ext_adv_set_enabled() tracks, and use its instance
number and random address. On an error, free the instance found with
hci_free_adv_instance() rather than looking it up again. Global
Advertising, and any other handle, are handled as before.

Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
 net/bluetooth/hci_event.c | 42 +++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f0ce124bb..9bec2a328 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6179,6 +6179,26 @@ static void hci_le_pa_sync_lost_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+/* The instance advertising on the set identified by handle. Handle 0x00 may
+ * be shared by Global Advertising and an instance, e.g. instance 1 when the
+ * controller supports a single advertising set, in which case the instance
+ * enabled on it, if any, owns the set (see hci_le_ext_adv_set_enabled()).
+ */
+static struct adv_info *hci_le_ext_adv_owner(struct hci_dev *hdev, u8 handle)
+{
+	struct adv_info *adv;
+
+	if (handle)
+		return hci_find_adv_instance(hdev, handle);
+
+	list_for_each_entry(adv, &hdev->adv_instances, list) {
+		if (!adv->handle && adv->enabled)
+			return adv;
+	}
+
+	return NULL;
+}
+
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 				    struct sk_buff *skb)
 {
@@ -6202,15 +6222,18 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	adv = hci_find_adv_instance(hdev, ev->handle);
+	adv = hci_le_ext_adv_owner(hdev, ev->handle);
 
 	if (ev->status) {
+		u8 instance;
+
 		if (!adv)
 			goto unlock;
 
 		/* Remove advertising as it has been terminated */
-		hci_remove_adv_instance(hdev, ev->handle);
-		mgmt_advertising_removed(NULL, hdev, ev->handle);
+		instance = adv->instance;
+		hci_free_adv_instance(hdev, adv);
+		mgmt_advertising_removed(NULL, hdev, instance);
 
 		list_for_each_entry_safe(adv, n, &hdev->adv_instances, list) {
 			if (adv->enabled)
@@ -6227,22 +6250,19 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->conn_handle));
 	if (conn) {
-		/* Store handle in the connection so the correct advertising
-		 * instance can be re-enabled when disconnected.
+		/* Store the instance in the connection so the correct
+		 * advertising instance can be re-enabled when disconnected.
 		 */
-		conn->adv_instance = ev->handle;
+		conn->adv_instance = adv ? adv->instance : ev->handle;
 
 		if (hdev->adv_addr_type != ADDR_LE_DEV_RANDOM ||
 		    bacmp(&conn->resp_addr, BDADDR_ANY))
 			goto unlock;
 
-		if (!ev->handle) {
-			bacpy(&conn->resp_addr, &hdev->random_addr);
-			goto unlock;
-		}
-
 		if (adv)
 			bacpy(&conn->resp_addr, &adv->random_addr);
+		else if (!ev->handle)
+			bacpy(&conn->resp_addr, &hdev->random_addr);
 	}
 
 unlock:
-- 
2.47.3

