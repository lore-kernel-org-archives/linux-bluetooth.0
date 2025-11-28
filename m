Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F82FF14C
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320548; cv=none; b=KqWewDxhuybMRQw4yj5S25JhoVVoE6Tt93E4F6X7YCqcPqCJFPa1X31mvBmzWb8Igq6qJ2QL2dN7UdFlzYFgj6tJhvplVgcUQjqs9UQTDi56yLPnzeYtOKGRe2u8IuB+73/SthscbaVPmQ3/ByIWpef0hvcKf9Awab1fIIQC/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320548; c=relaxed/simple;
	bh=bFDdKSns5d3WkFMlQ1ny4/3w/r6PvGTkr33j5EFKuIM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YZBahMQjGqM7ZIK7y/CLBKFSYpBXliobQwSY9X2b2HLqqRMT/rEsDbxfnpHlwBMNiba1pvlLL+fEHY6J5gSxdlUE9E7aH9fTBbtXp/OwpleWRdTgYoMVn9TmrnH2PqEvxyuLd9jZsETWq3n9Y6PWj6xyVDA6GdHktowtRIvoEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-433770ba913so10179305ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 01:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764320545; x=1764925345;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYEGiucc3jDXdKRoaLp8Ulhwj2Z6I1Jr5vS3nTkXZ8w=;
        b=hXj9a2hL7vmvoYfvCAG8c6PFNMQ3Qm/+eXP4sJyDum9P+IKtZJso2FmJdC6WIJ81tw
         jRlb0hvnmBVPegYwbCe/vrh+K7UAtKerjcXA1vOUZsVsexZJgiwBFOllLS5LryYB1dTB
         N4WBroo6X81J4PWM4CgJRadmXJ8dyuiXyFEFGWpgfGUDzWmwcZMApgeVM0VQ6pALKvIb
         BLQyifuhCUwkBm28AeMrisSfDchHW6ArNjXLp8X++7GZGSQ3JGQNkyrnuMNqN6yCARfs
         T2uTy40DIyNXd13LjYQ/ISVDFLOD093nlCP7ICuHgCj4RLclY0tedybJemAxsSQxVOfr
         V1GQ==
X-Gm-Message-State: AOJu0YyWi0D3aqU+ruYIG2Jm94vQonQULoa4CQjyD87AZDkcmfX3YSfi
	6wl3YbO4agqhsJL9E6Z8hDt8SNNMe6ISGL1ne0/tk0VfqFpvRY06zHyjvd7PKl+PvUYVnFTITY0
	04fGQabI9mY/XBH6KthReHTu7RhKzVib2P/eRt1CZRo6cBAhADWv4sTZwgxGLPA==
X-Google-Smtp-Source: AGHT+IGgsEIj9zlZPvhC21Ddej9gE2P9agZoggSFa6AAB2s1p81DG79t+2jWTXCS8PMOtXzRAdxFDwUv4SL185TDErutiVvUvPW4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f09:b0:433:7826:2b69 with SMTP id
 e9e14a558f8ab-435b8e4fcb7mr239951145ab.11.1764320545535; Fri, 28 Nov 2025
 01:02:25 -0800 (PST)
Date: Fri, 28 Nov 2025 01:02:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69296521.a70a0220.d98e3.0134.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in skb_pull
From: syzbot <syzbot+2d7ca98b34b871173f28@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d13f3ac64efb Merge tag 'mips-fixes_6.18_1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171bd8b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14b6a9313e132a6b
dashboard link: https://syzkaller.appspot.com/bug?extid=2d7ca98b34b871173f28
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7bcabeb5eac8/disk-d13f3ac6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f32f75375954/vmlinux-d13f3ac6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/889beba59370/bzImage-d13f3ac6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d7ca98b34b871173f28@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in skb_pull_inline include/linux/skbuff.h:2839 [inline]
BUG: KASAN: slab-use-after-free in skb_pull+0x133/0x1d0 net/core/skbuff.c:2619
Read of size 4 at addr ffff8880687ace30 by task kworker/0:1/16647

CPU: 0 UID: 0 PID: 16647 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: events hci_uart_write_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 skb_pull_inline include/linux/skbuff.h:2839 [inline]
 skb_pull+0x133/0x1d0 net/core/skbuff.c:2619
 hci_uart_write_work+0x329/0x550 drivers/bluetooth/hci_ldisc.c:168
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 16739:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 kmem_cache_alloc_node_noprof+0x433/0x710 mm/slub.c:5340
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1383 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:510 [inline]
 hci_cmd_sync_alloc+0x3d/0x380 net/bluetooth/hci_sync.c:58
 hci_cmd_sync_add net/bluetooth/hci_sync.c:99 [inline]
 __hci_cmd_sync_sk+0x1a7/0xbc0 net/bluetooth/hci_sync.c:168
 __hci_cmd_sync_status_sk net/bluetooth/hci_sync.c:263 [inline]
 __hci_cmd_sync_status net/bluetooth/hci_sync.c:287 [inline]
 hci_read_local_features_sync net/bluetooth/hci_sync.c:3708 [inline]
 hci_init_stage_sync net/bluetooth/hci_sync.c:3623 [inline]
 hci_init1_sync net/bluetooth/hci_sync.c:3755 [inline]
 hci_init_sync net/bluetooth/hci_sync.c:4867 [inline]
 hci_dev_init_sync net/bluetooth/hci_sync.c:5059 [inline]
 hci_dev_open_sync+0x14be/0x2b60 net/bluetooth/hci_sync.c:5137
 hci_dev_do_open net/bluetooth/hci_core.c:430 [inline]
 hci_power_on+0x1b4/0x680 net/bluetooth/hci_core.c:959
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880687acdc0
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 112 bytes inside of
 freed 240-byte region [ffff8880687acdc0, ffff8880687aceb0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x687ac
memcg:ffff88806bd25281
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801d2fb8c0 dead000000000100 dead000000000122
raw: 0000000000000000 00000000000c000c 00000000f5000000 ffff88806bd25281
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6067, tgid 6067 (kworker/u8:10), ts 1088046828849, free_ts 1087965340429
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1845
 prep_new_page mm/page_alloc.c:1853 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3879
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5178
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3059 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3232
 new_slab mm/slub.c:3286 [inline]
 ___slab_alloc+0xf56/0x1990 mm/slub.c:4655
 __slab_alloc+0x65/0x100 mm/slub.c:4778
 __slab_alloc_node mm/slub.c:4854 [inline]
 slab_alloc_node mm/slub.c:5276 [inline]
 kmem_cache_alloc_node_noprof+0x4c5/0x710 mm/slub.c:5340
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:763 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x29a/0xb80 drivers/net/netdevsim/dev.c:866
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 5194 tgid 5194 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2901
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 common_interrupt+0xbb/0xe0 arch/x86/kernel/irq.c:318
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688

Memory state around the buggy address:
 ffff8880687acd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff8880687acd80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>ffff8880687ace00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880687ace80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff8880687acf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
