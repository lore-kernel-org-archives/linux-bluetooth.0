Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719719F42F
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970905; cv=none; b=GYD1tsmTqU/qiH1iW4t9z2kriCMuABw65XhDQkxFgnL6uvtk71/qOHK8PZiygz2tHLrv50LGXckPWfAMbd5BFVO78MOi6KgD8a+84HQi+ur4B6v9uR3lvuIdLy2ndixfbCD7t7qbNr7t2X5tSFDFfub6tOtl2FQbmGkNY7EEU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970905; c=relaxed/simple;
	bh=Rjam4N9XElTuCl8k0v0e3NlkET0xKgDBzqll595pSC0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QfSvsv6NeAzmEIMtUOdlQuTi/c/edY1nLKAx2mxKJZDlKZ18w85SF1zKviNtD8dX2e0SivTzxxJjBj1BG0juVc3fg8SqLebV9XHydbPNk7cpFUx4Jno5hzZ7URTxsxlIFmStU4rSFqFle6VLLlfNP/OdBV3YhmidRO82HAISErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3466d220dso12106115ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2024 08:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970903; x=1728575703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6gla1t8GwMuhtXRHdzB8lYJVs59JxbelzMstEOFi0w=;
        b=UY5YL+b1QDaZ0j7ZvDFd79I7Bh+ETVYpAosBYyQE+ewFHp7DLQRjSnvDKsXGbOqOwL
         xgQhwU58jr47AzXbSBW4u7xOlBop+M/rMGlPB6pLiLDJ5mqUEa3TqxRoWRXaXGewX7V9
         KyE2MnWcBFsDZGCJLm0bdy1BHPH3CqmZJpLsZlH2lLzf7dmukiAwCmht5S3hkGJS5tNz
         aM6Axt7EfqDKF1TXOqNHeUxiCuBfsS955uNa2yllKkD3/e6/gpAgzBq+vyjTOfcYrSSp
         84iFZZbXtQBbRxCw/YBnSAcsHTjMph36HPztzxJplwChYoOwS/cpENXvoCu5G6VIzkNp
         FD6g==
X-Gm-Message-State: AOJu0YxARmNqrUFvKhsGGBLL2k3xuxNBj0tmV0JUTjyvp/wLVFQAeM62
	x/zq87qNK18z+kXZRotGGAiWKao5h8yjaOY9MU8yINlFuFL8mzWhHzvqmlIN1ZziL6PgPKz1Gmb
	Gp84OlVXivAUU3WPwXTehWN+3Dunu2WEjJBUwxBo7h0DXEn6wJtcqrzo=
X-Google-Smtp-Source: AGHT+IEf15kQnhzM/6hRNaE+lgS/TtGW4YTYw6O9TIFkMPxbJc8zKtMJ0q8XkVDqM4OGo2TiqyLc8atehgI/nQUBcK+w8DYkiHLN
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a3:63c3:352e with SMTP id
 e9e14a558f8ab-3a365944538mr74060575ab.19.1727970902680; Thu, 03 Oct 2024
 08:55:02 -0700 (PDT)
Date: Thu, 03 Oct 2024 08:55:02 -0700
In-Reply-To: <CABBYNZJLj6gSa-1prGM5aLKTJbFJo5mxxJkBU=WoqEx-P6TdOA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66febe56.050a0220.9ec68.0045.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in hci_conn_drop

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop+0x34/0x280 include/net/bluetooth/hci_core.h:1548
Write of size 4 at addr ffff88801ea58010 by task syz-executor.0/5537

CPU: 0 UID: 0 PID: 5537 Comm: syz-executor.0 Not tainted 6.12.0-rc1-syzkaller-g7ec462100ef9-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
 hci_conn_drop+0x34/0x280 include/net/bluetooth/hci_core.h:1548
 sco_conn_destruct+0x57/0x100 net/bluetooth/sco.c:166
 sco_sock_destruct+0x43/0x90 net/bluetooth/sco.c:407
 __sk_destruct+0x5a/0x5f0 net/core/sock.c:2259
 sco_sock_release+0x25e/0x320 net/bluetooth/sco.c:1259
 __sock_release net/socket.c:658 [inline]
 sock_close+0xbe/0x240 net/socket.c:1426
 __fput+0x241/0x880 fs/file_table.c:431
 __do_sys_close fs/open.c:1565 [inline]
 __se_sys_close fs/open.c:1550 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1550
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa71cc7cd5a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffc91af2860 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fa71cc7cd5a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fa71cdad980 R08: 0000001b2d160000 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000016f8e
R13: ffffffffffffffff R14: 00007fa71c800000 R15: 0000000000016c4d
 </TASK>

Allocated by task 5455:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4296
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 __hci_conn_add+0x2f9/0x1850 net/bluetooth/hci_conn.c:932
 hci_conn_add_unset net/bluetooth/hci_conn.c:1041 [inline]
 hci_connect_sco+0xd0/0x370 net/bluetooth/hci_conn.c:1689
 sco_connect net/bluetooth/sco.c:279 [inline]
 sco_sock_connect+0x2fc/0x990 net/bluetooth/sco.c:596
 __sys_connect_file net/socket.c:2066 [inline]
 __sys_connect+0x2d3/0x300 net/socket.c:2083
 __do_sys_connect net/socket.c:2093 [inline]
 __se_sys_connect net/socket.c:2090 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2090
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 4494:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4728
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 hci_conn_cleanup net/bluetooth/hci_conn.c:174 [inline]
 hci_conn_del+0x8c4/0xc40 net/bluetooth/hci_conn.c:1160
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5586
 hci_cmd_sync_work+0x22d/0x400 net/bluetooth/hci_sync.c:328
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 queue_delayed_work_on+0x1ca/0x390 kernel/workqueue.c:2552
 sco_conn_destruct+0x57/0x100 net/bluetooth/sco.c:166
 sco_sock_destruct+0x43/0x90 net/bluetooth/sco.c:407
 __sk_destruct+0x5a/0x5f0 net/core/sock.c:2259
 sco_sock_release+0x25e/0x320 net/bluetooth/sco.c:1259
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

The buggy address belongs to the object at ffff88801ea58000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 16 bytes inside of
 freed 8192-byte region [ffff88801ea58000, ffff88801ea5a000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ea58
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888015442280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080020002 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff888015442280 0000000000000000 dead000000000001
head: 0000000000000000 0000000080020002 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00007a9601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4772, tgid 4772 (dhcpcd-run-hook), ts 33884825404, free_ts 32631813811
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
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4291
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0x11cd/0x2050 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x38a/0x11f0 security/tomoyo/common.c:2099
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x146e/0x1d40 security/tomoyo/domain.c:881
 tomoyo_bprm_check_security+0x114/0x180 security/tomoyo/hooks.h:76
 security_bprm_check+0x86/0x250 security/security.c:1296
 search_binary_handler fs/exec.c:1740 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xa56/0x1770 fs/exec.c:1845
page last free pid 4743 tgid 4743 stack trace:
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
 __kmalloc_cache_noprof+0x132/0x2c0 mm/slub.c:4291
 kmalloc_noprof include/linux/slab.h:878 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x1ca/0x2050 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x38a/0x11f0 security/tomoyo/common.c:2099
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission+0x243/0x360 security/tomoyo/file.c:587
 tomoyo_path_perm+0x480/0x740 security/tomoyo/file.c:838
 security_inode_getattr+0x130/0x330 security/security.c:2371
 vfs_getattr+0x45/0x430 fs/stat.c:204
 vfs_fstat fs/stat.c:229 [inline]
 vfs_fstatat+0xe4/0x190 fs/stat.c:338
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499

Memory state around the buggy address:
 ffff88801ea57f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801ea57f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801ea58000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88801ea58080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801ea58100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         7ec46210 Merge tag 'pull-work.unaligned' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114d5527980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0ca089c3fc6b54e
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15355527980000

