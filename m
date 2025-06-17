Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B92FA62E
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179506; cv=none; b=iJ8lo1lcXZDP7K8SNbfonz3mr3wKlR3IS0mW0LWybQs2O3UHGvRyuFqmeVuhG4j1cnMTrddDF0K2vpI5z1zQHYoUY7Vv1FvJCN/EHstxLBkDu5YNWM/75VjaZbt7i1rUHUQNlmiS1RbsOv3ShsR5wuF4Qd7zQqnIRDHDiddyb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179506; c=relaxed/simple;
	bh=jI6GcIHsPxPMIpIrjhQ0LkQfrlJXvn3ulHCDpr1sYvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtmCdTDFhhnQE3o3c3ZXNvCO9hlX30ZzJqgdIEQkitO+ogp6vrzPCTL7B39KmcJn7yRKbDyLoMFRA4RLdoXnDZNZlebpJZbI5s4rFlKXaThjw4TUMjsRMWVmtwca8QOj6UYp3DmSkJfR3DuAjBA4ztXTSOC5884RTS7/PT9vPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8j6JT2u; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8j6JT2u"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2360ff7ac1bso42141995ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750179504; x=1750784304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLaruF6nFX9m5hiqItF1n1lBuh7pApW2QKqY9CbknDw=;
        b=J8j6JT2ubJU0d48tz9a1+5E5HD0SR4Mi65OxPdzWYudnDPa7rPC5k3o4XLKkDW5R2/
         Wz1ug2ySXFxnW3ssBA60/n2dd69bmmo/tuw8ac1wP+YPz8JMnBdnhJ+aVtj+O8N4hlTF
         Ox7f+OHANxosXgbr9IhDOD9x9Xiw8xqrMsHmpBe4y+hCXA92RDlcyOP4SyQktkHWfLI/
         C6EbdYHVa6XgwAYLmk09+eS9njaumlkcMYzf49Opk8GWpviyVYdI42myu9/U6ucLovXD
         hIQeoovixr71IXnzJmAjdHP2Dr8NCDUlq8dJ+s+m1olADLWIm+7y/9z12abaivgxWvT/
         Srbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750179504; x=1750784304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLaruF6nFX9m5hiqItF1n1lBuh7pApW2QKqY9CbknDw=;
        b=B2DZBj0IB+A1iFQkAIG44fSKz6/AzMXaDAjf2If8UVQhQQ4QrA5UrqIHKR5jXk5lvD
         R/AXyrDpazVh+LK2cKXLWZBEJP8Ze8C67TMtG9n86ysBluUfBFv1xjnpl7V0P6UQubMQ
         q8McK23uWH6fJdgedc24Hbpj//LMydVpEm0Zhsnmg1mCEnJhPoZSXHwjwZzSiSg3k1qO
         gH7UGpFqYJ+K6Tr6GWi45/5ocezgGt+HUtJMQ6Hnuv1l9TD7WhDJWCRBzFALFZwtERYZ
         cAc9vZ6vYfC5FnreFOI1GgEkpJPK0rDoFsjTjq10m9mySY20ZqUaaJa8hIiL9kUcXBuL
         M5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCX+W5iPuRev57i0QHZBFsp/T1wjIE7ISeUjH6nGLntL2eK6gOpatq5pRq5XKJ8WZyliyUBfHi7kuhmrGchYNEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7U5o+WTY2Ry4aZAUB3Afwzaq8+DsFyBDP4MoFbp/bG1Zx76i
	1e10sjcrcJ6UjOaQF1S4zg2Al9J4kDfdEOpvAItq7WV2vVt372PwnencLkElsYoJUoeW
X-Gm-Gg: ASbGnctrxiInGZZPgTORXLo2yCQNv5KljtIdC/fDamYyNu8/pO5f13KdgV3P25jtFrR
	cYY1whU/fhJEBRk/U4veDULtLqP26xKupbYZX89f+w3PLRiSdvoqlZ4dVQWgIGbPnPG9lROcSsZ
	6U8+umrctLvtsAwaVDLr/YlR37ZyJ5PdmGEDHDSwG+y4hTVPDJWIZg5DOir9UzYpWJq2dP+Dnvn
	JNIne/JslcJsnQ3sYX4uJUrkvQiRLFzjqbppeua8hI7CggcaCuoqRNWc0Lj6jRsLWKfNKLUfj4s
	0UGBxtV1Zk3pkZQE09oWX/NfrAJIToNXpjLuPH4=
X-Google-Smtp-Source: AGHT+IGN/M/a2b/k0j3hiCYI+3jBtB32GVQJAZpqzzzkBp088X0bgYpd1pfjWJAV/vs4dOFeGQt8ZQ==
X-Received: by 2002:a17:903:320b:b0:236:15b7:62e4 with SMTP id d9443c01a7336-2366b1443c8mr233155565ad.38.1750179503713;
        Tue, 17 Jun 2025 09:58:23 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb87ddsm82666995ad.177.2025.06.17.09.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 09:58:23 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Marcel Holtmann ' <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: David Rheinsberg <david@readahead.eu>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Pauli Virtanen <pav@iki.fi>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Subject: [PATCH v3] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
Date: Tue, 17 Jun 2025 09:58:13 -0700
Message-ID: <20250617165819.1755687-1-kuni1840@gmail.com>
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
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v3:
  * Restore tmp value for list iteration

v2: https://lore.kernel.org/linux-bluetooth/20250616173803.928382-1-kuni1840@gmail.com/
  * Fix subject format

v1: https://lore.kernel.org/linux-bluetooth/20250616173803.928382-1-kuni1840@gmail.com/
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

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
index 07a8b4281a39..ce1d8c997a31 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -64,7 +64,7 @@ static DEFINE_IDA(hci_index_ida);
 
 /* Get HCI device by index.
  * Device is held on return. */
-struct hci_dev *hci_dev_get(int index)
+static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
 {
 	struct hci_dev *hdev = NULL, *d;
 
@@ -77,6 +77,8 @@ struct hci_dev *hci_dev_get(int index)
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (d->id == index) {
 			hdev = hci_dev_hold(d);
+			if (srcu_index)
+				*srcu_index = srcu_read_lock(&d->srcu);
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

