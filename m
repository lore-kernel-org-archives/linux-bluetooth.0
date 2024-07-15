Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA9199A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036189; cv=none; b=L9AIwACzj1kJK1/MzqHg/1uXFj3a6HT7WN2YJrqhsl6mFZ3EZjeZWp4gkVY6BsJEHX3gpsF5iwq4UOtQvGWJ1jWy9QjAbBfxq1YLUBuHS2VdU49NV/NpJ+Gq+kdFASN0xDe4AQNk/QI3pK9QbZeDUpu/F67ErMocqx2Wb89pR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036189; c=relaxed/simple;
	bh=8QtGi/i0ImRwuJh3+fS59aC+201MYYNYZD2SSncqJfw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zy1aUX2BgF3T2oJ6M7J4QKZa+sGthMdwida2XP77X3ndVlR4x+PEt2cHMMqE4c54rpmP0g/45o3t3m1qWADM6bvuvmtKf+HV+kk/wbAKnn2Z6aHOzuAPD8bDrsTrk72OJ8G4hqzOjqfdu1JscxoHguuDy0pEpvV0QzhbnCRaMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7fdfb3333e5so470533439f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 02:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721036187; x=1721640987;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeoZB6fPJWIGRauIwEdDQjWLLVZ3C8qGzJlbE6eScS0=;
        b=tOHjs8GqP8pWv/xKLixzuqE9eLmzLNayi1CaU1VEqc7ghlGQ04GE5hgH/HpBk2t1oo
         SbjpWZsU2wQxHAfS6feWTt2TveKQMQL7lQLtU5E3ufp9EewKPsHzIlo+U/Uu9aWVFjF0
         tR2zVZqfc5Dv7DDPJadBADIrAxbyxqgu+6JkViIQdHBwpvnWTLPv+D6W9og0/qkX5G3s
         JxIBoVcL9IKaBITihMEVKZtMmLLxYR0mV9Xo09JBzHlZgsSJ4oU3bRrAIrF2UT8FD4oU
         Q2daE5gliKHd0VxQyrtlxE7E26gGHMBUvNvPaH6wsLJiEUU3jbJ2ZO5rmCpVQPgSSwA7
         OO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyxn0oMks6QkflDsN7u4AT6doYIkUfhm55z8t/5dEFL5QP6uvqnxSxy86fhxGmgqleiBFOltZn5WnCeY9kJEavjRTlDylMlXAM19GRsad9
X-Gm-Message-State: AOJu0YyU6X4DD4mbTXGFRqRwqah6KJ0G5R0dfTcADhclw2jbeU35x8wv
	Uls8t0lInK2IrkPnIKwCWogWZ9OQGM2PmI+XAq0yZ7CYZ2ebPnXoGfOrqqXkY4OLA1IhY0b5szB
	f/amtALaNuYDfQ+2HAwN3+xW+SWXB1icANa7DpL/LqDsldBcfmZiZ8yw=
X-Google-Smtp-Source: AGHT+IENUBACwBFvhB6Vq3Ip6eD1+kXna9FJxcf0W9UEf1Dh4MUcRkOEED8UvWrZL6HyWbdXmdB0Wa8R4L6tac+L4JkVWhkV75FX
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b88:b0:80f:81f5:b47d with SMTP id
 ca18e2360f4ac-80f81f5b95amr26415839f.2.1721036187048; Mon, 15 Jul 2024
 02:36:27 -0700 (PDT)
Date: Mon, 15 Jul 2024 02:36:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000932e45061d45f6e8@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0c3836482481 Linux 6.10
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e50766980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a18058d86df5936b
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-0c383648.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/871d2f2915c4/vmlinux-0c383648.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5582453293c4/bzImage-0c383648.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com

Bluetooth: hci0: Opcode 0x206a failed: -110
==================================================================
BUG: KASAN: slab-use-after-free in set_powered_sync+0xc1/0xd0 net/bluetooth/mgmt.c:1354
Read of size 8 at addr ffff88804642e318 by task kworker/u33:2/5212

CPU: 3 PID: 5212 Comm: kworker/u33:2 Not tainted 6.10.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 set_powered_sync+0xc1/0xd0 net/bluetooth/mgmt.c:1354
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:323
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 673:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 mgmt_pending_new+0x5b/0x290 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x160 net/bluetooth/mgmt_util.c:296
 set_powered+0x28c/0x5c0 net/bluetooth/mgmt.c:1395
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1712 [inline]
 hci_sock_sendmsg+0x1526/0x25e0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 sock_write_iter+0x50a/0x5c0 net/socket.c:1160
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_write+0x1f8/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 674:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4559
 cmd_status_rsp net/bluetooth/mgmt.c:1452 [inline]
 cmd_complete_rsp+0x119/0x160 net/bluetooth/mgmt.c:1466
 mgmt_pending_foreach+0xdf/0x140 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0x11f/0x2e0 net/bluetooth/mgmt.c:9346
 hci_sock_bind+0xc6d/0x1810 net/bluetooth/hci_sock.c:1307
 __sys_bind+0x1f3/0x220 net/socket.c:1847
 __do_sys_bind net/socket.c:1858 [inline]
 __se_sys_bind net/socket.c:1856 [inline]
 __ia32_sys_bind+0x71/0xb0 net/socket.c:1856
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff88804642e300
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff88804642e300, ffff88804642e360)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88804642e280 pfn:0x4642e
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 04fff00000000000 ffff888015442280 ffffea000073c300 dead000000000002
raw: ffff88804642e280 0000000080200017 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5205, tgid 5205 (syz-executor), ts 60618600133, free_ts 58387633005
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
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_noprof+0x37f/0x420 mm/slub.c:4136
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 tnode_alloc net/ipv4/fib_trie.c:333 [inline]
 tnode_new+0x25a/0x340 net/ipv4/fib_trie.c:386
 inflate net/ipv4/fib_trie.c:546 [inline]
 resize+0xa2b/0x2250 net/ipv4/fib_trie.c:870
 trie_rebalance net/ipv4/fib_trie.c:1107 [inline]
 fib_insert_node net/ipv4/fib_trie.c:1151 [inline]
 fib_insert_alias+0x9c0/0xe30 net/ipv4/fib_trie.c:1165
 fib_table_insert+0xaab/0x1d70 net/ipv4/fib_trie.c:1379
 fib_magic+0x4d6/0x5c0 net/ipv4/fib_frontend.c:1104
 fib_add_ifaddr+0x174/0x560 net/ipv4/fib_frontend.c:1126
 fib_inetaddr_event+0x174/0x2c0 net/ipv4/fib_frontend.c:1440
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
page last free pid 5207 tgid 5207 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2588
 __put_partials+0x14c/0x170 mm/slub.c:2995
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmalloc_trace_noprof+0x11e/0x310 mm/slub.c:4149
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ref_tracker_alloc+0x17c/0x5b0 lib/ref_tracker.c:203
 __netdev_tracker_alloc include/linux/netdevice.h:4038 [inline]
 netdev_hold include/linux/netdevice.h:4067 [inline]
 netdev_hold include/linux/netdevice.h:4062 [inline]
 netdev_queue_add_kobject net/core/net-sysfs.c:1783 [inline]
 netdev_queue_update_kobjects+0x281/0x640 net/core/net-sysfs.c:1838
 register_queue_kobjects net/core/net-sysfs.c:1900 [inline]
 netdev_register_kobject+0x290/0x3f0 net/core/net-sysfs.c:2140
 register_netdevice+0x12ce/0x1c40 net/core/dev.c:10375
 veth_newlink+0x4f6/0xa10 drivers/net/veth.c:1860
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink+0x119c/0x1960 net/core/rtnetlink.c:3730
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361

Memory state around the buggy address:
 ffff88804642e200: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff88804642e280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88804642e300: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff88804642e380: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff88804642e400: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
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
