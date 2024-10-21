Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443071799F
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500391; cv=none; b=cfCQsd4oSb7jReyM01Jf+L4h1bQhI+/sVDJrMTNuONfsJD0r124UUzc5NoKeN7u9QWLUMiWhVhPVPEf2kQA4MWxOGzFlmZsMvhnTUt2mCMBJ8C9Td8ZT3v8ZDaVs4reFXh+5HXTvFbuA16bqEKhRGsJ2X2dPgWZcl8veBpv3fM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500391; c=relaxed/simple;
	bh=qCbSUrSMZ/8kZmixZDTVx4KpuYRY/jKylG2zM4P8bcI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p1dUQt1sBbgPDiiP1dnKMoSt1hiFVKwNJftISL5fzwaApxIrcJnojBjTwVuFbexK1ndnDGdFVa+7POcBK9+vLff+nOPbAGfgatdruKkThIwd0bmv31MRZSOBlc9HYIFPsgoEPQfJoJAzyo3D+SF3ClroE9OP8D39LH27MR6WbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so35588635ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 01:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729500388; x=1730105188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0w8pGpm3qDBi4Q0vwzypMlEcmiB4WxdGUUgyzJHESY=;
        b=nd/3JvNpwZ6ZDLQ3Kl0VBKBq8AjeRVLuZ7UFgtiEA+HwP5UBXtT1U2Vw7Q7up20Fco
         Esnfjxj/xj6E1gm4LGCePPCfIzQnzWkIjw95oOc/c9cTWVBuFPGms257yJQdMnlXhmqq
         JFNjyWiWzXOmJYwZ9AMnGFKjC8jt/Q/uM9cb0rzGY8hHd9gYFA5I9CIuNy+FI6Phj3gX
         WjWwxYAXS2nBVDCu9YrJo+NvRdPX3DEsLo2/LoD7MthyAlJ8+DojARfT9UXbo45OFLia
         vfPV+0r9/Hc3QGB++riToEomv8CnuwK4fHqdEALC7XC1y071iZ5lArA81/wFuRHBcu0R
         9M1g==
X-Forwarded-Encrypted: i=1; AJvYcCUxL9mPJ2b9tRAWh2zZpN/hdZI6z+9K8cb9ZWk5riHf+H6nwFzxIgxu8j0i3K6TIMpkdZ3HeGhWQfHKfnCnm+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3Ul+Px/hBq5b1HN6a7wnE9ix59HUWDpuF32oet1WFu0u5psT
	C2T83boOmhxMRT5urZs2UB5ug8JnnbUADTaCnPVjhwg5AcN6S/0buDUU4zToTo40NtqepDoEZHh
	n5rKHiBR/LnnKNKlVRx2zg/QkPCZwWk52GWZinPhMZvzUvM7UAwIfImo=
X-Google-Smtp-Source: AGHT+IHGf2JfFutbIm7jvx/pvf/IfMuURWvpzdE1wzNHwpkNqHcFoiLQeh8XAK6t/stxFgPI8j8nYpRuPl6hpQj9tVOPspE+hQsc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:3a2:e9ff:255a with SMTP id
 e9e14a558f8ab-3a3f40b139fmr89977005ab.22.1729500388312; Mon, 21 Oct 2024
 01:46:28 -0700 (PDT)
Date: Mon, 21 Oct 2024 01:46:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671614e4.050a0220.1e4b4d.0055.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_sock_new_connection_cb
From: syzbot <syzbot+cdae834448ec8c3602fe@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d939780b705 Merge tag 'mm-hotfixes-stable-2024-10-17-16-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17712240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c9b3fd66df7ebb7
dashboard link: https://syzkaller.appspot.com/bug?extid=cdae834448ec8c3602fe
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d54d8e0d6d3/disk-4d939780.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a28782ce0f67/vmlinux-4d939780.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66ae027c044c/bzImage-4d939780.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdae834448ec8c3602fe@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_sock_new_connection_cb+0x22a/0x240 net/bluetooth/l2cap_sock.c:1483
Read of size 8 at addr ffff888051b0d580 by task kworker/u9:5/5235

CPU: 1 UID: 0 PID: 5235 Comm: kworker/u9:5 Not tainted 6.12.0-rc3-syzkaller-00217-g4d939780b705 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci5 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 l2cap_sock_new_connection_cb+0x22a/0x240 net/bluetooth/l2cap_sock.c:1483
 l2cap_connect_cfm+0x4c9/0xf80 net/bluetooth/l2cap_core.c:7261
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 le_conn_complete_evt+0x1662/0x1d80 net/bluetooth/hci_event.c:5758
 hci_le_conn_complete_evt+0x23c/0x370 net/bluetooth/hci_event.c:5784
 hci_le_meta_evt+0x2e2/0x5d0 net/bluetooth/hci_event.c:7132
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x666/0x1180 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x2c6/0x16c0 net/bluetooth/hci_core.c:4025
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5235:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2164
 sk_alloc+0x36/0xb90 net/core/sock.c:2217
 bt_sock_alloc+0x3b/0x3a0 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc.constprop.0+0x35/0x180 net/bluetooth/l2cap_sock.c:1877
 l2cap_sock_new_connection_cb+0x101/0x240 net/bluetooth/l2cap_sock.c:1468
 l2cap_connect_cfm+0x4c9/0xf80 net/bluetooth/l2cap_core.c:7261
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 le_conn_complete_evt+0x1662/0x1d80 net/bluetooth/hci_event.c:5758
 hci_le_conn_complete_evt+0x23c/0x370 net/bluetooth/hci_event.c:5784
 hci_le_meta_evt+0x2e2/0x5d0 net/bluetooth/hci_event.c:7132
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x666/0x1180 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x2c6/0x16c0 net/bluetooth/hci_core.c:4025
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 12523:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 sk_prot_free net/core/sock.c:2200 [inline]
 __sk_destruct+0x5eb/0x720 net/core/sock.c:2292
 sk_destruct+0xc2/0xf0 net/core/sock.c:2307
 __sk_free+0xf4/0x3e0 net/core/sock.c:2318
 sk_free+0x6a/0x90 net/core/sock.c:2329
 sock_put include/net/sock.h:1888 [inline]
 l2cap_sock_kill net/bluetooth/l2cap_sock.c:1250 [inline]
 l2cap_sock_kill+0x171/0x2d0 net/bluetooth/l2cap_sock.c:1235
 l2cap_sock_cleanup_listen+0x3d/0x2a0 net/bluetooth/l2cap_sock.c:1448
 l2cap_sock_release+0x5c/0x210 net/bluetooth/l2cap_sock.c:1411
 __sock_release+0xb0/0x270 net/socket.c:658
 sock_close+0x1c/0x30 net/socket.c:1426
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 get_signal+0x1ca/0x2770 kernel/signal.c:2690
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888051b0d000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1408 bytes inside of
 freed 2048-byte region [ffff888051b0d000, ffff888051b0d800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x51b08
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b042000 ffffea0001e8d600 dead000000000002
raw: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801b042000 ffffea0001e8d600 dead000000000002
head: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea000146c201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 8071, tgid 8071 (syz-executor), ts 364335009732, free_ts 364003293789
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2ba/0x3f0 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 rtnl_newlink+0x49/0xa0 net/core/rtnetlink.c:3768
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 __sys_sendto+0x479/0x4d0 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2222
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
page last free pid 8 tgid 8 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x153/0x310 mm/slub.c:4186
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1322 [inline]
 alloc_skb_with_frags+0xe4/0x850 net/core/skbuff.c:6612
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2883
 sock_alloc_send_skb include/net/sock.h:1782 [inline]
 mld_newpack.isra.0+0x1ed/0x790 net/ipv6/mcast.c:1747
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1850
 add_grec+0x111e/0x1670 net/ipv6/mcast.c:1988
 mld_send_cr net/ipv6/mcast.c:2114 [inline]
 mld_ifc_work+0x41f/0xca0 net/ipv6/mcast.c:2651
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147

Memory state around the buggy address:
 ffff888051b0d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888051b0d500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888051b0d580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888051b0d600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888051b0d680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
