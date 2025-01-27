Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942821FC7FF
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737964763; cv=none; b=nW9N/X5oFH3hNcHy7JLIgfSBmZ89uCq3NTqkc6hAW9EqA0V0Aed+pgNr0uGcF6SwsRQ9VEjqlscL424aQagDLj7QvwvGHGUn+eJ9LFtinxS7dDWN64dPV+BydAKhafvG0PkZff1KhEH0ZJdOFohXZ+v3MKGrCBch0j+ZzQFmhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737964763; c=relaxed/simple;
	bh=SVRKuDGV/iQ4a5EQ8vy+pBD1L4Zl7Kgf0ZwR1z3ezYo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HHRjpT+j7rmThsz9bRuVPEoCVbgAOKlxFVyicoTNNtPeWYBuuYWVIoD/8pR2f3FP3G4DLSL1xVk/qQ9o+lcSBEoqLyBt8GTDqkfN1LLG96csGiVg1WxvqaIW/UaThlAXpgxZb+bN/BNhPmRSQ/VPBVFirXU+5MQZ1GNwoB2I1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso33703725ab.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 23:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737964760; x=1738569560;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=057ToeDcX5gl484GndQKpevaLOqwDphYFy7+qxMQhuc=;
        b=AQas1C+9EQpycsauyu1zGLGYS6TGP7zu+6FEq6BGsUrpekM74bTAHxAjy1v7rC6kDv
         VkAy9A2Xo1r2o1dsEhTqLF5T5NlK6wCfYB0Pvxsk/2MHFh55wtFEgkzKq1NNJsQGnNyz
         0G0ct4xmbp6j1C/FlyVVhcmcvMKcgszCMgUYNm7KemqdLdbye54mjjk1oCIOp8CI9jZy
         nVg7UcWkAX/rS+Kf/IYXje63NKmJb4BQZhBL3AnrPoj74Oc+1xZcVFwVxN4yVe3nbU2E
         XhWrBobj0L4gxyMHnamQ6YngZ62YsD8IJMPY4KWpdYgXAsyyW2H0Yy2DCeIvA5oo6iUe
         Yzvw==
X-Forwarded-Encrypted: i=1; AJvYcCWLHJlBbiRI2V5AQjCjDhEUiCpMDw0cLkq+8/7fFx4EcMZzzkGpcI1MxYGVl1GD7+L9nllfCEHLl3x4lhqxpbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO45UPKfO/RCARe9n9MMZqPclc1PVZYRHoKrxZjJfjkRZM7TxO
	oMEjui8LPB/RuY2RoJwFw+HiYd1mqRD9/7PYUjdHGCsmCicxnATzVZ1WGrKvppia6TI/whgdRZ5
	ix/VqaNh1k+XQMGbe5WohW6zQL41RVI3YM0wzicdvSrL3efaqhrgGUhA=
X-Google-Smtp-Source: AGHT+IH/ude7oaVQq956JjCyM/PgGFs4yd3usmqZ97Jiz97S/1ZBomTB9A5/FXAAPAmsPRXYhQBvttFTJsm8+IX13d3sRlBLTQFo
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2688:b0:3cf:e76b:3937 with SMTP id
 e9e14a558f8ab-3cfe76b3ab6mr18151345ab.0.1737964760636; Sun, 26 Jan 2025
 23:59:20 -0800 (PST)
Date: Sun, 26 Jan 2025 23:59:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67973cd8.050a0220.2eae65.0044.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sock_def_readable
From: syzbot <syzbot+0cabe82a7ed71379b27d@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    95ec54a420b8 Merge tag 'powerpc-6.14-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ace824580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36c0fee2efbf1634
dashboard link: https://syzkaller.appspot.com/bug?extid=0cabe82a7ed71379b27d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-95ec54a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f55c60f56c5/vmlinux-95ec54a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/afb77bff66ad/bzImage-95ec54a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0cabe82a7ed71379b27d@syzkaller.appspotmail.com

Bluetooth: hci2: Opcode 0x0406 failed: -4
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in sock_flag include/net/sock.h:992 [inline]
BUG: KASAN: slab-use-after-free in sk_wake_async_rcu include/net/sock.h:2470 [inline]
BUG: KASAN: slab-use-after-free in sock_def_readable+0x175/0x610 net/core/sock.c:3458
Read of size 8 at addr ffff8880750a2060 by task syz.8.2237/20732

CPU: 0 UID: 0 PID: 20732 Comm: syz.8.2237 Not tainted 6.13.0-syzkaller-00918-g95ec54a420b8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 sock_flag include/net/sock.h:992 [inline]
 sk_wake_async_rcu include/net/sock.h:2470 [inline]
 sock_def_readable+0x175/0x610 net/core/sock.c:3458
 l2cap_sock_teardown_cb+0x1d1/0x3c0 net/bluetooth/l2cap_sock.c:1602
 l2cap_chan_del+0xba/0x8f0 net/bluetooth/l2cap_core.c:658
 l2cap_conn_del+0x37c/0x730 net/bluetooth/l2cap_core.c:1785
 l2cap_connect_cfm+0x7aa/0xf10 net/bluetooth/l2cap_core.c:7235
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_conn_failed+0x225/0x3e0 net/bluetooth/hci_conn.c:1266
 hci_abort_conn_sync+0x968/0x1030 net/bluetooth/hci_sync.c:5604
 hci_disconnect_all_sync.constprop.0+0x104/0x3c0 net/bluetooth/hci_sync.c:5627
 hci_suspend_sync+0x772/0xab0 net/bluetooth/hci_sync.c:6104
 hci_suspend_dev+0x27d/0x5e0 net/bluetooth/hci_core.c:2831
 hci_suspend_notifier+0x28d/0x2f0 net/bluetooth/hci_core.c:2411
 notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
 notifier_call_chain_robust kernel/notifier.c:120 [inline]
 blocking_notifier_call_chain_robust kernel/notifier.c:345 [inline]
 blocking_notifier_call_chain_robust+0xc9/0x170 kernel/notifier.c:333
 pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
 snapshot_open+0x189/0x2b0 kernel/power/user.c:77
 misc_open+0x35a/0x420 drivers/char/misc.c:165
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0xf59/0x1ea0 fs/open.c:938
 vfs_open+0x82/0x3f0 fs/open.c:1068
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e81/0x2d70 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1395
 do_sys_open fs/open.c:1410 [inline]
 __do_compat_sys_openat fs/open.c:1472 [inline]
 __se_compat_sys_openat fs/open.c:1470 [inline]
 __ia32_compat_sys_openat+0x16e/0x210 fs/open.c:1470
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf706e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f506055c EFLAGS: 00000296 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000200004c0
RDX: 0000000000000800 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 20737:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x21a/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2168
 sk_alloc+0x36/0xb90 net/core/sock.c:2221
 bt_sock_alloc+0x3b/0x3a0 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc.constprop.0+0x33/0x1c0 net/bluetooth/l2cap_sock.c:1879
 l2cap_sock_create+0x123/0x1f0 net/bluetooth/l2cap_sock.c:1920
 bt_sock_create+0x182/0x350 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x335/0x8d0 net/socket.c:1558
 sock_create net/socket.c:1616 [inline]
 __sys_socket_create net/socket.c:1653 [inline]
 __sys_socket+0x14f/0x260 net/socket.c:1700
 __do_sys_socket net/socket.c:1714 [inline]
 __se_sys_socket net/socket.c:1712 [inline]
 __ia32_sys_socket+0x72/0xb0 net/socket.c:1712
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 20737:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 sk_prot_free net/core/sock.c:2204 [inline]
 __sk_destruct+0x5eb/0x720 net/core/sock.c:2296
 sk_destruct+0xc2/0xf0 net/core/sock.c:2311
 __sk_free+0xf4/0x3e0 net/core/sock.c:2322
 sk_free+0x6a/0x90 net/core/sock.c:2333
 sock_put include/net/sock.h:1910 [inline]
 l2cap_sock_kill net/bluetooth/l2cap_sock.c:1252 [inline]
 l2cap_sock_kill+0x171/0x2d0 net/bluetooth/l2cap_sock.c:1237
 l2cap_sock_release+0x189/0x210 net/bluetooth/l2cap_sock.c:1423
 __sock_release+0xb0/0x270 net/socket.c:640
 sock_close+0x1c/0x30 net/socket.c:1408
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 get_signal+0x1d3/0x2610 kernel/signal.c:2809
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff8880750a2000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 96 bytes inside of
 freed 2048-byte region [ffff8880750a2000, ffff8880750a2800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880750a6000 pfn:0x750a0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801b042f00 ffffea00017b9400 dead000000000002
raw: ffff8880750a6000 0000000000080007 00000001f5000000 0000000000000000
head: 04fff00000000040 ffff88801b042f00 ffffea00017b9400 dead000000000002
head: ffff8880750a6000 0000000000080007 00000001f5000000 0000000000000000
head: 04fff00000000003 ffffea0001d42801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 11242, tgid 11242 (syz-executor), ts 209858358142, free_ts 209856543599
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x221/0x2470 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c8/0x620 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xcda/0x1660 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_track_caller_noprof+0x2ee/0x520 mm/slub.c:4317
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:609
 __alloc_skb+0x164/0x380 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1323 [inline]
 nlmsg_new include/net/netlink.h:1018 [inline]
 inet6_ifinfo_notify+0x77/0x150 net/ipv6/addrconf.c:6178
 addrconf_notify+0x81a/0x19c0 net/ipv6/addrconf.c:3784
 notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2026
 call_netdevice_notifiers_extack net/core/dev.c:2064 [inline]
 call_netdevice_notifiers net/core/dev.c:2078 [inline]
 __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:9007
 dev_change_flags+0x10c/0x160 net/core/dev.c:9045
page last free pid 11242 tgid 11242 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2659
 __put_partials+0x14c/0x170 mm/slub.c:3157
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_noprof+0x1d0/0x520 mm/slub.c:4304
 kmalloc_array_node_noprof include/linux/slab.h:1018 [inline]
 alloc_slab_obj_exts+0x41/0xa0 mm/slub.c:1964
 account_slab mm/slub.c:2552 [inline]
 allocate_slab mm/slub.c:2607 [inline]
 new_slab+0x314/0x410 mm/slub.c:2642
 ___slab_alloc+0xcda/0x1660 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 kmem_cache_alloc_noprof+0xeb/0x3b0 mm/slub.c:4175
 sk_prot_alloc+0x60/0x2a0 net/core/sock.c:2162
 sk_alloc+0x36/0xb90 net/core/sock.c:2221
 unix_create1+0xa6/0x6c0 net/unix/af_unix.c:1024
 unix_create+0x10e/0x1d0 net/unix/af_unix.c:1094
 __sock_create+0x335/0x8d0 net/socket.c:1558

Memory state around the buggy address:
 ffff8880750a1f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880750a1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880750a2000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff8880750a2080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880750a2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
