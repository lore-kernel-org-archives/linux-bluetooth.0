Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40874A0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471406; cv=none; b=VD2a3N6EG7YJWVWqKt+Fn6r3WaY5awQsQFPm1brNQL+BKLwN+0BuD9faBJTvVgllADNTM9Ez+jONKze7aP+yweCxGKnUTmTVhngV6OGRAiC2amrFl7bRAng2fIljejQsx/VN1zi9GIs9+JeLz0544XdjA5dUXEW/9x5wtfvdWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471406; c=relaxed/simple;
	bh=A8WYjF/Dhj9kF73cfANIqmcdphaFglvFZjUsWJ3BzKs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xz8G9SJOo1StKALcKZVYzCFjfm98CA7YY/nTFgThQKlrfmgHQiRId3ai7G7EDqZfVXX5/fWmQ4crg7SfshWaVw1aW1v67v5Sw9wjMnfJanbbrlfeldzMZ2flNRJVoDl1dDUdEjO9mnsZqRLsh3GzNULfKhgSYxuImyidY90XF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGaFZdWj; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGaFZdWj"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7db123701bcso1551308241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711471400; x=1712076200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nthGlb3FB3B+HqLkaF6NISmJc2r1dMzeBpZPtAbkYTY=;
        b=dGaFZdWj/oKvCBxVPQdDJ3chdjiYfgXaYTE8za/ftGObSqEfTCttOI/dkDstv2+iS0
         2FRCOZQgT39QoIHyeu0MslV/bUm8QjIMzQdbKhKjKAVc2piVFdJdPR4keCNIxDERIQed
         Uk0A2ADqDkAjYXxtH+k+YJoZyYGrs9Zr1mpxlEQJJ/SRyADW6ki80ImDBS3SO+BhtIEh
         7xP0AivU8Emd8+tHvZGKPfh+YrTCixlBhzpmAMkV5LhZz4eSmTuSmAxkHWhXhYlnsQ1L
         PxUi0SUH/rBKpYloXG7vUR92m5an7uyq69V+3IMVqovdTsLpldlGYkBDYpEQ8rEw8Dgg
         GFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711471400; x=1712076200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nthGlb3FB3B+HqLkaF6NISmJc2r1dMzeBpZPtAbkYTY=;
        b=Tn8EugFNNo7jGmhhFOPuLoQPu0+IKlyAT1vUfqYgRo3zXU3oIP5iWNiFB8OFqGmUeQ
         afGv1qedVh69fwgU7gmCwbiMOymcvV1vBoCLyVBM+k71+tpD3tkTPSeP/HlWFEkePjsD
         9QnyF6xGxne8VWCroDfvJBaarY7rf8mCwmwoOEuGBWxnM/bnyugT0jgAjnzEyeN6Zvjp
         MzI42SacUArKC0/7NbUL+KF9zfX669Jj7wozZVNm0EOVY7SYMH7KnxbSwRYmoctrpYLq
         8IL+b1aUxIxDhx2tExVDYLWV1qTYOhvpSjsdsF5zfa7M3CuVWExPyGDhl1D/8N8vC3+m
         YkXw==
X-Gm-Message-State: AOJu0YxXwAPQt8J6TT+KI0eMwrDgZuhuHy4iSE/b3Ak0nS45v3aVqlp7
	E97SwORk74DGEdh8VAGgfLi4Y+UMLJ8pSWh69zBq4Wjq7Pp4sD3HaAUFKZJ9
X-Google-Smtp-Source: AGHT+IE1Iw67u4gFeVzpve3pnKArhKTajqoavhTWAdhHKJ1IPo5UGxxtv/CoGHcqVNi0WrYoXR2t7g==
X-Received: by 2002:ac5:c75c:0:b0:4d4:ef9:719d with SMTP id b28-20020ac5c75c000000b004d40ef9719dmr340907vkn.5.1711471399647;
        Tue, 26 Mar 2024 09:43:19 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id fn12-20020a056122298c00b004d8949c60d0sm465244vkb.10.2024.03.26.09.43.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:43:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync
Date: Tue, 26 Mar 2024 12:43:17 -0400
Message-ID: <20240326164317.1460864-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_cmd_sync_cancel_sync shall check the error passed to it since it
will be propagated using req_result which is __u32 it needs to be
properly set to a positive value if it was passed as negative othertise
IS_ERR will not trigger as -(errno) would be converted to a positive
value.

Fixes: 711c35949648 ("Bluetooth: hci_core: Cancel request on command timeout")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 6 +++---
 net/bluetooth/hci_sync.c | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1690ae57a09d..a7028d38c1f5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2874,7 +2874,7 @@ static void hci_cancel_cmd_sync(struct hci_dev *hdev, int err)
 	cancel_delayed_work_sync(&hdev->ncmd_timer);
 	atomic_set(&hdev->cmd_cnt, 1);
 
-	hci_cmd_sync_cancel_sync(hdev, -err);
+	hci_cmd_sync_cancel_sync(hdev, err);
 }
 
 /* Suspend HCI device */
@@ -2894,7 +2894,7 @@ int hci_suspend_dev(struct hci_dev *hdev)
 		return 0;
 
 	/* Cancel potentially blocking sync operation before suspend */
-	hci_cancel_cmd_sync(hdev, -EHOSTDOWN);
+	hci_cancel_cmd_sync(hdev, EHOSTDOWN);
 
 	hci_req_sync_lock(hdev);
 	ret = hci_suspend_sync(hdev);
@@ -4210,7 +4210,7 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 
 	err = hci_send_frame(hdev, skb);
 	if (err < 0) {
-		hci_cmd_sync_cancel_sync(hdev, err);
+		hci_cmd_sync_cancel_sync(hdev, -err);
 		return;
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 639090b9f4b8..8fe02921adf1 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -617,7 +617,10 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
 	if (hdev->req_status == HCI_REQ_PEND) {
-		hdev->req_result = err;
+		/* req_result is __u32 so error must be positive to be properly
+		 * propagated.
+		 */
+		hdev->req_result = err < 0 ? -err : err;
 		hdev->req_status = HCI_REQ_CANCELED;
 
 		wake_up_interruptible(&hdev->req_wait_q);
-- 
2.44.0

