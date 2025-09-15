Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606551C5D55
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952919; cv=none; b=u/kHRTHlWYRDs78B8jW5EY1gNTT1+A10V8moCPXNwl1/SI6rVtyzQDHGtN2GHJBx6QVkA+O93vgQd+i6DihEfSuE+AgREJM8E0ruDfIGY5epscC8sT7ARcDtGxqdJxOvXQ0Bgq+l0/tEVxPL84KUl2DKkswm1izfp4FirsqLtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952919; c=relaxed/simple;
	bh=esxEDSpTZYDm4CXVVwwabGZNI3fO5CdC1/ExRJbIDPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CSK4Le4/R6Q2Ry5CvWftQOiYU47lrdksDjncEp1iKyK0siWDMCLFdMjeYH8ti5bQ/aYf/jM/XcuYTx7WMn7Rx4jATGtiZkbC9k8rmUjoehNJG6Bp9wTpuMmJT1ZP7cDQUhVCB1sjnajgcrkhkt1KE9jPIg8FkrrJY0BwTg2Ov6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glDgvfmR; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glDgvfmR"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54a30c66258so487084e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757952915; x=1758557715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKaHHLjcDQOUYOLH/4lDiFVfUKe9peYlx+IVjuWnnbQ=;
        b=glDgvfmRUaUd3y9ZjcTjlZEScesDQRZYXkI56QOqUbR/auMSZexZi2o1sCaNyHHXSt
         MuTlls/egcGGxjXSiC3NoQQROcvyy3UmcL1rxi1faJ6MW5wCevwzfwClmwDh4fRkvWJD
         NY6TJDxjdUmciAynso6XwwuKyUjyPZAqWoSOg3BROqDOhNu4wIVZBOkxVCOxPudCyDYU
         dUomCXwiLNt6A25qYlwu/yff1LJ34PKhIP9BEJWDVZD+ks6babk308f0WVPz3XGFAZ7M
         IiN2+RxLyP/cYt9V46eTfGjyaJgEPvHNCoYiS3n48ijTtyrpzWRIphQar2bxBDs/LQqh
         hkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952915; x=1758557715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKaHHLjcDQOUYOLH/4lDiFVfUKe9peYlx+IVjuWnnbQ=;
        b=rhMMUQabWlo7een9af7p4QtvvCp6py/11C/LEPzP+T7FxZoDsO155sBCkhj3sbA3HE
         ejFAUWm47N8HvoqWYXdMD+oq/WAiCgUO83wi5dhwgIJBteqzogXktFTWQGytE0Sh+DMa
         2IYGGJszmIaTs03vv9PdCL7dak+pHM88QdhivlFhqgXrO4VP84Cso1RbHX3kbH88QgBH
         yhBny4ltrTEsVs9wyMBg27wdI6U6mYgbsrHmBt/7shhw3TkUGRXQVS/xE0ro8qSSv4XP
         9HyOoQtGhDJa919GfmXruq0yZqh0Lms1v44160B/U8CULnVxSctQfh1+falGU+SBV7Z3
         21dA==
X-Gm-Message-State: AOJu0YyDeAjTd+H+qO1gC18PN1afuAqajArL3VWs9QT5b3ZNLE60VN1K
	JdFfMcaiWd1MJP1hK5Zorq4RO6o9WJiG4e2wdMe2qMozAPGHNwdzvRS/qGEB3g==
X-Gm-Gg: ASbGncuArzlx9VMet1TFp2HbX8a3eUSnuhjbikU0Q2T7UfWHbJZsEgPAshwokhktQVT
	rL52uaTJZ7l2fPWIqbe9AmpOY1B6MG/aRkK4trVB5HjWYYX65jQR+6+RfBDffxne6NhjCz7uXxs
	cRWJEn+iQkOP3vZq3CV9k4eX2131l/AVu+CGJHIrbYP59qsYYrJlGJfCRFGyEvGPS7PTIXHg4RP
	u7Dxbj7Y+ASQMjBKtry+PMayeOVLX3cIPr6k06ph7bOIm9gmn6DPg9gB2unutjp0B9oHXmZhtYT
	QbP3WunVUCKuhGmcLxfdtXIANCja+uGHr4Y/56uA5hzDU8TDWwTvbqo6FaBjRBE/56tTXvbcuUf
	yh0B/j12WPIrWSSElcQN3564LJhANZo71lDpBlNBXQsx2RXRWMQAyospC71dAZ+HUAA==
X-Google-Smtp-Source: AGHT+IHE6VwuA6ZQ76KsNCF50uuaaa/0RzTeJ8UkTgJRc+PLDKKsUZroDylRcXSWTWFcatyU3KkQwQ==
X-Received: by 2002:a05:6122:a0f:b0:544:4cd3:4bfb with SMTP id 71dfb90a1353d-54a16d0878bmr3960879e0c.15.1757952914889;
        Mon, 15 Sep 2025 09:15:14 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d3f050esm2392338e0c.14.2025.09.15.09.15.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:15:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 1/3] Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
Date: Mon, 15 Sep 2025 12:15:02 -0400
Message-ID: <20250915161504.814410-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following UAF caused by not properly locking hdev when
processing HCI_EV_NUM_COMP_PKTS:

BUG: KASAN: slab-use-after-free in hci_conn_tx_dequeue+0x1be/0x220 net/bluetooth/hci_conn.c:3036
Read of size 4 at addr ffff8880740f0940 by task kworker/u11:0/54

CPU: 1 UID: 0 PID: 54 Comm: kworker/u11:0 Not tainted 6.16.0-rc7 #3 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 hci_conn_tx_dequeue+0x1be/0x220 net/bluetooth/hci_conn.c:3036
 hci_num_comp_pkts_evt+0x1c8/0xa50 net/bluetooth/hci_event.c:4404
 hci_event_func net/bluetooth/hci_event.c:7477 [inline]
 hci_event_packet+0x7e0/0x1200 net/bluetooth/hci_event.c:7531
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4070
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16-rc7/arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 54:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __hci_conn_add+0x233/0x1b30 net/bluetooth/hci_conn.c:939
 le_conn_complete_evt+0x3d6/0x1220 net/bluetooth/hci_event.c:5628
 hci_le_enh_conn_complete_evt+0x189/0x470 net/bluetooth/hci_event.c:5794
 hci_event_func net/bluetooth/hci_event.c:7474 [inline]
 hci_event_packet+0x78c/0x1200 net/bluetooth/hci_event.c:7531
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4070
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16-rc7/arch/x86/entry/entry_64.S:245

Freed by task 9572:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 device_release+0x9c/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 hci_conn_cleanup net/bluetooth/hci_conn.c:175 [inline]
 hci_conn_del+0x8ff/0xcb0 net/bluetooth/hci_conn.c:1173
 hci_abort_conn_sync+0x5d1/0xdf0 net/bluetooth/hci_sync.c:5689
 hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16-rc7/arch/x86/entry/entry_64.S:245

Fixes: 134f4b39df7b ("Bluetooth: add support for skb TX SND/COMPLETION timestamping")
Reported-by: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 571b7ca011c2..abb17dadf03c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4391,6 +4391,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "num %d", ev->num);
 
+	hci_dev_lock(hdev);
+
 	for (i = 0; i < ev->num; i++) {
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
@@ -4462,6 +4464,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 	}
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_mode_change_evt(struct hci_dev *hdev, void *data,
-- 
2.51.0

