Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933542EA47D
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621969; cv=none; b=McSj3+rBE8fsHLicvPW4kwjb8rO9/hUn3LxU4wqPljT+6yEYErpoXIrvgHZVBI44KhjUrNqdUpRt9OB0s3jyHPHt58Md5r/A/rDBWcvW1v7dr/mBH1eIpFXWpoB2Q1NK7pJXUcHaIzOFv9sb1GPzKHKiYPaCg2kJeLzawbn4yiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621969; c=relaxed/simple;
	bh=hSRWBQH87Xh6SXF4eNlZghbPax/M89Nwl1fX8ilpFEw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FS2rJO3+hvyog4i3v3tEFNwrAcCGvqDB6XpBi8BLfrXxSqCPzLFvqcajgEt6Ha5qn7qfcBS+vClBzZaxCQQwIFcjIcZ7jFleeEyMIhmJo3N6kXk3QihRbJMBUOpd9dT6NCS5CLiAhJIX/6odGTob5Dku1/7V0/68XjC8C7Me1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-873fd6e896bso71316439f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jul 2025 02:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751621966; x=1752226766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/U7M0cHts+78Jm0qC0RTHE+XbcJQzP2x3jox1YG48XM=;
        b=mgT/ewpDZA2ZUPfsjxvDsg2EuTqdNZoGFAFXnxS9DnuoM95sRtvcRSk7TuwC5TJfSW
         NNXy5UGOSO4m2RLZ8lFe3+qEHgPi6TFlT0v2AQl6JKz0gR2A19Usr3vEVO3Cp65umsVR
         Gh55nWz1VqMIeQgOsTwa2tnlKTJZ0U7+u1XdF1hsbY196SLU7vDkmDI+cH/II9tLq01R
         76WbXmIdtTgbRqI3quvlzVbY0nnAaJJkRkb5/kMdEk/wDpqHJZbKKNIeLUy8s+nyiaOz
         rQysENHm3hgNxh/DoBVZ2zZarcFgJXmsE7EICSPXGi/iJo8ajppntUCL6VLA3yrJJPby
         jHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB9SAshe2lVPBawCqZ2g2mitJ0Vz0iGDGpRty99vPHqKDa6pf32vzXdXC3TtUC4HkH81fKWPZtClfu03bLgEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+O0bDDgr14BI6TG9L3BHSgRTzaHGnRMNf9hXk+NUKCE/cxXOn
	T9nQRuYWVT91LwaUui1NRaGkMoPWhAgn7Q2ps+sQJHBOIPXK59MuI8tIAPRNtXSG0DpyQ5/u3Ov
	F1a3V4c17KJeIcrAGIwo8ckJZmru5T4Qrqns/zEmr2erT04ss0P6UBdFzX2U=
X-Google-Smtp-Source: AGHT+IEHzlEtREyrnS7m87FbCaBVtKt7JVt+Mbwgn5Kh0eRRPvlYhpGxcJc8212zxmTZtbP+LnV82+YriJXtS+STKiZSS+LgWPTY
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b46:b0:3dd:d1bc:f08c with SMTP id
 e9e14a558f8ab-3e1355e71bbmr16995735ab.20.1751621966634; Fri, 04 Jul 2025
 02:39:26 -0700 (PDT)
Date: Fri, 04 Jul 2025 02:39:26 -0700
In-Reply-To: <676b6d4d.050a0220.2f3838.0256.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6867a14e.a70a0220.29cf51.0017.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in force_devcd_write
From: syzbot <syzbot+bc71245e56f06e3127b7@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	mazin@getstate.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4c06e63b9203 Merge tag 'for-6.16-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11594c8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9887aa986c36cc50
dashboard link: https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139dac8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b90f70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25b7407ad24e/disk-4c06e63b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b2ae62cd2161/vmlinux-4c06e63b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3cecae8778af/bzImage-4c06e63b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc71245e56f06e3127b7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in force_devcd_write+0x312/0x340 drivers/bluetooth/hci_vhci.c:327
Read of size 8 at addr ffff888025726000 by task syz.0.616/6743

CPU: 0 UID: 0 PID: 6743 Comm: syz.0.616 Not tainted 6.16.0-rc4-syzkaller-00123-g4c06e63b9203 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 force_devcd_write+0x312/0x340 drivers/bluetooth/hci_vhci.c:327
 full_proxy_write+0x13c/0x200 fs/debugfs/file.c:398
 vfs_write+0x29d/0x1150 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d06f8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff1271b2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8d071b5fa0 RCX: 00007f8d06f8e929
RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f8d07010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8d071b5fa0 R14: 00007f8d071b5fa0 R15: 0000000000000003
 </TASK>

Allocated by task 5958:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 vhci_open+0x4c/0x430 drivers/bluetooth/hci_vhci.c:635
 misc_open+0x35a/0x420 drivers/char/misc.c:161
 chrdev_open+0x231/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x744/0x1c10 fs/open.c:964
 vfs_open+0x82/0x3f0 fs/open.c:1094
 do_open fs/namei.c:3896 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4055
 do_filp_open+0x20b/0x470 fs/namei.c:4082
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5958:
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
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x86c/0x2bd0 kernel/exit.c:964
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1105
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x490 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888025726000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff888025726000, ffff888025726400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25720
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b841dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b841dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea000095c801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5605, tgid 5605 (dhcpcd-run-hook), ts 69092117143, free_ts 69052522693
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
 load_elf_binary+0x14c1/0x4f00 fs/binfmt_elf.c:954
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
page last free pid 5601 tgid 5601 stack trace:
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
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x1d4/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_realpath_from_path+0xc2/0x6e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x274/0x460 security/tomoyo/file.c:822
 security_inode_getattr+0x116/0x290 security/security.c:2377
 vfs_getattr fs/stat.c:259 [inline]
 vfs_fstat+0x4b/0xe0 fs/stat.c:281
 __do_sys_newfstat+0x87/0x100 fs/stat.c:555
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888025725f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888025725f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888025726000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888025726080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025726100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
