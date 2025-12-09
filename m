Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8506DF76
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264651; cv=none; b=bsuxsXLKCn32GqYQKlIZIGL3dHU0STCNpsvT/RIeL8mUaKRXKrF0K6ul31h3PprJEnFETVgG26tUl6pieG7JIm95rDwON9DYFTQ9oiazDZXD/2oHkH1rneBwblIioDEj/9si8uHrs28AvfbtSarX3NLd3MozJRJkJ5UAI/9LnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264651; c=relaxed/simple;
	bh=n6G313WPiJejO+ZpvTBGsvbRiJHvypVyUn0r7HF48jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LPm/3+IkeXeeYsibqUAuav2f60nvA80t1eiocvAOLQjdwcExw//JUvCpixx3Ugy/Yzh6qZafOw2ZtXiibP/BmOkxPsFgUnDup3KvWwKWdnSKjuphyyZ1d9jS0zotpB1tLlsxzJYVarRqdDFF5HriGdsp6Hh6S5Tq4gzJEJ6MO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJanU7Kw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJanU7Kw"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b80fed1505so5552059b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 23:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765264649; x=1765869449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjJGCdCeBeoefMULktLbEhsWf3L0qKXXM/mrlsCWH18=;
        b=RJanU7KwATxWiKrRFRonLLbR1vtroEoY/a+6YPv+ADeH/4RAzd2VnLyCqspHhfjrGs
         Fs5yDK8LEgvoQig30swj2GW7/LehRab99bBnwc01FVtVE7PrU1YPQjBBKmYKQxJkxVNU
         6Ch4KQW7WDE36XK0GfOeqxrl47Iq2K/x0Cpnk9lsMUvZP6fuKJp0vGdR+UViHJbuomP+
         G1d3XczpGuZji93vhjWxohT65koUtgmOvbbE2oYwRXuwOv6+n6Icw+VfQlleQ9OAc/zw
         qsgcTo9mQRH2GtcusNcBqUhVZ9tNmSgISnwmh0hLOa7ggoPrvC8kfuPlpFeJT+PQLyvu
         YFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765264649; x=1765869449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjJGCdCeBeoefMULktLbEhsWf3L0qKXXM/mrlsCWH18=;
        b=KjMzZPcAGm60OayI6c8L7jBt2cOU5Lcgd/05jK4Pc2STR4SJCYUxjZqM7OJwquvrT0
         hC4nO+Wg9uU4fE6igHkMYxBDDFVaNBstXbXIsZvPDqMO/7RbcflrqtwJvQCzDY0K4UqY
         50mG8UonHV4UwIhDUFM5LXsu96oMqKuC1jZT25NanxPHL0mrXUgZC/5oacaJnRm0aaXn
         oV3YYhiWFZstVJbGSBdh2b4OgUs85IHhUQq4z/9Z5LAvWNOkxuGirzSdnUZoBKXpkdzR
         EYmq8EnQavbzXp7mRLE7bq/mQmtsFxTh6Hw6VLtph9JFpcEgbySJazDC4zQ2REfeAX8j
         Rbbw==
X-Forwarded-Encrypted: i=1; AJvYcCVw6LyyFWP5O2f6geq39pKIh8Y4PtBrpKAiFobTJfyTjC9SVDyvX5gT8gymNimH/ni47W1kJ5ZaurikBriNNkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrF/M8boPolMVHNLqH+bnNulf7WmCE5q2vKa+UrDHPdbcxDLJB
	HcTPBrf8goQ7TTkYiMyGR0lz9nUOYdKTwypf/TLGbu2VHRsUL4sAsBqnQeTYtmBBkMo=
X-Gm-Gg: ASbGncsq9KD2XsMdIxNkmFoB2uSXbDGpElwVbfjY2wyPw7hyO7ExOoLB7Kd/C5UmTbJ
	LrwMlo8J4DVzCNQ+rTbXstsIrGRgKNmSNm4zLwilAdp8WD1T4jBz/+FojRKGQ72D0VaScnb6ZJp
	1fia3ebdLCVRIyE4BiV6L35wRMnMJEpqw/dMNd58uSuj7gCDV1yU9Lbi+s7Ypu2L0QsIztetz09
	lyYSG7KHfnB3IO9mtH1S73gBAjXCUkaVfZIYj5M89xUHmKt4ZKCBKJe+Ie3fax8ueSG3wcV9nOx
	4X/pdsp1y/U4yOS+f6sgVYsL5hpF6MetJxWA8C2G2gdlEMQXL27UQqCXdU1x7SIs2+v4FCj5gAo
	AuVt2qpJRo2IJJWhJKlzF47tMgY+3Lv5D9XQx2IwywQwns0L3BoOYfO7VHAmh6EcagLvhAtDJk/
	pkwxjnelPloXHCjkd4UVV+ACNK7Ao=
X-Google-Smtp-Source: AGHT+IHhpnodgm0X3Kb5hZSr10+4m7fcJqMPZJ3NYoPgYBczSRs6Bbm0JQF7xsfK35+Ujwut0MgMdA==
X-Received: by 2002:a05:6a20:1611:b0:34f:c83b:b3ea with SMTP id adf61e73a8af0-36617e6c5f7mr10014926637.18.1765264648685;
        Mon, 08 Dec 2025 23:17:28 -0800 (PST)
Received: from lavm-prs74opxn5.. ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a4a1fab4bsm766871a91.1.2025.12.08.23.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 23:17:28 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	pav@iki.fi,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] Bluetooth: btintel: serialize hw error recovery with req_lock
Date: Tue,  9 Dec 2025 15:12:48 +0800
Message-Id: <20251209071248.3575845-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

btintel_hw_error() issues two __hci_cmd_sync() calls to reset the
controller and fetch the Intel exception report. Unlike the shutdown
path, this helper ran without hci_req_sync_lock(), so it could race
against hci_dev_do_close() and both sides would manipulate
hdev->req_status/req_rsp concurrently.When the close path freed the
shared response buffer first, the still running hw_error path hit a
slab-use-after-free inside kfree_skb() (skb_unref → atomic_read) and
KASAN reported the crash in the trace.

Acquire hci_req_sync_lock() around the hw_error recovery sequence and
make sure all error/cleanup paths release it. This serializes the Intel
handler with every other synchronous command issuer and prevents the
req_* bookkeeping from being double-touched.

Below is the data race report and the kasan report:

BUG: data-race in __hci_cmd_sync_sk / btintel_shutdown_combined

read of hdev->req_rsp at net/bluetooth/hci_sync.c:199 by task kworker/u17:1/83
write/free of same SKB at drivers/bluetooth/btintel.c:3660 by task ioctl/22580

Call Trace (reader):
  __hci_cmd_sync_sk+0x12f2/0x1c30 net/bluetooth/hci_sync.c:200
  __hci_cmd_sync+0x55/0x80 net/bluetooth/hci_sync.c:223
  btintel_hw_error+0x114/0x670 drivers/bluetooth/btintel.c:254
  hci_error_reset+0x348/0xa30 net/bluetooth/hci_core.c:1030
  ...

Call Trace (writer):
  btintel_shutdown_combined+0xd0/0x360 drivers/bluetooth/btintel.c:3648
  hci_dev_close_sync+0x9ae/0x2c10 net/bluetooth/hci_sync.c:5246
  hci_dev_do_close+0x232/0x460 net/bluetooth/hci_core.c:526
  ...

BUG: KASAN: slab-use-after-free in sk_skb_reason_drop+0x43/0x380 net/core/skbuff.c:1202
Read of size 4 at addr ffff888144a738dc by task kworker/u17:1/83

Call Trace:
  __hci_cmd_sync_sk+0x12f2/0x1c30 net/bluetooth/hci_sync.c:200
  __hci_cmd_sync+0x55/0x80 net/bluetooth/hci_sync.c:223
  btintel_hw_error+0x186/0x670 drivers/bluetooth/btintel.c:260
  ...

Allocated by task 84:
  skb_clone+0x212/0x3a0 net/core/skbuff.c:2049
  hci_event_packet+0x66c/0x2da0 net/bluetooth/hci_event.c:7614
  ...

Freed by task 22580:
  btintel_shutdown_combined+0xd0/0x360 drivers/bluetooth/btintel.c:3648
  hci_dev_close_sync+0x9ae/0x2c10 net/bluetooth/hci_sync.c:5246
  hci_dev_do_close+0x232/0x460 net/bluetooth/hci_core.c:526
  ...

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/bluetooth/btintel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9d29ab811..baa3ee510 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -251,10 +251,12 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 
 	bt_dev_err(hdev, "Hardware error 0x%2.2x", code);
 
+	hci_req_sync_lock(hdev);
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reset after hardware error failed (%ld)",
 			   PTR_ERR(skb));
+		hci_req_sync_unlock(hdev);
 		return;
 	}
 	kfree_skb(skb);
@@ -263,18 +265,22 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Retrieving Intel exception info failed (%ld)",
 			   PTR_ERR(skb));
+		hci_req_sync_unlock(hdev);
 		return;
 	}
 
 	if (skb->len != 13) {
 		bt_dev_err(hdev, "Exception info size mismatch");
 		kfree_skb(skb);
+		hci_req_sync_unlock(hdev);
 		return;
 	}
 
 	bt_dev_err(hdev, "Exception info %s", (char *)(skb->data + 1));
 
 	kfree_skb(skb);
+
+	hci_req_sync_unlock(hdev);
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
-- 
2.34.1

