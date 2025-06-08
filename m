Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF92433CB
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749413765; cv=none; b=RgUsg9Z5DDo6sdhbBVKkFu8MchhBsu2jA+xYApbJturEfqj8TmVUT/UX34Qe0yoLJmW8fRQYgMvd44qnpzrgPEvb2F9jFlN6TewPZRK7jQC9s9mY2E3lue6vqFhWQgvWfcXSH3hh46n47dUhVsmwrdwbVg0MtCmhzH4dCjZGyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749413765; c=relaxed/simple;
	bh=Dz417L2k9jG2apG2xek5qmISU8WnR+rMvYYwzbXcThU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kVNefRBJVN+udiUsm2GQ4PY8ymzNi/7WviRL/PvpqxrFy959TCPy3fb98ErbE372unO7A0tgtk1r30ZYbtFNpttqH81CaGcC+lbU4uNB4MO1k/h71PlcXhI25tlYvRnxXiLXLQxjqAUA68spMoic5p5/EQ0qa2zZCrPkkUjdBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddc9e145daso55704625ab.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Jun 2025 13:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749413763; x=1750018563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfQeZN112qJNVFTmN3Leo3JApbmju5bPvJzr8JGwFuk=;
        b=WsZc0JXvPtF4uVx0VTcNQZZWHZCKJDxCRK6QjPCMyzSYYKUqkbzJbZwB5MYvLTqYTl
         3F8XLOZdOwjgHsxuTgK0JI5EUp6BA0A0L1rWUsG7UurEZ7C7cv92cU897MwDM94GAio3
         oVXixMLInUbN2X57E0AhJfnpHSh5DGkE2M6kOSGyaI9A96/o1mc9K5nWRryxK91o7aVb
         MDeZILdz3q8TqkGiTgQ+rJSUf6o1iJC+eEkTc/78tVR2g+aETmyhpdfpx6Fn7+xyTg5/
         4ODmMIFtzNdsfAa1xNM5fhBB9uGH4eHtmMUa6r62JJ55rXcceZYXSvzZsV5XyIfdEwmh
         dRJw==
X-Forwarded-Encrypted: i=1; AJvYcCWpHr954BMDUatnp0HFI3Ed1kHaHFdRsYp8N8A4uyEqTsrgtI2Ciibbnq+LhlNzJ9q/i0DGXVuKhl1HNT8FnJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5W9rYl+7K5mfASXyk+UZlJBHy+WsWiEsb5nyGl422vuULQFF
	hzSD1UiPIv8b+FzrXoC5rw9D8C/BD8Np9AxRjnKgjJXIbRwCFu9pcD7nhr4IKuleC+EOnvOe8Z0
	nIOBmFIEwOceKtBRtHg+kO0ezy1pRnJXGSgW8LAb66AG/kJYssQfx2pQpllM=
X-Google-Smtp-Source: AGHT+IH37MWdj3ftTxsMV69qiIZDjW66dJ9UUbZivQ8vUWjmuw9YV7scjt30ruJEjaoVjbqJbr6tQxblWD87YlcwNZ7wNl80uGP5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:3dc:875e:ed7e with SMTP id
 e9e14a558f8ab-3ddce4524b2mr124232545ab.12.1749413762922; Sun, 08 Jun 2025
 13:16:02 -0700 (PDT)
Date: Sun, 08 Jun 2025 13:16:02 -0700
In-Reply-To: <01c4295e-1fe8-48c9-8bee-c43c8023dd2b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6845ef82.a70a0220.27c366.004f.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in hci_devcd_dump
From: syzbot <syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com>
To: ipravdin.official@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in force_devcd_write

==================================================================
BUG: KASAN: slab-use-after-free in force_devcd_write+0x312/0x340 drivers/bluetooth/hci_vhci.c:327
Read of size 8 at addr ffff88807b5f6000 by task syz.0.616/7999

CPU: 0 UID: 0 PID: 7999 Comm: syz.0.616 Not tainted 6.15.0-syzkaller-13804-g939f15e640f1-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 force_devcd_write+0x312/0x340 drivers/bluetooth/hci_vhci.c:327
 full_proxy_write+0x13f/0x200 fs/debugfs/file.c:398
 vfs_write+0x29d/0x1150 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3210d8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3211b9b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3210fb5fa0 RCX: 00007f3210d8e969
RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f3210e10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3210fb5fa0 R15: 00007fff9eb91938
 </TASK>

Allocated by task 6438:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 vhci_open+0x4c/0x430 drivers/bluetooth/hci_vhci.c:635
 misc_open+0x35d/0x420 drivers/char/misc.c:161
 chrdev_open+0x231/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x744/0x1c10 fs/open.c:964
 vfs_open+0x82/0x3f0 fs/open.c:1094
 do_open fs/namei.c:3887 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4046
 do_filp_open+0x20b/0x470 fs/namei.c:4073
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6438:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 vhci_release+0xbb/0xf0 drivers/bluetooth/hci_vhci.c:671
 __fput+0x402/0xb70 fs/file_table.c:465
 task_work_run+0x150/0x240 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x864/0x2bd0 kernel/exit.c:955
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1104
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x490 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807b5f6000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff88807b5f6000, ffff88807b5f6400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b5f0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b441dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b441dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001ed7c01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5498, tgid 5498 (S41dhcpcd), ts 56157746693, free_ts 56113477136
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 load_elf_phdrs+0x102/0x210 fs/binfmt_elf.c:525
 load_elf_binary+0x1fa/0x4f00 fs/binfmt_elf.c:854
 search_binary_handler fs/exec.c:1665 [inline]
 exec_binprm fs/exec.c:1697 [inline]
 bprm_execve fs/exec.c:1749 [inline]
 bprm_execve+0x8c3/0x1650 fs/exec.c:1725
 do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1855
 do_execve fs/exec.c:1929 [inline]
 __do_sys_execve fs/exec.c:2005 [inline]
 __se_sys_execve fs/exec.c:2000 [inline]
 __x64_sys_execve+0x8e/0xb0 fs/exec.c:2000
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5184 tgid 5184 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 discard_slab mm/slub.c:2717 [inline]
 __put_partials+0x16d/0x1c0 mm/slub.c:3186
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_lru_noprof+0x1d0/0x3b0 mm/slub.c:4216
 __d_alloc+0x31/0xaa0 fs/dcache.c:1690
 d_alloc+0x4a/0x1e0 fs/dcache.c:1769
 d_alloc_parallel+0xe3/0x12e0 fs/dcache.c:2533
 __lookup_slow+0x193/0x460 fs/namei.c:1802
 lookup_slow fs/namei.c:1834 [inline]
 walk_component+0x353/0x5b0 fs/namei.c:2138
 lookup_last fs/namei.c:2639 [inline]
 path_lookupat+0x142/0x6d0 fs/namei.c:2663
 filename_lookup+0x224/0x5f0 fs/namei.c:2692
 vfs_statx+0x101/0x3e0 fs/stat.c:353
 vfs_fstatat+0x7b/0xf0 fs/stat.c:375
 __do_sys_newfstatat+0x97/0x120 fs/stat.c:542

Memory state around the buggy address:
 ffff88807b5f5f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807b5f5f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807b5f6000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807b5f6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b5f6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         939f15e6 Merge tag 'turbostat-2025.06.08' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15698a82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6678e7c8a50af095
dashboard link: https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c18a82580000

