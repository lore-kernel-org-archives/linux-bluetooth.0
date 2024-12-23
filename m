Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DC17E473
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942986; cv=none; b=Fk+egs6Ip6nQ6ON2B8+Iru5v8BT0jILvxQ7/4uuhqbbxg7IFl2/HRLDPlVcLs3OQQeo0o3111ctUwvBn027Xs9+rFbqt+JDB4a3G0BwrkD51ORbgC3oYIBCH8qWaNBRKYXEohQ6RnSkK0BfEFPzk2mrSjak4178mGKaiOJQ5EhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942986; c=relaxed/simple;
	bh=ZqJJMJCWOLXxFOxG1qWyt6HWEGizht8+vFoeOW8Jats=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q74uGfUYsNKFql9jNkfDRzdOfliQxEh3wRpv4saLuqAB1vbOvQq4Gusq7ZGy46Fwt3ZggxYKr2LaXHCVHE773T4ItpfxeJDhexOoYNvNbZrNMX3jbPmFKq3VB30A4FlIYGTBqsai2hoEHLRSLwQnjObVgnRqIgn3I4F3qzhIROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a814406be9so75594275ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 00:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734942983; x=1735547783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFM98kQbjpjB51QgybAOy4rx8Cw5DjlrTkWpXHN4dgQ=;
        b=sqKObr5+uRHo4bPTtA4cfGInc6Y/xafqC65UkKksY05OF9JJKEjT/LYjx1MJ/JL2pA
         KJ7RQDLQabouxWr1BhMTjpPHZmSCOHVdgWyoPEf1TiXGjyI0gXqmvq/cVYJSvZUkM9h0
         cvfwaNlwRtXWVsdCz+9xKd97nnzMuz5Su/cQtCF4/edWcP3ZZ4so5FOGlwSYlfpkd+Wz
         jKpKQl3UmMXrVJJ31Y7cwTgT+KhHXvBsSSQySNfbGjWolFv/Aw3ikjqJ4ikVz8pqvfhT
         FGQSnGESSr48d0RTzaO9hgyFRz0GKU29BkY4GigUIAo1Utr0G0uGOcBE2Mh2jYtsKaBL
         xmIg==
X-Forwarded-Encrypted: i=1; AJvYcCXgk/iV1p7PgC0PqtT4s8GL/K1xL7PK+wSLRx6NXX7+dzxVsqfJ0ns+KAuYnNxFwn2DfH0kVJy7OJvlhJzRQzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp1qdjaKTmZWjnbSArFIcnA2H4uJc5M05bbDKmvaen82/9seRC
	zFAe3MORnJrpZ2GPishBlOWAm88bZI9orLF74VNYV9zjJDUge29wVWGe/sUpgh9pOtpC+ynBlEw
	NyJtTrp3kUluIQ7jUVq+z+88mJr11CET5ScMwHWUIgiMs9FaonK0L1aM=
X-Google-Smtp-Source: AGHT+IFm5AWEHqWuyw6yLKi5/3Mn+m/1FGHXBz2rkzXcNRXruTihHV9FOQvaQuIexk3PddWlS3+jvT0r8EKigQuZ0j+Ooj7pFkiY
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2411:b0:3a7:159d:2dd8 with SMTP id
 e9e14a558f8ab-3c2d2578956mr107551255ab.7.1734942983539; Mon, 23 Dec 2024
 00:36:23 -0800 (PST)
Date: Mon, 23 Dec 2024 00:36:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67692107.050a0220.2f3838.0018.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_tx_work
From: syzbot <syzbot+16d8ca27d71a0e077962@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aef25be35d23 hexagon: Disable constant extender optimizati..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c43730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=16d8ca27d71a0e077962
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-aef25be3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70f483235c09/vmlinux-aef25be3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a10ff66b04cc/bzImage-aef25be3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16d8ca27d71a0e077962@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hci_sched_le net/bluetooth/hci_core.c:3703 [inline]
BUG: KASAN: slab-use-after-free in hci_tx_work+0x11ad/0x1410 net/bluetooth/hci_core.c:3757
Read of size 4 at addr ffff888021cc4778 by task kworker/u33:3/5944

CPU: 0 UID: 0 PID: 5944 Comm: kworker/u33:3 Not tainted 6.13.0-rc3-syzkaller-00044-gaef25be35d23 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci3 hci_tx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 hci_sched_le net/bluetooth/hci_core.c:3703 [inline]
 hci_tx_work+0x11ad/0x1410 net/bluetooth/hci_core.c:3757
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5944:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 hci_chan_create+0xa6/0x3d0 net/bluetooth/hci_conn.c:2838
 l2cap_conn_add.part.0+0x1a/0xa60 net/bluetooth/l2cap_core.c:6856
 l2cap_conn_add net/bluetooth/l2cap_core.c:7232 [inline]
 l2cap_connect_cfm+0x264/0xf10 net/bluetooth/l2cap_core.c:7239
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 le_conn_complete_evt+0x1623/0x1d10 net/bluetooth/hci_event.c:5763
 hci_le_conn_complete_evt+0x23c/0x370 net/bluetooth/hci_event.c:5789
 hci_le_meta_evt+0x2e2/0x5d0 net/bluetooth/hci_event.c:7162
 hci_event_func net/bluetooth/hci_event.c:7470 [inline]
 hci_event_packet+0x666/0x1190 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x2c5/0x16b0 net/bluetooth/hci_core.c:4035
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 19353:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 l2cap_conn_del+0x43a/0x730 net/bluetooth/l2cap_core.c:1795
 l2cap_connect_cfm+0x7aa/0xf10 net/bluetooth/l2cap_core.c:7235
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_conn_failed+0x225/0x3e0 net/bluetooth/hci_conn.c:1266
 hci_abort_conn_sync+0x968/0x1030 net/bluetooth/hci_sync.c:5603
 hci_disconnect_all_sync.constprop.0+0x104/0x3c0 net/bluetooth/hci_sync.c:5626
 hci_suspend_sync+0x772/0xab0 net/bluetooth/hci_sync.c:6103
 hci_suspend_dev+0x27d/0x5e0 net/bluetooth/hci_core.c:2831
 hci_suspend_notifier+0x28d/0x2f0 net/bluetooth/hci_core.c:2411
 notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
 notifier_call_chain_robust kernel/notifier.c:120 [inline]
 blocking_notifier_call_chain_robust kernel/notifier.c:345 [inline]
 blocking_notifier_call_chain_robust+0xc9/0x170 kernel/notifier.c:333
 pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
 snapshot_open+0x189/0x2b0 kernel/power/user.c:77
 misc_open+0x35a/0x420 drivers/char/misc.c:165
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0xf59/0x1ea0 fs/open.c:945
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_compat_sys_openat fs/open.c:1479 [inline]
 __se_compat_sys_openat fs/open.c:1477 [inline]
 __ia32_compat_sys_openat+0x16e/0x210 fs/open.c:1477
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff888021cc4700
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 120 bytes inside of
 freed 128-byte region [ffff888021cc4700, ffff888021cc4780)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21cc4
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac42a00 ffffea0001b73740 dead000000000004
raw: 0000000000000000 0000000080100010 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 6785, tgid 6785 (syz-executor), ts 211288740796, free_ts 211265855652
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_slowpath mm/page_alloc.c:4286 [inline]
 __alloc_pages_noprof+0x6a6/0x25b0 mm/page_alloc.c:4764
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_slab_page mm/slub.c:2425 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0xca/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_noprof+0x2f0/0x520 mm/slub.c:4304
 kmalloc_array_node_noprof include/linux/slab.h:1018 [inline]
 alloc_slab_obj_exts+0x41/0xa0 mm/slub.c:1964
 __memcg_slab_post_alloc_hook+0x2a7/0x9b0 mm/memcontrol.c:3005
 memcg_slab_post_alloc_hook mm/slub.c:2152 [inline]
 slab_post_alloc_hook mm/slub.c:4129 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x310/0x3b0 mm/slub.c:4175
 prepare_creds+0x2e/0x750 kernel/cred.c:212
 copy_creds+0xa7/0xa50 kernel/cred.c:312
 copy_process+0xeff/0x6f20 kernel/fork.c:2259
 kernel_clone+0xfd/0x960 kernel/fork.c:2807
 __do_compat_sys_ia32_clone+0xb7/0x100 arch/x86/kernel/sys_ia32.c:254
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2823
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff888021cc4600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021cc4680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888021cc4700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888021cc4780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888021cc4800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
