Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AB2571D4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455120; cv=none; b=fBkP1omYALxplPd/C/PEG1bt4cJfeqvObmkpqlSDa9CuQpYWOcrdDzTN1PbqI1V+UTzNMvwwCAdI6ddyor2beCOZxx11qMZ5AhEk11f8+Kt96MBLFM81iXRczfZSNf8PHQ3CyDANZk91khTjx5HXPXjM75ZjDXxZWyUsKrRpeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455120; c=relaxed/simple;
	bh=esxEDSpTZYDm4CXVVwwabGZNI3fO5CdC1/ExRJbIDPc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSib/e4/gyfz3omtzO4d9EMUxxQ4SrVuss6oOZP0Tj9XB8rXi06JQIEWhd1G6ANMxu9UwOM6zUBgPJWTB+jtSN8iw5duWT54MZqpaF2NA/VyeJjTCr+mT2FxNw3tYHEP42RNQBIrpS4WdWrGHVahppvgRTniCBUWeV+uz6wchKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsUs8z+r; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsUs8z+r"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5300b29615cso4147775137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Sep 2025 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757455117; x=1758059917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKaHHLjcDQOUYOLH/4lDiFVfUKe9peYlx+IVjuWnnbQ=;
        b=EsUs8z+rcSiUm4LUzaMqZZdTk7EahYxq+3b+IdsOF/ITWkI4upRoexK4rkfwbgXEhQ
         7osaQfHg04WHqDvLIJE+Jf55X49N656C5eU35uN8RVmJ9CAIriDpbjh5Lx6feGiCuRy5
         BamwwbADPsuIRQ4Gbw+OApoOGQHU0Jx6Xn3Qth9TGb1OlwTkDi4uOW+kuDiPPdhbEY07
         qUq3aUw1Z1lhcVyDTMG3Y+wgpJiaJzOyOypezFAobKlK53c8kMGQsIM2IJw2oi1tNe9p
         tfjmKAM6Us03VQ7ySf+9nSRUb0NFM1NulGtdYkI2shMxg5iWvwLIQ3ZLfj1p1KjrnzaF
         UJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757455117; x=1758059917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKaHHLjcDQOUYOLH/4lDiFVfUKe9peYlx+IVjuWnnbQ=;
        b=YzNZ1N4JnNtDe+h81ieYXjP7QK7YpOqSHuZi5JnE3dI8Kq8EzpH6lumsPu7HUgsSGj
         zGza89IcBaZ7EKQBKRJ9hR2VEvxYLO6MKOwMziOM/x/A/8I31+aCGshwqNzKKk1KE6LE
         lcmfRladyASYXqjDzYgVKQydU4ThtgZa61VXdkLRD64oFVBpvEyzUmHGa1LviCJJzzGG
         Tjt8jD+SupNsT3cJs2HT4a6mDQUxmfkPn5H1hii7V030BTebg2UCXa/yocDj57ukR3cK
         8/goq/JwJhWJgaxACl/YOUQzcKFj4v13ncJDvxQVHNxv5i7NDJGMyFCN2cpa7TOYAba+
         VYgg==
X-Gm-Message-State: AOJu0YwS75YvWQZRODQO7eLOc6c5eOv1lBBQeoc2hnMh7BNBklZppA/a
	Fd/QYIV29/Fm+xgNkRUSpeRbMxasV42SPCzqQXPzgHs96eVjAzid3hsH4sn+52MggFE=
X-Gm-Gg: ASbGncvPF9xVqX0+LaFqZO92kN6xqddZCxzhFTFB81CsfyQ637PlNIgMvhiFILxcRg+
	vTEwiZ4c9ODg9KM5FnprIegjuUSkvAIYssux9EEmRsIBWE+6lb5n5s0hfcaFiARPjZuIhG7XTQ5
	P0EQAjrOLGQLupP+LWj4uCe1EL4gE1Md2m1mn6ccnQv22gpVT/1QZ4nnSwjg82kvZjuFwZzKDZG
	vlS5Up54X27yOHuKI1anTQSH3n2yaFJw93oUU1e7WKeAR+t6PtRMSo4JfZiQm5m5nMu0KcyjXQJ
	EJICpBY1+TbwXEFlUVB5Ei2iPy/hnsUcf6UEugOEryKGCC5h88WDUI8tkZjNa3N8eGjF61kCQ4E
	bwSeyelUc333WeDI3NLU4QYD0cl5Ca0bgOi+09l7Jz9OE6yyZiGQqGZFF9KI5kqVfPToDizC8et
	9aWcekF8VI91ofy6B57LekSYSGI4wCo6jUuYBdzeCU
X-Google-Smtp-Source: AGHT+IFHDeKs9UgQoT8a24IYY55iYQUakLQ+RXWRGGz0BFmZpPHX/Jr5o4VH25YmJE800Cu5MK3rPw==
X-Received: by 2002:a05:6102:290c:b0:529:a2d:a5e9 with SMTP id ada2fe7eead31-53d1aeada4bmr3658288137.6.1757455116959;
        Tue, 09 Sep 2025 14:58:36 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89607330273sm9215212241.18.2025.09.09.14.58.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:58:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
Date: Tue,  9 Sep 2025 17:58:23 -0400
Message-ID: <20250909215824.1739006-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909215824.1739006-1-luiz.dentz@gmail.com>
References: <20250909215824.1739006-1-luiz.dentz@gmail.com>
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

