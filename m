Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2CC8BFA
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935466; cv=none; b=JfxwUJVHfnzwvrn23/ad/MHUFeQaYR/sR6aSzssXv4kBJMBKD2HAEgzHbD+8WjbPlrZuFeIJUp7PitubkCRSllI/lB7rKsDqil4E11YYc24KG5wBKBZGGibmZDxvqDdDj89lgEoQB0gZRe1WpJBeXlIiiLG+0Tkw9Tp77NwKA34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935466; c=relaxed/simple;
	bh=7oTLY/dLl6ct2uu22+98GEIckG91C0BuTboCsA3hsU4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aGlhRqIhqlswj1AGnuyer61SQdjsGaMuKaILf+hGhBr8Zcm4plDtqqgJKexp1JOwOetW840CK+81vf9HAi+eYaWRkWmUF1SBtRkpEf0QiPLPhaPy6WlNbBdYrN2u+sfYo5obyDGmYK/W5mcgvotmccHK8OSKp2F28y0ifK+YVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36c6dfc6134so91454895ab.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 01:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715935464; x=1716540264;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VfsBYwjkk8CcFcmkFiyosuPyfoZxN44RotgcSCOxXo=;
        b=t0EbgA1kpcNmD+Fb965bU6lmozF9qjiZ3T8xay6m6Fzy3hnavD6t28D51LO8wg28l2
         5XE1yv/a33iVOwS3UqaYzGyLwLrUEHJYqKFSHFElNXRc+gm//JqJXtm88cWU76NZjAO+
         Tf+g0jzSUUPxCbp683GohFleb7GJ/Z/MBHQ0nQ3owpw/66p8jBxbxYSCo8zP1OtWnwBU
         wlAeqi4vlw7du8hCHVaiBcJBbe8d+e1CaIg6sODyPElSt8sCydG7sVuh1O3ALjwk2kfl
         k53XZpIjbD150kVGjbTM9Ow16ZNeqJ3M/8BvBeRk9oSslW5UwQyrosJzMPlyNgPxxGnq
         m5xw==
X-Gm-Message-State: AOJu0YxLHflb/Aq9PyU4gAXV3SoHFs8yj5+p21Lb0WCc+iBuXRe4ZPHE
	LCEdO71cwrAkrMnGb0cceC8Mnb0n+dOmaSdUg8WOIUMT/7AyqUa3SKJ8Kn+2Bbl7I/kAwS4fBD+
	7L7ZNeaPhEEqCjm5XrDWzCgj7yYETSrWfL/P0NkfXl9fJsX1yxMjsbDbVbw==
X-Google-Smtp-Source: AGHT+IEuE0TmXyhQCdMDCrAZERlDGVT1ZOWja9gs3+9ygnw2axUTahGHkyqMFbyn+v8eJLLqZ4zJtm2y1tIYCcXSGVkiUo9IPOQg
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cb0f:0:b0:36c:4b0a:8455 with SMTP id
 e9e14a558f8ab-36cc14cf690mr3323915ab.3.1715935464103; Fri, 17 May 2024
 01:44:24 -0700 (PDT)
Date: Fri, 17 May 2024 01:44:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbc8670618a25b24@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 skb_queue_purge_reason (2)
From: syzbot <syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    621cde16e49b Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14b6fa84980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bddb81daac38d475
dashboard link: https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9591b45993bc/disk-621cde16.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a31801cab2a/vmlinux-621cde16.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37962f7be4eb/bzImage-621cde16.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in skb_queue_empty_lockless include/linux/skbuff.h:1840 [inline]
BUG: KASAN: slab-use-after-free in skb_queue_purge_reason+0xb9/0x500 net/core/skbuff.c:3877
Read of size 8 at addr ffff8880118db058 by task syz-executor.1/9233

CPU: 1 PID: 9233 Comm: syz-executor.1 Not tainted 6.9.0-syzkaller-05156-g621cde16e49b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 skb_queue_empty_lockless include/linux/skbuff.h:1840 [inline]
 skb_queue_purge_reason+0xb9/0x500 net/core/skbuff.c:3877
 skb_queue_purge include/linux/skbuff.h:3273 [inline]
 vhci_flush+0x44/0x50 drivers/bluetooth/hci_vhci.c:69
 hci_dev_do_reset net/bluetooth/hci_core.c:625 [inline]
 hci_dev_reset+0x42a/0x5d0 net/bluetooth/hci_core.c:665
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdbb787cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdbb85530c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdbb79abf80 RCX: 00007fdbb787cee9
RDX: 0000000000000000 RSI: 00000000400448cb RDI: 0000000000000006
RBP: 00007fdbb78c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fdbb79abf80 R15: 00007ffea6376cb8
 </TASK>

Allocated by task 8951:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x370 mm/slub.c:4070
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 vhci_open+0x57/0x370 drivers/bluetooth/hci_vhci.c:636
 misc_open+0x313/0x390 drivers/char/misc.c:165
 chrdev_open+0x5b0/0x630 fs/char_dev.c:414
 do_dentry_open+0x907/0x15a0 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8951:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4353 [inline]
 kfree+0x153/0x3b0 mm/slub.c:4463
 vhci_release+0xbf/0xd0 drivers/bluetooth/hci_vhci.c:672
 __fput+0x429/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880118db000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 88 bytes inside of
 freed 1024-byte region [ffff8880118db000, ffff8880118db400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118d8
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888015041dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
head: 00fff00000000840 ffff888015041dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
head: 00fff00000000003 ffffea0000463601 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4793, tgid 4793 (dhcpcd), ts 31626179552, free_ts 31588472252
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2353 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2406
 ___slab_alloc+0xb07/0x12e0 mm/slub.c:3592
 __slab_alloc mm/slub.c:3682 [inline]
 __slab_alloc_node mm/slub.c:3735 [inline]
 slab_alloc_node mm/slub.c:3908 [inline]
 __do_kmalloc_node mm/slub.c:4038 [inline]
 __kmalloc+0x2e5/0x4a0 mm/slub.c:4052
 kmalloc include/linux/slab.h:632 [inline]
 load_elf_phdrs fs/binfmt_elf.c:526 [inline]
 load_elf_binary+0x2f4/0x2660 fs/binfmt_elf.c:855
 search_binary_handler fs/exec.c:1786 [inline]
 exec_binprm fs/exec.c:1828 [inline]
 bprm_execve+0xaf8/0x17c0 fs/exec.c:1880
 do_execveat_common+0x553/0x700 fs/exec.c:1987
 do_execve fs/exec.c:2061 [inline]
 __do_sys_execve fs/exec.c:2137 [inline]
 __se_sys_execve fs/exec.c:2132 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2132
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 4791 tgid 4791 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x986/0xab0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2452 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2920
 put_cpu_partial+0x17c/0x250 mm/slub.c:2995
 __slab_free+0x2ea/0x3d0 mm/slub.c:4224
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3871 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmem_cache_alloc+0x174/0x350 mm/slub.c:3925
 getname_flags+0xbd/0x4f0 fs/namei.c:139
 vfs_fstatat+0x11c/0x190 fs/stat.c:303
 __do_sys_newfstatat fs/stat.c:468 [inline]
 __se_sys_newfstatat fs/stat.c:462 [inline]
 __x64_sys_newfstatat+0x125/0x1b0 fs/stat.c:462
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880118daf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880118daf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880118db000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff8880118db080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880118db100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
