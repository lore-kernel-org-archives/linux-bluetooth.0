Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372223BCE3
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864867; cv=none; b=ps4aoxSioiKcxWPXXDZl9FOz5WURUCSnk9WfXZFXBKXi8R7i3tIIQPbxYbtLDEdX2aenGKf9xpMWHg5tf5KnoQMTyi41V9vL/YKwZ+CRTeCe9EytfwJN+G8HNtUUI+AUjGGAxyVxbt5Sdb+cR+0bcyIVE4Zxp/KgXZfYWknaUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864867; c=relaxed/simple;
	bh=Vw/pUHcQcJxGtl7rqO4AZaWgMImlq9FTd3lRF7GqwOw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SFm0v2vTpJ+exrW33CF2N9X+g5n6bYVHZUPyREnzssma83hdMIBJj2ElN7NC8DTAeWZY9xCbjh5a/3c9nZyqgfLjFcWOcvmDr00A0QAqCKGl5axrZ61/RK+pB9lrEo+XUWN200cW01cXqU0enCkn9UmlMkdOdZj6yVP1X88dwDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69492bc3a38so3211655eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 06:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864864; x=1777469664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6WaWM4tjv86DS5nK3WHJW9i7eYlwCGd+p8KSv5y3Y4=;
        b=Jc4Map2BED9mIK2IOBPA6EALotPgoHYhoIWvvO29zaPS7APvujYMoH5F2AkXIiQJzS
         UGTF0GAvtvGhJRLBoFf2uQxjojo5P71Dtorm57br9DivF9wPsSH+pUdnkQfWGbrpXh+5
         uX/IBiCTLokVjtws+k3K7gru4Vau9wXUTfJLqspSVZBueS2WKmtAfF4pl+E5UdEdo5T0
         kgWFCt1Gccs1kSfQTCEccPa7pi3D+oYAayZhMJPfnkOm3WmKcNMhUqzQsv3egb1DvII/
         2dRGxe6HG67SKTB60QvvoN8kUVDTwi638mHg8fN8+ixpgp5AaGqraqKNuwMmv0ALKDx3
         vWbg==
X-Forwarded-Encrypted: i=1; AFNElJ8nuDKmYG0Momw4TpmCBZg+9haor1OB2oX1UZriqrAn9C7aGlCCdMqw3xAQQGBgXMuXn07MFdKE5IKy4kabW1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxBN7Sth0grtYLaFJxvUH4bCfPFLOO8s6b2x03ONWaUUSs1vS
	fT/CtOTOlxvPx07L8slpipAFsI1DVZOvFDBOfTVCRFApRW+cDrgVBMuCMllX3z7+YFMaEE9wJKY
	JkB6+AeF8B22RokfMIeeDz6HswcO3P8nTTozroJr9nkief/QTvH/55dc1A7U=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e90c:0:b0:694:8b4d:5f8f with SMTP id
 006d021491bc7-6948b4d61b9mr6678588eaf.57.1776864863740; Wed, 22 Apr 2026
 06:34:23 -0700 (PDT)
Date: Wed, 22 Apr 2026 06:34:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e8ce5f.050a0220.24bfd3.0041.GAE@google.com>
Subject: [syzbot] [bluetooth] KASAN: slab-use-after-free Read in
 process_one_work (2)
From: syzbot <syzbot+b6a688ec97f423efb8ab@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c7275b05bc42 Add linux-next specific files for 20260417
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14aac1ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac861e8185149d86
dashboard link: https://syzkaller.appspot.com/bug?extid=b6a688ec97f423efb8ab
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/02c64cb49b64/disk-c7275b05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2703650c5cda/vmlinux-c7275b05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a9b28b754f3/bzImage-c7275b05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6a688ec97f423efb8ab@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
Read of size 1 at addr ffff8880318ca330 by task kworker/1:8/10951

CPU: 1 UID: 0 PID: 10951 Comm: kworker/1:8 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: events l2cap_chan_timeout
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x84/0x350 kernel/locking/lockdep.c:5844
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
 rt_mutex_slowunlock+0xb8/0x300 kernel/locking/rtmutex.c:1426
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 60:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3a6/0x690 mm/slub.c:5415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 l2cap_conn_add+0xaa/0x970 net/bluetooth/l2cap_core.c:7001
 l2cap_connect_cfm+0x142/0x1560 net/bluetooth/l2cap_core.c:7378
 hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
 hci_remote_features_evt+0x5b9/0x950 net/bluetooth/hci_event.c:3760
 hci_event_func net/bluetooth/hci_event.c:7796 [inline]
 hci_event_packet+0x6ab/0xef0 net/bluetooth/hci_event.c:7847
 hci_rx_work+0x3ee/0x1040 net/bluetooth/hci_core.c:4077
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 13989:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6246 [inline]
 kfree+0x1c5/0x6c0 mm/slub.c:6561
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
 hci_conn_hash_flush+0x10d/0x260 net/bluetooth/hci_conn.c:2734
 hci_dev_close_sync+0x821/0x10e0 net/bluetooth/hci_sync.c:5368
 hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
 hci_unregister_dev+0x21a/0x5a0 net/bluetooth/hci_core.c:2716
 vhci_release+0x155/0x1b0 drivers/bluetooth/hci_vhci.c:690
 __fput+0x461/0xa70 fs/file_table.c:510
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x70f/0x22c0 kernel/exit.c:975
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1117
 get_signal+0x1284/0x1330 kernel/signal.c:3037
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2226
 __queue_work+0xcfd/0x1010 kernel/workqueue.c:2381
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1794 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x764/0x9f0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1155
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2226
 __queue_work+0xbdb/0x1010 kernel/workqueue.c:2385
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2432
 queue_work include/linux/workqueue.h:696 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1660 [inline]
 l2cap_connect_cfm+0x10f5/0x1560 net/bluetooth/l2cap_core.c:7419
 hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
 hci_remote_features_evt+0x5b9/0x950 net/bluetooth/hci_event.c:3760
 hci_event_func net/bluetooth/hci_event.c:7796 [inline]
 hci_event_packet+0x6ab/0xef0 net/bluetooth/hci_event.c:7847
 hci_rx_work+0x3ee/0x1040 net/bluetooth/hci_core.c:4077
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880318ca000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 816 bytes inside of
 freed 1024-byte region [ffff8880318ca000, ffff8880318ca400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880318cf800 pfn:0x318c8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000240(workingset|head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000240 ffff88813fe0fdc0 ffffea00007db010 ffffea0001ad2610
raw: ffff8880318cf800 000000080010000e 00000000f5000000 0000000000000000
head: 0080000000000240 ffff88813fe0fdc0 ffffea00007db010 ffffea0001ad2610
head: ffff8880318cf800 000000080010000e 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 17176054733, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x27d6/0x2850 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x33c/0x3d0 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x373/0x720 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 __kmalloc_cache_noprof+0x44e/0x690 mm/slub.c:5410
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 comedi_alloc_board_minor+0x57/0x530 drivers/comedi/comedi_fops.c:3510
 comedi_init+0x109/0x1c0 drivers/comedi/comedi_fops.c:3664
 do_one_initcall+0x250/0x870 init/main.c:1392
 do_initcall_level+0x104/0x190 init/main.c:1454
 do_initcalls+0x59/0xa0 init/main.c:1470
 kernel_init_freeable+0x2a6/0x3e0 init/main.c:1703
 kernel_init+0x1d/0x1d0 init/main.c:1593
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880318ca200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880318ca280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880318ca300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880318ca380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880318ca400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
