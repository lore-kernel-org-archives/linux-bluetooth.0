Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE160369D5B
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122902; cv=none; b=ewFow8uakRCj8EDQacfzkGrvnQBMWBv4nqTw9+N8/rYbNjKXGG+2ywsYWQH83v4PSsppGHV/htsUijGMu6y1KWlZ33c+o71XXde4J5sKFSkoma/1LTOvu/4z3Wd8NJwmv2gqOISNvuT5jmmfqOd4cSn8JYk8EZwIDnL2awHTxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122902; c=relaxed/simple;
	bh=WB8dRUf6XLxfanapOu0sYFXda3FdAbvfroLTLDi6lys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Psv8TjZrf/Yxq8b1dIextREKTIG51b26+UJ6x1Iink+wNjP6tiOExRQicGFPO/2DbdGtn4/vZyfQ/I3ntsv+JvWreMT28jtQbO/t8QpGWHqflWNRNX647osD15Ppfw7f0rfJayXwREXfKySi/vN9lHM1rUaSWJOrEPVWO1CneFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpVdx+zo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpVdx+zo"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so3035965a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122900; x=1786727700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPuNzfnUATtwtcxlughhAs7uGIbQAduY3vyUAuT3Jqk=;
        b=gpVdx+zoq5X5oNAoGxfxcQssVVilKBh7xH3g7Ban5sas9DbZB0EqpicoYdzLsKXvdO
         op0+p3o+9so9lGJ0deZHqjL8hqeMWhmovB7InmJo+Myf8gUOC8DqlJicyz4ChGpqclqt
         N6Im9I90HNcUH+5FItioZwgqmzjurcg+b5QwHsCZfpCPqo+36ohKdep15hiqktyL0NtZ
         N/BbZm2FWtvGSYDkZrmmW8Lzb+RrrJkA15LtK9aPKSuQ+72YZ4kIDBForqpN9emUwj/I
         tddPSw2SD0tGM+/cZpMCQCqiBJuBgXIf3I9xoEZI5KyOF9Gfsg3u3RgkUQzZLB7y5tMY
         jahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122900; x=1786727700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPuNzfnUATtwtcxlughhAs7uGIbQAduY3vyUAuT3Jqk=;
        b=OdzLi9hSqmCBZLpBHwnuQu8+c0mcAahIo5f+5Wp3vqTbz1HXERGs4VbYgTChQ0O5f1
         JGW2J0/fW0S/Ma4oFCoLqnJPO+iCkXeja+fTQlnFJXd6jSiJ09ymbeSrn/QmGS0e/8Rr
         9etzVrJEpUcJR8J/DMV4F2wIKtoetrrglWBgSEHxG2EtjjQqInK1cekbHoL+lyofuwAN
         0DjPMZjVoKF9A2eA847qTKGD6RxrsZZmhiEbGtStqyP3PVsvSWm/605w8q+gGbqCBdGA
         HEwAcoNREnB5YHrOupFghD/T/ZVOIaDBqKMeeQytIdP0Hy5iZ2rmQgKsrpni+L0zZMkw
         nIJw==
X-Gm-Message-State: AOJu0YyWkKAFVJ8TU84Qvr+EwbPRKH6QdSItfg4pZ12MF//anMUqdZ0I
	hy5yAw1en5l0Bq09uJFfldw/61fvOSYcKVq6HFrC8AomGl8Q+0nhFhvSFsgFQgQC
X-Gm-Gg: AR+sD11SasfZtPNloz6leFedtIZQ28U13iVtLcF9NrxawOH2CKOiFNBLYK6XRFFq3ft
	bz8SX/pp4i1BquOIleN6Z+iKoqpjze7jm7ph6YGyqdXRjsaERGLeQUnoInRi36FgOCd4wzMBjXh
	tJlCLwDZ64D14ORfRQ/sSYD9ch4rw2Nm1ghKwj3HaSv+Oe3nteJB+3G2N8NGT2mWqKilm5C7gXL
	mHxe+P9Ux1sls9Ck0k3/arnxvg7qwEsHvHebdQwB5yO+jDd+5HT6L4Xb9xNbGVuOvgCIx5XGdqx
	EJqibQUXhcxLAX8tfBmq4SuyIk0mGLF2Rsec0gOXuYZXH7gzJRhqS11vIhWm0UJVKx5M9bFGSHC
	ReYL6dRWrzOwxIajxDXaateTNy2BqehipN6rd+LafAzvmmWMOzEZz/IYOhrweagLBWcrIpQl8nV
	pbohHsHgLXihicelRE4QFAEEg45dl+SApYRSIWBtoDv7sDxDb7YoLisUmnQz5VCJ7Gx22OZCdim
	4ls
X-Received: by 2002:a17:90b:3c8d:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-3909d822517mr11992908a91.9.1786122899819;
        Fri, 07 Aug 2026 10:14:59 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b150ef29sm1646254a91.1.2026.08.07.10.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:14:59 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mcchou@chromium.org,
	mmandlik@google.com,
	alainm@chromium.org,
	abhishekpandit@chromium.org,
	apusaka@chromium.org,
	vega@nebusec.ai,
	edragain@163.com,
	enjou1224z@gmail.com
Subject: [PATCH RESEND 1/1] Bluetooth: msft: fix vendor event use-after-free during open
Date: Sat,  8 Aug 2026 01:14:45 +0800
Message-ID: <ea4efa51cc3be16d3eb7726fe5486f0be6c47907.1786092373.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1786092373.git.edragain@163.com>
References: <cover.1786092373.git.edragain@163.com>
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
