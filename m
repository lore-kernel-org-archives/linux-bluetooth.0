Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DD16D9B5
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jun 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718531601; cv=none; b=jhh/S3NHtc8st1pCOhgXjpg4Bj1u6wvndb8Oy+qklodlwu+C79VsSee0W2hJT2mHnMwxzsLLaCumR+jGoTo2mdvIT9l1Fg/jTWQpDNjXaWu/fDV8aGkDpoV8HD04biA61mWEXKbpSyea5wyZiTA8tvujnAPWFlGTeuTK7/aiB8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718531601; c=relaxed/simple;
	bh=gaKuEm8V1Ju/MyapGmyeCSE+iRQdTCL6yDPfq4U/D6s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kX1aUTB1WayS8/+Qj9up4PcK2MlXmHPbGXpD9Q/pYT6LpIYwQ9c0RjvfoxpSnFou2BlTg4xEAy8iBKxxX6sj2tTe60TRN3t0lTf2KGHuOH6qRZbTftigcGIunSw2B3adijDWHn2AghIFyO8VXnWSnvv4zYSV7zMGERVwCi5KkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ebd2481a89so371425039f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jun 2024 02:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718531598; x=1719136398;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQJ66GueA9EFO4nQTIwtSHlZyILstor2j8dmbIXY3oU=;
        b=GSnOeyJuDsFk6pfupJHhssaeWgUxbEXbXKXqn8rWC88p6YVXyEdM2HhyqxcksQ8ijZ
         QFOzh5C8iD33P8e3Mo5OyMT7oyE+6ma23LWH3J5eH0jy5aw9xS5tHtQBu0yZmBN4GD/U
         0fl49XxkgR8fSkTuBxOGoTTTwCTjOVPrzUALQmy0ZtlyCthxZ+I6E/jmol31YXPdZpX0
         Xkyyujzma1tNuF3kKhp2lNrg5+dDF8G+BdA6hUg2vL8Zk2FRHrtxT0xdjRbhPqWUnQ9l
         txmZp5Ni11IT9u/cUMnaUiZe/ZrFfN+7aIx3Kh0+Mkb1nwVWmvQZt4+12ZhUOK3muER8
         TN4A==
X-Forwarded-Encrypted: i=1; AJvYcCURjZNOgL7wPvixgQmTdB/JsdypThTT/48uhVsXLpyhh+Xmzjk+rKnnFfqXtBIYMMk9wvxpY/FEHGsSeKZ3eEe21gyjfMTgCueipgWTG+3f
X-Gm-Message-State: AOJu0Yy/wr/fYU+1blrd4P10z4sFgp8GF/w4F0zF29Hi5l8aQV5sobNe
	ULEWIdf3felH05lBe1XWIZu4Q/HNQ320uaDB//Hp7dPytJshcu2s2DNP56nlt1GpdFSKWAMSTjt
	rc4jwEGxJ+xbsZYlsEdeSpzhmYlnnxvRJwfKQ2UNaPLwzF+/SwFTcai4=
X-Google-Smtp-Source: AGHT+IFLl+bvQDTSBL8QdqRM7NQ/JIEsgWkAxvBqXwS9xVz1OS+iWFL3+CMLEnKxn0DE2I8j+Ej8oVzJsefKt5zEH7m9CHkMkbFA
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40aa:b0:4b9:165a:ffbe with SMTP id
 8926c6da1cb9f-4b963c9c2b8mr185811173.0.1718531598410; Sun, 16 Jun 2024
 02:53:18 -0700 (PDT)
Date: Sun, 16 Jun 2024 02:53:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000758110061afed1c0@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock (2)
From: syzbot <syzbot+9486ac2c18a7693c45d6@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cea2a26553ac mailmap: Add my outdated addresses to the map..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fdde02980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=9486ac2c18a7693c45d6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127efa36980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115da30a980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-cea2a265.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4de5cb3dff6d/vmlinux-cea2a265.xz
kernel image: https://storage.googleapis.com/syzbot-assets/75a2492b6478/bzImage-cea2a265.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9486ac2c18a7693c45d6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x2dd6/0x3b30 kernel/locking/lockdep.c:5005
Read of size 8 at addr ffff88801abd01d8 by task kworker/u33:2/5194

CPU: 1 PID: 5194 Comm: kworker/u33:2 Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 __lock_acquire+0x2dd6/0x3b30 kernel/locking/lockdep.c:5005
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __lock_sock+0x147/0x270 net/core/sock.c:2960
 lock_sock_nested+0xda/0xf0 net/core/sock.c:3539
 lock_sock include/net/sock.h:1602 [inline]
 l2cap_sock_recv_cb+0x54/0x3d0 net/bluetooth/l2cap_sock.c:1488
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x20cb/0xa190 net/bluetooth/l2cap_core.c:6833
 l2cap_recv_acldata+0x9ac/0xb60 net/bluetooth/l2cap_core.c:7516
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0xaa7/0x1610 net/bluetooth/hci_core.c:4079
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5630:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_noprof+0x1ec/0x410 mm/slub.c:4135
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
 __x64_sys_socket+0x72/0xb0 net/socket.c:1718
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5630:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4558
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
 __x64_sys_close+0x86/0x100 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801abd0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 472 bytes inside of
 freed 2048-byte region [ffff88801abd0000, ffff88801abd0800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1abd0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015442f00 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080080008 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015442f00 0000000000000000 dead000000000001
head: 0000000000000000 0000000080080008 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea00006af401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 4398644014, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 kmalloc_trace_noprof+0x2b4/0x300 mm/slub.c:4148
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 acpi_ds_create_walk_state+0x78/0x250 drivers/acpi/acpica/dswstate.c:518
 acpi_ds_call_control_method+0xf3/0x6d0 drivers/acpi/acpica/dsmethod.c:498
 acpi_ps_parse_aml+0x845/0xcb0 drivers/acpi/acpica/psparse.c:503
 acpi_ps_execute_method+0x55a/0xb30 drivers/acpi/acpica/psxface.c:190
 acpi_ns_evaluate+0x76c/0xca0 drivers/acpi/acpica/nseval.c:205
 acpi_evaluate_object+0x1fb/0xa90 drivers/acpi/acpica/nsxfeval.c:354
 acpi_evaluate_integer+0xde/0x200 drivers/acpi/utils.c:260
 acpi_bus_get_status_handle drivers/acpi/bus.c:82 [inline]
 acpi_bus_get_status+0x1a2/0x420 drivers/acpi/bus.c:111
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801abd0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801abd0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801abd0180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88801abd0200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801abd0280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
