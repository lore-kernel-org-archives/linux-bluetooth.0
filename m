Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414941A08C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136566; cv=none; b=bH2NwxBghu72OihYg8gq4pZ750yWKvdeMIk3Q3QAG8pwxb/srDOHNCIqR1dWmuyq8k/zvyAb/ESzDowJqoWh80SOigv/2BBXT1fOYiWvYGc6wXceKkq5CNkTfZCfwbLYzM2xuRObvpDuBFlTTet/nrk5Dp85l1sbWNGNd4Spb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136566; c=relaxed/simple;
	bh=+vgPWgHew/n1RwMiI1Wo2bFY/DdO/pUPAFaY/L3/FnM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r/HCHGjDRFSlAli1L3/9rG1FBcQOwSa3s47dos1s6k4cqcRYyH5mNobcTljzHwY3vdVa0dwT5wbh1/lxxlTtBPwZOSYUAhcNSGli2DUGsuepUAgOfwbyiPJCvL1PB41F4VJHwAaelXL8hbsfvBnbK4bb6MkHkBGfeBiAmFLuHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce8db7c342so46308765ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 09:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136563; x=1737741363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obUIzXclMntkcS8OxRycfZF8RX5vB+qNsBEaWzhSg5E=;
        b=tjONnb325lXRoI4+5X4a5TSnRH7iYzaqKr1/j27WGG4NbX0hqp/Rldd/P+LS/68Zgq
         qVDWDs2C9aaYs360MmfejVtovXxhVkjpkKlfEvG5trS0laa0ETZauVeedS73GrmrrdxW
         QhY0214rjuTA9VPAI7Hi3Da80umY9DljOlhCnquqTHqSK8KScKppm3TqMLfRKCJuMOcM
         a+uaGp/Cx89MHhdDR7052qkigxqpQzXUyEOQts1xwhBEkzvvIaRYV0P6j3KVGCUELroT
         by0Hut3pStVgAd8Hz/cbtKTRwGjRU2/A4G64pbTxYeSmiBZXHld0llnURRKHz7UeZX3l
         9Njw==
X-Gm-Message-State: AOJu0YyAMAeoAA03AU8+GwgzPi13HH7Lp6nDhtb9Jm2RBh/rRBzniih6
	VRr44onTzAGMhgmZ0II3Ztn++SSOPuEzlKnzv6EHOfvE86w0/noy1y7Qn9x2QSTLGP589o3K8Sp
	XYD6osk6M/kiAq9BIPYaK/DYc26qEu/5asIrjW6nRYHD6OOX8nc9mg4M=
X-Google-Smtp-Source: AGHT+IH5/0lcUlIAhE9tFMzroqvdOhrKEJ0ic9GjKAid1fvwYmBu0GAsZWHNDKJ/robZgpITc68Xg3LWbxYbczCEU2GicmdivQFE
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164f:b0:3ce:7ac0:64c0 with SMTP id
 e9e14a558f8ab-3cf743bc7bcmr29319945ab.3.1737136563442; Fri, 17 Jan 2025
 09:56:03 -0800 (PST)
Date: Fri, 17 Jan 2025 09:56:03 -0800
In-Reply-To: <CABBYNZKyZKqM4pNxjqPEc1ot5fi50Oy_0VnujUXrJOe_ZeWNWA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a99b3.050a0220.303755.0012.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_send_cmd
From: syzbot <syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in l2cap_send_cmd

Bluetooth: Wrong link type (-22)
==================================================================
BUG: KASAN: slab-use-after-free in l2cap_build_cmd net/bluetooth/l2cap_core.c:2951 [inline]
BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x67b/0x8d0 net/bluetooth/l2cap_core.c:954
Read of size 4 at addr ffff88805bd45810 by task kworker/u9:8/6565

CPU: 1 UID: 0 PID: 6565 Comm: kworker/u9:8 Not tainted 6.13.0-rc7-syzkaller-gad26fc09dabf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: hci5 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 l2cap_build_cmd net/bluetooth/l2cap_core.c:2951 [inline]
 l2cap_send_cmd+0x67b/0x8d0 net/bluetooth/l2cap_core.c:954
 l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5502 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5538 [inline]
 l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6817
 hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
 hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6556:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6860
 l2cap_connect_cfm+0x115/0x1090 net/bluetooth/l2cap_core.c:7239
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
 hci_event_func net/bluetooth/hci_event.c:7473 [inline]
 hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 6556:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x430 mm/slub.c:4761
 l2cap_connect_cfm+0xcc/0x1090 net/bluetooth/l2cap_core.c:7235
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_conn_failed+0x287/0x400 net/bluetooth/hci_conn.c:1266
 hci_abort_conn_sync+0x56c/0x11f0 net/bluetooth/hci_sync.c:5604
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 call_timer_fn+0x187/0x650 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1839 [inline]
 __run_timers kernel/time/timer.c:2418 [inline]
 __run_timer_base+0x695/0x8e0 kernel/time/timer.c:2430
 run_timer_base kernel/time/timer.c:2439 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2449
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xb66/0xf50 kernel/workqueue.c:2343
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1640 [inline]
 l2cap_connect_cfm+0xdd5/0x1090 net/bluetooth/l2cap_core.c:7280
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
 hci_event_func net/bluetooth/hci_event.c:7473 [inline]
 hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88805bd45800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 16 bytes inside of
 freed 1024-byte region [ffff88805bd45800, ffff88805bd45c00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5bd40
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00016f5001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 52, tgid 52 (kworker/u8:3), ts 110221332948, free_ts 104807511653
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x3e1/0x780 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4317
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1323 [inline]
 nlmsg_new include/net/netlink.h:1018 [inline]
 inet6_rt_notify+0xba/0x240 net/ipv6/route.c:6195
 fib6_add_rt2node net/ipv6/ip6_fib.c:1259 [inline]
 fib6_add+0x1e33/0x4420 net/ipv6/ip6_fib.c:1488
 __ip6_ins_rt net/ipv6/route.c:1317 [inline]
 ip6_ins_rt+0x106/0x170 net/ipv6/route.c:1327
 __ipv6_ifa_notify+0x5d2/0x1230 net/ipv6/addrconf.c:6282
 ipv6_ifa_notify net/ipv6/addrconf.c:6321 [inline]
 addrconf_dad_completed+0x181/0xcd0 net/ipv6/addrconf.c:4341
page last free pid 6489 tgid 6489 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
 vfree+0x1c3/0x360 mm/vmalloc.c:3383
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x23c/0xa50 fs/file_table.c:450
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2a/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3017
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805bd45700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805bd45780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805bd45800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88805bd45880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805bd45900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         ad26fc09 Merge tag 'mm-hotfixes-stable-2025-01-16-21-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162c3a18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
