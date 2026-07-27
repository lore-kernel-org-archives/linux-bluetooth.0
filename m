Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEC42BC44
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172581; cv=none; b=D8pdrd2dKyPOFsquqsJDnl7Rkm95cIYtdrLY6POQHRRTFFSXJEaLE6Vj8M3a5ImVUtnR569L7gUMg+uMSt8CKEP3MCroTeylSriNR55tNbvyoqkVbsEMNY4+iUGv6zNHIFIy23icl6/xGectry9ODSRG89w/3ZzvUSjd7Tdm4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172581; c=relaxed/simple;
	bh=WB8dRUf6XLxfanapOu0sYFXda3FdAbvfroLTLDi6lys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVEQ08TKjMiNdUw4Sqan5UReLOYjcI2Fu6aKM4H6AZmN7mXGVBPdxKjKfnr2iqYazOtCKVp1/WQS6ItLTFz4dwQEJ/7cG4C17uNAxXIUyJGBlZQEREyMrP92UvG02XHh8imzYb6dzkNbkX9gUJi9VjD6kASenBZLvjEBYbRlOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuIlDHvz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuIlDHvz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceed7018c8so19273215ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785172575; x=1785777375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPuNzfnUATtwtcxlughhAs7uGIbQAduY3vyUAuT3Jqk=;
        b=QuIlDHvztpoANK7QRAQK3vMgmU7TzhVpnyHjQC8hIo20eom2HbTUk53d2YiN+ZOxe1
         jMlEK5hko6kJptOv4eCMFIVVXu7gS0Zj4ze34+Xbf9aL4ONCtm8CedNQisf/OMLNrl36
         4z3xhnVtVZez1xBnPNT44EFVlCgpTNrNtyHbHD82gzB8EcnUp4Btj3+HzLWOMItQUN6s
         4hOlZbgOufXPYky3WRpBlyORYSCYFpODHdVprW9WcOaQPpJ08qbf7Y/cyKqiEjgCJ8eZ
         odi/0GQmju2lxQeecL4fOfNyfpwpjJpNqfkMOWLDLO7Wlyk3L2eUUm4kSgT05PLTIL1H
         9s8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172575; x=1785777375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPuNzfnUATtwtcxlughhAs7uGIbQAduY3vyUAuT3Jqk=;
        b=M6SeF1dOGS52oxmKzvJetpKjKnFgY4LgLD3d7ct4Gqke9xKRmNnEYY7haWpU2KBYte
         6D0jVVv4oCOTuG4Bdq5rYNM8vUFnDSGI9McQGi8Rh4j1SVFXXGmma2uGpFVSe2OELfPh
         /LFlB9QrknweA0H44LpVDkjergRXOOyM48MBw8dlW6B+4U/v0xR1wsf6M1S2dvH6KB+b
         l4sjqgaHfrV1MX9wLOhVzZIveubKEnGXZAhMsRrh3xFERNGedUTOYtuVfTSVJnjOHDxj
         JQSiDdlWkxVqVJVkIcQeVbjIcS/fKAGxSaLaXh5RDBlv4rboG3BvlLvWELFHZsHIAhq6
         naXg==
X-Gm-Message-State: AOJu0YxDW/PVjcelh4ITPaoyKLAzPNMRLinRmQj3wLxvbUTS2cosqYzE
	YaC2P/1wzKGF3oSYiLc4Cfdqh1AEgTMX/E0QgU85WPN+l6row3dHAr21+1wUSgBGmys=
X-Gm-Gg: AR+sD10ZivwL9RWPbLnE+z7rXwrUs5v+o6A5vhkB2B+Z6me3QUPF1eRRXWfyvv5HuRp
	MCbWyHc19Bss4D/4qYy3NzWvK0/7VhyPfzvks8eOb9tQk60GAo4DF05vqw9jumaGgmszJ0on/+Z
	aKlkSfDwQajb6F7pxs7FqV3hbJsA6pi2pBZKouWMYpojYQjSxBEOpB/zhJTcYysfydid6XNFili
	Tei10Tb3Uxa0zB4Ke41x5Kr8A5TO7aTFMqF+I3/jlE99KDsT0UBXW0sRaF9WQFgaw8HAEHTXG7q
	GDWYIKz/j35E1A+R58QBOKcfWVmgyS8JkWknMP/6eNnLskoMuiAU9HUaWIP5RQjW8NLjeSkMTTF
	byVXnKRLtR7O3vDxqvLv0lGqxYp1RtB1ZsWnNm6NJMTw3MN3cayNFu8Gg+eAwsL0/AFz8Ou8C/s
	K6HHWjQC2G8IWjlmW9k63D
X-Received: by 2002:a17:902:f607:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2cfde84581bmr80924945ad.29.1785172574791;
        Mon, 27 Jul 2026 10:16:14 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e333bsm38377075ad.30.2026.07.27.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:16:14 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mcchou@chromium.org,
	abhishekpandit@chromium.org,
	alainm@chromium.org,
	mmandlik@google.com,
	vega@nebusec.ai,
	edragain@163.com,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] Bluetooth: msft: fix vendor event use-after-free during open
Date: Tue, 28 Jul 2026 01:16:04 +0800
Message-ID: <0e31ed963082a6fdabbbb10b913d35d6be5e7a19.1784880004.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784880004.git.edragain@163.com>
References: <cover.1784880004.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

Commit 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a
hci_dev's life cycle") changed msft_do_open() to reuse the live
hdev->msft_data object across power cycles.

That makes msft_do_open() free and replace msft->evt_prefix while the
MSFT extension is already published through hdev->msft_data. On failure
it can also clear hdev->msft_data and free the whole msft object.

At the same time, msft_vendor_evt() reads hdev->msft_data and checks
msft->evt_prefix_len / msft->evt_prefix before taking hci_dev_lock().
Since HCI vendor events may still be processed while HCI_INIT is set,
vendor event handling can race with msft_do_open() and hit a use-after-
free on the old prefix buffer or the msft_data object itself.

Fix this by reading the supported feature data into a temporary object
first, then updating the live MSFT state only while holding
hci_dev_lock(). Also make msft_vendor_evt() take hci_dev_lock() before
reading hdev->msft_data and the event prefix state.

This keeps the published MSFT state stable across the open path and
serializes it against vendor event processing.

Fixes: 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a hci_dev's life cycle")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Yong Wang <edragain@163.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/bluetooth/msft.c | 70 +++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index d7badce8746c..ff8629638299 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -133,13 +133,19 @@ struct msft_data {
 	struct mutex filter_lock;
 };
 
+struct msft_supported_features {
+	__u64 features;
+	__u8  evt_prefix_len;
+	__u8  *evt_prefix;
+};
+
 bool msft_monitor_supported(struct hci_dev *hdev)
 {
 	return !!(msft_get_features(hdev) & MSFT_FEATURE_MASK_LE_ADV_MONITOR);
 }
 
 static bool read_supported_features(struct hci_dev *hdev,
-				    struct msft_data *msft)
+				    struct msft_supported_features *supported)
 {
 	struct msft_cp_read_supported_features cp;
 	struct msft_rp_read_supported_features *rp;
@@ -166,17 +172,14 @@ static bool read_supported_features(struct hci_dev *hdev,
 		goto failed;
 
 	if (rp->evt_prefix_len > 0) {
-		msft->evt_prefix = kmemdup(rp->evt_prefix, rp->evt_prefix_len,
-					   GFP_KERNEL);
-		if (!msft->evt_prefix)
+		supported->evt_prefix =
+			kmemdup(rp->evt_prefix, rp->evt_prefix_len, GFP_KERNEL);
+		if (!supported->evt_prefix)
 			goto failed;
 	}
 
-	msft->evt_prefix_len = rp->evt_prefix_len;
-	msft->features = __le64_to_cpu(rp->features);
-
-	if (msft->features & MSFT_FEATURE_MASK_CURVE_VALIDITY)
-		hdev->msft_curve_validity = true;
+	supported->evt_prefix_len = rp->evt_prefix_len;
+	supported->features = __le64_to_cpu(rp->features);
 
 	kfree_skb(skb);
 	return true;
@@ -631,6 +634,7 @@ int msft_resume_sync(struct hci_dev *hdev)
 void msft_do_open(struct hci_dev *hdev)
 {
 	struct msft_data *msft = hdev->msft_data;
+	struct msft_supported_features supported = {};
 
 	if (hdev->msft_opcode == HCI_OP_NOP)
 		return;
@@ -642,19 +646,29 @@ void msft_do_open(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "Initialize MSFT extension");
 
-	/* Reset existing MSFT data before re-reading */
-	kfree(msft->evt_prefix);
-	msft->evt_prefix = NULL;
-	msft->evt_prefix_len = 0;
-	msft->features = 0;
-
-	if (!read_supported_features(hdev, msft)) {
-		hdev->msft_data = NULL;
-		kfree(msft);
+	if (!read_supported_features(hdev, &supported)) {
+		hci_dev_lock(hdev);
+		kfree(msft->evt_prefix);
+		msft->evt_prefix = NULL;
+		msft->evt_prefix_len = 0;
+		msft->features = 0;
+		hci_dev_unlock(hdev);
 		return;
 	}
 
-	if (msft_monitor_supported(hdev)) {
+	hci_dev_lock(hdev);
+
+	kfree(msft->evt_prefix);
+	msft->evt_prefix = supported.evt_prefix;
+	msft->evt_prefix_len = supported.evt_prefix_len;
+	msft->features = supported.features;
+
+	if (supported.features & MSFT_FEATURE_MASK_CURVE_VALIDITY)
+		hdev->msft_curve_validity = true;
+
+	hci_dev_unlock(hdev);
+
+	if (supported.features & MSFT_FEATURE_MASK_LE_ADV_MONITOR) {
 		msft->resuming = true;
 		msft_set_filter_enable(hdev, true);
 		/* Monitors get removed on power off, so we need to explicitly
@@ -1067,12 +1081,15 @@ static void msft_monitor_device_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 {
-	struct msft_data *msft = hdev->msft_data;
+	struct msft_data *msft;
 	u8 *evt_prefix;
 	u8 *evt;
 
+	hci_dev_lock(hdev);
+
+	msft = hdev->msft_data;
 	if (!msft)
-		return;
+		goto unlock;
 
 	/* When the extension has defined an event prefix, check that it
 	 * matches, and otherwise just return.
@@ -1080,23 +1097,21 @@ void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 	if (msft->evt_prefix_len > 0) {
 		evt_prefix = msft_skb_pull(hdev, skb, 0, msft->evt_prefix_len);
 		if (!evt_prefix)
-			return;
+			goto unlock;
 
 		if (memcmp(evt_prefix, msft->evt_prefix, msft->evt_prefix_len))
-			return;
+			goto unlock;
 	}
 
 	/* Every event starts at least with an event code and the rest of
 	 * the data is variable and depends on the event code.
 	 */
 	if (skb->len < 1)
-		return;
+		goto unlock;
 
 	evt = msft_skb_pull(hdev, skb, 0, sizeof(*evt));
 	if (!evt)
-		return;
-
-	hci_dev_lock(hdev);
+		goto unlock;
 
 	switch (*evt) {
 	case MSFT_EV_LE_MONITOR_DEVICE:
@@ -1110,6 +1125,7 @@ void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 		break;
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.53.0
