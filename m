Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994F1E3788
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059646; cv=none; b=H8TP/Fxiy1U5/zI3T3LjyG7LxqCSMfQNEg+q6C3NTJ1AdcPAx0PfyMYUiNVgz368FT7BZOjYQEN4TO1CWtc1mX40Kc1owFNmq2amXg38RumECnAog67MBaGo78ZfecH86v89zA0icTN42eYdr+yC2Q2dPeyq04bd3a8PI0S+WYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059646; c=relaxed/simple;
	bh=luGiNjfAqRML657SA23qiUMPysQi+9kCMMN/lkgsqys=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KBujApTV1N1uRxcX8tsNPhCh7acLvTgfLkfg5vOuHg4cxIZ9Qz/Kqyw9CUDz8+OZ+iJJpj/dtFwcCVyl8eNx8cSNQcz+X2ToOblNp56oabNhT+tCCtzIFcw//bMpfSVoMDikfAyxAh0L9p4cyGnI0GHBNXZx+E/stHfI2VDCxaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a363981933so29067745ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 09:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059644; x=1728664444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/aQhE9ajfh9pOWYTaT4IkwwQwIV7zv/+D/iOH9uDmY=;
        b=ItqNcsR6287BmpCbtz66rHD33GG0KXPbTuQlpFHPSm3kWFc/cCg3v/CxVhzgtUmogm
         xDxs+ybk+iGcS3x6ttVIHnITb+++/0rIYHCQYvq1XpRqHuQi3f9MU9xjDB0O7qzZ45HJ
         +oxGBPvL0yXMBm1G5DGlWh+9jIL8+tg6SEPuiGm2y2ywefCAslR5UtdvyvfqhyGiWI30
         EVzqCyCkQEvI6uXoQZA6hwy1hCdj3x45TS270jGOry2+0N4dEhMbBoleHXYwL/ziWOU6
         qUC6zNZgbpAvMzimEs508p8YJ8Nsp4S/5DQ05fV7EseZOIUKKnLdskPPTsRyOYuXHBBb
         P51w==
X-Gm-Message-State: AOJu0Yybh2aoXkmyZtgA042rytQntCf9jiq35IVfZ1fWyX7ts0frO7te
	knOSp6gPj7oR34jzkSdfnF0Ia4ff0klpvO1X1z0n6q7BLdgXi1ozSaWNpUHhlv50EDpNG6MQN8x
	HEcOADB7BKmgSSoCE1YV3I10ezuNRdA7SLBOlJetY2RlO7Qcbi9EFkQU=
X-Google-Smtp-Source: AGHT+IE9gqXYOwjYD7YvrcThcBj/MTXysQ/Xx1poFCbrowpZOuU3E451qbs5LHzGBFWVhyJi9cPjDNd5JMabBqlcHL4amq1qR8b/
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0a:b0:3a2:7651:9864 with SMTP id
 e9e14a558f8ab-3a375b99555mr33699345ab.12.1728059643928; Fri, 04 Oct 2024
 09:34:03 -0700 (PDT)
Date: Fri, 04 Oct 2024 09:34:03 -0700
In-Reply-To: <CABBYNZ+i88jmqD3pV2Czh=7fBhZ0_73s1+tsumt0+oVo8kSm1w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670018fb.050a0220.49194.0492.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in sco_conn_del

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:781 [inline]
BUG: KASAN: slab-use-after-free in sco_conn_del+0x9a/0x2c0 net/bluetooth/sco.c:227
Write of size 4 at addr ffff88801f485080 by task kworker/u9:1/4491

CPU: 0 UID: 0 PID: 4491 Comm: kworker/u9:1 Not tainted 6.12.0-rc1-syzkaller-00125-g0c559323bbaa-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 sock_hold include/net/sock.h:781 [inline]
 sco_conn_del+0x9a/0x2c0 net/bluetooth/sco.c:227
 sco_connect_cfm+0xe6/0xb40 net/bluetooth/sco.c:1381
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1d0/0x300 net/bluetooth/hci_conn.c:1262
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5586
 hci_cmd_sync_work+0x22d/0x400 net/bluetooth/hci_sync.c:328
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5576:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4265 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2164
 sk_alloc+0x38/0x370 net/core/sock.c:2217
 bt_sock_alloc+0x3c/0x340 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:517 [inline]
 sco_sock_create+0xbb/0x390 net/bluetooth/sco.c:548
 bt_sock_create+0x163/0x230 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x492/0x920 net/socket.c:1576
 sock_create net/socket.c:1627 [inline]
 __sys_socket_create net/socket.c:1664 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1711
 __do_sys_socket net/socket.c:1725 [inline]
 __se_sys_socket net/socket.c:1723 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1723
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5577:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4728
 sk_prot_free net/core/sock.c:2200 [inline]
 __sk_destruct+0x479/0x5f0 net/core/sock.c:2292
 sco_sock_release+0x25e/0x320 net/bluetooth/sco.c:1276
 __sock_release net/socket.c:658 [inline]
 sock_close+0xbe/0x240 net/socket.c:1426
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:228
 get_signal+0x15e8/0x1740 kernel/signal.c:2690
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801f485000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff88801f485000, ffff88801f485800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f480
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888015442000 ffffea00007d4800 0000000000000002
raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff888015442000 ffffea00007d4800 0000000000000002
head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00007d2001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5098, tgid 5098 (syz-executor.0), ts 63096504293, free_ts 61414295203
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kmalloc_array_noprof include/linux/slab.h:923 [inline]
 cache_create_net+0x83/0x270 net/sunrpc/cache.c:1743
 nfsd_idmap_init+0xe8/0x1e0 fs/nfsd/nfs4idmap.c:476
 nfsd_net_init+0x4b/0x450 fs/nfsd/nfsctl.c:2242
 ops_init+0x320/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
page last free pid 5088 tgid 5085 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2678 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3146
 put_cpu_partial+0x17c/0x250 mm/slub.c:3221
 __slab_free+0x2ea/0x3d0 mm/slub.c:4450
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2033 [inline]
 tomoyo_supervisor+0xe0d/0x11f0 security/tomoyo/common.c:2105
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission+0x243/0x360 security/tomoyo/file.c:587
 tomoyo_path_perm+0x480/0x740 security/tomoyo/file.c:838
 security_inode_getattr+0x130/0x330 security/security.c:2371
 vfs_getattr+0x45/0x430 fs/stat.c:204
 vfs_statx_path fs/stat.c:251 [inline]
 vfs_statx+0x199/0x490 fs/stat.c:315
 vfs_fstatat+0x145/0x190 fs/stat.c:341
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499

Memory state around the buggy address:
 ffff88801f484f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801f485000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801f485080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801f485100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f485180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         0c559323 Merge tag 'rust-fixes-6.12' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fdb3d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0ca089c3fc6b54e
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160db3d0580000

