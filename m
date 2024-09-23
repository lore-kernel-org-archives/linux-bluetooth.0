Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF054AEDA
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082144; cv=none; b=ZeHMbUEiQfzU0C9hyw95OLf2JkCLm3+XrnP7s93N17vh/bYq5pBjg4NYhfVw586Jt8B5et01VgSGyXDI6viX2qSTeN5+24HNbYPvw3DKUor84AUpIA/71LR6CVvFWrJ0mBj0E34haMje2osNmiSVj3UBk/LJptXTKch9lmtIgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082144; c=relaxed/simple;
	bh=euqCRnNOI5401CvUM/BzMJR0wqCrCHNBLDOjB/Byv2s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yn8mZZzWIjRs5EmPiXWRbD80Fn6594kQ3ZpSwg9ZMa/BMxXrcz/Ab7orTRfYY/KmB3Q0zcz6fHnMr0Ba5EvChR92akTE0SPH/1RNRmbEmZGDXfjkhRHsZCwllxXWwrm9VjdMYIU5Ea+2bdYRY+IUHzYvaftp1bncTzBy2w6NmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ad9fca5fcso397574539f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 02:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082141; x=1727686941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xplx3+w0ZKIYtT8jhqfA2dJZji00LfeH/7wLt/KOxKI=;
        b=XG21h18ZRVims6vtY9MNMQ4+KP69hns1AhuuJFotudJAg2QT5nLG4Pu7SgaqMdaKQz
         EiT9B6t5k97shFjM2BrghgLdV3BJN49phTqpniapEXGQ7AnUpOILKDY2cfJCAx/n1fmS
         MqlPzoGyROUhQqtqnt4dLSH/FNpN4lHwC0RwqqEunMPe31ibKw1ZqeTUWCMmiypV0k+v
         mb2UM9KXSSAKoltwCas5ntsofIhf5EJPS8kMF8Av9GX7ezMgufvIfQ2fzvCwe57G4DzK
         qQqah1frBx1znkShGc2F3LfnFpLTgohgTx2a6IjTISmACZMWnZOdlnVgOos3FM4W7QdU
         011Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcdC4i7e0w0VOKMWm1VV+Ym/345/3iNn3qhRXHDTl5gvk8KC88mkwWXmRPKpSRdeEna2OJ9i2QgYyQcZ1OC3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+/h04U96j9AXTEpf7HhByXVE+M9Lfr8ugzUrIMbZszTb7vui
	5HwSALw2yjyjHpAHlXMQvmaWxw07uHrvfbxj2XDv0U7sBJ/e5LytOOnpIAttHWdYBwVQXuNXJzM
	tjfCtjv/f31OptLK+K0O+zCCmSAaKO/WeTyz9JNsyE+4Xzd+Coc9uyIY=
X-Google-Smtp-Source: AGHT+IEPAlyB8dgZFgS2scWAHXrdk/xn2HPS08QiKeK7btXvTVv2mg+F9igk8/HLI5TMEX+CfFE4nNiUbdmOzu5i/KqnIIQne+fn
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1383:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a0c8cc9ef9mr80798135ab.15.1727082141572; Mon, 23 Sep 2024
 02:02:21 -0700 (PDT)
Date: Mon, 23 Sep 2024 02:02:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f12e9d.050a0220.3eed3.0008.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sco_chan_del (2)
From: syzbot <syzbot+b70293d0c3fc68076e49@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a940d9a43e62 Merge tag 'soc-arm-6.12' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11959677980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44d46e514184cd24
dashboard link: https://syzkaller.appspot.com/bug?extid=b70293d0c3fc68076e49
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a940d9a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9929bfe422c/vmlinux-a940d9a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6c74ee261ed/bzImage-a940d9a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b70293d0c3fc68076e49@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sco_chan_del+0x460/0x4b0 net/bluetooth/sco.c:174
Read of size 8 at addr ffff88802a8f5600 by task syz.0.1372/8986

CPU: 3 UID: 0 PID: 8986 Comm: syz.0.1372 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 sco_chan_del+0x460/0x4b0 net/bluetooth/sco.c:174
 __sco_sock_close+0xf2/0x640 net/bluetooth/sco.c:459
 sco_sock_close net/bluetooth/sco.c:474 [inline]
 sco_sock_release+0x6f/0x2d0 net/bluetooth/sco.c:1249
 __sock_release+0xb0/0x270 net/socket.c:659
 sock_close+0x1c/0x30 net/socket.c:1427
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 get_signal+0x1ca/0x2770 kernel/signal.c:2690
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6f8957def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6f8a362038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007f6f89736058 RCX: 00007f6f8957def9
RDX: 0000000000000008 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00007f6f895f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f6f89736058 R15: 00007fff399424c8
 </TASK>

Allocated by task 8722:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:690 [inline]
 kzalloc_noprof include/linux/slab.h:816 [inline]
 sco_conn_add.part.0+0x43/0x2d0 net/bluetooth/sco.c:137
 sco_conn_add net/bluetooth/sco.c:266 [inline]
 sco_connect net/bluetooth/sco.c:278 [inline]
 sco_sock_connect+0x6c9/0xb00 net/bluetooth/sco.c:596
 __sys_connect_file+0x14d/0x190 net/socket.c:2067
 __sys_connect+0x149/0x170 net/socket.c:2084
 __do_sys_connect net/socket.c:2094 [inline]
 __se_sys_connect net/socket.c:2091 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2091
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5343:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2250 [inline]
 slab_free mm/slub.c:4474 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4595
 sco_conn_del+0x1d4/0x2a0 net/bluetooth/sco.c:214
 sco_connect_cfm+0x257/0xc10 net/bluetooth/sco.c:1364
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c3/0x340 net/bluetooth/hci_conn.c:1262
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5586
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2914
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802a8f5600
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 0 bytes inside of
 freed 256-byte region [ffff88802a8f5600, ffff88802a8f5700)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a8f4
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac42b40 ffffea0000a54280 dead000000000004
raw: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac42b40 ffffea0000a54280 dead000000000004
head: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000001 ffffea0000aa3d01 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5431, tgid 5429 (syz.2.13), ts 54219801688, free_ts 53733128813
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2319
 allocate_slab mm/slub.c:2482 [inline]
 new_slab+0x84/0x260 mm/slub.c:2535
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3721
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3811
 __slab_alloc_node mm/slub.c:3864 [inline]
 slab_alloc_node mm/slub.c:4026 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_noprof+0x367/0x400 mm/slub.c:4171
 kmalloc_noprof include/linux/slab.h:694 [inline]
 kmalloc_array_noprof include/linux/slab.h:735 [inline]
 security_inode_init_security+0x140/0x390 security/security.c:1823
 shmem_mknod+0xe9/0x240 mm/shmem.c:3432
 shmem_mkdir+0x31/0x60 mm/shmem.c:3486
 vfs_mkdir+0x57d/0x860 fs/namei.c:4257
 do_mkdirat+0x301/0x3a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x83/0xb0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5340 tgid 5340 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3989 [inline]
 slab_alloc_node mm/slub.c:4038 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_node_noprof+0x1c3/0x430 mm/slub.c:4165
 __kvmalloc_node_noprof+0x9d/0x1a0 mm/util.c:650
 xt_jumpstack_alloc net/netfilter/x_tables.c:1355 [inline]
 xt_replace_table+0x1c7/0x910 net/netfilter/x_tables.c:1394
 __do_replace+0x1d9/0x9c0 net/ipv4/netfilter/arp_tables.c:912
 do_replace net/ipv6/netfilter/ip6_tables.c:1158 [inline]
 do_ip6t_set_ctl+0x94b/0xc40 net/ipv6/netfilter/ip6_tables.c:1644
 nf_setsockopt+0x8a/0xf0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x135/0x170 net/ipv6/ipv6_sockglue.c:998
 tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:4029
 do_sock_setsockopt+0x222/0x480 net/socket.c:2330
 __sys_setsockopt+0x1a4/0x270 net/socket.c:2353
 __do_sys_setsockopt net/socket.c:2362 [inline]
 __se_sys_setsockopt net/socket.c:2359 [inline]
 __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2359
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff88802a8f5500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802a8f5580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802a8f5600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802a8f5680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a8f5700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
