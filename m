Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F836D4FC
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761312; cv=none; b=r6qhAUUbt6ZT3WoVW1knWOXGeoSg6o/L1Yj1E6QJzFGbA+9WuYOdILtrmm5s8oZc65c7nP1YMnpOLbHoMMBEyIT82MKDVPeHJPFho7Eg1EO+ryo+RlwgBDZR+vhC9jWIv92mo1unC0OzLjL/SwzTe06wl/48YpPU+8oiVE6PzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761312; c=relaxed/simple;
	bh=WzADBPoioe8wJIb1bSxmokuCqoks5zMGfmKykUskkdA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s46WjzFiXLFD+i5fYB2lT3LL6C+WU5niKjOZLRepNwsuz3X+dxlCwf+LObQ0BebhRaY7rSmHHxmIxEMv0G54oB+Zma5FzNnk/BAF63zhIXv9G0DXI+AHjM1e3hCjKqUJPdaZAOoS3Hs4crdzpz3OPows/b2ha2FhV0e3szPukoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6574475208eso2694180eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Dec 2025 03:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761310; x=1765366110;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tw8fZMYsNsjCYR15Owd4XEwOB2IMoPTGqCNuHJpR32E=;
        b=Vx97LWaxQbcvmJz1NYMoigBP/6ixQhSZwSm3sRZXVu1jEtP1fnYB2HVuJWeL+m2yb7
         tMaKzXSMDbHr90IuAEIMDTRiqXKeJCvQImnQCwB3ga0EPKvsoZgv3mepy6UAPmXTpTTS
         AS6loyuPdjh7MnDsJ+zZ+Ny95LJCT7/kDOf2brsFbrOg7cRva6pJ+L1Sgh99fJ6yXR0O
         FmUx10utMsl80/etD5u86anT1hGehYRLmaUTPpMlFz0tI9ankQN8sxb8KLaTxLZwN9in
         kZ24v/4ruQjx+s5MgS7TzIWis5q3IrjdBFpkw1T/ZgyrUchLalRsDqGplD6nNaAI7Gzj
         wpCg==
X-Forwarded-Encrypted: i=1; AJvYcCXlYUYNVkMMwtFKRco3ATQ96ZCkrushlKFEs5OPoqjNlsCchfmChO3fMB2n3esKs4fBl8m1Y6bT4C35dxwK9AM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4w6HFDkd3LI3RE+CLmP/HCzBC7wx9dNCrV3SNb8/+bEwlJHob
	1v6LSBuLeibq+YuzipwwE6Kf045SGtlfdk7Ip1XuwlAj14lMjnWy+6W/CCTiOd51GAEcXYqKDp7
	+sVzDDo2IujgsuCt/4FLL9+g9BrwxL2bXT7SzSs/ww7mYvGTrdk/x2ImjMY4=
X-Google-Smtp-Source: AGHT+IF7JMbLgUXjuplTMqEBPxwb4JzEW+uPCp0BsWCWfZdgp2MHPDcD6zXt5gRuPVf58Pni0EcIIbqUNJcxf4lMAtMZbsc6IyqA
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a54:4785:0:b0:44f:eb07:5042 with SMTP id
 5614622812f47-4536e51cd96mr710116b6e.44.1764761309801; Wed, 03 Dec 2025
 03:28:29 -0800 (PST)
Date: Wed, 03 Dec 2025 03:28:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69301edd.a70a0220.2ea503.00cf.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (3)
From: syzbot <syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1715f484580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
dashboard link: https://syzkaller.appspot.com/bug?extid=3609b9b48e68e1fe47fd
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d34112580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f0e112580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad90de/disk-7d31f578.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca7/vmlinux-7d31f578.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc0448ab2411/bzImage-7d31f578.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop+0x34/0x2b0 include/net/bluetooth/hci_core.h:1688
Write of size 4 at addr ffff88807b2a0010 by task kworker/u9:1/5148

CPU: 0 UID: 0 PID: 5148 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
 hci_conn_drop+0x34/0x2b0 include/net/bluetooth/hci_core.h:1688
 hci_cmd_sync_work+0x262/0x400 net/bluetooth/hci_sync.c:334
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 5848:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x3e2/0x700 mm/slub.c:5771
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 __hci_conn_add+0x3c5/0x1b30 net/bluetooth/hci_conn.c:963
 le_conn_complete_evt+0x6f6/0x1420 net/bluetooth/hci_event.c:5714
 hci_le_enh_conn_complete_evt+0x189/0x4a0 net/bluetooth/hci_event.c:5861
 hci_event_func net/bluetooth/hci_event.c:7716 [inline]
 hci_event_packet+0x78f/0x1260 net/bluetooth/hci_event.c:7773
 hci_rx_work+0x3ee/0x1060 net/bluetooth/hci_core.c:4076
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Freed by task 5848:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6663 [inline]
 kfree+0x1c0/0x660 mm/slub.c:6871
 device_release+0x9e/0x1d0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x228/0x570 lib/kobject.c:737
 hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
 hci_conn_del+0xc36/0x1240 net/bluetooth/hci_conn.c:1234
 hci_disconn_complete_evt+0x64e/0x950 net/bluetooth/hci_event.c:3451
 hci_event_func net/bluetooth/hci_event.c:7719 [inline]
 hci_event_packet+0x7e3/0x1260 net/bluetooth/hci_event.c:7773
 hci_rx_work+0x3ee/0x1060 net/bluetooth/hci_core.c:4076
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

The buggy address belongs to the object at ffff88807b2a0000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 16 bytes inside of
 freed 8192-byte region [ffff88807b2a0000, ffff88807b2a2000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b2a0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe27280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe27280 dead000000000122 0000000000000000
head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001eca801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5848, tgid 5848 (kworker/u9:2), ts 108134257211, free_ts 108012219828
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xf2b/0x1960 mm/slub.c:4651
 __slab_alloc+0x65/0x100 mm/slub.c:4774
 __slab_alloc_node mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:5246 [inline]
 __kmalloc_cache_noprof+0x41e/0x700 mm/slub.c:5766
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 __hci_conn_add+0x3c5/0x1b30 net/bluetooth/hci_conn.c:963
 le_conn_complete_evt+0x6f6/0x1420 net/bluetooth/hci_event.c:5714
 hci_le_enh_conn_complete_evt+0x189/0x4a0 net/bluetooth/hci_event.c:5861
 hci_event_func net/bluetooth/hci_event.c:7716 [inline]
 hci_event_packet+0x78f/0x1260 net/bluetooth/hci_event.c:7773
 hci_rx_work+0x3ee/0x1060 net/bluetooth/hci_core.c:4076
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
page last free pid 5999 tgid 5999 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 discard_slab mm/slub.c:3346 [inline]
 __put_partials+0x146/0x170 mm/slub.c:3886
 put_cpu_partial+0x1f2/0x2d0 mm/slub.c:3961
 __slab_free+0x288/0x2a0 mm/slub.c:5947
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:349
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4948 [inline]
 slab_alloc_node mm/slub.c:5258 [inline]
 kmem_cache_alloc_noprof+0x37d/0x710 mm/slub.c:5265
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2498 [inline]
 do_sys_openat2+0xbc/0x200 fs/open.c:1426
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807b29ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807b29ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807b2a0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88807b2a0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b2a0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
