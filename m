Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FE25BAC4
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282891; cv=none; b=D91XNPWDpOMpghAXgUzSdUQrSEZIdGUJ3K2yIITsJ6F3+3fD8WchS3STF6PpiPYA83wuVtEUTeGAtm/ZcLZwMnAiEBUsf5qlIxTJtsOEDJm+7WJAVSa+GUM3bXWbXlucLviLGGmvqEqx+fXVBRXISKg/ffmRMTekqqAl3lgxuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282891; c=relaxed/simple;
	bh=cuP/vScxGtaMqppW/h6NaC/dlve9qOgtjc8hq4kp0AU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RAK5tfdeUnTla22syQ1cPnsfqSkv4jT0Jm2mKY9dgI9PQonJfslgxD5evZxyFVTIwsR3ekIBP7QLMRlZS/vvmJG67n1HuWB19mYWGr9d9EvanfkxeMM7ZJvFsyVya8GGW0iFzQznqGOQQ/1LteakuQJMqRKWv6u+HdlkBgknLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d2a63dc62aso6261745ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 09:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282889; x=1741887689;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifMmxd60Hb7OPYrM+DTw5Np2I8L4Y/29uTi+Rh8hpQk=;
        b=TcTaXoAPN7rf3MJSC6fgtoncrpvjvWE/5Jj2Xlklw/isxcJzmJj3DFOPjOSeG/LGGN
         25ccFyuUiGb6cFwvlpzJIV2pF15PmOmwkeDLQ61dv+X3zxEz5ZOixCkrxRYg26R5JxFn
         Zu+MNc701zqNIfmaf9UmF07V48Og/d7F4Nu436eSTqQYzY8jlSMpmZ6n1XY4DbtJofQ8
         JllXLtZp+0blba5Nmoq+x6AK03F+S5mA94rcuOEiCdBwEMddfYQQk7ZLYF0j0n6WNqPp
         Sh0MhkeR6y6cDIPK+dMXZMnzBG3vOnEjA6s7oBKhkRp2NSCBmiGKMa635LOX0gw8Py9n
         /H7w==
X-Forwarded-Encrypted: i=1; AJvYcCUtBSd/IblmhDHZNWlBJTCwswdV9lANfN6QL+/iupvDo+ohJBpINhizf8IH9BbeNfcnZmxu+sCnffyMk7FESb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHwUEEafKZ1euBQAD3nFwh9OS/TckHs2nYn0B5Bumbs2jT4ml6
	FVm7eU+fM02MJw/2Gx0BRVEPOtkIg7lyylLPi36nbW52OZTpa5DFEWImor84XVk8OUIFPbfwnhG
	uslOudCqgkzw8Pqa9Oz6WBwP4Zo6vyOA1q6OXldpnMtYJxy/rJRDQI+A=
X-Google-Smtp-Source: AGHT+IG74jscPTid21GN5AeFHpwiDjHnBGpR/bu4j/PEbv2yM/Ien+tIxhhe8+veYsy/V4/IwaId4xCFVcSHk3oIb/JGWeTKLUyN
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:3d3:dfc2:912c with SMTP id
 e9e14a558f8ab-3d4419ff334mr4674985ab.17.1741282888728; Thu, 06 Mar 2025
 09:41:28 -0800 (PST)
Date: Thu, 06 Mar 2025 09:41:28 -0800
In-Reply-To: <6761bbbd.050a0220.29fcd0.0075.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c9de48.050a0220.15b4b9.003b.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect_cfm
From: syzbot <syzbot+e9abaabc441d3dd18735@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f66d6acccbc0 Merge tag 'x86_urgent_for_v6.12' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1666b2e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca2f08f822652bd0
dashboard link: https://syzkaller.appspot.com/bug?extid=e9abaabc441d3dd18735
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5b28ec7d6aaa/disk-f66d6acc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1999546fff71/vmlinux-f66d6acc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef848d42ab19/bzImage-f66d6acc.xz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147adb78580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=167adb78580000
console output: https://syzkaller.appspot.com/x/log.txt?x=127adb78580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9abaabc441d3dd18735@syzkaller.appspotmail.com

kobject: kobject_add_internal failed for hci5:201 with -EEXIST, don't try to register things with the same name in the same directory.
Bluetooth: hci5: failed to register connection device
==================================================================
BUG: KASAN: slab-use-after-free in l2cap_conn_ready net/bluetooth/l2cap_core.c:1619 [inline]
BUG: KASAN: slab-use-after-free in l2cap_connect_cfm+0xdbe/0xf80 net/bluetooth/l2cap_core.c:7278
Read of size 8 at addr ffff8880780f0480 by task kworker/u9:3/5950

CPU: 0 UID: 0 PID: 5950 Comm: kworker/u9:3 Not tainted 6.12.0-rc7-syzkaller-00216-gf66d6acccbc0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci5 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1619 [inline]
 l2cap_connect_cfm+0xdbe/0xf80 net/bluetooth/l2cap_core.c:7278
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 le_conn_complete_evt+0x1665/0x1d80 net/bluetooth/hci_event.c:5758
 hci_le_conn_complete_evt+0x23c/0x370 net/bluetooth/hci_event.c:5784
 hci_le_meta_evt+0x2e5/0x5d0 net/bluetooth/hci_event.c:7132
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x669/0x1180 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4029
 process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5950:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 l2cap_chan_create+0x44/0x920 net/bluetooth/l2cap_core.c:449
 l2cap_sock_alloc.constprop.0+0xf3/0x180 net/bluetooth/l2cap_sock.c:1886
 l2cap_sock_new_connection_cb+0x101/0x240 net/bluetooth/l2cap_sock.c:1468
 l2cap_connect_cfm+0x4cc/0xf80 net/bluetooth/l2cap_core.c:7261
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 le_conn_complete_evt+0x1665/0x1d80 net/bluetooth/hci_event.c:5758
 hci_le_conn_complete_evt+0x23c/0x370 net/bluetooth/hci_event.c:5784
 hci_le_meta_evt+0x2e5/0x5d0 net/bluetooth/hci_event.c:7132
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x669/0x1180 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4029
 process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 6070:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 l2cap_chan_destroy net/bluetooth/l2cap_core.c:495 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_chan_put+0x216/0x2c0 net/bluetooth/l2cap_core.c:519
 l2cap_sock_cleanup_listen+0x4d/0x2a0 net/bluetooth/l2cap_sock.c:1451
 l2cap_sock_release+0x5c/0x210 net/bluetooth/l2cap_sock.c:1411
 __sock_release+0xb3/0x270 net/socket.c:658
 sock_close+0x1c/0x30 net/socket.c:1426
 __fput+0x3f9/0xb60 fs/file_table.c:431
 task_work_run+0x151/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880780f0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1152 bytes inside of
 freed 2048-byte region [ffff8880780f0000, ffff8880780f0800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880780f6000 pfn:0x780f0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b042000 ffffea0001292c00 0000000000000002
raw: ffff8880780f6000 0000000080080003 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801b042000 ffffea0001292c00 0000000000000002
head: ffff8880780f6000 0000000080080003 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0001e03c01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2965, tgid 2965 (kworker/u8:7), ts 97728781507, free_ts 97577158223
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_track_caller_noprof+0x355/0x430 mm/slub.c:4283
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:609
 __alloc_skb+0x164/0x380 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 nlmsg_new include/net/netlink.h:1015 [inline]
 rtmsg_ifinfo_build_skb+0x81/0x280 net/core/rtnetlink.c:4099
 unregister_netdevice_many_notify+0x983/0x1e50 net/core/dev.c:11411
 cleanup_net+0x58c/0xb40 net/core/net_namespace.c:621
 process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
page last free pid 2965 tgid 2965 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
 __folio_put+0x32a/0x450 mm/swap.c:112
 kvfree+0x47/0x50 mm/util.c:701
 unix_net_exit+0x61/0xb0 net/unix/af_unix.c:3708
 ops_exit_list+0xb3/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b7/0xb40 net/core/net_namespace.c:626
 process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880780f0380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880780f0400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880780f0480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880780f0500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880780f0580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: wild-memory-access in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: wild-memory-access in l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
BUG: KASAN: wild-memory-access in l2cap_conn_ready net/bluetooth/l2cap_core.c:1621 [inline]
BUG: KASAN: wild-memory-access in l2cap_connect_cfm+0x7eb/0xf80 net/bluetooth/l2cap_core.c:7278
Read of size 4 at addr deacfffffffffc8c by task kworker/u9:3/5950

CPU: 0 UID: 0 PID: 5950 Comm: kworker/u9:3 Tainted: G    B              6.12.0-rc7-syzkaller-00216-gf66d6acccbc0 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci5 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1621 [inline]
 l2cap_connect_cfm+0x7eb/0xf80 net/bluetooth/l2cap_core.c:7278
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 le_conn_complete_evt+0x1665/0x1d80 net/bluetooth/hci_event.c:5758
 hci_le_conn_complete_evt+0x23c/0x370 net/bluetooth/hci_event.c:5784
 hci_le_meta_evt+0x2e5/0x5d0 net/bluetooth/hci_event.c:7132
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x669/0x1180 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4029
 process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
==================================================================
Oops: general protection fault, probably for non-canonical address 0xfbd59bffffffff91: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xdeacfffffffffc88-0xdeacfffffffffc8f]
CPU: 0 UID: 0 PID: 5950 Comm: kworker/u9:3 Tainted: G    B              6.12.0-rc7-syzkaller-00216-gf66d6acccbc0 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci5 hci_rx_work
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
RIP: 0010:l2cap_conn_ready net/bluetooth/l2cap_core.c:1621 [inline]
RIP: 0010:l2cap_connect_cfm+0x7f2/0xf80 net/bluetooth/l2cap_core.c:7278
Code: 80 fb ff ff 49 39 c5 0f 84 29 01 00 00 e8 26 a0 6e f7 49 8d 6f 0c be 04 00 00 00 48 89 ef e8 b5 80 cf f7 48 89 e8 48 c1 e8 03 <0f> b6 14 18 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 c5
RSP: 0018:ffffc90003e0f878 EFLAGS: 00010213
RAX: 1bd59fffffffff91 RBX: dffffc0000000000 RCX: ffffffff814e821f
RDX: ffff888030808000 RSI: ffffffff81ee2f8e RDI: 0000000000000007
RBP: deacfffffffffc8c R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 3d3d3d3d3d3d3d3d R12: ffff88804779003b
R13: ffff88806c83d2c0 R14: 0000000000000080 R15: deacfffffffffc80
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558a5ef5c8 CR3: 000000007bf02000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 le_conn_complete_evt+0x1665/0x1d80 net/bluetooth/hci_event.c:5758
 hci_le_conn_complete_evt+0x23c/0x370 net/bluetooth/hci_event.c:5784
 hci_le_meta_evt+0x2e5/0x5d0 net/bluetooth/hci_event.c:7132
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x669/0x1180 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4029
 process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
RIP: 0010:l2cap_conn_ready net/bluetooth/l2cap_core.c:1621 [inline]
RIP: 0010:l2cap_connect_cfm+0x7f2/0xf80 net/bluetooth/l2cap_core.c:7278
Code: 80 fb ff ff 49 39 c5 0f 84 29 01 00 00 e8 26 a0 6e f7 49 8d 6f 0c be 04 00 00 00 48 89 ef e8 b5 80 cf f7 48 89 e8 48 c1 e8 03 <0f> b6 14 18 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 c5
RSP: 0018:ffffc90003e0f878 EFLAGS: 00010213
RAX: 1bd59fffffffff91 RBX: dffffc0000000000 RCX: ffffffff814e821f
RDX: ffff888030808000 RSI: ffffffff81ee2f8e RDI: 0000000000000007
RBP: deacfffffffffc8c R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 3d3d3d3d3d3d3d3d R12: ffff88804779003b
R13: ffff88806c83d2c0 R14: 0000000000000080 R15: deacfffffffffc80
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558a5ef5c8 CR3: 000000007bf02000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	49 39 c5             	cmp    %rax,%r13
   3:	0f 84 29 01 00 00    	je     0x132
   9:	e8 26 a0 6e f7       	call   0xf76ea034
   e:	49 8d 6f 0c          	lea    0xc(%r15),%rbp
  12:	be 04 00 00 00       	mov    $0x4,%esi
  17:	48 89 ef             	mov    %rbp,%rdi
  1a:	e8 b5 80 cf f7       	call   0xf7cf80d4
  1f:	48 89 e8             	mov    %rbp,%rax
  22:	48 c1 e8 03          	shr    $0x3,%rax
* 26:	0f b6 14 18          	movzbl (%rax,%rbx,1),%edx <-- trapping instruction
  2a:	48 89 e8             	mov    %rbp,%rax
  2d:	83 e0 07             	and    $0x7,%eax
  30:	83 c0 03             	add    $0x3,%eax
  33:	38 d0                	cmp    %dl,%al
  35:	7c 08                	jl     0x3f
  37:	84 d2                	test   %dl,%dl
  39:	0f                   	.byte 0xf
  3a:	85 c5                	test   %eax,%ebp


---
