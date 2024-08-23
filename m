Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA01CD3D
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426015; cv=none; b=uoKFNJV8Y/G7JY3/+oPdQbeLLKMggxCXC0C9NgR2MqPz/oO4XiOl3y/Pe1QGpG2xTTt6v2FZtY00FS6WR74q3FFhtRuWujYs0pLecfhnfJapKpUGnSHO/wctG5trQL5su6jjflnLB/mN4+hgqfTfJO9UwRsZoEKknUw76CdcqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426015; c=relaxed/simple;
	bh=IePRQnnPlG7oh9AIN1/YtOZwzR1l2c59YbI/WTzUi7U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qPwhJZVok3dFMiNxQWBgyuKS/42z6UIp8xMl3XNNLXvgKRYaoi0QKPk2DOrMqJwZXJZkmVggfou/yzb341LS/AXYVv5d8HvLrrlajuoQv5MYbER3dz7CIfiEz8o/LPDCXOVk6b+wrHS1wAUvcetmsDvQBg+TL1koWoxLCkdv8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d3325ba79so21631505ab.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 08:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426013; x=1725030813;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyNYaEO283QBpS1opOSD/KF5NHRnbT90DG//xeHXTl4=;
        b=DwhBYNc5VmjGNBouybIRNGrz7bzNMtGYk6TagU4TXWLsCD3Zr9Lxg8zv8WAduJB9cE
         oiT72LyW9/dF26oAlkpwzGdRnNwGvHO/I1xS0ngLu+zHM6bch3YXoZlmg/9jtNSj2pCD
         O1PyIQbByfF407IhUITNdh3yrLOY6CfDKpBWjBB3gB+63bISAf7k9h1/Q8FuUFduhrYa
         U2ThJW3vQ9aadtxPMw3VzFyUAUzmtGGrgZuoLs7OSRD+qmnfsadKAE9MIS4LoR5PvB5d
         k4t5fVilyuevAbjaFCRxnd0ZTzTBd0qaUDfB3efLjqkvD2B+k1tCqh2v/EIK+x/SfBfS
         DO3w==
X-Forwarded-Encrypted: i=1; AJvYcCV3LHLPve/pH7Dwpf6casEhmGH+p3JXG+gkK9GpK61PfPARjCL7XxPd52egu6qiOAyxgG0FoVmN9N6ZoEHJE3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7cpe1MMjDqoR1UmPfwjeyeWUg1LS0zQSX0zcI5GtB+k/0tM9
	aWiz/HmOpBnssDzgt7SZZKv/jNMOLAHnuNeANXsxN+2LhKlr2oa53DZfff0KM8v69mtDjACMH6v
	TqpTfaF9VzxcZUj13k27/dryE3hE3bqzYRd3SkKk1yEf07SnscNmBM7Y=
X-Google-Smtp-Source: AGHT+IF98di3hc2TZwYlK1+8jyWaf7gy+z2D5ODb1vdcEs38yGGqHxpnVveNk1Vv49etUhsRCcPA1PltkG2AjKpp+hGY8KpRw0WG
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:39b:3bae:1f44 with SMTP id
 e9e14a558f8ab-39e3c9f0462mr1648965ab.3.1724426012838; Fri, 23 Aug 2024
 08:13:32 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:13:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efdd2c06205b37bc@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_cmd_work
From: syzbot <syzbot+430996d5d5a2ca4b7d07@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d67978318827 Merge tag 'x86_cpu_for_v6.11_rc1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17409785980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c27e4a218c759511
dashboard link: https://syzkaller.appspot.com/bug?extid=430996d5d5a2ca4b7d07
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c2b69e5e6e3/disk-d6797831.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4723bc702146/vmlinux-d6797831.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad0798383ba0/bzImage-d6797831.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+430996d5d5a2ca4b7d07@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in refcount_read include/linux/refcount.h:136 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1222 [inline]
BUG: KASAN: slab-use-after-free in __kfree_skb_reason net/core/skbuff.c:1195 [inline]
BUG: KASAN: slab-use-after-free in kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1222
Read of size 4 at addr ffff888067541c24 by task kworker/u9:2/5086

CPU: 0 PID: 5086 Comm: kworker/u9:2 Not tainted 6.10.0-syzkaller-01155-gd67978318827 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_cmd_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:136 [inline]
 skb_unref include/linux/skbuff.h:1222 [inline]
 __kfree_skb_reason net/core/skbuff.c:1195 [inline]
 kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1222
 kfree_skb include/linux/skbuff.h:1257 [inline]
 hci_send_cmd_sync net/bluetooth/hci_core.c:4090 [inline]
 hci_cmd_work+0x63e/0x710 net/bluetooth/hci_core.c:4111
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5086:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4009
 skb_clone+0x190/0x3f0 net/core/skbuff.c:2052
 hci_send_cmd_sync net/bluetooth/hci_core.c:4091 [inline]
 hci_cmd_work+0x66a/0x710 net/bluetooth/hci_core.c:4111
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 12745:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4513
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1131
 __kfree_skb net/core/skbuff.c:1188 [inline]
 kfree_skb_reason+0x138/0x210 net/core/skbuff.c:1223
 kfree_skb include/linux/skbuff.h:1257 [inline]
 __hci_req_sync+0x61d/0x980 net/bluetooth/hci_request.c:184
 hci_req_sync+0x97/0xd0 net/bluetooth/hci_request.c:206
 hci_inquiry+0x3ea/0x950 net/bluetooth/hci_core.c:383
 hci_sock_ioctl+0x2bb/0x880 net/bluetooth/hci_sock.c:1153
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888067541b40
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff888067541b40, ffff888067541c30)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x67541
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff88801929a780 ffffea0001fe0ac0 dead000000000004
raw: 0000000000000000 00000000000c000c 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 11673, tgid 11673 (syz-executor), ts 518110047408, free_ts 516558045102
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x1353/0x2e50 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 kmem_cache_alloc_noprof+0x2a7/0x2f0 mm/slub.c:4009
 skb_clone+0x190/0x3f0 net/core/skbuff.c:2052
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:300 [inline]
 __netlink_deliver_tap net/netlink/af_netlink.c:325 [inline]
 netlink_deliver_tap+0xab3/0xd90 net/netlink/af_netlink.c:338
 netlink_deliver_tap_kernel net/netlink/af_netlink.c:347 [inline]
 netlink_unicast_kernel net/netlink/af_netlink.c:1334 [inline]
 netlink_unicast+0x604/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 12063 tgid 12059 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_folios+0x991/0x1310 mm/page_alloc.c:2637
 folios_put_refs+0x487/0x6d0 mm/swap.c:1024
 free_pages_and_swap_cache+0x45f/0x510 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu mm/mmu_gather.c:373 [inline]
 tlb_finish_mmu+0x168/0x7b0 mm/mmu_gather.c:465
 exit_mmap+0x3d1/0xb20 mm/mmap.c:3354
 __mmput+0x12a/0x480 kernel/fork.c:1340
 mmput+0x62/0x70 kernel/fork.c:1362
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b7/0x2ba0 kernel/exit.c:863
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1025
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888067541b00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888067541b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888067541c00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff888067541c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888067541d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
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
