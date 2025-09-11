Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC0262D14
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621612; cv=none; b=u5PXMHorbZhqSTbGqYj3emyUFuIPu3V4upMSBMC6NL89BLPTyt3KPCD0cAktm9jCA5fstaVfXs+Ww2eXIlnpRvW9exl4UZC9Df74IovwXlZRpPVBTGmcdYu6fckskBgIVf3V9C9IapntsV3XEqMOli72+T29qUlbqDN/eM8dRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621612; c=relaxed/simple;
	bh=8sT5O3DJ7wjumV8lM59JEIsMclWaGn4v8tgZ56bfYMw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lCg6FTEf124vwl8/tQ2wd1Ce7+esGpnanQ8HhH/1FOmxOcs7/PGQl4bMVeRPrBb+IHzY9YfICuuOk854jpdFUv2LOm53PZQfayc50wV9JN6xvPLfKPq7PDAwnO5qUpcXkrgII6eTiSb7J7w2RU4COHdA8v8Y4m/V6zXdKCC1u5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88765dc1f92so317799739f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 13:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757621610; x=1758226410;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAfsIb4ls92SSExbl5BYowmnyY29MtBoPYVOFIR3zxM=;
        b=SMGlyklkVKeVjqfjgosxQSCoR3L067H6KoBwgLqyJp7F2t/Y33Ft0ZdLIdyq3pcrsp
         5ju05c+rfqrkH8KWaHpdBbRZW6AlXfTmMjp15TOUGgBHCxy2Oxg2F1SVuPtdXhGHu1wq
         p/BpbMaWIzq+1OAXFe2KPdEyKLsKEXnE8V3vBoH5JZ3Itcf3lVuQ8jQF9/7JE598Bz//
         OAb0tz5GddArSsf8Yk/NnXH70zwh5oS+ZCOihT4TJETiZqpyRTNDqSuW6yOgwt7PBc+O
         RyTRxHMYNObRnGJyc/9LH/WJ4LSYpN5sCPwYEqyeJuXjqcNG31aWXiZJLHWQaGmlmFP9
         4OUw==
X-Forwarded-Encrypted: i=1; AJvYcCV5GBwhiOCkCRJ3hsii8cA+Y5qLxjupCnT3n0A7q19qAV7BK0tw16K1vPCh0JD9UIFafJCQRDOaaXM8WAedFfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8aWVG72dZk+N1PMi5vjs7UdPorCq2yWUccgRrnxQ1N5lTgH0m
	YosSn5ZHhXWu8XLwXmKAKiRRTuPVcZPiz9wgKcLL4JZs8rt99BuYKcSXLHKQWRCJIy+Lm8SJJWd
	G3UiUVH7FvOYPHIZchX0Wr1cIiKadRfUXhlP1diRxlxR7J7AykgQYmBm4dHU=
X-Google-Smtp-Source: AGHT+IGY+2YfchmveD2IXMg/SKk85si6zarDkUjY7RGWMQYA7nPz000qxANAqBr9Tc/1uHHX9aAEQt9YXjUTRTR0/jIXvGzMFPRv
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258d:b0:3f0:375:e587 with SMTP id
 e9e14a558f8ab-4209ea1e5d0mr15130255ab.11.1757621609700; Thu, 11 Sep 2025
 13:13:29 -0700 (PDT)
Date: Thu, 11 Sep 2025 13:13:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c32d69.050a0220.2ff435.024a.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 hidp_session_thread (2)
From: syzbot <syzbot+9d57a553eefe89560c83@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6ab41fca2e80 Merge tag 'timers-urgent-2025-09-07' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ad7134580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67765a3521e7734
dashboard link: https://syzkaller.appspot.com/bug?extid=9d57a553eefe89560c83
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6ab41fca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/12e7bedca6e8/vmlinux-6ab41fca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c31f363b750/bzImage-6ab41fca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d57a553eefe89560c83@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:3188 [inline]
BUG: KASAN: slab-use-after-free in __mutex_unlock_slowpath+0xaf/0x7b0 kernel/locking/mutex.c:931
Read of size 8 at addr ffff888025e80050 by task khidpd_04580058/19309

CPU: 0 UID: 0 PID: 19309 Comm: khidpd_04580058 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:3188 [inline]
 __mutex_unlock_slowpath+0xaf/0x7b0 kernel/locking/mutex.c:931
 hidp_session_thread+0x45e/0x660 net/bluetooth/hidp/core.c:1304
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 18564:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 hci_alloc_dev_priv+0x1d/0x28a0 net/bluetooth/hci_core.c:2448
 hci_alloc_dev include/net/bluetooth/hci_core.h:1726 [inline]
 __vhci_create_device+0xf0/0x880 drivers/bluetooth/hci_vhci.c:421
 vhci_create_device drivers/bluetooth/hci_vhci.c:479 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:536 [inline]
 vhci_write+0x2c0/0x480 drivers/bluetooth/hci_vhci.c:616
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 18564:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x60/0x70 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4894
 hci_release_dev+0x4ef/0x610 net/bluetooth/hci_core.c:2776
 bt_host_release+0x6a/0xb0 net/bluetooth/hci_sysfs.c:87
 device_release+0xa4/0x240 drivers/base/core.c:2565
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e7/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3797
 vhci_release+0x185/0x230 drivers/bluetooth/hci_vhci.c:691
 __fput+0x3ff/0xb70 fs/file_table.c:468
 task_work_run+0x150/0x240 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x86f/0x2bf0 kernel/exit.c:961
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:548
 insert_work+0x36/0x230 kernel/workqueue.c:2184
 __queue_work+0x97e/0x1160 kernel/workqueue.c:2339
 queue_work_on+0x1a4/0x1f0 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:669 [inline]
 hci_recv_frame+0x503/0x880 net/bluetooth/hci_core.c:2968
 vhci_get_user drivers/bluetooth/hci_vhci.c:520 [inline]
 vhci_write+0x399/0x480 drivers/bluetooth/hci_vhci.c:616
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:548
 insert_work+0x36/0x230 kernel/workqueue.c:2184
 __queue_work+0x3f8/0x1160 kernel/workqueue.c:2343
 queue_work_on+0x1a4/0x1f0 kernel/workqueue.c:2390
 l2cap_send_acl net/bluetooth/l2cap_core.c:953 [inline]
 l2cap_send_cmd+0x974/0xc60 net/bluetooth/l2cap_core.c:980
 l2cap_information_req net/bluetooth/l2cap_core.c:4584 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4827 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5557 [inline]
 l2cap_recv_frame+0x2173/0x9540 net/bluetooth/l2cap_core.c:6839
 l2cap_recv_acldata+0xae4/0xd30 net/bluetooth/l2cap_core.c:7561
 hci_acldata_packet net/bluetooth/hci_core.c:3833 [inline]
 hci_rx_work+0xa80/0x16b0 net/bluetooth/hci_core.c:4076
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888025e80000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 80 bytes inside of
 freed 8192-byte region [ffff888025e80000, ffff888025e82000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25e80
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b843180 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b843180 0000000000000000 dead000000000001
head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea000097a001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 14034, tgid 14034 (syz-executor), ts 243655527610, free_ts 243622003487
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab mm/slub.c:2660 [inline]
 new_slab+0x247/0x330 mm/slub.c:2714
 ___slab_alloc+0xcf2/0x1750 mm/slub.c:3901
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3992
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 batadv_hash_new+0x74/0x2e0 net/batman-adv/hash.c:52
 batadv_tt_global_init net/batman-adv/translation-table.c:1361 [inline]
 batadv_tt_init+0x278/0x350 net/batman-adv/translation-table.c:4111
 batadv_mesh_init+0x4e3/0x9a0 net/batman-adv/main.c:197
 batadv_meshif_init_late+0xbd4/0xf30 net/batman-adv/mesh-interface.c:813
 register_netdevice+0x653/0x2270 net/core/dev.c:11133
 batadv_meshif_newlink+0x8f/0xc0 net/batman-adv/mesh-interface.c:1088
 rtnl_newlink_create net/core/rtnetlink.c:3825 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
 rtnl_newlink+0xc42/0x2000 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6946
page last free pid 14034 tgid 14034 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2758 [inline]
 __put_partials+0x165/0x1c0 mm/slub.c:3223
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 __kmalloc_cache_noprof+0x1f1/0x3e0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 ref_tracker_alloc+0x18e/0x5b0 lib/ref_tracker.c:271
 __netdev_tracker_alloc include/linux/netdevice.h:4349 [inline]
 netdev_hold include/linux/netdevice.h:4378 [inline]
 netdev_hold include/linux/netdevice.h:4373 [inline]
 register_netdevice+0x1689/0x2270 net/core/dev.c:11230
 team_newlink+0xb4/0x190 drivers/net/team/team_core.c:2213
 rtnl_newlink_create net/core/rtnetlink.c:3825 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
 rtnl_newlink+0xc42/0x2000 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 __sys_sendto+0x4a0/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2231

Memory state around the buggy address:
 ffff888025e7ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888025e7ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888025e80000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff888025e80080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025e80100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
