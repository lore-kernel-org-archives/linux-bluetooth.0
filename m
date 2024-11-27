Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F9201254
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733967; cv=none; b=g4OvEwdbQ1RpnPFabYWDHHPvoDS+7XRkdyRFTjQ/yXbgIz/V7bx9VWeSmjYnvtJQ6qpHm9bvTb1mdAQHXCbqYzEey/SjJdNqWodChZbw7ozZgRXWeWj/rZH2RmRHByRCUP9BfIlRxECsM2jeEufxI19uMM2S6nl4kc3OIVbCgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733967; c=relaxed/simple;
	bh=Zr0rW7hyNsyuoLzd5Wt+hgcnA/UJFzhXmvwHwx8L6d4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MEIfoyfkVxemy0k1enI5DYmddooQCGFyDUkf7DqCCesxQrm4ubV+Cf/YgCdAXJWQmgBn8Hnymn+bQYyjDwoAjldoHNaABrXTCL1TAz1JzAxwHXp54gJ51IG5LJ8wLL+lvjjTo5lbET76jpg50peJSKIsBFH8iVBbxvV2QiI5tQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77d56e862so84375ab.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 10:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733965; x=1733338765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31CABdibbDR2ILRNEa1U0QyGnU5KUtATg6N06rcwXbA=;
        b=JIxF/zVBlaDcVUStF1tsALqVe4JmvMKRL8l31JOPeL5gx4v2fv4XMd8GgTslJMggHn
         kUaLf/9w7R4U7Ph5MkR+yYO1PoRDnUqnCSrSEZxGap9FfPNgOUQ+wU7hUppwIA5jGfiy
         0kB+ECIJm9wj4I5z3gVibevE4gyt6hXsEswkHAIlh3C9Ap9RvbYOdnwln4pbP7etNuVk
         6tMisbtq8Ye+6Zqf90BUHhy/su1Y1371v329+0Z5JAiRh0e6NxdkH0Hqz3n/Hmx6RVmA
         vSSB6Mcqq2DMVgcQnnH2L6/zhilv94yKCFOJx+9L3DwLJqwUV0wc0Fk+10Y8gGtO771m
         3UCg==
X-Forwarded-Encrypted: i=1; AJvYcCX6oWYPYEhWA5+DLKRrPIe0ejgd0DnrBDh8Toa/JvfHChoqWFZzRMu6eTbNm35InMpnKwJUTcZEuzjHMTOplQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6G8IrdH+jSE4XL4PFgZf4S3Bj2hKoza0biYYNI0NG+u0M3AZX
	gyrHAfOc00egvSM17zC/uPyVhQoRpKevfWy+hx4smHUcW19kG2NnDVXvP7ijA6oHLd3lLJPpa1m
	4O0NsVFC5CSerGdDotblPtkr4sQcmWVe0uHGVGgOrc7Bxdha0kN7uJV8=
X-Google-Smtp-Source: AGHT+IG4zLhuSxBnqjKSBHmrVB7WS17KayS2Pyo0fzZ1k9amKhSuBrPW5llxFZjm8qThbEFlimDzQA127Lkn3sr2jXBglPOCv/KV
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3312:b0:3a7:c5b1:a55f with SMTP id
 e9e14a558f8ab-3a7c5b1a78bmr39560095ab.0.1732733965344; Wed, 27 Nov 2024
 10:59:25 -0800 (PST)
Date: Wed, 27 Nov 2024 10:59:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67476c0d.050a0220.253251.005d.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __timer_delete
From: syzbot <syzbot+9f9ccb1c9235f3d44d53@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c22dc1ee3a1 Merge tag 'mailbox-v6.13' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12143778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df9bf3383f5970
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9ccb1c9235f3d44d53
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15184f5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16143778580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9137c3e19e21/disk-2c22dc1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1aad80837d89/vmlinux-2c22dc1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d7979d71d6d2/bzImage-2c22dc1e.xz

The issue was bisected to:

commit e6720779ae612a14ac4ba7fe4fd5b27d900d932c
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Oct 1 19:46:10 2024 +0000

    Bluetooth: SCO: Use kref to track lifetime of sco_conn

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d47778580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15d47778580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11d47778580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f9ccb1c9235f3d44d53@syzkaller.appspotmail.com
Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")

==================================================================
BUG: KASAN: slab-use-after-free in timer_is_static_object+0x35/0x80 kernel/time/timer.c:733
Read of size 8 at addr ffff888027af7ea0 by task syz-executor215/15489

CPU: 1 UID: 0 PID: 15489 Comm: syz-executor215 Not tainted 6.12.0-syzkaller-09435-g2c22dc1ee3a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 timer_is_static_object+0x35/0x80 kernel/time/timer.c:733
 lookup_object_or_alloc lib/debugobjects.c:679 [inline]
 debug_object_assert_init+0x236/0x4b0 lib/debugobjects.c:1008
 debug_timer_assert_init kernel/time/timer.c:845 [inline]
 debug_assert_init kernel/time/timer.c:890 [inline]
 __timer_delete+0xad/0x380 kernel/time/timer.c:1412
 del_timer include/linux/timer.h:202 [inline]
 try_to_grab_pending kernel/workqueue.c:2064 [inline]
 work_grab_pending+0x157/0xae0 kernel/workqueue.c:2157
 __cancel_work+0xbb/0x390 kernel/workqueue.c:4322
 sco_sock_clear_timer net/bluetooth/sco.c:180 [inline]
 sco_sock_shutdown+0x155/0x3f0 net/bluetooth/sco.c:1273
 __sys_shutdown_sock net/socket.c:2423 [inline]
 __sys_shutdown net/socket.c:2439 [inline]
 __do_sys_shutdown net/socket.c:2444 [inline]
 __se_sys_shutdown net/socket.c:2442 [inline]
 __x64_sys_shutdown+0x13f/0x1a0 net/socket.c:2442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8530977559
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f853010d208 EFLAGS: 00000246 ORIG_RAX: 0000000000000030
RAX: ffffffffffffffda RBX: 00007f8530a07198 RCX: 00007f8530977559
RDX: 00007f8530952796 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f8530a07190 R08: 00007ffd066c2117 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f85309ce2c0
R13: 00007f8530a0719c R14: 00007ffd066c2030 R15: 00007ffd066c2118
 </TASK>

Allocated by task 15453:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 sco_conn_add+0xa7/0x360 net/bluetooth/sco.c:199
 sco_connect net/bluetooth/sco.c:336 [inline]
 sco_sock_connect+0x323/0x990 net/bluetooth/sco.c:645
 __sys_connect_file net/socket.c:2055 [inline]
 __sys_connect+0x288/0x2d0 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15473:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x420 mm/slub.c:4746
 sco_chan_del+0xa3/0x180 net/bluetooth/sco.c:236
 sco_sock_shutdown+0x164/0x3f0 net/bluetooth/sco.c:1274
 __sys_shutdown_sock net/socket.c:2423 [inline]
 __sys_shutdown net/socket.c:2439 [inline]
 __do_sys_shutdown net/socket.c:2444 [inline]
 __se_sys_shutdown net/socket.c:2442 [inline]
 __x64_sys_shutdown+0x13f/0x1a0 net/socket.c:2442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888027af7e00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 160 bytes inside of
 freed 256-byte region [ffff888027af7e00, ffff888027af7f00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27af6
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac41b40 ffffea0000c24d80 dead000000000006
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac41b40 ffffea0000c24d80 dead000000000006
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000001 ffffea00009ebd81 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 7753338606, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x363e/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 bus_add_driver+0x163/0x670 drivers/base/bus.c:659
 driver_register+0x23a/0x320 drivers/base/driver.c:246
 do_one_initcall+0x248/0x880 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888027af7d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888027af7e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888027af7e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888027af7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888027af7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
