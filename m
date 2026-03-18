Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501303D6CDE
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839445; cv=none; b=Z8GsePsg1qPQ0KqQg43heIpruFMnZup4M9ST7yppBioqSlsJb5rNM6a6yHATHpWoEnfP9XecaGqxl7dgmhK4euaBwBqARP4yGoVhnDYVuBFL8G5maGxweXDsFj2ahDI8kjWjqh1JRgJUs7LHCrcM6yew32v9MFbY3SC6WByPjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839445; c=relaxed/simple;
	bh=uxE93Pe0ME5mOyr5t6zmafzx7pZv4pe6U6PYEgUF9Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YUB2pYdtQk45nfec550OXVAV+tb1OT5ifVjuO9oHA9EVhehxqHl1a3lqGigNdhxe/lKZ1yWcMyjT2TomWfKTHW0a5AcpMUorg7PH/7LS1wW8w1bawHPW0jE77mTIPkTDNUJ2ogExGfX4OJ6+GejqAAOb6XaxsYbKcNgJmay3FNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9TX4pY+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9TX4pY+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82a655cfab5so1372673b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773839444; x=1774444244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mo7QqskrwYsU9/pVIbj151+YfplqmaufFzUar9GGUWU=;
        b=F9TX4pY+V5FdoYcX0H6Gud4qF2tikmj5dkFvWz6a+QBIrF247ZWVK1wFuzpIMPq/pb
         lmQdKacJ2vI6QzMIq7Rph+saz3gRaVjOsn5bjHnwc2Izqe8FBwtTIJ6pjlIgnnQqfmE6
         KUYx9Xx2KjpLcfyUXvdG1M1JQTmwKUIuqYVe/wdWv3WaOig6UtzAZ9YVwUYJPMbUA/q8
         iBpcjHBlXgKBtXzbwUNMVQ3rZ9pnxJNic8iuVZ+sz5AmtG4qqlOFsbXciPcO/UdDLBuu
         CE5Wd8yyrgw4ESOSiilNoeX7VGmNrUtKNJW6EBbiVr0950YtK7EB1kwJGGhjrUd5rxCY
         bGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839444; x=1774444244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo7QqskrwYsU9/pVIbj151+YfplqmaufFzUar9GGUWU=;
        b=W4RJGfe67i8lNKp2EhCt9ZY70xIaxxOgOmdI7ilSmQ/8wBdBdljbj41ZjPxH4dCYWg
         CcIvmGQ0Ka9n5VrHL3RXEUEjofRfQux4X78y1e2nXGF5ENUBAkGqJH+KSvlucRyrkthg
         eLAZ6MYYAyjQBGyJaDuJgbVne4EsssDVA3YMIS1m8CAhSYHNAmwkpEbXj9xXZIChZh1o
         5+MSmhmdkkMK+iaoCVYFE1GREby0RwMpvbjC0x2mMQWto2ukrE8bQIHvC3uSTW+hzlHl
         qa8O/9bAAqWCqWtAxwbuzmxCCMkwaN6uUkCbTjJH1dHJD8IkZ0LdeoN4RFbSoo7ROTVE
         N4eQ==
X-Gm-Message-State: AOJu0YyY/34dqEZ+prq1p1MW3cXNq89TF1FTBNPGUO2CgeJPDpBU9sR2
	XhheME8Y0GtqBbM0ZLDjQQnLM50k1CH5uR2KXQekb1E55byxTDI7/vdj
X-Gm-Gg: ATEYQzzAx6ZzndIAQFdplLQsE/YFRH+v5oHk+vitJu8VmeqiBbdtKZi9FU6HCiR86uj
	yB7izy/PdmKDwbeiCEUS+CrmN1lVw2cfYdBWSTa4DeICgx/8FvHBSOEBS4be6RMd761/zd5X/uN
	M7XkbLlwv3DrFmSRf4c9Sqe8EGP8vcD1/MRqb7SbDdtGKZtV0HAJXEWvQ349UIvG89129tOnW1m
	Mjf5taRxW9wSKUTUbqg/UXiif2HKCsmtU37Mqn5rzKFuEg6ok32TelMAktRd6MSDKbJlgYx5t8s
	eCJhZHDutVSNbAAWolNOk6rQ5iX9GH82TRFhgUsWWqGmu/bDxxcKTC6XPOWEdaf0i2mk1U43Pb2
	IoHBJAx2FBSV48588FHRdivjFyh1sKfH5P+ssTEqzuqtzm6/YzoFvWufgpWCWYxGUKMbpawv3m0
	ojzY3LdtKItPqc57uXwX5C9B/vg0uh
X-Received: by 2002:a05:6a20:748b:b0:395:d214:a531 with SMTP id adf61e73a8af0-39b99dd3633mr3071594637.28.1773839443397;
        Wed, 18 Mar 2026 06:10:43 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741dfd4090sm2574579a12.0.2026.03.18.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 06:10:43 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH v2] Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock
Date: Wed, 18 Mar 2026 20:54:03 +0800
Message-Id: <20260318125403.3135972-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_hw_error() issues two __hci_cmd_sync() calls (HCI_OP_RESET
and Intel exception-info retrieval) without holding
hci_req_sync_lock().  This lets it race against
hci_dev_do_close() -> btintel_shutdown_combined(), which also runs
__hci_cmd_sync() under the same lock.  When both paths manipulate
hdev->req_status/req_rsp concurrently, the close path may free the
response skb first, and the still-running hw_error path hits a
slab-use-after-free in kfree_skb().

Wrap the whole recovery sequence in hci_req_sync_lock/unlock so it
is serialized with every other synchronous HCI command issuer.

Below is the data race report and the kasan report:

  BUG: data-race in __hci_cmd_sync_sk / btintel_shutdown_combined

  read of hdev->req_rsp at net/bluetooth/hci_sync.c:199
  by task kworker/u17:1/83:
   __hci_cmd_sync_sk+0x12f2/0x1c30 net/bluetooth/hci_sync.c:200
   __hci_cmd_sync+0x55/0x80 net/bluetooth/hci_sync.c:223
   btintel_hw_error+0x114/0x670 drivers/bluetooth/btintel.c:254
   hci_error_reset+0x348/0xa30 net/bluetooth/hci_core.c:1030

  write/free by task ioctl/22580:
   btintel_shutdown_combined+0xd0/0x360
    drivers/bluetooth/btintel.c:3648
   hci_dev_close_sync+0x9ae/0x2c10 net/bluetooth/hci_sync.c:5246
   hci_dev_do_close+0x232/0x460 net/bluetooth/hci_core.c:526

  BUG: KASAN: slab-use-after-free in
   sk_skb_reason_drop+0x43/0x380 net/core/skbuff.c:1202
  Read of size 4 at addr ffff888144a738dc
  by task kworker/u17:1/83:
   __hci_cmd_sync_sk+0x12f2/0x1c30 net/bluetooth/hci_sync.c:200
   __hci_cmd_sync+0x55/0x80 net/bluetooth/hci_sync.c:223
   btintel_hw_error+0x186/0x670 drivers/bluetooth/btintel.c:260

Fixes: 973bb97e5aee ("Bluetooth: btintel: Add generic function for handling hardware errors")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/bluetooth/btintel.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 246b6205c5e0..ab146894ba4e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -251,11 +251,13 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 
 	bt_dev_err(hdev, "Hardware error 0x%2.2x", code);
 
+	hci_req_sync_lock(hdev);
+
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reset after hardware error failed (%ld)",
 			   PTR_ERR(skb));
-		return;
+		goto unlock;
 	}
 	kfree_skb(skb);
 
@@ -263,18 +265,21 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Retrieving Intel exception info failed (%ld)",
 			   PTR_ERR(skb));
-		return;
+		goto unlock;
 	}
 
 	if (skb->len != 13) {
 		bt_dev_err(hdev, "Exception info size mismatch");
 		kfree_skb(skb);
-		return;
+		goto unlock;
 	}
 
 	bt_dev_err(hdev, "Exception info %s", (char *)(skb->data + 1));
 
 	kfree_skb(skb);
+
+unlock:
+	hci_req_sync_unlock(hdev);
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
-- 
2.34.1

