Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF8288C1E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941022; cv=none; b=ZU7895Tz1GO1tUO21oK/DNv8pPpA3lDJGfoZyrYqJ4YQRvQOQ9nrrqjs8S8PDAawaOzaXscv3zRNNMmFrPvse53OrBgQoG3Ja7O5w1NcL4+kpQ8QL2ybKJPw4MMjC/uww9ontRTQivnLxLfkS6XdVaqw7s2fx+4k3MwCkYGaxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941022; c=relaxed/simple;
	bh=esxEDSpTZYDm4CXVVwwabGZNI3fO5CdC1/ExRJbIDPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G4fdvj6KbyZFpCnUWSiG0t+ZM3bnUL8HEhhvqa0s+oVoAbSG9j3QjRXJZ4OOFycyBwFnpNPCrKlVHHGYpETQCnhsR0B3aavVMqkkl1UpqUZApzCk859gGn1STbWL9e88gUlcpuviHg4TSemm6QPfdv120Lius60nUIQeMSZ2cAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jswNDbQ/; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jswNDbQ/"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-55784771e9dso1070780137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941019; x=1758545819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKaHHLjcDQOUYOLH/4lDiFVfUKe9peYlx+IVjuWnnbQ=;
        b=jswNDbQ/9Hhw6v43SRDtK+frkwp6hE43TIFZc/FOv01qIEocDAsMTJowGN32NnSIW0
         NKRaYI0ebzMJXZ6A6ixkYBrKYbqXRvmWsdIkNKNE6Z1oMMBtBypYqvDX/R6emFHdE8bi
         XTl4QjrGZf0akkJRjJKqMuxqxPb5bKF6wQx0VNYbtqGi4kWoh2EKfFrv+37pDJo3Y4SY
         kpyr60MNs6Zp6eg++hXNd9ke8K3XLJ930oTXvpNzM2EktqzthwTxt0qhRoCemSjLR738
         hulT+kArWEI/bArUdDWjbs2o0iaJYeyfGWXNYRPNVcHNdTdMT82nIxCdB4FdlEXO9wmD
         s9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941019; x=1758545819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKaHHLjcDQOUYOLH/4lDiFVfUKe9peYlx+IVjuWnnbQ=;
        b=Ucl+fnumm8yojsr5ET5h2V+IxX+wh4x6kpS4LV8mzwvktB7w5R/AVW7KtC5c/v5LPO
         oXNvptMlkBdlKP/a/VuOCu9dIKaawmBGx2huByKmQEe/EqqQJJilULCq63Ze/rXkJiSk
         gJZIhbZmuKFAyh65DSsLCznb1u2fIXusKBXB7HX5H9P6qOaRrrbus0bRFybgjVPXMk3e
         B3JnU1sE60qcyw0QAbyqDJ+9okg32bJ76jfet7VcZLoWfN6CLxcPUDXR9DrQY7o1pS11
         Rd7okeftLv88gl/5wSbbOIvOdWpCbszxHctD6Tx8oRqB0nSFwvbQ0mzAVQb8GK6Wua20
         gbGA==
X-Gm-Message-State: AOJu0YxbUs46VXIMxcSRiNT5pe2MfhryYltrdMTFYe1CyIGrL8U3NzEr
	F0DCths9yJOpA7FUiBDtla70XgndWiwi4/SwlT55hEJjRWJkVoJuB9fyCckH5g==
X-Gm-Gg: ASbGncu1Ws+byYl04/FCc1GqERNYPS9mRdop18aOFgB3MbCIanqrKoTP7UxwJbKOWKi
	eOBbTydJNs0osAJby0gXRFStJvBbY7eqgmoY6ES5T407mqdxBfQex3yLQEnw/6WQl24pf1tF7Av
	ES+rjNYALfzg+8rCr8ecgoCIVgdVKtSIP03+S8Mcdut9SBEBi3VVblTXKGbf+2/gBP4xafsOGit
	sHG4mM5+9vPcV6j97CThGB1eYOGOTxT6crME45V1V6tNmYp0T8ht2pDeVp0xLSyjmVgoaMJJovi
	vP3W8X3oOq9tSZ4x9hRs59yb27mBjQxoHcLhoUBRnU6aw1oI8kgc3xAQEgfLPMo5V0b1LkQl89C
	ER2yX8N7bp1VCe2SnkmaiUaPeW9gKmQhIIi9JiZ8EPNBMovu44YZgg6FTHu7vXu6O5g==
X-Google-Smtp-Source: AGHT+IE1G4+ersqzBU47nfJMy5ruicqp1xs6XyhCmeB8OfKJYzrib+aLrtRHfRsm6GkwQ8TbI8YdhQ==
X-Received: by 2002:a05:6102:b12:b0:520:a44f:3dd6 with SMTP id ada2fe7eead31-5560a3ff4dfmr3788377137.8.1757941017091;
        Mon, 15 Sep 2025 05:56:57 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-555bd4fe0a4sm2490260137.8.2025.09.15.05.56.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:56:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/3] Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
Date: Mon, 15 Sep 2025 08:56:42 -0400
Message-ID: <20250915125644.664438-1-luiz.dentz@gmail.com>
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

