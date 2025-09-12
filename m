Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FC03009D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701793; cv=none; b=S7S90+y1k/ihXNIIk4EQqm2yFgBcksHdWFuUBVCSQTduROcp0vkU+glsxE2OiC6PJDxkbx4GWzQwzlr6B86HsoWzW8H+vzde+lLEUf2c94mD82AhHB3o8DHwni6/5lsFm+Q/A4jINh34HyyeIKyDh6rDsvTd6I7F0KyVazDf+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701793; c=relaxed/simple;
	bh=esxEDSpTZYDm4CXVVwwabGZNI3fO5CdC1/ExRJbIDPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aCC45JSnVswsJ+TsFOtu1Txb29XwM7SzSAZ7KY3h/TQC1vym39WwrldvXPBbyu17jIK+cmbCNPEg4dtJ40kFgYcq1AH0ey1p2n2bp6XkCN3kTAQWuDQCZsKHn6RKBMzBN4l6H/yC7GN9yO0OwTYN+Ukzn0e/O1B/06rbrPWHzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcbd2Gss; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcbd2Gss"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-544a1485979so712591e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757701790; x=1758306590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKaHHLjcDQOUYOLH/4lDiFVfUKe9peYlx+IVjuWnnbQ=;
        b=dcbd2GsswKitxIp75gkqF0PdV1Y8V5HOdOsjqwkPPsfELpl5DFmxchKUWKOCc9svdP
         8YEhaYv6twP5rxugd9CB1wtvanXjB5FAKCQm3Ef8i/LQzcgbQFVReWyK3UL9ohE8IEUh
         hXxCziCC1pOlBa/9wZ/bXmPac0fRUQ0AK9xJFHBpwzroxiXbz5fs1/Bu0Nxq2BfM/Sud
         UExncF/y4GSkZSZruBd2oSDpp516zCZ1oMsxhq3SWVYGNAHd+lbHc+Ll3REmcyo6D4rT
         MFnl4XHZ7NNz/luR/Qu/H3Sx+AFFbf7D/Qa7E8PcdMDiDhL5PhAgvi1CyWwec1OtV28t
         MyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757701790; x=1758306590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKaHHLjcDQOUYOLH/4lDiFVfUKe9peYlx+IVjuWnnbQ=;
        b=HOKuliqVbUVi37qcbHaL5voJu2qbIrXrgpVBkEv83hND/24mVB/Z0iwIy3Cx+vwCEn
         47f5t0yNViYMufPA+myjCKdlF8p9J0kd/DpFqS75F4YB4mCaMTUmzotBdBAN8h3v/6We
         OKqq2VRg04ZE8iC9IeiY3hlyFXvFEEsL/jLJw9jTocyR0Oejq2xwC0kyWSxzdEqEXb8A
         OqXvGKp8j8N5SlsazZoNar4G9SX5Kx0IgDa106KMAZD0BBdnRcnXyze2SrvwqKoGZ04K
         AaDv/DLF/5PQr850tAZCBZ/QYswFpkddra+D3PE4p1DQ2x2Hol+6aNw8BdEI6hT0mHSO
         s7tw==
X-Gm-Message-State: AOJu0YwZac+lHbQxJelt3f03VSE9J9ZZ5DqDyuuYf9/KabmAMP2w4yJy
	K0MPlqm0/fyCtPYR7J0eKP+cQVg2jM+XtRNUeX08eVkPqReNIeLzWEogL/EpZg==
X-Gm-Gg: ASbGncs8F8PMj9csC1dfdfNGekixJukyyGMenHhKNzZW/hrzXhUNpmTETPBewxs9FwB
	J1DjK7DR3ykeOBe/ccn+9vdXX0PQzyHudThCUa3/k53Oqi9vmoA6pmrc7aQjEO+9d9De77CAjVc
	zus8ZD72iPfnpPuy1dNeBN5rXgweCxWpfL+Fa92LxQ/qyzoR0BkK1+pyshRQDOLN2oS9RRhdGCo
	Foj7WQfzYH8r/c8T8gqsU+6fRAsigDP0T+U+sCjQ3jRNHcv4O8gBSUwAx09D4G4TXlGbbMbyIGE
	fx0qgvRANO/m7Fvvy67ljxORRkQnykDla1Uzqrnh2Ve38gSqST4h5F1IWdXeIXqjXL03N3UDqcG
	Wj3a9+HmedoNlj9i0yUA48gvinncaAFWg1ulJA+yk8I732bfLJ+slVzrAv5rOQ51nqLM91hxCd5
	5hCFX4VygI5yDcDlpG5h6uD2omr7XHnenBIDhd2zH7
X-Google-Smtp-Source: AGHT+IHo/S8rrT/HURzShIM6mEJIDqp3jfF3qKXby0gLN/xKvdX/Y3PXFJe/4JPAD41Dr0hjq9LijQ==
X-Received: by 2002:a05:6122:1d16:b0:539:3bb5:e4c8 with SMTP id 71dfb90a1353d-54a16cd393dmr1593304e0c.12.1757701790190;
        Fri, 12 Sep 2025 11:29:50 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d40b63bsm968454e0c.22.2025.09.12.11.29.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:29:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/3] Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
Date: Fri, 12 Sep 2025 14:29:39 -0400
Message-ID: <20250912182941.31867-1-luiz.dentz@gmail.com>
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

