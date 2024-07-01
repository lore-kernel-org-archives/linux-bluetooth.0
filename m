Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BF76EEA
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868549; cv=none; b=R8KnYUReNR08ooReR0/fWyCg2biBbsqbcU0NMs4LicFs9HfrEZ+HtvlbLNqp/ODY5ezeA69gop5/4UMGPnHDWT7DsvjT9SvVNbUrKHuOqhlm7gNWLmDBgD5yX87Y3T7R3PAXIWwpIYikYY/H54bomIQIAM0v+F8YwcZx7evp7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868549; c=relaxed/simple;
	bh=Sg4XYQ2DkTpkW+Ct9L82f4w3Fvf4oSYwc4Oa4H0saDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICunz84hwiKytgw3BhJHE78m6obr1DsKUyC14nfFOG8L0eYv2+Upqp5jBLiQEjcb5/8VYTfK6Jo1VLOBKXACIctzcRWwCqfOyq/ptZ2Bctb/UFxXc6t0UDm7NtUJ5DsCY4jXk8I9mYHpadeaDpv8+umpYWDRg1PydOovOq9DlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKcUx6F+; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKcUx6F+"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4e7eadf3668so1351054e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719868544; x=1720473344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvmvhUSi6b6BDCS2FpTrvNmjYqGymuKGuzjccLZ+6fw=;
        b=eKcUx6F+0tEkSm2qdylDCAYIMVi681srkbQ/uJxj8i/GjbvboXeGBgfTRsujwVClew
         8WCvwBzs+1aaBC8cxK7m6D0OcSLaVjvSknin9RE17eB8TF7qbmcirJ0/tUkaDly5Yb7L
         DP/lMNluJp2rQskqFFFRm7z2+7ZJpGQ9e/br5V1ESiZUyJ+iVDbDvPvv1zhj3BKqZPKL
         nM9nDzZ6bbwtcj3flJOg16aqTcl/AYSl9OlTn9c4TRbpgXtcdkvmbIKecQHqnb8a6ne7
         AH2NbCgNYBMmx4gjlU8wAFXrdAWc2kqpWxaJDwFIAq7ETao4IsiWzuKEzo+6jiHailuM
         cQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719868544; x=1720473344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvmvhUSi6b6BDCS2FpTrvNmjYqGymuKGuzjccLZ+6fw=;
        b=VhanmjLiTqQJ0dLjjBBN5rkwuqMzOWv7l5KPmrTsU0Y4Jut6t8MbwCp2Bqz58ICmSW
         11hYBwY4VCyeJogmeKR3OCLLqwUuhtBOIHi5clt6pOBgp/NMMFTIMFdcRlUJFSCMCgQ8
         ZYHBF6lruxAbEQ1mXzUoyfsYHowWP7QbCVusITYtUZVXTWzDzGFYqa9y7bE/5SqAvLVq
         R0HxLsUiOWnr1h0m+Nx6W95g3ItbJ8R/F5ChYdWmTgSmgkXMbDIJB59orgO4PPMEJ9W0
         UkwgVSLPR6lh9KRKI9GZqJAktNGtCOO3s7akArr28l9S2Na6kFgg9MHWUAek5FLf7I0E
         Ha3g==
X-Gm-Message-State: AOJu0YxW7OElocDwY35HjhmO8vRoDOau9FR9JXhORhZloF1X8e+gY4+C
	bY5xNiEXI4ctDzpUUNw58bo/nEfLkHgHOMYjN5nuJU4TfJSiiMgZOPO/QQ==
X-Google-Smtp-Source: AGHT+IHR4JVj1ulbADT4RehuaYnG52Oh00JCEARP6cxNJTfFFsFnNpyUq7B+6lkxIX+Q5ehrJuxFPg==
X-Received: by 2002:a05:6122:2810:b0:4ec:f4ea:6495 with SMTP id 71dfb90a1353d-4f2a57067c1mr8167907e0c.11.1719868544303;
        Mon, 01 Jul 2024 14:15:44 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f292271514sm1144827e0c.51.2024.07.01.14.15.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:15:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/5] Bluetooth: hci_sync: Move handling of interleave_scan
Date: Mon,  1 Jul 2024 17:15:36 -0400
Message-ID: <20240701211538.1420913-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701211538.1420913-1-luiz.dentz@gmail.com>
References: <20240701211538.1420913-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves handling of interleave_scan work to hci_sync.c since
hci_request.c is deprecated.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c |  3 +--
 net/bluetooth/hci_sync.c | 53 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1e8e84017e1e..d00eded9c4b6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2555,7 +2555,6 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_DELAYED_WORK(&hdev->ncmd_timer, hci_ncmd_timeout);
 
 	hci_devcd_setup(hdev);
-	hci_request_setup(hdev);
 
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
@@ -4077,7 +4076,7 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (hci_req_status_pend(hdev) &&
+	if (hdev->req_status == HCI_REQ_PEND &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0c8888448d3c..63548c4cc1ac 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -566,6 +566,53 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+static bool is_interleave_scanning(struct hci_dev *hdev)
+{
+	return hdev->interleave_scan_state != INTERLEAVE_SCAN_NONE;
+}
+
+static int hci_passive_scan_sync(struct hci_dev *hdev);
+
+static void interleave_scan_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    interleave_scan.work);
+	unsigned long timeout;
+
+	if (hdev->interleave_scan_state == INTERLEAVE_SCAN_ALLOWLIST) {
+		timeout = msecs_to_jiffies(hdev->advmon_allowlist_duration);
+	} else if (hdev->interleave_scan_state == INTERLEAVE_SCAN_NO_FILTER) {
+		timeout = msecs_to_jiffies(hdev->advmon_no_filter_duration);
+	} else {
+		bt_dev_err(hdev, "unexpected error");
+		return;
+	}
+
+	hci_passive_scan_sync(hdev);
+
+	hci_dev_lock(hdev);
+
+	switch (hdev->interleave_scan_state) {
+	case INTERLEAVE_SCAN_ALLOWLIST:
+		bt_dev_dbg(hdev, "next state: allowlist");
+		hdev->interleave_scan_state = INTERLEAVE_SCAN_NO_FILTER;
+		break;
+	case INTERLEAVE_SCAN_NO_FILTER:
+		bt_dev_dbg(hdev, "next state: no filter");
+		hdev->interleave_scan_state = INTERLEAVE_SCAN_ALLOWLIST;
+		break;
+	case INTERLEAVE_SCAN_NONE:
+		bt_dev_err(hdev, "unexpected error");
+	}
+
+	hci_dev_unlock(hdev);
+
+	/* Don't continue interleaving if it was canceled */
+	if (is_interleave_scanning(hdev))
+		queue_delayed_work(hdev->req_workqueue,
+				   &hdev->interleave_scan, timeout);
+}
+
 void hci_cmd_sync_init(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
@@ -577,6 +624,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_WORK(&hdev->reenable_adv_work, reenable_adv);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
+	INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work);
 }
 
 static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
@@ -2110,11 +2158,6 @@ static void hci_start_interleave_scan(struct hci_dev *hdev)
 			   &hdev->interleave_scan, 0);
 }
 
-static bool is_interleave_scanning(struct hci_dev *hdev)
-{
-	return hdev->interleave_scan_state != INTERLEAVE_SCAN_NONE;
-}
-
 static void cancel_interleave_scan(struct hci_dev *hdev)
 {
 	bt_dev_dbg(hdev, "cancelling interleave scan");
-- 
2.45.2

