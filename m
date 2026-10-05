Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C24D6C27
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222753; cv=none; b=iPRtUGtrNXe7GgvA4XroXbJh2jRdMtNZw939w7q3HbB5KnJSARvT8WPubW00p0KIfalSXCjYvCqSPdlNEgfGxZShdmKJaLAyr2Qcupc+emfq8urUU13A8djLNal52E5xlxJK4ZttNeE6akn1PBXwlTr9uORpjJC1IFP8hyAeTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222753; c=relaxed/simple;
	bh=J2aHUM150zq0AHCgF9OSoKzYq7GJBf+/oChx44snPM4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFjTq4Go0F/KlB2/8o3rCwQcQByKKWse+xh1X9g3UEXW1OR6ZXSNkNEpqZYNBrA5JZgyAv4qXqoT4dYdG8RJVXqhA7jONEW3c3d+gCuu+q4r3Eo2ttp1Piz17Otk6g/2uPSquAew7j62y3c8VxVakD4DsspTEnvFNIg7kemmkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGfAnZ+F; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGfAnZ+F"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so286383241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791222750; x=1791827550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bNtz6wuRSjUN7eEUvQNwYu2SrnALpKhGGnJWkW08VtU=;
        b=VGfAnZ+FSJRmLlD3XWPSwf4WYSMR6cEy2EBjf9jnmMW7wXZmuNREscp0reZ8gpVw5s
         EfqR3YG5hytuc076Ld0SwYXySXKZa4JviG6eBf25cRWW3umnMGaWqlNY68W+/9WRFA0P
         f4xAw5YgMQ90AKck4Edle4m9kCxAD696iO/dvUfIbA5xeq4t6kwX0EGakvpk1ebFY/jz
         COGDkEsy82V0bI3KdQSludeW6g5WWShlLlR1MDTNiECEnkZ9ytxDpLh2jB5Op2m3VJKT
         8anN5IzY2IBgETgwc1UYLW78goFpg4MWRDDLs4ft5qerqVfZHfAjBm+IfxaXQ0hzQVny
         0lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791222750; x=1791827550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bNtz6wuRSjUN7eEUvQNwYu2SrnALpKhGGnJWkW08VtU=;
        b=zKORsHVzY7iUFpuQUP7pjsZzAl0N0kcKuI2brsn+9hjkFdE5FCmqVxgdxB7IzDPBww
         L72RPEvMtqNzR747nHP8ivE5DDNCxWp+Iq2aEgKYR9rAf+AsK5XuLkPCRCCYcDt6R1xS
         D16Z7Nkd4IQdjP176nI8T2yHkFG44jrxaks0MskynqAHwk2QiNDb3NExNSZ+s9Kkl94D
         8bGBkuNQUGnxatTIctnnd31BlqVfJSEFd9qbm0xRvCWz3E6TMxyEmv/m5wiP2PvyL3Rm
         hui3l0k32OGOng54YGGPXfqs3DWVAcvvMQdEIsEfiWkmiBdUyCA+bI8zJpfbfUrS7WR5
         /DEQ==
X-Gm-Message-State: AFq9FYIztsNQv29rLY/YGH/y4EWbJq5J4W6Tll4oYiFr+7r3maH4hkHo
	/b1Z1RbqNai4z4cDJ9NnovCSsaUxQUvcWg5Y1criuf0ukiBoYyHTDTyCyfyhbeMS
X-Gm-Gg: AYBFou1XlwcdrQDuod8UD0mGukwQFQm4s2VUTpzwoOuEcudrDnLMHNjaqW/RSN5D3Yd
	qY/1+xnhV2Z+TXDYeJVGRfBr0cBP1J5ebGnnArWevZxr2giSWmjC4ZrxqyhTVhYyC4dw14PLxMP
	l4KEIakWef3U4nSulDIOIbfw+D2pE6ubqOFlEQTVEr5j8QKZhxOV22J5qq8yrcD24A6G+GJr1Fi
	4Pe5REBuV8clk6o/bQgueZWBan2Mnej4yOMjcgqSNY8C7eyG6LK31CphuVplUe+pfjdDc0Y7Biu
	H3M3PFalDec0BMb/ksjsGetqXnpWH2kHKYbkKE/xTLFOnu+Q2+6i1GG+2+IfOH0a1LgUFKa30tO
	QKOxYkgBWrvIXAmmiYnwGp6l+R9RTIpRJji0ztII6dK3TicBTezsg3TDmMWxguEpW1gLMrFMAM6
	hs1vbBmqha9ttYEuKUH+36CAK5hJ25TDAfp3L1beEs2ohZfiSzxYzeWyznTj1pY+RbOJjaLjkUk
	lwsxqE7MFH7MCVeRRVWz73U9xNbpJzfuKyNfmsax3/6ugyzo73K0Jwl/R1ZIz0E
X-Received: by 2002:a05:6122:d22:b0:5c9:a60b:e5bd with SMTP id 71dfb90a1353d-5de6a337782mr2292348e0c.13.1791222750299;
        Mon, 05 Oct 2026 10:52:30 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e54eee558bsm25655e0c.7.2026.10.05.10.52.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:52:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
Date: Mon,  5 Oct 2026 13:52:17 -0400
Message-ID: <20261005175219.3547838-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005175219.3547838-1-luiz.dentz@gmail.com>
References: <20261005175219.3547838-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When the controller supports a single advertising set, instance 1 uses
handle 0x00 which is the same handle used by instance 0 (Global
Advertising), but hci_cc_le_set_ext_adv_enable would lookup the instance
using the handle as instance identifier, marking instance 0 as
enabled/disabled instead of instance 1, leaving its state out of sync.

Fix this by matching instances by handle and, for handle 0x00, using
hdev->cur_adv_instance, now set when enabling an instance, to determine
which instance owns the set. Also disable the instance sharing the
advertising set of instance 0 before overriding it.

Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 47 ++++++++++++++++++++++++++++++---------
 net/bluetooth/hci_sync.c  | 21 +++++++++++++++++
 2 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2c8f6f22a4ee..9ec6c3c22fbd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1639,6 +1639,39 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+/* Update the enabled state of the instance(s) using the advertising set
+ * identified by handle.
+ *
+ * Instances may share handle 0x00 with instance 0 (Global Advertising), e.g.
+ * when the controller supports a single advertising set, in which case the
+ * set is owned by the instance last enabled (hdev->cur_adv_instance) and any
+ * other instance sharing it shall be considered disabled.
+ */
+static void hci_le_ext_adv_set_enabled(struct hci_dev *hdev, u8 handle,
+				       bool enable)
+{
+	struct adv_info *adv;
+	bool owned = false;
+
+	list_for_each_entry(adv, &hdev->adv_instances, list) {
+		if (adv->handle != handle)
+			continue;
+
+		adv->enabled = enable &&
+			       (handle ||
+				adv->instance == hdev->cur_adv_instance);
+		owned |= adv->enabled;
+	}
+
+	if (handle)
+		return;
+
+	if (enable && !owned)
+		hci_dev_set_flag(hdev, HCI_LE_ADV_0);
+	else
+		hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
+}
+
 static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 				       struct sk_buff *skb)
 {
@@ -1660,18 +1693,13 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	if (cp->num_of_sets)
-		adv = hci_find_adv_instance(hdev, set->handle);
-
 	if (cp->enable) {
 		struct hci_conn *conn;
 
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
-		if (adv)
-			adv->enabled = true;
-		else if (!set->handle)
-			hci_dev_set_flag(hdev, HCI_LE_ADV_0);
+		if (cp->num_of_sets)
+			hci_le_ext_adv_set_enabled(hdev, set->handle, true);
 
 		conn = hci_lookup_le_connect(hdev);
 		if (conn)
@@ -1680,10 +1708,7 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 					   conn->conn_timeout);
 	} else {
 		if (cp->num_of_sets) {
-			if (adv)
-				adv->enabled = false;
-			else if (!set->handle)
-				hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
+			hci_le_ext_adv_set_enabled(hdev, set->handle, false);
 
 			/* If just one instance was disabled check if there are
 			 * any other instance enabled, including instance 0,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 19917aa49cb2..fbe88ca1e60b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1413,6 +1413,21 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		if (err)
 			return err;
 
+		/* Disable any instance sharing the advertising set of
+		 * instance 0 since it is going to be overridden.
+		 */
+		list_for_each_entry(adv, &hdev->adv_instances, list) {
+			if (adv->handle || !adv->enabled)
+				continue;
+
+			err = hci_disable_ext_adv_instance_sync(hdev,
+								adv->instance);
+			if (err)
+				return err;
+
+			break;
+		}
+
 		adv = NULL;
 	}
 
@@ -1676,6 +1691,12 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 		set->duration = cpu_to_le16(duration / 10);
 	}
 
+	/* Track which instance owns the advertising set since the handle
+	 * alone is ambiguous when instances share handle 0x00, see
+	 * hci_cc_le_set_ext_adv_enable.
+	 */
+	hdev->cur_adv_instance = instance;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
 				     sizeof(*cp) +
 				     sizeof(*set) * cp->num_of_sets,
-- 
2.55.0

