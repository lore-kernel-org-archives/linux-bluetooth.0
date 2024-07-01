Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57492BB05
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868544; cv=none; b=D93ecz3lgNoWzLN8R/p4axHTTQq1+2Hw5qhvFQFmTU1i9Y6ci3RUD5EaC/4SqmgvOaazGrAKui6ZWCcxk5qSBAgedrqTdx/qlWt8KocqwAOjRkd4PHzI/WRvMsWYFNuzr4V1KvbNZuFE6IShhL8fxM8gmNu/cyLwNseoZpXw1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868544; c=relaxed/simple;
	bh=BTdVhi+4ji5HBNhNdD3NEqMCJ58L6Q9038sIO1ZWzX8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WzoErj8aG0jb0RiAEUpWwcbYI6DEORArqPNsE9TolGIU+6XmpnfX1XLbCjQGKKOChq73h1Gyj/mMz/Fw6eeV/nGvoRSxS0w9ZsBc0KSXOTs8q7FrVgzUkRCwq1L/k2vZolmpKy42PINY9ZGILIxd3sh24ILUpJBxcIJ5VzSJexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcia+ich; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcia+ich"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f284e7bb99so2150095e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719868541; x=1720473341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t7541zxrkeuJYcIdiyRNLcbk7/HyjD+qsEPC4LS0OA0=;
        b=Jcia+ichuwjp/3Wh7dt90LtsrmCT9b0j4/FdDxrx0f3gQ9PEdaTY+QQQ7vj+Oc58l1
         sD53t5wZqE0Akylu1n5My6d9EoLhnTL7ZuP71N9d5p1P38tHyUiDRjjFAZDJ0+UTgS7J
         oWJfVuGvVZHAENgCmn5xtarv9/jfC5kHYIG8FPCHKBOYoZuyvoMU3krIj15BOCKNS2fQ
         zMHSmcNmBQcXgs7M8HUSxguTLiC7g1gRUk2iM6m/t+nG5XtEPaUjNWAEFPo8hw79yPZ6
         kq8F3lgZP04eonq/e/TstJWrl8crfVLP3Gv0lwgIS/0wnFTmjxJLdNDqiJAw/V4IpNky
         xeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719868541; x=1720473341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7541zxrkeuJYcIdiyRNLcbk7/HyjD+qsEPC4LS0OA0=;
        b=hJIFGRWy6x8C+uhytnOympB6AagKAudYTfhAETQqZTltuvfJyIJLsFwY0xZiShlGMP
         5dvkfTB6LSMIeLVmeEtGSOwK9dcvHh4uHzm5C8gvRTbLCOfdXuHa1U5OCl4oq6J8ncx1
         c65fROa1+uSiWHrW0XTcZhCzHOFSlN8VlJ2Pu68FGAP3Y2QGWQVkrxmbedGuRJ8FrO66
         EqSvAeQk718LmJnZfL6EHfu/pE1zNh5uvRWxqf0yGavPKU8qhNUgCCTHo9KTtMcRGKk2
         2fsv2XAdSPM4bXSGCRhYlOZy3U8jN7IGxjNa9L/3y93il8EylZP6LxH8HOv2gjtVHvGT
         WIgg==
X-Gm-Message-State: AOJu0Yw8hvNeCjJ9opmBuHjp2qzQZl8M/8ZInFoXfjogAje8yVl+jw43
	WEXRYu6MyUE4u2P/i5d4LZLyMaDVk+D8+7jr2TZUHK4ilzsxnWe2EoacJQ==
X-Google-Smtp-Source: AGHT+IE1hVMHivQtT8oVoC+qopoElLqUoEabOjgjZnNAhgQzURelGBlDNxMFOMQJZ8YjzuAzNMR8qw==
X-Received: by 2002:ac5:cce6:0:b0:4eb:ddd:4b95 with SMTP id 71dfb90a1353d-4f295c44eb1mr6782340e0c.0.1719868540467;
        Mon, 01 Jul 2024 14:15:40 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f292271514sm1144827e0c.51.2024.07.01.14.15.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:15:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/5] Bluetooth: hci_core: Remove usage of hci_req_sync
Date: Mon,  1 Jul 2024 17:15:34 -0400
Message-ID: <20240701211538.1420913-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_request functions are considered deprecated so this replaces the
usage of hci_req_sync with hci_inquiry_sync.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_core.c         | 26 ++++----------------------
 net/bluetooth/hci_sync.c         | 10 +++++-----
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 20168732f20e..620e6014beb2 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -131,6 +131,8 @@ int hci_update_discoverable(struct hci_dev *hdev);
 
 int hci_update_connectable_sync(struct hci_dev *hdev);
 
+int hci_inquiry_sync(struct hci_dev *hdev, u8 length, u8 num_rsp);
+
 int hci_start_discovery_sync(struct hci_dev *hdev);
 int hci_stop_discovery_sync(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index db9b9bb7d74d..ff60c3617ebd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -312,26 +312,6 @@ static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 	return copied;
 }
 
-static int hci_inq_req(struct hci_request *req, unsigned long opt)
-{
-	struct hci_inquiry_req *ir = (struct hci_inquiry_req *) opt;
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_inquiry cp;
-
-	BT_DBG("%s", hdev->name);
-
-	if (test_bit(HCI_INQUIRY, &hdev->flags))
-		return 0;
-
-	/* Start Inquiry */
-	memcpy(&cp.lap, &ir->lap, 3);
-	cp.length  = ir->length;
-	cp.num_rsp = ir->num_rsp;
-	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
-
-	return 0;
-}
-
 int hci_inquiry(void __user *arg)
 {
 	__u8 __user *ptr = arg;
@@ -380,8 +360,10 @@ int hci_inquiry(void __user *arg)
 	timeo = ir.length * msecs_to_jiffies(2000);
 
 	if (do_inquiry) {
-		err = hci_req_sync(hdev, hci_inq_req, (unsigned long) &ir,
-				   timeo, NULL);
+		hci_req_sync_lock(hdev);
+		err = hci_inquiry_sync(hdev, ir.length, ir.num_rsp);
+		hci_req_sync_unlock(hdev);
+
 		if (err < 0)
 			goto done;
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 76b283b8e90d..46b394842a27 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -347,10 +347,9 @@ static int scan_disable_sync(struct hci_dev *hdev, void *data)
 	return hci_scan_disable_sync(hdev);
 }
 
-static int hci_inquiry_sync(struct hci_dev *hdev, u8 length);
 static int interleaved_inquiry_sync(struct hci_dev *hdev, void *data)
 {
-	return hci_inquiry_sync(hdev, DISCOV_INTERLEAVED_INQUIRY_LEN);
+	return hci_inquiry_sync(hdev, DISCOV_INTERLEAVED_INQUIRY_LEN, 0);
 }
 
 static void le_scan_disable(struct work_struct *work)
@@ -5662,7 +5661,7 @@ int hci_update_connectable_sync(struct hci_dev *hdev)
 	return hci_update_passive_scan_sync(hdev);
 }
 
-static int hci_inquiry_sync(struct hci_dev *hdev, u8 length)
+int hci_inquiry_sync(struct hci_dev *hdev, u8 length, u8 num_rsp)
 {
 	const u8 giac[3] = { 0x33, 0x8b, 0x9e };
 	const u8 liac[3] = { 0x00, 0x8b, 0x9e };
@@ -5685,6 +5684,7 @@ static int hci_inquiry_sync(struct hci_dev *hdev, u8 length)
 		memcpy(&cp.lap, giac, sizeof(cp.lap));
 
 	cp.length = length;
+	cp.num_rsp = num_rsp;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
@@ -5771,7 +5771,7 @@ static int hci_start_interleaved_discovery_sync(struct hci_dev *hdev)
 	if (err)
 		return err;
 
-	return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN);
+	return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN, 0);
 }
 
 int hci_start_discovery_sync(struct hci_dev *hdev)
@@ -5783,7 +5783,7 @@ int hci_start_discovery_sync(struct hci_dev *hdev)
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
-		return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN);
+		return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN, 0);
 	case DISCOV_TYPE_INTERLEAVED:
 		/* When running simultaneous discovery, the LE scanning time
 		 * should occupy the whole discovery time sine BR/EDR inquiry
-- 
2.45.2

