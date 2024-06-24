Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B919B5AF
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242783; cv=none; b=E1CkU3h5SnvP23q6rVWFt8NErD9IeKL5E3C8hMYd9AF6ejXCY5ZzotaFhQE1QfWgp8Tf0C7mxspZwUExHIoMU1t25zyRXUNGUtx1Vsj6wrImVDMi5RLmQ6Qol0C6duO8Bk+KjSk8XjnNpkEe7QPkmrg0TaYFanRgdYZOOq7p63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242783; c=relaxed/simple;
	bh=h8A0oZRocuyHlIjb2daNyCVqc0lHiO3N90Ns6kARoOg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RD2S8+VVZHJQV2urmYO4h8c+bzqj/zemISkSKutARoZNW7E0lOnVbIYPpw3E2Q3a+hqeVwTJgT4mooKBlZ4SglW5dv0G1zGCSruU8G0Yk6RUEFd8NVvM4yoW9vvHJt+7EhimMLSiWvl64e9Er8cGuR8LZBsH/B/x63mqmfBmlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so614392739f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 08:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242781; x=1719847581;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zE0uc2zZWZCVhWmtz4i27J/y5P9e8XPvlk5YjcDFoUY=;
        b=Udh9IE3HkzISlhG0ZfX3+mWwgb3h9Pr/ZNs+velULYLX5e/u7Wb99lSdJNl8WlSsxb
         KTcks596Myh9sirWYSbrcftjVRjw4q2fB36WPrq1acJFDsB4it+c4fYRMTSHMNZdbJFa
         Qh+3LCdrvdzeA8qOT7uRhnNyFWl9y93NhebRUoAe4faUlRllLnOZyvWs3khbLczbQwrn
         1X+Th0YkhgBmFhwxtxshn+/ZmDE/ZBYLd/ku+TEJTCpFN4glf9n0HCHULIzAo0PORiF5
         mzGKtmSpm2q3xmkByeXSO/hLuRYLefaQBG2Bb1/P+7boPOYMnvjgoS+hLrPwTrLOWwZ6
         Aqhg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Le7OQikm1PtRs48lDyYd6gWqQztzZ/2Z6EtCR80HyYtjln58xvTXB5T36AZiS7uTCJORTX2oCroKYkiXEi6Y5Wijv7p2PbKScoeYoMnR
X-Gm-Message-State: AOJu0YyoxmXOMTZK/4VfBMENFdcAgKFZWik0BSzkbZCxQrtoXec6g9e3
	kRTeN95uAs/2aeWomUYksa4C685vFSdqlVZvCfcvyGXA1PbANpbCyVRlxbf8ypHvvO+YVInSh6O
	CSB6hzMZ0kPlnUFqZ45qtsPAHeB2Khak6IOXSaQBBuNK6wYyysMw1CzY=
X-Google-Smtp-Source: AGHT+IH74hyxIpjqGZAzbASNgjIbln1O6jdscUnoNE5VAcZL/dLqqLmU3lLWlfMNzJhkdBu4SXUCojfSvJieyMI4IKen3dqaJUSE
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871c:b0:4b9:731a:6844 with SMTP id
 8926c6da1cb9f-4b9ef9c717dmr250150173.0.1719242780872; Mon, 24 Jun 2024
 08:26:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:26:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c9f54061ba467b9@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __sock_queue_rcv_skb
From: syzbot <syzbot+88fd97e5fd010b9cd053@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    96e09b8f8166 Merge tag 'platform-drivers-x86-v6.10-3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143e77ba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96fd46a1ee1615e0
dashboard link: https://syzkaller.appspot.com/bug?extid=88fd97e5fd010b9cd053
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-96e09b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2bf80e54d1f/vmlinux-96e09b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b81837ec8c21/bzImage-96e09b8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88fd97e5fd010b9cd053@syzkaller.appspotmail.com

Bluetooth: hci5: Opcode 0x1003 failed: -110
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_lock+0x271/0x2c0 kernel/locking/spinlock_debug.c:115
Read of size 4 at addr ffff888029af3104 by task kworker/u33:3/5232

CPU: 0 PID: 5232 Comm: kworker/u33:3 Not tainted 6.10.0-rc2-syzkaller-00269-g96e09b8f8166 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: hci3 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x271/0x2c0 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
 __sock_queue_rcv_skb+0x377/0xa80 net/core/sock.c:504
 l2cap_sock_recv_cb+0xfa/0x3d0 net/bluetooth/l2cap_sock.c:1507
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x20d0/0xa080 net/bluetooth/l2cap_core.c:6833
 l2cap_recv_acldata+0x9ac/0xb60 net/bluetooth/l2cap_core.c:7516
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0xaa7/0x1610 net/bluetooth/hci_core.c:4079
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 7577:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x1ec/0x420 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2080
 sk_alloc+0x36/0xb90 net/core/sock.c:2133
 bt_sock_alloc+0x3b/0x3a0 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc.constprop.0+0x35/0x180 net/bluetooth/l2cap_sock.c:1869
 l2cap_sock_create+0x123/0x1f0 net/bluetooth/l2cap_sock.c:1909
 bt_sock_create+0x182/0x350 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x32e/0x800 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socket_create net/socket.c:1659 [inline]
 __sys_socket+0x14f/0x260 net/socket.c:1706
 __do_sys_socket net/socket.c:1720 [inline]
 __se_sys_socket net/socket.c:1718 [inline]
 __ia32_sys_socket+0x72/0xb0 net/socket.c:1718
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 7576:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4557
 sk_prot_free net/core/sock.c:2116 [inline]
 __sk_destruct+0x5d8/0x730 net/core/sock.c:2208
 sk_destruct+0xc2/0xf0 net/core/sock.c:2223
 __sk_free+0xf4/0x3e0 net/core/sock.c:2234
 sk_free+0x7c/0xa0 net/core/sock.c:2245
 sock_put include/net/sock.h:1879 [inline]
 l2cap_sock_kill net/bluetooth/l2cap_sock.c:1246 [inline]
 l2cap_sock_kill+0x22f/0x270 net/bluetooth/l2cap_sock.c:1235
 l2cap_sock_release+0x189/0x210 net/bluetooth/l2cap_sock.c:1417
 __sock_release+0xb0/0x270 net/socket.c:659
 sock_close+0x1c/0x30 net/socket.c:1421
 __fput+0x408/0xbb0 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __ia32_sys_close+0x86/0x100 fs/open.c:1540
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff888029af3000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 260 bytes inside of
 freed 2048-byte region [ffff888029af3000, ffff888029af3800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29af0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015442f00 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015442f00 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0000a6bc01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4916, tgid 4916 (dhcpcd), ts 29721812125, free_ts 29702960673
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2df0 mm/page_alloc.c:3402
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4660
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2264
 allocate_slab mm/slub.c:2427 [inline]
 new_slab+0x84/0x260 mm/slub.c:2480
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3666
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmalloc_trace_noprof+0x2c5/0x310 mm/slub.c:4147
 kmalloc_noprof include/linux/slab.h:660 [inline]
 rtnl_newlink+0x49/0xa0 net/core/rtnetlink.c:3739
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2585
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2639
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2668
page last free pid 5022 tgid 5022 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2565
 __put_partials+0x14c/0x170 mm/slub.c:2994
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4007
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags include/linux/audit.h:322 [inline]
 getname+0x8f/0xe0 fs/namei.c:218
 do_sys_openat2+0x104/0x1e0 fs/open.c:1399
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888029af3000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029af3080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888029af3100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888029af3180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029af3200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
