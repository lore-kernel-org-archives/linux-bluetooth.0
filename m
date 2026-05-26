Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41F18D636
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777994; cv=none; b=SBjifZEKyhziuP5aUjBK7E13Eq41MfLvDeHsCFzF2AAUH/gg5jTROEmuUqZp45MN5VcpsfMaQHXLLh8mK3Rp2wn9TOg5Fn3kQ/Wr4wkMDnITzKSNzIYBVeZm5ElDeTTgasIbogqG49XT5lfRPzYttjazQbqPOkuNh52tiuJEu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777994; c=relaxed/simple;
	bh=proz3bvmpK+oQ0Lvpfcu0g5cp2K7Ti68TVEU2KsPx/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rdbUFIDyocPJa615HnRXSh+3hsYpbjjaWiUABNBa2eYw2wgPRtTVJQ/CPRKVYbDjg/PX3SMe5TvLd+ZmJbDGHJzpR9Ehf+lCLX+ezSr6J9Vr2junoinVSwP7oXFkS0wlRw+emptCt8HCdnYp6CbgxjSsA4O3GhG7jiOgGRmS4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7e4026a2524so2514555a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 23:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779777991; x=1780382791;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKTcPQnzhEa8TVxOVh8eNG3KMGP6qrlwK0hvhnEkZ54=;
        b=qO1F8Ah6qeZ5xluldgqojvKfBg1gyobk3mNN+LVkKrjPgh4sjObAR5rbP1V3k4XRyK
         ugu+u0w5dVQ9AQfVEOVckfjUgQxrZMcZqZ3O0BoLXUR45dKCiV40Pw7aellpMqw99tTL
         YvDBBCGCJa+zK5p1Cb+vek5cu1ED6BQqnlinMv+/v0PfszcAkv4FTfY5d6vhAdoaLxlJ
         j9aZkBLhkOsTDPZK2tsF1+gDtAbxX3pYNde8Nyaiv/BZ06ExTOE/xE7yQOwgCUbwlcH0
         NgnWTe85TclZ2lVSc2+boiK6sIdx1yyCk7t3pA7BBVsfCmu6USEJOVOZSZHcD//UuWmJ
         Ymcw==
X-Gm-Message-State: AOJu0YzM0ltw7vflyphxFMjin6i0nKL2FJpUDy3b+zuL+ECEGvy4SFZD
	EiZzm/zpNRMAkbZTdMccKOilVAYkgZutf3ugofn5vDEIVPbb7IERYZCKW0wcoalvoIrUnUL9Scu
	3yVipaIHGhpR/6P24MxOPh7oNwrRIs+mFe4l+ggfYx8C2xuMRwgjgJW9jHuapLA==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:edce:0:b0:69d:78aa:c0df with SMTP id
 006d021491bc7-69d7eb6e4e4mr9961426eaf.17.1779777991559; Mon, 25 May 2026
 23:46:31 -0700 (PDT)
Date: Mon, 25 May 2026 23:46:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1541c7.820a0220.e7972.000a.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in bnep_add_connection
From: syzbot <syzbot+604a39147226ba42d117@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d3a2a466b8d HID: core: Fix size_t specifier in hid_report..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111e702e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f195f6be48c12ec
dashboard link: https://syzkaller.appspot.com/bug?extid=604a39147226ba42d117
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4d3a2a46.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e6f8ace9c896/vmlinux-4d3a2a46.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d18ecf0e8cf/bzImage-4d3a2a46.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+604a39147226ba42d117@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1764
==================================================================
BUG: KASAN: slab-use-after-free in strnlen+0x66/0x90 lib/string.c:432
Read of size 1 at addr ffff8880126e8120 by task syz.0.0/5330

CPU: 0 UID: 0 PID: 5330 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 strnlen+0x66/0x90 lib/string.c:432
 strnlen include/linux/fortify-string.h:231 [inline]
 __fortify_strlen include/linux/fortify-string.h:267 [inline]
 strcpy include/linux/fortify-string.h:794 [inline]
 bnep_add_connection+0x90c/0xca0 net/bluetooth/bnep/core.c:649
 do_bnep_sock_ioctl+0x40b/0x650 net/bluetooth/bnep/sock.c:83
 sock_do_ioctl+0x101/0x320 net/socket.c:1313
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1434
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3074f9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3075f38fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3075215fa0 RCX: 00007f3074f9ce59
RDX: 00002000000001c0 RSI: 00000000400442c8 RDI: 0000000000000006
RBP: 00007f3075032d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3075216038 R14: 00007f3075215fa0 R15: 00007fff1a9f2b28
 </TASK>

Allocated by task 5330:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5295 [inline]
 __kvmalloc_node_noprof+0x528/0x8a0 mm/slub.c:6832
 alloc_netdev_mqs+0xa8/0x1210 net/core/dev.c:12029
 bnep_add_connection+0x214/0xca0 net/bluetooth/bnep/core.c:584
 do_bnep_sock_ioctl+0x40b/0x650 net/bluetooth/bnep/sock.c:83
 sock_do_ioctl+0x101/0x320 net/socket.c:1313
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1434
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5333:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6250 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6565
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x228/0x560 lib/kobject.c:737
 bnep_session+0x2b45/0x2c50 net/bluetooth/bnep/core.c:545
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880126e8000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 288 bytes inside of
 freed 4096-byte region [ffff8880126e8000, ffff8880126e9000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x126e8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88801abd5001
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac58500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800040004 00000000f5000000 ffff88801abd5001
head: 00fff00000000040 ffff88801ac58500 dead000000000100 dead000000000122
head: 0000000000000000 0000000800040004 00000000f5000000 ffff88801abd5001
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4709, tgid 4709 (udevd), ts 42519099965, free_ts 42499523170
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x24ba/0x2540 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7271
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 __do_kmalloc_node mm/slub.c:5294 [inline]
 __kvmalloc_node_noprof+0x657/0x8a0 mm/slub.c:6832
 seq_buf_alloc fs/seq_file.c:39 [inline]
 seq_read_iter+0x202/0xe10 fs/seq_file.c:211
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x582/0xa70 fs/read_write.c:574
 ksys_read+0x150/0x270 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 4707 tgid 4707 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0xbc7/0xd30 mm/page_alloc.c:2943
 __slab_free+0x274/0x2c0 mm/slub.c:5612
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 __do_kmalloc_node mm/slub.c:5294 [inline]
 __kvmalloc_node_noprof+0x4d7/0x8a0 mm/slub.c:6832
 seq_buf_alloc fs/seq_file.c:39 [inline]
 seq_read_iter+0x202/0xe10 fs/seq_file.c:211
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x582/0xa70 fs/read_write.c:574
 ksys_read+0x150/0x270 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880126e8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880126e8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880126e8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff8880126e8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880126e8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
