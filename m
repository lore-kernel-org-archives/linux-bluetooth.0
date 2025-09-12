Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3623AB8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691993; cv=none; b=WF4e43zqIyvaJBamBhocLYTdxF/OptT/NgoZ96aFMD6OW/y9iB1g3o8V3fZCds7N93faT/bmm0UNIs3/WM6x4trySsw/t96NKP5RqtLcLQn4aN0tmrlKSC0wk2hro1JORv5W95vxtfOZbQwDfXJSemi9JEvgUD/uM5pgoNbGbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691993; c=relaxed/simple;
	bh=y7CSvpwDNoZP/AQb4KkTyNw9yYUr9jxGoEbsLHS93ww=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=atFoGGH5jcspQC3UaE9HSQBNmMojQxaSyLNwjAZIDPYxxy+YsjFD8r2br1e1fvpaZ4xG2IceEB7qAUEqteCJWCljTkEmUKktp34cPLu2wy2Dg179DP9w1nGOs+sSmhl2A2btkjCFJSdqRZ2Pd+EAO36jMbMWcaeOa+ERJwz2DI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42306862fc5so5567535ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 08:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691990; x=1758296790;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmIDwGLt88oK0VrPke850QRBTnWxm93rpkXbpCBvQgY=;
        b=llZGOGW4mBzCXXM6C/j++DNwnrJl5+EuPrrmwYpUgM4yIwr7xg8/s2W/BpjaUmA3EW
         Y6SGLQ4NK2t805BmfRqXjekr+w+uXCcQrusuvGLPsnD5/EP7reZzeZigjWMZ3PjsVgOI
         LgBr+vmxn7XWcfzAQB293wg6fx/Zpou/GJ7LJSpyAxIdJXim+1lmeKWEnLfQo+z+53N4
         /GDHtF16H+6PO66g6rBmPx3nwiKSGMWo2TOQQv+4XyxiedgOi9+insUZzWCh9DSyeK4t
         tHakO0E7MBNM9/6KipCw8FHK5BAElIJYakEnUQIDLa1uY6ukwhg0RYKau0EPvpfihdGn
         fj5w==
X-Forwarded-Encrypted: i=1; AJvYcCU2z6k+TpMldz/4z0IxIIIlTZ22VAlJnGFt5yHmF6Nw/8TXukTiWY2YybMK5cEVgC4qX6CtzTRyrYu86g2cesI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywee6r1L00d2XAX0yyQQN6yMEnOLTD+lxkOlCg0cwoK2B66DLK
	/bCNbU02LHsJz4+i1fk570Tt7A4xEqmrZyDoKWiIf1WEhGeOBevVSIwai1myODwbdX8CiOl6aQ3
	n1VX89uxwMiAM1nCufgMH7fKwl70yZxtJ7bBfTIPLipFsGt/9a0PXuIa5bSA=
X-Google-Smtp-Source: AGHT+IG40qt48oLK9UMwkLmihYsue37aN2kGi5xgVYk++JOC1PkU/3f//zf8GtC9EhFdZBkBlOrE3YvxhsLV+ZfY6NePHwn64pb6
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:41c:ba93:bee0 with SMTP id
 e9e14a558f8ab-420a4dec279mr46332665ab.28.1757691990269; Fri, 12 Sep 2025
 08:46:30 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:46:30 -0700
In-Reply-To: <67d84663.050a0220.2ca2c6.0020.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c44056.a70a0220.3543fc.0036.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: wild-memory-access Read in l2cap_connect_cfm
From: syzbot <syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    590b221ed425 Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=161d1934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9134e501f17b95a4
dashboard link: https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111d1934580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/872439e79d04/disk-590b221e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09ebcfd707c1/vmlinux-590b221e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3417bc549df/bzImage-590b221e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com

 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
kobject: kobject_add_internal failed for hci0:201 with -EEXIST, don't try to register things with the same name in the same directory.
Bluetooth: hci0: failed to register connection device
==================================================================
BUG: KASAN: slab-use-after-free in l2cap_conn_ready net/bluetooth/l2cap_core.c:1623 [inline]
BUG: KASAN: slab-use-after-free in l2cap_connect_cfm+0x6e4/0x1040 net/bluetooth/l2cap_core.c:7304
Read of size 8 at addr ffff888076dfc480 by task kworker/u9:3/5984

CPU: 1 UID: 0 PID: 5984 Comm: kworker/u9:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1623 [inline]
 l2cap_connect_cfm+0x6e4/0x1040 net/bluetooth/l2cap_core.c:7304
 hci_connect_cfm+0x95/0x140 include/net/bluetooth/hci_core.h:2085
 le_conn_complete_evt+0xcd3/0x1220 net/bluetooth/hci_event.c:5761
 hci_le_conn_complete_evt+0x187/0x450 net/bluetooth/hci_event.c:5787
 hci_event_func net/bluetooth/hci_event.c:7532 [inline]
 hci_event_packet+0x78f/0x1200 net/bluetooth/hci_event.c:7589
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4099
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5984:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x3d5/0x6f0 mm/slub.c:5457
 kmalloc_noprof include/linux/slab.h:956 [inline]
 kzalloc_noprof include/linux/slab.h:1090 [inline]
 l2cap_chan_create+0x50/0x760 net/bluetooth/l2cap_core.c:445
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1906 [inline]
 l2cap_sock_new_connection_cb+0x182/0x2b0 net/bluetooth/l2cap_sock.c:1485
 l2cap_connect_cfm+0x37a/0x1040 net/bluetooth/l2cap_core.c:7287
 hci_connect_cfm+0x95/0x140 include/net/bluetooth/hci_core.h:2085
 le_conn_complete_evt+0xcd3/0x1220 net/bluetooth/hci_event.c:5761
 hci_le_conn_complete_evt+0x187/0x450 net/bluetooth/hci_event.c:5787
 hci_event_func net/bluetooth/hci_event.c:7532 [inline]
 hci_event_packet+0x78f/0x1200 net/bluetooth/hci_event.c:7589
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4099
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6106:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2474 [inline]
 slab_free mm/slub.c:6181 [inline]
 kfree+0x199/0x6d0 mm/slub.c:6389
 l2cap_sock_cleanup_listen+0xea/0x3e0 net/bluetooth/l2cap_sock.c:1468
 l2cap_sock_release+0x6a/0x210 net/bluetooth/l2cap_sock.c:1426
 __sock_release net/socket.c:649 [inline]
 sock_close+0xc3/0x240 net/socket.c:1442
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888076dfc000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1152 bytes inside of
 freed 2048-byte region [ffff888076dfc000, ffff888076dfc800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76df8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a842000 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a842000 0000000000000000 0000000000000001
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001db7e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12, tgid 12 (kworker/u8:0), ts 101722977992, free_ts 59750752696
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3869
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5159
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2986 [inline]
 allocate_slab+0x8a/0x330 mm/slub.c:3154
 new_slab mm/slub.c:3208 [inline]
 ___slab_alloc+0xbd1/0x13f0 mm/slub.c:4480
 __slab_alloc+0x55/0xa0 mm/slub.c:4571
 __slab_alloc_node mm/slub.c:4646 [inline]
 slab_alloc_node mm/slub.c:5056 [inline]
 __do_kmalloc_node mm/slub.c:5425 [inline]
 __kmalloc_node_track_caller_noprof+0x5c7/0x800 mm/slub.c:5445
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:600
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:669
 alloc_skb include/linux/skbuff.h:1377 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 rtmsg_ifinfo_build_skb+0x84/0x260 net/core/rtnetlink.c:4392
 unregister_netdevice_many_notify+0x1556/0x1ff0 net/core/dev.c:12218
 ops_exit_rtnl_list net/core/net_namespace.c:186 [inline]
 ops_undo_list+0x3dc/0x990 net/core/net_namespace.c:247
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
page last free pid 5549 tgid 5549 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 __slab_free+0x2e7/0x390 mm/slub.c:5656
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:349
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4770 [inline]
 slab_alloc_node mm/slub.c:5068 [inline]
 __do_kmalloc_node mm/slub.c:5425 [inline]
 __kmalloc_noprof+0x3c3/0x7f0 mm/slub.c:5438
 kmalloc_noprof include/linux/slab.h:960 [inline]
 tomoyo_realpath_from_path+0xe3/0x5d0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x213/0x4b0 security/tomoyo/file.c:822
 security_inode_getattr+0x12f/0x330 security/security.c:2416
 vfs_getattr fs/stat.c:259 [inline]
 vfs_fstat fs/stat.c:281 [inline]
 __do_sys_newfstat fs/stat.c:555 [inline]
 __se_sys_newfstat fs/stat.c:550 [inline]
 __x64_sys_newfstat+0xfc/0x200 fs/stat.c:550
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888076dfc380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076dfc400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888076dfc480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888076dfc500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076dfc580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
