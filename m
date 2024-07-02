Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AECC85298
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947527; cv=none; b=RyyoJBcvknB4P2yIX+AhNclS7M6ZWmhxuvZG2tVW52UJMdJHIHawk2PmqO5YCyWkoeUWZlp65MvfU5KGHev6Y6zEYH5yYyRtInJmnogBb2tRrml7GO1rqxI2r7/1rCi4E5rEhewvOErxksk3deuOaJ2Ng+nbht6aUV/HOd+u1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947527; c=relaxed/simple;
	bh=6mW99Ta0ycy+Z6PRTSeHWVTaX6Hpn6ijx/Mn24elF4M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBM3ANsb1zxsKwoZb5ohvBE5T13S40iCJ+wXK4lq6cST2gKO+lf+37ccS5DT4Mi2XsFwx+7w65/GVLOvDk20AT9G9cnTNCqQiMjtfYxVyIkF55LzQx49zMA9N3g1zCQNd8sCS0EpYDQ2v3qG715g9nbO+KnEwayCvNU7szNRPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MocGogO/; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MocGogO/"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80fe89eaa4dso1855450241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719947524; x=1720552324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hhzy2cKs3k8K5O/je7DzKpGuvnT4IygNAttt2HgJDJE=;
        b=MocGogO/4zYB8Z+2imbkZKEhx5qlU16JW6xE7u9IZKx2QRQfqlZ9pNB7EpJ5gIXezK
         op5VgOPahU6XkVlJeZIpg57oI0FEbq8RJsFTG51Bj7QaYFMIzfnuYYxdquLH5u0bZftf
         wIOHe+PYoD0q7pxJspDT8B8PGeQD6HeYu1CIyZnK10b5ZF5Kyb2EZ5Qk8N7XkgjCJMT4
         kr1K+ChRRI0PHkGwmFrVb27vE0KuKmq5oCsNlv2PVgZ+S57vwLWwikZc9XRvMoLmcsPW
         AqmFVfDKnjS0O0dQX8H9Jn1cIHMrP+5Vc+siq0DUz8Uv8gKN5Wqjn3vQTEM4Weqk+v3O
         NJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719947524; x=1720552324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hhzy2cKs3k8K5O/je7DzKpGuvnT4IygNAttt2HgJDJE=;
        b=VZNz+rHr78VPbrl0jkAv16Fm00+4tybQ5r1C9zP5sxsOwBcTPbWbRb+oCUjyjUz1Wq
         nIm6czPkm6fc4RpmqXVDj3TIqcryzjjDEdDV4fqyhfh5OeufogXvMblv5m8ljQuToJ/r
         mSpZBDlcUUQqdu2zbjY/aJ7A+fZY8otdrnCnXRhKG21MJDBSF7NP6F8a1NTf0bJDfAzK
         IVqhz7a7SNUwV94zdrS2NOhq8Y6z6SEiY+Oik8Lm9yTuFmgJ5763bz/pOs3jwGT5XlTU
         iBaD3gpfMHVa30OE61Iu/BQEB2vs9ynDeQUzLHddiXohoBLRc7F+r8cwiyz2z3FVyva+
         m2nA==
X-Gm-Message-State: AOJu0YwSYjgAIPJ9uvjzOVJEK2xkiDyUC7Aap8KQEMI8U6HF6LD35XE3
	SYdufXavo7lU0xCvl5yEkIqc+ZDicPS8UoZrrAXVYAZrgjfbahwO5w0xtg==
X-Google-Smtp-Source: AGHT+IF5TA32PK99QONY5KnrxISKs25Cb3YejxfaTIrjEtzRciNl83n+iwQrU5lxTokj0pgQ/ox7yw==
X-Received: by 2002:a1f:ca46:0:b0:4ef:5707:ae78 with SMTP id 71dfb90a1353d-4f295e72584mr7950437e0c.4.1719947523668;
        Tue, 02 Jul 2024 12:12:03 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f292259618sm1383232e0c.37.2024.07.02.12.12.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:12:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/5] Bluetooth: hci_sync: Move handling of interleave_scan
Date: Tue,  2 Jul 2024 15:11:55 -0400
Message-ID: <20240702191157.1722089-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702191157.1722089-1-luiz.dentz@gmail.com>
References: <20240702191157.1722089-1-luiz.dentz@gmail.com>
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
index 9bdd3e1f8cfc..fc0424ae551e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2552,7 +2552,6 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_DELAYED_WORK(&hdev->ncmd_timer, hci_ncmd_timeout);
 
 	hci_devcd_setup(hdev);
-	hci_request_setup(hdev);
 
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
@@ -4074,7 +4073,7 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
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

