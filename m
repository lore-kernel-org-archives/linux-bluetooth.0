Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32026D4CE
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408346; cv=none; b=KepzTAh+64Yjhwpkn5uUq89gBBUBQ5W2R5i6dozvrQf+T3FHxH7JF9lyGTDYBhNUIWOgHEiLrqGpI1W5ovn4UmmNPxAna30QT7MZ1tbE9b1LaP3c3C7YAswEd7JPyhinrJm105ZWKhM912KasTZDRFEHh7HMTJkugRdgLIJ03cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408346; c=relaxed/simple;
	bh=604DmnlN5FKJXlnCPF7Cz5HzYTZ0ji8BEc2CCi775SY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FDg/flkU1cKtyslqNxzv4EAX/j28b+bX9KaiSP83m5SG7wujg+N8muxl1UD4MFdCytKnOlbvJNgFHPrrFlnXNSDQsrFYPmcdh71+JisaplRM8Q+z8UQZYmWWP7Go9htGHTCvWhflHJejsn6er4tZgelAtDta2ChC7NOYHli1rKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d91a0d3e15so34152825ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 04:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745408344; x=1746013144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2d9QnuJwif/hl9wfYSPziOPeakCUUaYqmPPjpsjgZsI=;
        b=JatzGolneHWkn5HuRsG5svVH0ZGVXzhNjCLX06IdlILbemw0tMc+iPM936rZg63gBh
         JdXmH2AeN1SXHLTKSMTPjFnw1BupcIu2yF0jTtM9fPUNpr7i8g6w5d21bmjh46qdff8Z
         Xa5LMFYTj5LkhGlV1eZMj2s/fWJdAssJU4JsyopA7ExkgCMbYt7VgdbZLVQ689kjep9y
         69WOzdc6lYpdL3fW5zDqpnDsXyC2FmnHa6lKuRlCmMBDXUPXIQesOnJLKOaO5Jn/5ILq
         6QKs1b6YJgw2Urm5j00tEBqYw4eD0oAZToccDJByveIuWh5M7lL1LexQVQpIplD/3Or3
         kTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaqscn8nqidn9RKPCo3uqD5952BoFUNAQg8Uewv90n2uSMgOAXASjpq4/+6LnfRbTBdV4YVi6O62ctz1g/4B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhwl/0cCu7xlID9X6izVw1lLBki+msi8E9VB/RzjR+18NChVEx
	FK65FZ5x/2XqpcutGlsUknfhoHdHT/4bjFZDvly+49Cs7cYIzH4i2xpV22nLWdZYuBsRO1JT68R
	yDL1+VPazl+/OHemSDr9Cv06V6qX5ILlTUw8NhhRx61NgnSpoD1hK/dw=
X-Google-Smtp-Source: AGHT+IFm5o/15WP2P4URudbHWvdLxIL0lEkMO3WXWucEcI/jthl/ryFZiCpJFsx3TfnEC2kMFaReG/DHXvl2zeL9QTWqAbTR86lt
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca48:0:b0:3d8:8900:9a30 with SMTP id
 e9e14a558f8ab-3d89428ae3bmr203350565ab.20.1745408344038; Wed, 23 Apr 2025
 04:39:04 -0700 (PDT)
Date: Wed, 23 Apr 2025 04:39:04 -0700
In-Reply-To: <20250423112029.189032-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6808d158.050a0220.dd94f.01de.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in hci_devcd_dump
From: syzbot <syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in force_devcd_write

==================================================================
BUG: KASAN: slab-use-after-free in force_devcd_write+0x312/0x340 drivers/bluetooth/hci_vhci.c:327
Read of size 8 at addr ffff888028448800 by task syz.0.616/8068

CPU: 0 UID: 0 PID: 8068 Comm: syz.0.616 Not tainted 6.15.0-rc3-syzkaller-gbc3372351d0c-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 force_devcd_write+0x312/0x340 drivers/bluetooth/hci_vhci.c:327
 full_proxy_write+0x13c/0x200 fs/debugfs/file.c:398
 vfs_write+0x25c/0x1180 fs/read_write.c:682
 ksys_write+0x12a/0x240 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1dc558e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1dc47fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1dc57b5fa0 RCX: 00007f1dc558e169
RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f1dc5610a68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1dc57b5fa0 R15: 00007ffc66674788
 </TASK>

Allocated by task 6607:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 vhci_open+0x4c/0x430 drivers/bluetooth/hci_vhci.c:635
 misc_open+0x35a/0x420 drivers/char/misc.c:179
 chrdev_open+0x231/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x741/0x1c10 fs/open.c:956
 vfs_open+0x82/0x3f0 fs/open.c:1086
 do_open fs/namei.c:3880 [inline]
 path_openat+0x1e5e/0x2d40 fs/namei.c:4039
 do_filp_open+0x20b/0x470 fs/namei.c:4066
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6607:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2398 [inline]
 slab_free mm/slub.c:4656 [inline]
 kfree+0x2b6/0x4d0 mm/slub.c:4855
 vhci_release+0xbb/0xf0 drivers/bluetooth/hci_vhci.c:671
 __fput+0x3ff/0xb70 fs/file_table.c:465
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xafb/0x2c30 kernel/exit.c:953
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7a0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x230 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888028448800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff888028448800, ffff888028448c00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28448
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b441dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b441dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000a11201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5928, tgid 5928 (kworker/u8:2), ts 88342641017, free_ts 88224139595
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2468 [inline]
 allocate_slab mm/slub.c:2632 [inline]
 new_slab+0x244/0x340 mm/slub.c:2686
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3872
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3962
 __slab_alloc_node mm/slub.c:4037 [inline]
 slab_alloc_node mm/slub.c:4198 [inline]
 __do_kmalloc_node mm/slub.c:4340 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:909 [inline]
 load_elf_phdrs+0x102/0x210 fs/binfmt_elf.c:532
 load_elf_binary+0x14b3/0x4f80 fs/binfmt_elf.c:960
 search_binary_handler fs/exec.c:1778 [inline]
 exec_binprm fs/exec.c:1810 [inline]
 bprm_execve fs/exec.c:1862 [inline]
 bprm_execve+0x8c0/0x1650 fs/exec.c:1838
 kernel_execve+0x2ef/0x3b0 fs/exec.c:2028
 call_usermodehelper_exec_async+0x255/0x4c0 kernel/umh.c:109
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 5903 tgid 5903 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4217
 getname_flags.part.0+0x4c/0x550 fs/namei.c:146
 getname_flags+0x93/0xf0 include/linux/audit.h:322
 getname include/linux/fs.h:2852 [inline]
 do_sys_openat2+0xb8/0x1d0 fs/open.c:1423
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888028448700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888028448780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888028448800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888028448880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028448900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         bc337235 Merge tag 'for-6.15-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a91014580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f65c1740d8e72188
dashboard link: https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11fdbacc580000

