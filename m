Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5A47CC67
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260458; cv=none; b=csODhejcnTlXx58vVaIn2K00qNXpxChsf/NDemQqcY3OxTV7ooRYevDQcMo3swNSDhrobNMdsXOybTZdJv7VN15SLFeApnTxy62nmq81UO78yCJLqivGU6O/3nLI0ptB3RBd9Qh6tUfHbk1HBkwcDG01hP/2aFQBbM6+nMIHF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260458; c=relaxed/simple;
	bh=6z6jIgLM9MKwGXpO5ot4OUdHkH9Uszd70bofv9CXk/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKkaA67l5ZGYTwGVWRrKep+28zKZd7tr+HFXCLE1u2uSXW7V4XNFJDNpgJT5tdI9DOIwt8yXSJUBGQPNOxn1WNWu/PVUN4zBhUwtfDjBV3m+oSkwbC1SrRvcxpB4NqqJGwyXnvVCw8itlion3OUjDTnv8VDwWzmocz9aEoptEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=a5T9Ro4v; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="a5T9Ro4v"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso791795a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 04:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788260456; x=1788865256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8q2AjDQLMcrjoB5m2qcet57wLAozgS4N2jZOk44+xRE=;
        b=a5T9Ro4vwNdxv0ZXeB57pU7W1h7S/2N6KN5YQvyJ7oVepZ8cw9Ma4IyhmqgyzfufR5
         KJtnlYAnBU/IDQ9QU1nFD65OF02JKufqrMSdECWI0gnvYqJKOD2CtJ2aMJ4Nyt3Dx2iP
         ID50oFQSTTiCS7IReanB3fIDD4UhrgzUQ/42yUAwQboBW26mreqiFB4Nv+cuRAcXTV9P
         g6HI4JyrqZ8W3U0l30LQAar9xwdtRv8ATm+rXx02pW31kExXZNkqRKwXPcR7NXhPdwXw
         hG1p5EVLNcqMAgr6FA59g407nRfbcnVrljharkZgNx2aqa5qWPgIp19FgVnzccbQ7QiG
         M1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788260456; x=1788865256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8q2AjDQLMcrjoB5m2qcet57wLAozgS4N2jZOk44+xRE=;
        b=PasF967Xx8Jl0YImbdVb3AXvcxjbNlPCu/6Tya1OlJ7u14A4pVr9nphzCwnDSPPdlO
         E33/le12qdVF0BWtuv//05b+0C6G35Ws0aQ4XNPaa3/HjyOaMEHuVooiBjCIok2HOvxA
         CifRQIwZUbwhzTkKbY5CRLWajArGAyhm2p4dTYbD/C+KQL2dRzXUBInbihQNcXlE9Tep
         k83yDb4l4anftLjZfJBgUTnllXC+49SLRnxxZ2JtHO9sAEshpjYYdBBcvRvaxnTnxA08
         F0x/zeSn+myxFQ9+VwhXGno6kIH9DaYfuJtx6HTwpgbVanmpFRfy7lbCU/W5NgpUWflj
         8qjg==
X-Gm-Message-State: AFuF++laQclXzV3rjNdSifXiGGYwjllfFbZVU/4JB5KkPIwsBprs5hHk
	BKn36QTHtP3Ikw3D9OHOVL6vLZhOcsPKEtHfzN+sxuxb6QE8LzbF/NND8pviwLjD6exqrAVfRJi
	t7+R6vg/ORBk=
X-Gm-Gg: AYBFou2FnWnPIYVBlM840jIp5UmO3yYetR1Qa7O7xK2rGbRE+7gslyZcbQTAVQeN82o
	DSYdRHFYfd27NLDnQyJX22g23zQLY8JaPDUWU0u6HTuZeiQNWU9BIDLrxdE47ux/DXWTwp9uUUG
	lIzQpyd2b8HzqMGNl3URbECqp94+gujzzK8hkFaQLRCLHbY69Y9qgsfwF63IpX4L8E/wlDM9Pj+
	wAU41xZafA083400XZV9ensyX9RTcgh++RQQhFgOc/cj032xC1GXcFqbbCtmgJbXv9bLcoEzuHX
	aPSQtSxcmEzsy7uYIMjrP7TsSGHipgJTqGLj4ic67jHbcphYkQhv3Rh1+wsHg7tPT7UPBJr2TZo
	Y2R4Yfz4jWX9b3UyY3b1fNEK/y3Om6HJOh0s5FLiYTkJkIEUOK31qlDYQyHH9t3f4riHbLx+E+j
	STPq/STl6nk4WKLPnKHFvtN9knb/wykGxSAihFx5asrQYKq8W1syPp+tj2kohWHczkJoJBoUk=
X-Received: by 2002:a17:90b:582e:b0:398:9be9:ab8e with SMTP id 98e67ed59e1d1-3989be9acb8mr34678225a91.19.1788260455758;
        Tue, 01 Sep 2026 04:00:55 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d75fc49sm5472245a91.12.2026.09.01.04.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:00:55 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mcchou@chromium.org,
	mmandlik@google.com,
	alainm@chromium.org,
	abhishekpandit@chromium.org,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH v3 1/1] Bluetooth: msft: fix vendor event use-after-free during open
Date: Tue,  1 Sep 2026 19:00:39 +0800
Message-ID: <20260901110039.2399040-2-weir@nebusec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901110039.2399040-1-weir@nebusec.ai>
References: <20260901110039.2399040-1-weir@nebusec.ai>
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
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/bluetooth/msft.c | 70 +++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index ded68568e6c9..20205403380a 100644
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
@@ -171,17 +177,14 @@ static bool read_supported_features(struct hci_dev *hdev,
 	}
 
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
@@ -636,6 +639,7 @@ int msft_resume_sync(struct hci_dev *hdev)
 void msft_do_open(struct hci_dev *hdev)
 {
 	struct msft_data *msft = hdev->msft_data;
+	struct msft_supported_features supported = {};
 
 	if (hdev->msft_opcode == HCI_OP_NOP)
 		return;
@@ -647,19 +651,29 @@ void msft_do_open(struct hci_dev *hdev)
 
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
@@ -1072,12 +1086,15 @@ static void msft_monitor_device_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -1085,23 +1102,21 @@ void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
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
@@ -1115,6 +1130,7 @@ void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 		break;
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.53.0
