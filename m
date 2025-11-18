Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BB2EF65B
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448576; cv=none; b=E5Y3CiMTgH46SNS9fNC/Jxv7UrwmI6bSJnb5GF+Wpz0gK/VS7MIozkZvLV+aY5K//ydA1mW49zrkLcVdUbWvW58EB5msGQWQQ0iRYs8hLAB1l+GU7ast9KVdBkbzcaGPPI4zdGB6gPz5WQHTi6umsVOhjjXax52ObJKJ4EULuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448576; c=relaxed/simple;
	bh=S6sHFOLObZ9XXLTkGGXS49/PCdRphNoWr9aH32If8wc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b4qWGDRkku6h13VshstTwSmJhU7RmY1OPnLjBOzcbZ2w/eiR0GC7hBukqDFgbNhlJlXCho+x0u+Q5RuPyvZwTJcFp+1IzrIidkSfIPPQjXsEwO/s+knWqYaT9cvHUDtaiL+wh8YGblarjtiITBELfLjCNMVWGaDuQ1QZ0HzaJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-9490387e016so196714039f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 22:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763448573; x=1764053373;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9T0bLs7M7iFwor/oOnBTPBa+m5jhYZGw1ZQxdaokqk=;
        b=lwxe9alALadp2VDISNDFh1tpwZgA5IPtDwNkWgU2VJmUzpi3c4ZP0cG7vZUMaYQ8Eb
         VjXQLDXzXr2p25gU5qZ5guvgAe2iIahuuf9a/TRucL+tnhcIO5tVS+9wuACwvF4K5bns
         CGxIJTZjhgqzia82Mi8ObepwD3sfaudaAFHiZ429rm48eEaYneZtjHvJYE/OdByrf/l9
         /eC6jl6YEi/PWg8OshWK4IaVAi02PLSXpVfpYIA6WNMXG0fiWlz7jkYd1SxAKMoJ9IEL
         qFZil7WNeCo6MA+yJnyUma5T9FcfPB/iwYhw9B5eFQQoSY7EB7bnndPU4aWGnTG0eNeI
         vVHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbXsrBfqWLgZlKACQvSoyJmu53/VgOy/bF6D2WYm6CUKOTz32aTxtgJDdJCFA6B4Mve6RCj4mb+MYJnBm1aM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyud3WlJujrVQOjKE64KlLTszjCQMfPD7judQaHF/xgZt/pGhtm
	cWbD43AkEwZ85FOEE08jZNniIuWjdcRTJ+u7A69Y2XQGTv/13mybMkl/Hca3XHkFLiCt9jpe/wY
	tWhNY9QoD3g6V1BQ0tgUh/Dev+UGJgWPnYfi7BG5SgezHKBHToXg8tkaXIGs=
X-Google-Smtp-Source: AGHT+IGGjp/mkLqjB0dQ5EWZ3myyTXgMFlnl7DaD1dFu4Rp+2xMiViBGCm4/fQtiYnTmdsWvQNM73iW8MP5iKP7Rwhe7vhIZt84S
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3302:b0:433:2072:9d2c with SMTP id
 e9e14a558f8ab-4348c89e9d5mr216031485ab.10.1763448573391; Mon, 17 Nov 2025
 22:49:33 -0800 (PST)
Date: Mon, 17 Nov 2025 22:49:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691c16fd.a70a0220.f6df1.0054.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_cmd_work (2)
From: syzbot <syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f2995693867 Add linux-next specific files for 20251114
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16e42fcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=873352b3ee3a5f48
dashboard link: https://syzkaller.appspot.com/bug?extid=4d6b203d625d2f57d4ca
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d8d032a78b87/disk-0f299569.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf21de5b7c96/vmlinux-0f299569.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4472182fc485/bzImage-0f299569.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com

Bluetooth: hci3: unexpected cc 0x0c03 length: 249 > 1
Bluetooth: hci4: unexpected cc 0x0c03 length: 249 > 1
Bluetooth: hci1: unexpected cc 0x1003 length: 249 > 9
Bluetooth: hci2: unexpected cc 0x0c03 length: 249 > 1
==================================================================
BUG: KASAN: slab-use-after-free in hci_cmd_work+0x5d0/0x7b0 net/bluetooth/hci_core.c:4174
Read of size 2 at addr ffff888061d8f538 by task kworker/u9:5/5835

CPU: 1 UID: 0 PID: 5835 Comm: kworker/u9:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: hci4 hci_cmd_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 hci_cmd_work+0x5d0/0x7b0 net/bluetooth/hci_core.c:4174
 process_one_work+0x93a/0x15e0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 52:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:339 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:365
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4948 [inline]
 slab_alloc_node mm/slub.c:5258 [inline]
 kmem_cache_alloc_node_noprof+0x43c/0x710 mm/slub.c:5310
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:664
 alloc_skb include/linux/skbuff.h:1383 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:510 [inline]
 hci_cmd_sync_alloc+0x3d/0x3b0 net/bluetooth/hci_sync.c:58
 hci_cmd_sync_add net/bluetooth/hci_sync.c:99 [inline]
 __hci_cmd_sync_sk+0x1a7/0xc70 net/bluetooth/hci_sync.c:168
 __hci_cmd_sync_status_sk net/bluetooth/hci_sync.c:263 [inline]
 __hci_cmd_sync_status net/bluetooth/hci_sync.c:287 [inline]
 hci_read_local_features_sync net/bluetooth/hci_sync.c:3708 [inline]
 hci_init_stage_sync net/bluetooth/hci_sync.c:3623 [inline]
 hci_init1_sync net/bluetooth/hci_sync.c:3755 [inline]
 hci_init_sync net/bluetooth/hci_sync.c:4874 [inline]
 hci_dev_init_sync net/bluetooth/hci_sync.c:5066 [inline]
 hci_dev_open_sync+0x14b2/0x2dc0 net/bluetooth/hci_sync.c:5144
 hci_dev_do_open net/bluetooth/hci_core.c:430 [inline]
 hci_power_on+0x1b4/0x720 net/bluetooth/hci_core.c:959
 process_one_work+0x93a/0x15e0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Freed by task 5839:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6663 [inline]
 kmem_cache_free+0x197/0x640 mm/slub.c:6774
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 kfree_skb include/linux/skbuff.h:1331 [inline]
 vhci_read+0x49a/0x5b0 drivers/bluetooth/hci_vhci.c:593
 vfs_read+0x200/0xa30 fs/read_write.c:570
 ksys_read+0x145/0x250 fs/read_write.c:715
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888061d8f500
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 56 bytes inside of
 freed 240-byte region [ffff888061d8f500, ffff888061d8f5f0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x61d8f
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff8881416a0a00 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5835, tgid 5835 (kworker/u9:5), ts 69895228046, free_ts 69894023338
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3920
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5215
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xf56/0x1990 mm/slub.c:4651
 __slab_alloc+0x65/0x100 mm/slub.c:4774
 __slab_alloc_node mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:5246 [inline]
 kmem_cache_alloc_noprof+0x40f/0x700 mm/slub.c:5265
 skb_clone+0x212/0x3a0 net/core/skbuff.c:2069
 hci_event_packet+0x1a6/0x1260 net/bluetooth/hci_event.c:7667
 hci_rx_work+0x45d/0xfc0 net/bluetooth/hci_core.c:4099
 process_one_work+0x93a/0x15e0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
page last free pid 2 tgid 2 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2948
 __kasan_populate_vmalloc_do mm/kasan/shadow.c:393 [inline]
 __kasan_populate_vmalloc+0x1b2/0x1d0 mm/kasan/shadow.c:424
 kasan_populate_vmalloc include/linux/kasan.h:579 [inline]
 alloc_vmap_area+0xdca/0x1500 mm/vmalloc.c:2124
 __get_vm_area_node+0x1f8/0x300 mm/vmalloc.c:3220
 __vmalloc_node_range_noprof+0x365/0x1640 mm/vmalloc.c:3981
 __vmalloc_node_noprof+0xc2/0x110 mm/vmalloc.c:4081
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct+0x3d4/0x830 kernel/fork.c:880
 copy_process+0x4ea/0x3930 kernel/fork.c:2011
 kernel_clone+0x21e/0x850 kernel/fork.c:2609
 kernel_thread+0x10d/0x160 kernel/fork.c:2670
 create_kthread kernel/kthread.c:486 [inline]
 kthreadd+0x575/0x770 kernel/kthread.c:844
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Memory state around the buggy address:
 ffff888061d8f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888061d8f480: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>ffff888061d8f500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888061d8f580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff888061d8f600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
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
