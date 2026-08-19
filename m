Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042D47605F
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152135; cv=none; b=gOVzWFmbsK9Av4ue23qs2/Vy0bmSfMGAPTs9n0uYgqpt+Vfmi7+RPM5/CifLZaDaCXFMKZ3Tqspw0izZYZu7Gv9Ef67Se2p4l5pSZLOdDGqAnlyXUyIgwHXLhDUAuGr6bbBc0Vs1Vr5MBVVszXeSqQKpYKBR2wjJD6MFNowJ4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152135; c=relaxed/simple;
	bh=VRoloCEixpP3ZL+v0f+4Zf9sENAFDaw6lpEJi/XbyOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeUuGhU0qInYidDDN8KXGqDZhOYaX6XS35t6Q7zZI2qp2mIUlFRcFdks9HP7JWdisL70Sg2doABs3KlRqY8exKSfkiZ6lMkdCugY77vkCh6xul6Z3WGVV7Aayz/y6xHbgvWdZuF37BeTNqXpyxWXNkgwPO46o60trQyDPQ4YnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=sMp4+aMR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="sMp4+aMR"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8485ef63b68so1088571b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787152131; x=1787756931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7ZL37ywK5whEM3P/oeE6FWfJslEPtQULU2SoHzcKxs=;
        b=sMp4+aMRg8SA+bVo0iEkhYwMwQ/fKrLxX2hK2U2brQwEekbPPmkAfwX94NL6+oWRpZ
         zTbO7xpUFiv0PYV9WJotimriilBkUczVES0qjqMxoetogkx3TVVj6TeVcExxUHdn8hIo
         EubPCWqVO2XbyJJCiV5L7lhvpj/YVQw8xod0oPxYWd7myNdoPB0gGjPB3afzaNlSdHhI
         +AsJylA5dOfJF9VxhyDq8mkr4yCoPzais7YTiUIdBFzK2OD6W/kQwT4dIp4JHZ7mJEgE
         z5jnpXTfuwCJhW5nwHb3/LEEE9Lrf3rD5pFmHKxuQMoAM3cbRgFuRCqIoxDfDxKlWHht
         CkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152131; x=1787756931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e7ZL37ywK5whEM3P/oeE6FWfJslEPtQULU2SoHzcKxs=;
        b=Xh9BQuDZPairhblFwWHtIVmfT9VnzYVx//uuXZPFn8H4pBEZjQnVhqcE2F0bpQo0GK
         CmQQjEVpZQ9M3ytcZDxH6hneo9ZsD8+bsPYNZJwdc+qLLHbIuxd5De6RWoidfIm03BZv
         kfb3DFLuPO7jzxyhVc3mJzaDxFZBJ2FPQEqJDUE+soWrryo8mktS8KMEOaK7uDz1nOPH
         dnhd5cyWeONDijwo7NT6eNvJvOjP11/+8f+KSXegMJFZLzTHwlBzJBK66tZHxhQF0XVG
         cc7ULj6B1i1nFR1ON9LWyJ9wSNixgAGT0D3boYGtiHrM2dqR3XMQ9Sz6cybJMgKcKACN
         JmAQ==
X-Gm-Message-State: AOJu0YxyvCDI16lJN0uWPO7SY18h+R9tkteDmtIdOO7X5fqHWe+uB7xA
	GWPVRYMVC/tiUFrqRd2jUj47e13bBzNvPz61xhFe3G6qjjs9jd63HFhLtUPppZqO4R4QdxXNI0g
	cVKXQ9g==
X-Gm-Gg: AR+sD13DCFS2IkLddQp1aNtesu3hgBTjR25EkggiN/8CQoF8YIwA5nhaSrvI4BeGGD2
	k78YImLZfU1mLTOH3M6+tE3pMbZPUKVTQZH/j5yKEf0mw4HX6JIsSZjM4AACx/69SFHsgKPsGrm
	AFurUucQc4Hf1FB8nLKNyM7/D/mw2wmuZLMBqerfC7Ab+tqKEwmTWU5XjXOYJZ5SA5BeS+WSqTK
	J5lin7jQnM+wIQf/5WK+vlbsOdcYc4yrX9a8zYBuS2Sf5ptRHXjG9/kyyAleCcuav+6NQnzzqag
	mnFfNJd8FO8ZU7hvkqYFpaecJfd6cdbE6mBP/DTS8tYAJf87tmTo8S9kHCLmTTUvYVzLuw353Gy
	lZtsmaOIKQy6Yy7mMN8BCpQRgWMUv+Acg3QFgHAp+9UOzGXd7D/cmULKHCgzBrAGG8DLbFlG0Oy
	RuSGp+FPFmnOyGllkj6R+d1rZjoZ6vpNvCDMCBcyXA3BlRknwzcMIplzYDKxyuVFh6Z/jmLjI=
X-Received: by 2002:a05:6a00:4c87:b0:847:83bc:d2a4 with SMTP id d2e1a72fcca58-851d36d24femr9807112b3a.2.1787152131107;
        Wed, 19 Aug 2026 08:08:51 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15567543fsm723762a12.18.2026.08.19.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:08:46 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mcchou@chromium.org,
	apusaka@chromium.org,
	mmandlik@google.com,
	alainm@chromium.org,
	vega@nebusec.ai,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH v2 1/1] Bluetooth: msft: fix vendor event use-after-free during open
Date: Wed, 19 Aug 2026 23:08:43 +0800
Message-ID: <2e1dd2754cccae9180551049ff384bd04bbfb0b1.1787048594.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1787048594.git.edragain@163.com>
References: <cover.1787048594.git.edragain@163.com>
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
