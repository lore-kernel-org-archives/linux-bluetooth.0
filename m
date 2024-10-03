Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571101A7263
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974386; cv=none; b=KpTBI66GFSRMrnd3qllktK4sFLrRx2gDoKYaug3vY+YzwueqtR/ki+jHE76cWWpFLcnoCjjRiYB2XHItcyWq4HWlYgi3QoTzG3h4BqoTdxIB3NChRK7ki/RSLabMLQKe0VWKlrSfbF/nwxrnnsceZI25BxeuOZRJc4nS8mkfPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974386; c=relaxed/simple;
	bh=zFrC2FnuXXN+Yr7YYG8BpOyLovInPFEBPL9MCUoIbTw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RVxcWkKIr6JnH3q8P8gaJU5Q5Ea0kue5j9J6rGEnf7pBIUgazMNkygU02t7jrF+t7rwipy30z9GI8nEeVLHHwwbABFSkpDvb4HNkMmbOutmDI87sBz0Ovb37LJ6jLjwOticMYu1K5dLYT51LABTkRQ1tw18+b3g0lqcixIJq9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3466d220dso12720555ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2024 09:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974383; x=1728579183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF2wAzgXzC5rat6G/PZ6FcEqUibQthWMV1dmo4Bz3kI=;
        b=ogdI43zYnQC0tkMkWFmv/NjO5I/Xtn3jqBF8+hkBI2XB9ooyBlLIFSIIMVN3gKQutA
         M8FeXppNHDTKj4IcFOjPjYC+gYIWLgnb7VagzwKKYqZwPN4klOYSh7CkIZ7iIFtwaSeY
         LeLh0B11qtoAn8O5GVgmHzXtDe7ejpkMi7tW4GZEJBkefob1qRDVY+crpq9uxAcOx5+T
         b2QiATGt3ZlHvb3SfKC3bZ8rijrxRcMOM7S5I9BEJ2CLfuK3bRPsz8sQKnMsplfh3wCi
         ajNWUpq2ThPVhisNZzT8QAf25nhvBUoRyTX3xZ5m1e/RhoJQ29HddBqmtJCntoTh76rh
         WdNA==
X-Gm-Message-State: AOJu0YxgvOJNuYxCstU4kXg13M/W7wILczxB4eThgWIzgqoLREHAultR
	3hl0/NURDfuHSyHddIBkNIlPegLKhAS8EAi9j9JO6h8btkKMnl7Huf8jMasLG9wjjqEepSPYLV9
	csRnCwIFjklkJoxRLljVHFUD1UfQ9X2a7BvSs4xEUgb0S+AHqo7vy1H0=
X-Google-Smtp-Source: AGHT+IGVhQ4ZygX5BEk4Ls1litXLr/CX8CmJyTe7D+lPwZDGW1VR9KBLKS5rCBg+UGexeAJfHGP0Ge03ArPuMWvXIRXPuPLTXCvd
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1946:b0:3a0:b384:219b with SMTP id
 e9e14a558f8ab-3a36595ae87mr67138345ab.26.1727974383577; Thu, 03 Oct 2024
 09:53:03 -0700 (PDT)
Date: Thu, 03 Oct 2024 09:53:03 -0700
In-Reply-To: <CABBYNZJGF4156YhdOH5DoZ7hkh1NTrpQwntwJZiYJ9AyHYr14w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fecbef.050a0220.9ec68.004e.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in sco_sock_destruct

==================================================================
BUG: KASAN: slab-use-after-free in sco_conn_destruct net/bluetooth/sco.c:167 [inline]
BUG: KASAN: slab-use-after-free in sco_sock_destruct+0xb9/0x170 net/bluetooth/sco.c:409
Write of size 8 at addr ffff88807926cfe8 by task syz-executor.0/5580

CPU: 0 UID: 0 PID: 5580 Comm: syz-executor.0 Not tainted 6.12.0-rc1-syzkaller-g7ec462100ef9-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 sco_conn_destruct net/bluetooth/sco.c:167 [inline]
 sco_sock_destruct+0xb9/0x170 net/bluetooth/sco.c:409
 __sk_destruct+0x5a/0x5f0 net/core/sock.c:2259
 sco_sock_release+0x25e/0x320 net/bluetooth/sco.c:1261
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
RIP: 0033:0x7f16c9a7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f16ca8910c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007f16c9babf80 RCX: 00007f16c9a7de69
RDX: 0000000000000008 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00007f16c9aca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f16c9babf80 R15: 00007ffceef62378
 </TASK>

Allocated by task 5580:
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
 sco_connect net/bluetooth/sco.c:281 [inline]
 sco_sock_connect+0x2fc/0x990 net/bluetooth/sco.c:598
 __sys_connect_file net/socket.c:2066 [inline]
 __sys_connect+0x2d3/0x300 net/socket.c:2083
 __do_sys_connect net/socket.c:2093 [inline]
 __se_sys_connect net/socket.c:2090 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2090
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 54:
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
 sco_chan_del net/bluetooth/sco.c:190 [inline]
 __sco_sock_close+0x22b/0x430 net/bluetooth/sco.c:461
 sco_sock_close net/bluetooth/sco.c:476 [inline]
 sco_sock_release+0xb3/0x320 net/bluetooth/sco.c:1251
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

The buggy address belongs to the object at ffff88807926c000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4072 bytes inside of
 freed 8192-byte region [ffff88807926c000, ffff88807926e000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79268
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888015442280 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080020002 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff888015442280 0000000000000000 0000000000000001
head: 0000000000000000 0000000080020002 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0001e49a01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4757, tgid 4757 (start-stop-daem), ts 32264510159, free_ts 32243341192
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
page last free pid 4757 tgid 4757 stack trace:
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
 load_elf_phdrs fs/binfmt_elf.c:526 [inline]
 load_elf_binary+0x2eb/0x2710 fs/binfmt_elf.c:855
 search_binary_handler fs/exec.c:1752 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xafa/0x1770 fs/exec.c:1845
 do_execveat_common+0x55f/0x6f0 fs/exec.c:1952
 do_execve fs/exec.c:2026 [inline]
 __do_sys_execve fs/exec.c:2102 [inline]
 __se_sys_execve fs/exec.c:2097 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2097
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807926ce80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807926cf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807926cf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807926d000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807926d080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         7ec46210 Merge tag 'pull-work.unaligned' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e97580580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0ca089c3fc6b54e
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f17580580000

