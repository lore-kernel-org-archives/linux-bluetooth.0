Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560143AA4
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759587034; cv=none; b=jHK+iPDle0tbZKFBOLF/277dhNO2PynlbTJ7//vx26VAcsbGTIF498YRvpCiaJdpCuQ/C/6sMZobOzRbcQ/8nmgnCWh2SwnTzWb34v0gYH4ATPPXbx3inTfbSq/z3yOr0t2tfqE8idL9tQl9VARAk3/xBs42x/c0T87nm9qsszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759587034; c=relaxed/simple;
	bh=MOtGaOG23iYhOtlTH9y2RBp2QvnTKiicO+UsweqDGZ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y1uy/ezCN6GzZqAFRcvWQaXVYu2PDoPzqO4EQPL1OWCnf61IeyKjvX0YZvJB/xZ6MzswaL7K87jTDcoFFsfmmmXPJY/xvdMsg6j8Hg9pIGJ8otahPnunbySwzyZgJzLcxTmmhpqi3oPolHLALVLgMEh6N9mQMA/dBUG3cE7kslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4257567fb7cso40395595ab.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Oct 2025 07:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759587031; x=1760191831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7BJc/9uhy1iwb9MWEqPHFDcMigEwvdmj6x+whTMF3U=;
        b=xCe+lFhEaJOvzWwOMuGDE1Pb/lKzvTDwY4kqG0Jy0SZAs27y4atCooBZoDypQzufTu
         xyTshrtox2qhuMcHfAg3+EF8ruiA32K0AOUN1M+J2c4Id0vBUJNwjBhBEPloFVsZcsr5
         Wg0uq7ndvPYqxPkREyv9QqQxBdd2YRF5/dJG+zENA0pipwBquxn+NJf4QD9wZHHnnIBC
         UiUn44TRI5y5dYyJ6G5aPRKhKkZrfX4ttUQXanivnfLTQ5RTavpgDzCJvjfGD6Nk0MO4
         YtYgA1PbpEFs85TZ8ANXOdu3/bFd9y5xfEJkEQwNJqdmdQ++RlgiGlDL90WXp/w85bfe
         jEAA==
X-Forwarded-Encrypted: i=1; AJvYcCXgwW1RkmUjdAfJqpRbAE5qG3/OddjH8t7Dxkk90xuZuXkao39OqrtFmIX3o5PF1PCSi2jtNewTXNVhRdAFvDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4prD9j4dc24nFM64FYVH/M+dg6QGSN7Qz4c0PGx9WvnfsQra
	lUIT4+UgK8n6fSFlc2zSWNQ+JMmUyAMEGrk8ayYAKUDWPbdmdlU4caJ/Rlmokk44c0OuKDWxmMB
	2TzeGikub421qeiFSFUPK/H3EwSPV6OSiXYbrI4hyd7wpxqorsVvJS1835Dg=
X-Google-Smtp-Source: AGHT+IG5Fu7UjjB55Isl3KKTmJJSG7eYQO3g9SknmWSz6JZJVyS05aFHTpcmVdGeDBdpYPeZOe9Yv6Fc0DzRnEWQQf/9KX6GrhQj
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:42a:dd1d:c3e4 with SMTP id
 e9e14a558f8ab-42e7ad846aamr90839255ab.15.1759587031579; Sat, 04 Oct 2025
 07:10:31 -0700 (PDT)
Date: Sat, 04 Oct 2025 07:10:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e12ad7.050a0220.bce5e.000e.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_disconn_ind (2)
From: syzbot <syzbot+97d2b6a9ca6a6e0f204c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146067bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
dashboard link: https://syzkaller.appspot.com/bug?extid=97d2b6a9ca6a6e0f204c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/924cb94b3bad/disk-8d245acc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df04a64e8404/vmlinux-8d245acc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92335877cbf3/bzImage-8d245acc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97d2b6a9ca6a6e0f204c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_disconn_ind+0x79/0xc0 net/bluetooth/l2cap_core.c:7315
Read of size 1 at addr ffff8880574a22b0 by task kworker/u9:2/5864

CPU: 0 UID: 0 PID: 5864 Comm: kworker/u9:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: hci3 hci_conn_timeout
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 l2cap_disconn_ind+0x79/0xc0 net/bluetooth/l2cap_core.c:7315
 hci_proto_disconn_ind include/net/bluetooth/hci_core.h:2058 [inline]
 hci_conn_timeout+0xdd/0x290 net/bluetooth/hci_conn.c:581
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 12107:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4396
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 l2cap_conn_add+0xaa/0x8d0 net/bluetooth/l2cap_core.c:6886
 l2cap_chan_connect+0x6c8/0xe30 net/bluetooth/l2cap_core.c:7077
 bt_6lowpan_connect net/bluetooth/6lowpan.c:900 [inline]
 lowpan_control_write+0x421/0x6c0 net/bluetooth/6lowpan.c:1135
 full_proxy_write+0x124/0x1f0 fs/debugfs/file.c:388
 vfs_write+0x27b/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12409:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x18e/0x440 mm/slub.c:4879
 l2cap_connect_cfm+0x11d/0x1040 net/bluetooth/l2cap_core.c:7259
 hci_connect_cfm include/net/bluetooth/hci_core.h:2082 [inline]
 hci_conn_failed+0x1cb/0x310 net/bluetooth/hci_conn.c:1289
 hci_abort_conn_sync+0x658/0xe30 net/bluetooth/hci_sync.c:5689
 hci_disconnect_all_sync+0x1b5/0x350 net/bluetooth/hci_sync.c:5712
 hci_suspend_sync+0x3fc/0xc60 net/bluetooth/hci_sync.c:6188
 hci_suspend_dev+0x28d/0x4d0 net/bluetooth/hci_core.c:2849
 hci_suspend_notifier+0xf2/0x290 net/bluetooth/hci_core.c:2420
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 notifier_call_chain_robust kernel/notifier.c:120 [inline]
 blocking_notifier_call_chain_robust+0x85/0x100 kernel/notifier.c:345
 pm_notifier_call_chain_robust+0x2c/0x60 kernel/power/main.c:103
 snapshot_open+0x19c/0x280 kernel/power/user.c:77
 misc_open+0x2bc/0x330 drivers/char/misc.c:161
 chrdev_open+0x4c9/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x950/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880574a2000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 688 bytes inside of
 freed 1024-byte region [ffff8880574a2000, ffff8880574a2400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x574a0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a441dc0 ffffea0000a4d200 dead000000000003
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a441dc0 ffffea0000a4d200 dead000000000003
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea00015d2801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4890, tgid 4890 (kworker/u8:8), ts 90724194100, free_ts 25796139807
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 neigh_alloc net/core/neighbour.c:522 [inline]
 ___neigh_create+0x6d5/0x2260 net/core/neighbour.c:656
 ip6_finish_output2+0xb4d/0x16a0 net/ipv6/ip6_output.c:132
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xb54/0x1440 net/ipv6/ndisc.c:512
 addrconf_dad_completed+0x7ae/0xd60 net/ipv6/addrconf.c:4360
 addrconf_dad_work+0xc36/0x14b0 net/ipv6/addrconf.c:-1
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 __free_pages mm/page_alloc.c:5260 [inline]
 free_contig_range+0x1bd/0x4a0 mm/page_alloc.c:7091
 destroy_args+0x69/0x660 mm/debug_vm_pgtable.c:958
 debug_vm_pgtable+0x39f/0x3b0 mm/debug_vm_pgtable.c:1345
 do_one_initcall+0x233/0x820 init/main.c:1269
 do_initcall_level+0x104/0x190 init/main.c:1331
 do_initcalls+0x59/0xa0 init/main.c:1347
 kernel_init_freeable+0x334/0x4b0 init/main.c:1579
 kernel_init+0x1d/0x1d0 init/main.c:1469
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880574a2180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880574a2200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880574a2280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880574a2300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880574a2380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
