Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19807158555
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507802; cv=none; b=biatti0rZchD2mI410Stf56YoycBUQ7+jJ3oYtrTKznEAm0YIrFLvRQMB07Zuj502jn//YRCN23Oy9kR89owBmvWDX6rWxAroLkc4aqyThs5YMij8AbsI+T4hLPsAWmAY2kumXdSrOq4tv9sgr1SVSXLmp73KUjSxnAlY/7yfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507802; c=relaxed/simple;
	bh=BaQjCdcSOt+9cR2RBk/qkGl9sIMcLi5Tne+Hoy40QMg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=POknoLtGTeAklfIuNWbkAKCK/WOA51++0794xqlo5qEex58beFQvC9zLc0esSCMP/2/Ca2e6b9IKVSdq7kCEvFJqbs4Uq7c2S91UdtYZN9imjg10eDecAaVOxRcoyLmb22I+GTCrVpDBG+amXWAdcuzMvd7zyMSEOpBVoDMn1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so115598235ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 23:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734507799; x=1735112599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+GUkvGq7Lls6QIr9yvirUWFF3o/qk+ORqL2S4r6ZMgw=;
        b=KDZW5k3JVXuK5s898cbYBD6sxaLPmkPro8DmvpuURyQX4gBM5kI/cxZ1j9o+9ZMrOo
         +qEzBDpNmrKQlWqyxxdtAXNvJzpKoWUoynY+AgwXomv/zABwUH9HMo739J0DcWW6xJEa
         ypzC6fNHBBjpqdLsBkSMI1hTRQ8KoFbsncUoEOhO8fsJmAbwyA0TdgN4ikbZn0vVpoEI
         6iXDIr988w0x4TnfSpwTdT0n2wu3RL3QhJAe8VkLdJO1ZNjWkziEZT58jFXQZZCfHb0L
         TPCluPqggvroErfPWLXYRWHYy5JxN625eGbfDvHNLQjyOdoIGqIw9PqyjFpmPjmVTtnj
         myfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB8VhI9sE7ntBpyAVgok+9OYJCYH3GXqN+CUteAoo7uGEDrzxJTLGtjFSuPKDq3tzW7eKuyTp0et5Fh0LdKkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0sb5k+Ve+RVd4GDxciqP+TdlxTYHtuvE4cbcrcDSnRmZe1Yw
	E33Pq8XlULGd5OlzZEA9e+KEi6WdmzhixyFqRm0P9/dxRoZNZinKXquP2Q++yOJRX0DwE7PgA7L
	2wiE5qRpIU7jifW1c0eY7BpceyjFq61UHG2AprJANMYzb3E9MlbhG1xg=
X-Google-Smtp-Source: AGHT+IFI+Tgxb0/4eAxKE7/t9pEbpWIk13bIWvqHnyJUNL0HQiPX1bDa3WzIRBQD8BKPFYBagQpyHklAZ8w6pFLIyQlj/vJxjUtA
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:3a6:c98d:86bc with SMTP id
 e9e14a558f8ab-3bdc0411e61mr18228905ab.1.1734507799310; Tue, 17 Dec 2024
 23:43:19 -0800 (PST)
Date: Tue, 17 Dec 2024 23:43:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67627d17.050a0220.29fcd0.0088.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING: held lock freed in bt_accept_dequeue
From: syzbot <syzbot+4c5f0c6f8cc60159bdbf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    243f750a2df0 Merge tag 'gpio-fixes-for-v6.13-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149edbe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=4c5f0c6f8cc60159bdbf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-243f750a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3ec11e872fc/vmlinux-243f750a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d9df37410c95/bzImage-243f750a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c5f0c6f8cc60159bdbf@syzkaller.appspotmail.com

=========================
WARNING: held lock freed!
6.13.0-rc2-syzkaller-00192-g243f750a2df0 #0 Not tainted
-------------------------
syz.0.39/6085 is freeing memory ffff88806780b000-ffff88806780b7ff, with a lock still held there!
ffff88806780b258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
ffff88806780b258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: bt_accept_dequeue+0x249/0x600 net/bluetooth/af_bluetooth.c:276
2 locks held by syz.0.39/6085:
 #0: ffff888066585008 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #0: ffff888066585008 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release+0x86/0x270 net/socket.c:639
 #1: ffff88806780b258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #1: ffff88806780b258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: bt_accept_dequeue+0x249/0x600 net/bluetooth/af_bluetooth.c:276

stack backtrace:
CPU: 3 UID: 0 PID: 6085 Comm: syz.0.39 Not tainted 6.13.0-rc2-syzkaller-00192-g243f750a2df0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_freed_lock_bug kernel/locking/lockdep.c:6662 [inline]
 debug_check_no_locks_freed+0x208/0x2b0 kernel/locking/lockdep.c:6697
 slab_free_hook mm/slub.c:2281 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0xe5/0x4b0 mm/slub.c:4761
 sk_prot_free net/core/sock.c:2201 [inline]
 __sk_destruct+0x5eb/0x720 net/core/sock.c:2293
 sk_destruct+0xc2/0xf0 net/core/sock.c:2308
 __sk_free+0xf4/0x3e0 net/core/sock.c:2319
 sk_free+0x6a/0x90 net/core/sock.c:2330
 sock_put include/net/sock.h:1904 [inline]
 bt_accept_unlink+0x245/0x2e0 net/bluetooth/af_bluetooth.c:259
 bt_accept_dequeue+0x517/0x600 net/bluetooth/af_bluetooth.c:305
 l2cap_sock_cleanup_listen+0x5c/0x2a0 net/bluetooth/l2cap_sock.c:1439
 l2cap_sock_release+0x5c/0x210 net/bluetooth/l2cap_sock.c:1413
 __sock_release+0xb0/0x270 net/socket.c:640
 sock_close+0x1c/0x30 net/socket.c:1408
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7ff5579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff8596dc EFLAGS: 00000202 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000000001e
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_lock+0x271/0x2c0 kernel/locking/spinlock_debug.c:115
Read of size 4 at addr ffff88806780b1c4 by task syz.0.39/6085

CPU: 3 UID: 0 PID: 6085 Comm: syz.0.39 Not tainted 6.13.0-rc2-syzkaller-00192-g243f750a2df0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x271/0x2c0 kernel/locking/spinlock_debug.c:115
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 release_sock+0x21/0x220 net/core/sock.c:3635
 bt_accept_dequeue+0x505/0x600 net/bluetooth/af_bluetooth.c:309
 l2cap_sock_cleanup_listen+0x5c/0x2a0 net/bluetooth/l2cap_sock.c:1439
 l2cap_sock_release+0x5c/0x210 net/bluetooth/l2cap_sock.c:1413
 __sock_release+0xb0/0x270 net/socket.c:640
 sock_close+0x1c/0x30 net/socket.c:1408
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7ff5579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff8596dc EFLAGS: 00000202 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000000001e
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5953:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x21a/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2165
 sk_alloc+0x36/0xb90 net/core/sock.c:2218
 bt_sock_alloc+0x3b/0x3a0 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc.constprop.0+0x33/0x1c0 net/bluetooth/l2cap_sock.c:1879
 l2cap_sock_new_connection_cb+0x101/0x240 net/bluetooth/l2cap_sock.c:1470
 l2cap_connect_cfm+0x85f/0xf10 net/bluetooth/l2cap_core.c:7263
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_remote_features_evt+0x5aa/0xa30 net/bluetooth/hci_event.c:3726
 hci_event_func net/bluetooth/hci_event.c:7473 [inline]
 hci_event_packet+0x9eb/0x1190 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x2c5/0x16b0 net/bluetooth/hci_core.c:4035
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 6085:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 sk_prot_free net/core/sock.c:2201 [inline]
 __sk_destruct+0x5eb/0x720 net/core/sock.c:2293
 sk_destruct+0xc2/0xf0 net/core/sock.c:2308
 __sk_free+0xf4/0x3e0 net/core/sock.c:2319
 sk_free+0x6a/0x90 net/core/sock.c:2330
 sock_put include/net/sock.h:1904 [inline]
 bt_accept_unlink+0x245/0x2e0 net/bluetooth/af_bluetooth.c:259
 bt_accept_dequeue+0x517/0x600 net/bluetooth/af_bluetooth.c:305
 l2cap_sock_cleanup_listen+0x5c/0x2a0 net/bluetooth/l2cap_sock.c:1439
 l2cap_sock_release+0x5c/0x210 net/bluetooth/l2cap_sock.c:1413
 __sock_release+0xb0/0x270 net/socket.c:640
 sock_close+0x1c/0x30 net/socket.c:1408
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff88806780b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 452 bytes inside of
 freed 2048-byte region [ffff88806780b000, ffff88806780b800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x67808
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801ac42f00 ffffea00019a8600 dead000000000002
raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 04fff00000000040 ffff88801ac42f00 ffffea00019a8600 dead000000000002
head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 04fff00000000003 ffffea00019e0201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5945, tgid 5945 (syz-executor), ts 45957452176, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __kmalloc_cache_noprof+0xf6/0x420 mm/slub.c:4324
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 nsim_bus_dev_new drivers/net/netdevsim/bus.c:425 [inline]
 new_device_store+0x207/0x730 drivers/net/netdevsim/bus.c:173
 bus_attr_store+0x71/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88806780b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806780b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806780b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88806780b200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806780b280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
