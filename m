Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A3181BB1
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408564; cv=none; b=iecom8QBhoDeXpSCqpbwkP8T3csSfAvWjG9jsBvPtSK9g7VxFoAczy2UnAzoZ34qwts4YzshZiVrFwiMo6ehkMF1U6pmRa/UrIdT7Eda5AP+g98EFHKdWVSOG2OQmf5oTknJwNm6gwGpCitCFqc7Y/tV4QAFzVXVcYycuIRgRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408564; c=relaxed/simple;
	bh=xn504NGNG0kxNXRZnfYlpS74WmBzmR5XEQDopqL45lA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r0LrSkuXxPqUZxmuWwlR7N/YXRrVyooTYI2weFlbnuhPf9GhV5sguQ3iCvGVRRFVLb2dHa+5QQvQeVxcAClPZNQOcu0GcsMSI+DRejgqSIsakbavM6kqdJyR73Bd/tWRA2+E7rdaUUDVoJ5e4VQbQJWAI2H6wX+AfKOnEgv/W6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7f38e9f1f06so846782239f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 06:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719408562; x=1720013362;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGaEcmynSOXaEflC66T6hHmKgzOiTH3W9YWU2vZC/yk=;
        b=qgJSUY5jft3LtQOmUsPzV+MgPGwZvWVWU4tBBX936kVJ7iqNf6QfEFwZoymzbeEme3
         2BWzkFbZwqXbqvYD0vE53Me82Rw8/1QRocrPJnTFpBvpa5uYs8VXWrWijx/vH4Z4hMd4
         1pOV0imtB/zZBsPyjLhyUkOER55+dJaJJxz46uYWs+fq8CND6YpqVASss8VH4YWgEeIb
         TZYehaFZ8PqVb/+hfR10/JFboT80M1hOrvpGoU3fhkMferBCWerCqKtvS5QArrejEmSP
         uTBPrPPJcHb83KmKSsYf+8fLTZMS8F3VaWvqR/dubGFQMTICsUxy6Yo5DfuSNN9F9DWu
         tjBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEoEDtGI+6p8POYvaOnxjDiS91kw9SBcRf+wvKNgBPrqT4Ec+qkskOPILas05PWutuNcqo5dltV2Z1POAPLRBDV0NrpBmUzKXPgrGJZL5X
X-Gm-Message-State: AOJu0YxH3v5fkcxT9NNB6h/qqWyvD8QikgkYWOiT6q/NFhvu6bICTP+F
	YCIGj5DXlYNSFPa/zv2Df6svU96LPe9x2IMfPGYg/DkqfaZ+NWUPPoqju2EYqNXnHAGh54t7icZ
	qeVtlaycjSCx0W/7+F0Mmo90rFvmydPxyvJB0T+X/bU6YCRkkHPIn6p4=
X-Google-Smtp-Source: AGHT+IFK6tEb7xGZa3FsEiesXHsG5oYPksDyJRvr6+CtFcrjW/n6T/oLMxJ9ti0EXVeyNhwTVrapnbMrsrkqBjKBd4JHNNLZLyYQ
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:375:88ec:8111 with SMTP id
 e9e14a558f8ab-3763e068f94mr10698315ab.3.1719408561765; Wed, 26 Jun 2024
 06:29:21 -0700 (PDT)
Date: Wed, 26 Jun 2024 06:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c4e52061bcb0014@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_chan_sent
From: syzbot <syzbot+330fbb52cab59274c69c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    234cb065ad82 Add linux-next specific files for 20240605
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d51564980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc762e458631913
dashboard link: https://syzkaller.appspot.com/bug?extid=330fbb52cab59274c69c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0492dc0386a/disk-234cb065.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/490224339088/vmlinux-234cb065.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5843c0673606/bzImage-234cb065.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+330fbb52cab59274c69c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hci_chan_sent+0x67d/0xaf0 net/bluetooth/hci_core.c:3548
Read of size 8 at addr ffff88801e8a9018 by task kworker/u9:0/53

CPU: 1 PID: 53 Comm: kworker/u9:0 Tainted: G        W          6.10.0-rc2-next-20240605-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: hci1 hci_tx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:91 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:117
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 hci_chan_sent+0x67d/0xaf0 net/bluetooth/hci_core.c:3548
 hci_sched_acl_pkt net/bluetooth/hci_core.c:3685 [inline]
 hci_sched_acl net/bluetooth/hci_core.c:3725 [inline]
 hci_tx_work+0x5c2/0x1590 net/bluetooth/hci_core.c:3818
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5127:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4153
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 hci_chan_create+0xc8/0x310 net/bluetooth/hci_conn.c:2724
 l2cap_conn_add+0x69/0x8e0 net/bluetooth/l2cap_core.c:6860
 l2cap_connect_cfm+0x136/0x1220 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm include/net/bluetooth/hci_core.h:1971 [inline]
 hci_remote_features_evt+0x536/0xaf0 net/bluetooth/hci_event.c:3721
 hci_event_func net/bluetooth/hci_event.c:7424 [inline]
 hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7476
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4087
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5122:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x149/0x360 mm/slub.c:4558
 l2cap_conn_del+0x4eb/0x680 net/bluetooth/l2cap_core.c:1795
 l2cap_connect_cfm+0x11f/0x1220 net/bluetooth/l2cap_core.c:7237
 hci_connect_cfm include/net/bluetooth/hci_core.h:1971 [inline]
 hci_conn_failed+0x1f6/0x340 net/bluetooth/hci_conn.c:1257
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5450
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:310
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88801e8a9000
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff88801e8a9000, ffff88801e8a9080)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e8a9
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff888015041a00 ffffea00006aa9c0 dead000000000004
raw: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4548, tgid 4548 (udevd), ts 39552199694, free_ts 39550682804
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1470
 prep_new_page mm/page_alloc.c:1478 [inline]
 get_page_from_freelist+0x2cbd/0x2d70 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4715
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4148
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 kernfs_get_open_node fs/kernfs/file.c:525 [inline]
 kernfs_fop_open+0x829/0xd10 fs/kernfs/file.c:700
 do_dentry_open+0x95a/0x1720 fs/open.c:959
 do_open fs/namei.c:3654 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3811
 do_filp_open+0x235/0x490 fs/namei.c:3838
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1424 [inline]
 __do_sys_openat fs/open.c:1440 [inline]
 __se_sys_openat fs/open.c:1435 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1435
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 4545 tgid 4545 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1089 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2621
 rcu_do_batch kernel/rcu/tree.c:2564 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2838
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff88801e8a8f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801e8a8f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801e8a9000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88801e8a9080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801e8a9100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
