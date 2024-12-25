Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9224B34
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Dec 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735093584; cv=none; b=rdKomD/ImKlntNc2576P0r0xMvQE20YgapdL47PvbAAgWUjypMJXxJZCnd8HpBHBGN/rOq0hdpi7qjmD2oweoeDXInn5clmDNx+Y7OpsrxviOvH8cF+zdgiy/gdj60gr9OV/y+UWJmnAFcIq7X9mSqHnS5lIYqzLucwaK/Pv+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735093584; c=relaxed/simple;
	bh=eyRIA5tyEXrlS7/NzH0UmLqWRKsrlWk8ujmWPDmcriU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aeEDpwqcDZWxfTaIWdTrsQtlcANJeYY94Rh3J4S1E3o9HjWdhVEBGBaRbck1bfQEPMMwF2F/oJsvhKno5cZDddat5d3nzZD1c4bN/1m2+zmdMPNlhnHKCn7WOKyA7Q5NU3r7GDE0hWj6GdiAu1U4ESAQVdgDsokd+9P2bO4/818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so110978405ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 18:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735093582; x=1735698382;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSfGSh7kpLTp0iKC7o07O1dmWAvNjiwack8NS35BbfI=;
        b=VQ4XZZR9uakatu0T5Kp47StVxKJv2m3lb+eOjFwGhVqCDFiYtCluGAIIbsheKkXqP7
         sDUIfImJ+oJriTTt+Zd5AFa6tmCFGsyr8Ss5vQKIU68/60gP6LN/WPQygRjg8b/Dv8zw
         8KRm/pxF1hFmlZ603NJDO0LKSN4+AX0dSaUPWClNCdpTie+m8tgmX/pj5xfalxrvBZ/n
         4J6klF0SPh229CDDmGBU7VbrhqaVP2GGBPqKdyhwTPamTEWWhzl1SxPkbWG1QVVxpluC
         LJ8r+Y+IK9/f0D7eW/Oyk1oaWb5sZ+VX3V1/ZpFcDfYWSvqoNg5rJOUiQLidxDA1Tb57
         L+3Q==
X-Gm-Message-State: AOJu0YwTJYQiR20AvzPXM2bu3SODDIl4ydrJxIO9iymeenDzLogKWzOs
	TKxYeOJIm42u7KFY47+gAAP3tVcR2htGcaQZ+wXC0zG7gh5d7WfZtgg7W6uzGgraQwpMzBTq/Qo
	aXt2Vkrr0G2wW1FaCH2wA13DJg/aLBzVonwmb5ow6+Hhuxy6dD2i/r3ylkQ==
X-Google-Smtp-Source: AGHT+IGqrnj+Cn9dpbtn8Ga12C8CzzCB3aOO3XA0fIPaKubJMmr14nQdlRvwdZYteqxlNONCvZYHAOJtZSKasyyPuNI9Jfe+VSA4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:3ab:1b7a:5932 with SMTP id
 e9e14a558f8ab-3c2d514f756mr143255725ab.18.1735093581799; Tue, 24 Dec 2024
 18:26:21 -0800 (PST)
Date: Tue, 24 Dec 2024 18:26:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676b6d4d.050a0220.2f3838.0256.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in force_devcd_write
From: syzbot <syzbot+bc71245e56f06e3127b7@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    48f506ad0b68 Merge tag 'soc-fixes-6.13-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f19f30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17df9fe8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f42f936a7d8d/disk-48f506ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f5d9512f350/vmlinux-48f506ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08855819fbb0/bzImage-48f506ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc71245e56f06e3127b7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in force_devcd_write+0x31f/0x350 drivers/bluetooth/hci_vhci.c:327
Read of size 8 at addr ffff88805dfd8800 by task syz.0.616/6633

CPU: 1 UID: 0 PID: 6633 Comm: syz.0.616 Not tainted 6.13.0-rc3-syzkaller-00289-g48f506ad0b68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 force_devcd_write+0x31f/0x350 drivers/bluetooth/hci_vhci.c:327
 full_proxy_write+0xfb/0x1b0 fs/debugfs/file.c:356
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4c25785d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffacf7c428 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4c25975fa0 RCX: 00007f4c25785d29
RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f4c25801aa8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4c25975fa0 R14: 00007f4c25975fa0 R15: 00000000000018c5
 </TASK>

Allocated by task 5945:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 vhci_open+0x4c/0x430 drivers/bluetooth/hci_vhci.c:634
 misc_open+0x35a/0x420 drivers/char/misc.c:165
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0xf59/0x1ea0 fs/open.c:945
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5945:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 vhci_release+0xbb/0xf0 drivers/bluetooth/hci_vhci.c:670
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xad8/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 get_signal+0x2576/0x2610 kernel/signal.c:3017
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805dfd8800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff88805dfd8800, ffff88805dfd8c00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5dfd8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea000177f601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5606, tgid 5606 (dhcpcd), ts 41765829328, free_ts 41751365215
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x2de/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 load_elf_phdrs+0x103/0x210 fs/binfmt_elf.c:532
 load_elf_binary+0x14c6/0x4ed0 fs/binfmt_elf.c:961
 search_binary_handler fs/exec.c:1748 [inline]
 exec_binprm fs/exec.c:1790 [inline]
 bprm_execve fs/exec.c:1842 [inline]
 bprm_execve+0x703/0x19b0 fs/exec.c:1818
 do_execveat_common.isra.0+0x4f1/0x630 fs/exec.c:1949
 do_execve fs/exec.c:2023 [inline]
 __do_sys_execve fs/exec.c:2099 [inline]
 __se_sys_execve fs/exec.c:2094 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2094
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5498 tgid 5498 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2659
 __put_partials+0x14c/0x170 mm/slub.c:3157
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_node_noprof+0x1ca/0x3b0 mm/slub.c:4220
 __alloc_skb+0x2b3/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1323 [inline]
 netlink_alloc_large_skb+0x69/0x130 net/netlink/af_netlink.c:1196
 netlink_sendmsg+0x689/0xd70 net/netlink/af_netlink.c:1866
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 __sys_sendto+0x488/0x4f0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805dfd8700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805dfd8780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805dfd8800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88805dfd8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805dfd8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
