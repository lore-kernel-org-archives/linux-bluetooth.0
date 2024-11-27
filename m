Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E24367
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732666054; cv=none; b=ifmgsYTtVehneTwk9KonIU6ySDr/CSys2zjEQQE6qy07qXqsv43MAhKZ+JK1C11lQJXBQudXZWg0S4h1oHH0k1pBgj0zRjvXrxeIRpubcP5+brNPJIwMqLopFTEy1bykBBe8z4e0PrCtD8Z0lFmsFaTcqJW8g41pIw3GLDMko2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732666054; c=relaxed/simple;
	bh=cCSVB87Oybt0Feurx/hAmK32cFXozy+EqGOQj4l5hWg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sBCrq70ER8CE3VZURiODI7wbAtMiFCwHzW2Y7SSAHKa654j34ZGZP9uOAduRvZ4GMbjUb+8dUWAqRWwaPdG2OT2oXrIhwewC/7X49htxCS65py9I7M48lG6S4czNz0fctd/7VZTCXXM0otNJFsUwdoaqLff6u6K6bb/e9IcuNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a777d47a8eso73583875ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 16:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732666051; x=1733270851;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VB6vI+nokYY9Inszc0TQur4AzhYeyReUOU/6+4yz1bA=;
        b=YDQJnuvDpoflIQwfIkgv7Vx0XE9f0hl0Eay85kl2udd5eLMRc0NAdZezEtaD5PeQWH
         KArRBFIOiiCpILUMmUbrYK6LDSlds2rnWYXEMjJfSZQmQnUioIpNOgIVaFMx9fEWMkSO
         20sx6GVLurxTQmH8pDopLQPtch2qV9KdXIhdQbwtfLxALH4gcpgZv5QkAatOl8wu0Y4H
         7p0cOpXY0AtkZHUrpWodIDt5jfdrohRdQSCCbdtCLeXmsXGx16Z4vF6OW9iThgsl6daC
         u1NEk6z7obRiJ9V0nObbA3oilTR0mHczerTguDbvr28j9Po5vJ2OhEghIe4rsWM8Zhs4
         v5nA==
X-Forwarded-Encrypted: i=1; AJvYcCXmAP05bVzB3HEPTOPvp76swGGUTOYWwO3H0zONXNY6pDFR7ZA7s3V1VmCqseKimP9+g4A+FKjg8VduZ0g7ocg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjPQX5M8qLceCQ7WYmGJpBu/Gy7RVM4bHMS7xVtORL094GBIu
	5xNZnjvKdWUPtaPkh8+KwT5aNlZnAmM3LlPf8QNu+HDdg4tCx5EEjKilhJWo14PkNEegGgQC3d6
	kq4Q6zvS5Up5XVpzFHeHtavC/kT7ixpHywE1hDgNEum1UyVwivPJdGyE=
X-Google-Smtp-Source: AGHT+IE/Sf74V4uq61Mbov7vEgEgJnN2LHDI+uBV4Isy68C2VmCUHyHe2ny/repkcRTsME2YnnPY7g4ypwTLyksmVOMQ86cVVswk
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178c:b0:3a7:8149:6aa with SMTP id
 e9e14a558f8ab-3a7c55fc480mr10455615ab.24.1732666051572; Tue, 26 Nov 2024
 16:07:31 -0800 (PST)
Date: Tue, 26 Nov 2024 16:07:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674662c3.050a0220.1286eb.0025.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 lookup_object_or_alloc (2)
From: syzbot <syzbot+4bab29ea59a63b8b33b1@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28eb75e178d3 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1156fec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2406be795e8a5f4
dashboard link: https://syzkaller.appspot.com/bug?extid=4bab29ea59a63b8b33b1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a3d6e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d656bfec363b/disk-28eb75e1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24f43f097510/vmlinux-28eb75e1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5d84a86858b1/bzImage-28eb75e1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bab29ea59a63b8b33b1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in timer_is_static_object+0x80/0x90 kernel/time/timer.c:733
Read of size 8 at addr ffff88807a901ca0 by task syz.1.23344/23262

CPU: 0 UID: 0 PID: 23262 Comm: syz.1.23344 Not tainted 6.12.0-syzkaller-07749-g28eb75e178d3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 timer_is_static_object+0x80/0x90 kernel/time/timer.c:733
 lookup_object_or_alloc.part.0+0x416/0x590 lib/debugobjects.c:679
 lookup_object_or_alloc lib/debugobjects.c:665 [inline]
 debug_object_assert_init+0x268/0x2f0 lib/debugobjects.c:1008
 debug_timer_assert_init kernel/time/timer.c:845 [inline]
 debug_assert_init kernel/time/timer.c:890 [inline]
 __timer_delete+0x81/0x1c0 kernel/time/timer.c:1412
 del_timer include/linux/timer.h:202 [inline]
 try_to_grab_pending+0x7d/0x850 kernel/workqueue.c:2064
 work_grab_pending kernel/workqueue.c:2157 [inline]
 __cancel_work+0xac/0x370 kernel/workqueue.c:4322
 sco_sock_clear_timer+0x4f/0xe0 net/bluetooth/sco.c:180
 sco_sock_close net/bluetooth/sco.c:522 [inline]
 sco_sock_release+0x67/0x2d0 net/bluetooth/sco.c:1298
 __sock_release+0xb0/0x270 net/socket.c:640
 sock_close+0x1c/0x30 net/socket.c:1408
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 get_signal+0x1d3/0x26c0 kernel/signal.c:2789
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f96dd37e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f96de0aa038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007f96dd535fa0 RCX: 00007f96dd37e819
RDX: 0000000000000008 RSI: 0000000020001580 RDI: 0000000000000004
RBP: 00007f96dd3f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f96dd535fa0 R15: 00007ffcbc3e10f8
 </TASK>

Allocated by task 23070:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 sco_conn_add net/bluetooth/sco.c:199 [inline]
 sco_conn_add+0xc8/0x410 net/bluetooth/sco.c:184
 sco_connect net/bluetooth/sco.c:336 [inline]
 sco_sock_connect+0x325/0xbd0 net/bluetooth/sco.c:645
 __sys_connect_file+0x13e/0x1a0 net/socket.c:2055
 __sys_connect+0x14f/0x170 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 23070:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 sco_conn_free net/bluetooth/sco.c:97 [inline]
 kref_put include/linux/kref.h:65 [inline]
 sco_conn_put+0x2cd/0x4c0 net/bluetooth/sco.c:107
 sco_chan_del+0x9c/0x1b0 net/bluetooth/sco.c:236
 __sco_sock_close+0xab/0x210 net/bluetooth/sco.c:508
 sco_sock_close net/bluetooth/sco.c:523 [inline]
 sco_sock_release+0x6f/0x2d0 net/bluetooth/sco.c:1298
 __sock_release+0xb0/0x270 net/socket.c:640
 sock_close+0x1c/0x30 net/socket.c:1408
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 get_signal+0x1d3/0x26c0 kernel/signal.c:2789
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807a901c00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 160 bytes inside of
 freed 256-byte region [ffff88807a901c00, ffff88807a901d00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88807a900200 pfn:0x7a900
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b041b40 ffff88801b040708 ffffea0001d81190
raw: ffff88807a900200 000000000010000a 00000001f5000000 0000000000000000
head: 00fff00000000240 ffff88801b041b40 ffff88801b040708 ffffea0001d81190
head: ffff88807a900200 000000000010000a 00000001f5000000 0000000000000000
head: 00fff00000000001 ffffea0001ea4001 ffffffffffffffff 0000000000000000
head: ffff888000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5848, tgid 5848 (syz-executor), ts 72198926581, free_ts 72169629294
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 ____ip_mc_inc_group+0x3ee/0x1000 net/ipv4/igmp.c:1468
 __ip_mc_inc_group net/ipv4/igmp.c:1503 [inline]
 ip_mc_inc_group net/ipv4/igmp.c:1509 [inline]
 ip_mc_up+0x154/0x3b0 net/ipv4/igmp.c:1808
 inetdev_event+0xafd/0x18a0 net/ipv4/devinet.c:1638
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8982
 dev_change_flags+0x10c/0x160 net/core/dev.c:9020
 do_setlink.constprop.0+0x69c/0x3f70 net/core/rtnetlink.c:3103
page last free pid 5841 tgid 5841 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4141
 getname_flags.part.0+0x4c/0x550 fs/namei.c:139
 getname_flags include/linux/audit.h:322 [inline]
 getname+0x8d/0xe0 fs/namei.c:223
 do_sys_openat2+0x104/0x1e0 fs/open.c:1396
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807a901b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807a901c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807a901c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88807a901d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807a901d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
