Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA4E30B9B5
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616995; cv=none; b=tsTAociDuZIEIowi94nzBeDzmKoWh0CpeKiNCLPt8hOIIknJUb2jzWr7DdvUYJ1Y1u+NPUWc2l+orijGGQUJEOA3mnFHVpTlxXah5lJWttn3fGz8x9sU32OPvovpmVYFr5AwhZO2NrnRpz8Lp9eMtoo52Bk0aJiJQCsBuEBihUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616995; c=relaxed/simple;
	bh=xbsopJL39niuVsGDOYwMUaBUFCKFRngrgF79uxr/ZKY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZunUiX6FsNoxwk7aNIGSQHadA9kP/Ku4d0c6gpwf8oHwsiNTNTszmlUXMbXzZVkXfk7TGvpIa8xxAfxZUQWx+/BscUGxH1VOLALgrdWX3gqPrLF1IlRy2pUdF1VDPTm/cbtGT0nuFqMlXbMb4LTw7ptA7m9nEgSRcj0KvFvGHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8760733a107so71607739f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jul 2025 01:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751616993; x=1752221793;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAOV0O39Dfto9e1fmoguAJJZaZN12TGtoq2S9bd2LxM=;
        b=VBCs+Dtwv/cVkAF6na0L2K+fosXKPcpZnaT/L5a6bGF3UpXgK+LnoruWrbAW5T2kcM
         hyHx5Fh5sBLg5noQMXIs57aWdirTjBwDnVYstqsQNOYULhHQrsJM1VTtHygpwWNW92WG
         DcY649bQAvLup6qQIDboNZ4Ut40bIykOnltBx9uE53BX4WSja4iDk927LfP7i/TkasHp
         l7MQc3MJzXNfJlBlzUT7DCCgvTI2gSRpEYl0TR2PupEn89aNuPLI8gHwM+eZbCDqsZW3
         /tLmTyU+BBgOIG+V9J9PVa37XBpLy9npzCnpW2vZ3w5VwaQZ7oB1TXKGQScOwvhgmTaR
         nPVw==
X-Gm-Message-State: AOJu0YwJXfiM/RUHTK7sZkqkL7zLwubuqr+eGAL8f3ombRKDp9EaHyXL
	OjFZ/itQWWcR3uoM2a4P965lv3IOAz3sgGSCsPAy24yz2kaGt6n6YV0TicRR3kz3LbyCwHNpBYY
	a6R6xA6cJbpapAk71bUxRaYtREv2Mol3KbviSvjZ6rh8lOnGoSjb84ekT1Cev/g==
X-Google-Smtp-Source: AGHT+IEvKDQ+YdcHLVl4KW33OmyKCaFvS6FxKhuBMNxKWBxx8PsBuwRKPv0+rkooN7roBoaMjoV19uAghEpSvfLN6eKrPjEyUt/U
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0a:b0:3e0:4564:4ef9 with SMTP id
 e9e14a558f8ab-3e13544f97amr14701475ab.4.1751616992708; Fri, 04 Jul 2025
 01:16:32 -0700 (PDT)
Date: Fri, 04 Jul 2025 01:16:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68678de0.a70a0220.29cf51.0012.GAE@google.com>
Subject: [syzbot] [bluetooth?] [usb?] KASAN: slab-use-after-free Read in btusb_disconnect
From: syzbot <syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cf16f408364e usb: core: config: Prevent OOB read in SS end..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1356f48c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c5153915e19e58
dashboard link: https://syzkaller.appspot.com/bug?extid=2fc81b50a4f8263a159b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cf7770580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1756f48c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4e5962e656a/disk-cf16f408.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13d6d9e53c15/vmlinux-cf16f408.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dea34e20aa1d/bzImage-cf16f408.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com

usb 4-1: New USB device found, idVendor=0e8d, idProduct=763f, bcdDevice=9b.23
usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-1: Product: syz
usb 4-1: Manufacturer: syz
usb 4-1: SerialNumber: syz
usb 4-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: slab-use-after-free in btusb_disconnect+0x4dc/0x580 drivers/bluetooth/btusb.c:4287
Read of size 4 at addr ffff888107ebf7c0 by task kworker/0:1/10

CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.16.0-rc2-syzkaller-00053-gcf16f408364e #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 btusb_disconnect+0x4dc/0x580 drivers/bluetooth/btusb.c:4287
 usb_unbind_interface+0x1da/0x9a0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44b/0x620 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3881
 usb_disable_device+0x355/0x7d0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2316
 hub_port_connect drivers/usb/core/hub.c:5375 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5675 [inline]
 port_event drivers/usb/core/hub.c:5835 [inline]
 hub_event+0x1aa0/0x5030 drivers/usb/core/hub.c:5917
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5b3/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 10:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_node_track_caller_noprof+0x212/0x4c0 mm/slub.c:4347
 alloc_dr drivers/base/devres.c:119 [inline]
 devm_kmalloc+0xa5/0x260 drivers/base/devres.c:864
 devm_kzalloc include/linux/device/devres.h:53 [inline]
 btusb_probe+0x23f/0x4480 drivers/bluetooth/btusb.c:3892
 usb_probe_interface+0x300/0x9c0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_new_device+0xd07/0x1a20 drivers/usb/core/hub.c:2663
 hub_port_connect drivers/usb/core/hub.c:5535 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5675 [inline]
 port_event drivers/usb/core/hub.c:5835 [inline]
 hub_event+0x2f85/0x5030 drivers/usb/core/hub.c:5917
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5b3/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 10:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x37/0x50 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x283/0x470 mm/slub.c:4842
 release_nodes+0x11e/0x240 drivers/base/devres.c:506
 devres_release_all+0x112/0x180 drivers/base/devres.c:535
 device_unbind_cleanup+0x19/0x1b0 drivers/base/dd.c:549
 __device_release_driver drivers/base/dd.c:1277 [inline]
 device_release_driver_internal+0x4c3/0x620 drivers/base/dd.c:1295
 usb_driver_release_interface+0x109/0x190 drivers/usb/core/driver.c:640
 btusb_disconnect+0x448/0x580 drivers/bluetooth/btusb.c:4280
 usb_unbind_interface+0x1da/0x9a0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44b/0x620 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3881
 usb_disable_device+0x355/0x7d0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2316
 hub_port_connect drivers/usb/core/hub.c:5375 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5675 [inline]
 port_event drivers/usb/core/hub.c:5835 [inline]
 hub_event+0x1aa0/0x5030 drivers/usb/core/hub.c:5917
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5b3/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888107ebf000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1984 bytes inside of
 freed 2048-byte region [ffff888107ebf000, ffff888107ebf800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107eb8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100042000 ffffea00041ba600 dead000000000002
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100042000 ffffea00041ba600 dead000000000002
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0200000000000003 ffffea00041fae01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 3804462285, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0xf98/0x2ce0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x259/0x21e0 mm/page_alloc.c:4959
 alloc_pages_mpol+0xe4/0x410 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xda5/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __kmalloc_cache_noprof+0x209/0x3c0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 netdev_create_hash+0x3c/0xc0 net/core/dev.c:12447
 netdev_init+0x70/0x230 net/core/dev.c:12463
 ops_init+0x1df/0x5f0 net/core/net_namespace.c:138
 __register_pernet_operations net/core/net_namespace.c:1284 [inline]
 register_pernet_operations+0x39c/0x700 net/core/net_namespace.c:1361
 register_pernet_subsys+0x28/0x40 net/core/net_namespace.c:1402
 net_dev_init+0x13a/0xcb0 net/core/dev.c:12796
 do_one_initcall+0x120/0x6e0 init/main.c:1274
 do_initcall_level init/main.c:1336 [inline]
 do_initcalls init/main.c:1352 [inline]
 do_basic_setup init/main.c:1371 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1584
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888107ebf680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888107ebf700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888107ebf780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff888107ebf800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888107ebf880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
