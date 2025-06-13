Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB502AE6D
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749855754; cv=none; b=Uk29UwG5e+6hfZPCmq+AihFVlXqlx/zhQSN2eFEaDgv1dfbt2Q7y/YVsAummUmxwoHLhvnOcQXGVPgVrAseMQNTILajPR9WeORTcB0TTDpy/sRh5mSVCg7oJAD0RVu4DSHvsgJqRtrHntrfPWwHXZjdRlZPXErlXoAxeuvdei2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749855754; c=relaxed/simple;
	bh=ovJkFkZibOT5oK7cvFe9gDIRLjFhjcwRMcJHu/dGoKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEMs65z7KLYDkQXr9iajxnTfbzDh2OQ2h1pakEtpFgnxusc7nJsKd70uJiaqUa6tHwlQOXYtkX13ISfXLwzpvhqQyTwT5+6nZn1VIF4shirkZ4nlDAfyO698tp/2zQqWO/Rp7WjK6gByBvPwozjw3Xxol5+3rcC3wDNAI3wLUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHLs2N2l; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHLs2N2l"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74264d1832eso2886356b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749855751; x=1750460551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PE9s9lmlHxhgv2odDeSGNOetD0vJ1YGGBxSwQuhqWw=;
        b=NHLs2N2lt8fhgdeMlkGQjgjRFTX2rMBWdV+t8oP43s5qqTUO6kx3oQogiXUP9+7xF8
         zolmyjxLxc6jkb/XTJlFZxuJsz1WjaNuKzeGJI5YTH0gXmu/n3PFTfwFj/yFLmEo7qOp
         iFCutuc+jLQiaxY0Xdp53/vMjD7WkGWrbyR1sIU4JhdhkFL8ec+tMvLXjtS5C4nFqwwd
         bZ8ADWus1Y3VR/hc/6AwDBkxAxBGsc/rvzVcCI4DMq2R//513iC1ohwftXm1oyjI64vk
         iFfmZkolVdLCn2Nzh6QdaZuWPRW5RURJHyWMetdfouHeRVxXiPTd3oqYMrvNpGm1GfQs
         flEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749855751; x=1750460551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PE9s9lmlHxhgv2odDeSGNOetD0vJ1YGGBxSwQuhqWw=;
        b=OvdpSGuR6kEGkAjf/q3Zm1JNPY6AMdW/luwzRFDR/cS4Xeox5cB0/aYzDX6Fmwe3wq
         LjbUVoni2Ko9hl1Uwy7qwkzgeHg1dBKPq06farS0J7jYeIvJOnUSounxl7MKFhnHVNYa
         Jisd0IO/ZgY0/lgEP8KLC+YBBRxBn1ToeyxFgYIsth9tFoyb2fVoOac3CUmPytU71Vd9
         NNzb9o4h2xlHMmIU3mCS1BAdAjA4T2/qpjRaLg4A6UE9l2NkRSJDrjyxlmNKJW+9niYg
         ICzTrKTzZk/bnmpL7INs/3zsIYwLiF4MddefapPfpajQK43V632Q83ymjbeZ1xhIeefk
         ZZvA==
X-Forwarded-Encrypted: i=1; AJvYcCVFeKWWNWcAAPPfVyVD54XCSnoP/hJS639XpMB/7kX/O9Cdaqeg0N+d8ID9RQgxN5c4P2tHDfgyrK2hwn99ApI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLIRxg2emZq5W+Z7maZ6ok4HXaLTUS7Y5NuG5LNSIP7qfK+j2
	RIP1Mr3mtDM8ZIzKpLNtEg967mXknT1qLqG1uwRad9OYBjqJJY8NwfY=
X-Gm-Gg: ASbGncvsb8pc4wbCjuNFoHF0R1grPZ5VHaZq4u8F2zJpav/TaBTfQNI6GONG4Ln3RFM
	tysH9kXSCs7fvO9q/4Kme2g4u3PKP6eYjvAr29CJbktZom65AETocmkGKz77aFGCT+OTpR8moep
	4GloVPo6Ptjo0zNIKuNwjvl3iZWbSSQVeOfQIYNaaeEHQu8HnPE9cU68fbSeq7TYk08rRsFaRvs
	Tq2pw9fks2ybB9aPRAZAHHVoNkSEk42mP310h+ZjTowfqV+rH1Dwisg773otDq5J9R4OfckMgLR
	Xe3Dni6GY7ikYoPfuRs2obX5CCUXRd+krUrYI9M=
X-Google-Smtp-Source: AGHT+IE7yzmJIApBasp31vfOp8KNhVNTjtlgSSSlQF/Hirsf4nmX5b9e+VhjVInF0SgaeZ6oaHR8Tg==
X-Received: by 2002:a05:6a00:18a5:b0:746:3200:5f8 with SMTP id d2e1a72fcca58-7489cff9e59mr1173495b3a.22.1749855751011;
        Fri, 13 Jun 2025 16:02:31 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900ac001sm2259350b3a.108.2025.06.13.16.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:02:30 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Marcel Holtmann ' <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: David Rheinsberg <david@readahead.eu>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Subject: [PATCH v1] bluetooth: hci_core: Fix use-after-free in vhci_flush().
Date: Fri, 13 Jun 2025 16:02:21 -0700
Message-ID: <20250613230228.1243343-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

syzbot reported use-after-free in vhci_flush() without repro. [0]

From the splat, a thread close()d a vhci file descriptor while
its device was being used by iotcl() on another thread.

Once the last fd refcnt is released, vhci_release() calls
hci_unregister_dev(), hci_free_dev(), and kfree() for struct
vhci_data, which is set to hci_dev->dev->driver_data.

The problem is that there is no synchronisation after unlinking
hdev from hci_dev_list in hci_unregister_dev().  There might be
another thread still accessing the hdev which was fetched before
the unlink operation.

We can use SRCU for such synchronisation.

Let's run hci_dev_reset() under SRCU and wait for its completion
in hci_unregister_dev().

Another option would be to restore hci_dev->destruct(), which was
removed in commit 587ae086f6e4 ("Bluetooth: Remove unused
hci-destruct cb").  However, this would not be a good solution, as
we should not run hci_unregister_dev() while there are in-flight
ioctl() requests, which could lead to another data-race KCSAN splat.

Note that other drivers seem to have the same problem, for exmaple,
virtbt_remove().

[0]:
BUG: KASAN: slab-use-after-free in skb_queue_empty_lockless include/linux/skbuff.h:1891 [inline]
BUG: KASAN: slab-use-after-free in skb_queue_purge_reason+0x99/0x360 net/core/skbuff.c:3937
Read of size 8 at addr ffff88807cb8d858 by task syz.1.219/6718

CPU: 1 UID: 0 PID: 6718 Comm: syz.1.219 Not tainted 6.16.0-rc1-syzkaller-00196-g08207f42d3ff #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 skb_queue_empty_lockless include/linux/skbuff.h:1891 [inline]
 skb_queue_purge_reason+0x99/0x360 net/core/skbuff.c:3937
 skb_queue_purge include/linux/skbuff.h:3368 [inline]
 vhci_flush+0x44/0x50 drivers/bluetooth/hci_vhci.c:69
 hci_dev_do_reset net/bluetooth/hci_core.c:552 [inline]
 hci_dev_reset+0x420/0x5c0 net/bluetooth/hci_core.c:592
 sock_do_ioctl+0xd9/0x300 net/socket.c:1190
 sock_ioctl+0x576/0x790 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf5b98e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf5c7b9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcf5bbb6160 RCX: 00007fcf5b98e929
RDX: 0000000000000000 RSI: 00000000400448cb RDI: 0000000000000009
RBP: 00007fcf5ba10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcf5bbb6160 R15: 00007ffd6353d528
 </TASK>

Allocated by task 6535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 vhci_open+0x57/0x360 drivers/bluetooth/hci_vhci.c:635
 misc_open+0x2bc/0x330 drivers/char/misc.c:161
 chrdev_open+0x4c9/0x5e0 fs/char_dev.c:414
 do_dentry_open+0xdf0/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 vhci_release+0xbc/0xd0 drivers/bluetooth/hci_vhci.c:671
 __fput+0x44c/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6ad/0x22e0 kernel/exit.c:955
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1104
 __do_sys_exit_group kernel/exit.c:1115 [inline]
 __se_sys_exit_group kernel/exit.c:1113 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1113
 x64_sys_call+0x21ba/0x21c0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807cb8d800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 88 bytes inside of
 freed 1024-byte region [ffff88807cb8d800, ffff88807cb8dc00)

Fixes: bf18c7118cf8 ("Bluetooth: vhci: Free driver_data on file release")
Reported-by: syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f62d64848fc4c7c30cd6
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 40 +++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a760f05fa3fb..9fc8f544e20e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <linux/srcu.h>
 
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_drv.h>
@@ -347,6 +348,7 @@ struct adv_monitor {
 
 struct hci_dev {
 	struct list_head list;
+	struct srcu_struct srcu;
 	struct mutex	lock;
 
 	struct ida	unset_handle_ida;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 07a8b4281a39..d648b514e2df 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
 
 /* Get HCI device by index.
  * Device is held on return. */
-struct hci_dev *hci_dev_get(int index)
+static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
 {
-	struct hci_dev *hdev = NULL, *d;
+	struct hci_dev *hdev = NULL;
 
 	BT_DBG("%d", index);
 
@@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
 		return NULL;
 
 	read_lock(&hci_dev_list_lock);
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->id == index) {
-			hdev = hci_dev_hold(d);
+	list_for_each_entry(hdev, &hci_dev_list, list) {
+		if (hdev->id == index) {
+			hci_dev_hold(hdev);
+			if (srcu_index)
+				*srcu_index = srcu_read_lock(&hdev->srcu);
 			break;
 		}
 	}
@@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
 	return hdev;
 }
 
+struct hci_dev *hci_dev_get(int index)
+{
+	return __hci_dev_get(index, NULL);
+}
+
+static struct hci_dev *hci_dev_get_srcu(int index, int *srcu_index)
+{
+	return __hci_dev_get(index, srcu_index);
+}
+
+static void hci_dev_put_srcu(struct hci_dev *hdev, int srcu_index)
+{
+	srcu_read_unlock(&hdev->srcu, srcu_index);
+	hci_dev_put(hdev);
+}
+
 /* ---- Inquiry support ---- */
 
 bool hci_discovery_active(struct hci_dev *hdev)
@@ -568,9 +586,9 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 int hci_dev_reset(__u16 dev)
 {
 	struct hci_dev *hdev;
-	int err;
+	int err, srcu_index;
 
-	hdev = hci_dev_get(dev);
+	hdev = hci_dev_get_srcu(dev, &srcu_index);
 	if (!hdev)
 		return -ENODEV;
 
@@ -592,7 +610,7 @@ int hci_dev_reset(__u16 dev)
 	err = hci_dev_do_reset(hdev);
 
 done:
-	hci_dev_put(hdev);
+	hci_dev_put_srcu(hdev, srcu_index);
 	return err;
 }
 
@@ -2433,6 +2451,9 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	if (!hdev)
 		return NULL;
 
+	if (init_srcu_struct(&hdev->srcu))
+		return NULL;
+
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
@@ -2678,6 +2699,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	synchronize_srcu(&hdev->srcu);
+	cleanup_srcu_struct(&hdev->srcu);
+
 	disable_work_sync(&hdev->rx_work);
 	disable_work_sync(&hdev->cmd_work);
 	disable_work_sync(&hdev->tx_work);
-- 
2.49.0

