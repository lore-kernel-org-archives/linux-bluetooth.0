Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CC369D56
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187654; cv=none; b=bXR5v1XNuoVC11h/1KkfD0u3lYm2iTUMGMQ+4ZNGDAAvLJzkpNk0UK2e/sPbxjl0mVYOwIDlVT54OmDUC+vvZ1BWxMpCaVviUwsjYWopMgs1jWAORfhdE2tnOihbbac/0dsCtTfL8+RQQio7KBIctNlGzF+uZUeG6rLXcSmJA1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187654; c=relaxed/simple;
	bh=NpDq0QVPIbABqsBEQzWj07PPeFtC4J3oOdcAnJRNEeQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g2fOh+Rxbqy20XHSHFjzLWWVK/o6T9rEL36MGWK/u4BGfP1VpTQ8OvWCS6S99uosaplFvI9t7x/nYQEZSr5hl8DYyMeLSeQZRX2ibFbWYJHJIP9yGcMN0Ygr2RGSQajPozCScq6E6XCu0CZEA8OJt5zhfJRoylc1O238OUq7CMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-43a55fd90faso3004823fac.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 03:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187652; x=1779792452;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJ9UjoBWE13MpAMcHncfPXHgsKRwiHLAn4nv/eDd1dc=;
        b=hea5hSFInSl3WPjDejfJRRft3oEN0MgO4cV17/GEoMw26nBh1kWOOxLdVUB0r3JTOF
         +V+rcPKCVnyLXtyN8fyvnh9dO0HtZW7X4MWCKUxEG06uuOSHNUF02NZ31FLdwAfY6nfk
         5tkBeqxxmWya9FF83ErdjDNqDxcL162RDGqtHroIbZUXL8HTYA9JY4qLpqf8MyM/FRSG
         IGmP8Ag+CEIEsGmkIwabkqoTM3AnOrUsTLHYXXw+Ub1sKDwfb39jdDLnRB0sFBNQdtcg
         +U+rIVacNj1NonRE6s3zhtEFXonE1yW9nbfvkG5tD86GO5usc6HGMQXjjCOWrHx6VNb8
         Kh1g==
X-Gm-Message-State: AOJu0YyIdggSOuGRFA9q0DPTZJJJ2LbV/e/KYWl6m+6GESibJV/3bpNd
	t3sYga0R8Mx4yegnHEy6x3hWlHer01KonQSSwavj45/V6CgqWpnPTt48fmc999ylJ4+CGcjlTpE
	PMmyhraxnllf1tH2m+yw3rig5mnRGKuwFO/3UlFbVKxGtAG33lu1I/K6cJXePbA==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee08:0:b0:67e:1be4:d8d4 with SMTP id
 006d021491bc7-69c9435b61cmr12019968eaf.21.1779187652227; Tue, 19 May 2026
 03:47:32 -0700 (PDT)
Date: Tue, 19 May 2026 03:47:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0c3fc4.a00a0220.2ee31e.0002.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in skb_dequeue (2)
From: syzbot <syzbot+d06554f43a8fb48030b0@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e98d21c170b0 Add linux-next specific files for 20260508
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d7df6c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59b98218d9b2edf4
dashboard link: https://syzkaller.appspot.com/bug?extid=d06554f43a8fb48030b0
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/66f2a00ee290/disk-e98d21c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b982257ce9e/vmlinux-e98d21c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a73fbea43e1a/bzImage-e98d21c1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d06554f43a8fb48030b0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
Read of size 1 at addr ffff888029fc01a8 by task kworker/1:1/10569

CPU: 1 UID: 0 PID: 10569 Comm: kworker/1:1 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: events btusb_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x84/0x350 kernel/locking/lockdep.c:5844
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
 rtlock_slowlock kernel/locking/rtmutex.c:1918 [inline]
 rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
 rt_spin_lock+0x157/0x400 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 skb_dequeue+0x2d/0x150 net/core/skbuff.c:3943
 btusb_rx_work+0x27/0xd0 drivers/bluetooth/btusb.c:2477
 process_one_work+0x98b/0x1630 kernel/workqueue.c:3306
 process_scheduled_works kernel/workqueue.c:3389 [inline]
 worker_thread+0xb49/0x1140 kernel/workqueue.c:3470
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 8189:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3a6/0x690 mm/slub.c:5432
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 btusb_probe+0x396/0x3050 drivers/bluetooth/btusb.c:4086
 usb_probe_interface+0x659/0xc70 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:707
 __driver_probe_device+0x1e2/0x350 drivers/base/dd.c:869
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:899
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1027
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1099
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1154
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7ec/0xb90 drivers/base/core.c:3702
 usb_set_configuration+0x1a87/0x2110 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:707
 __driver_probe_device+0x1e2/0x350 drivers/base/dd.c:869
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:899
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1027
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1099
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1154
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7ec/0xb90 drivers/base/core.c:3702
 usb_new_device+0x9f8/0x16e0 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x2a49/0x4f60 drivers/usb/core/hub.c:5953
 process_one_work+0x98b/0x1630 kernel/workqueue.c:3306
 process_scheduled_works kernel/workqueue.c:3389 [inline]
 worker_thread+0xb49/0x1140 kernel/workqueue.c:3470
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 8189:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2700 [inline]
 slab_free mm/slub.c:6291 [inline]
 kfree+0x1c5/0x6c0 mm/slub.c:6606
 usb_unbind_interface+0x26e/0x910 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:619 [inline]
 __device_release_driver drivers/base/dd.c:1350 [inline]
 device_release_driver_internal+0x4d9/0x870 drivers/base/dd.c:1373
 bus_remove_device+0x45a/0x570 drivers/base/bus.c:664
 device_del+0x52b/0x900 drivers/base/core.c:3891
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x315/0x970 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1cf9/0x4f60 drivers/usb/core/hub.c:5953
 process_one_work+0x98b/0x1630 kernel/workqueue.c:3306
 process_scheduled_works kernel/workqueue.c:3389 [inline]
 worker_thread+0xb49/0x1140 kernel/workqueue.c:3470
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2226
 __queue_work+0xcfd/0x1010 kernel/workqueue.c:2381
 queue_delayed_work_on+0x11a/0x1e0 kernel/workqueue.c:2600
 queue_delayed_work include/linux/workqueue.h:713 [inline]
 schedule_delayed_work include/linux/workqueue.h:855 [inline]
 btusb_recv_event drivers/bluetooth/btusb.c:1233 [inline]
 btusb_recv_intr+0x48a/0x750 drivers/bluetooth/btusb.c:1296
 btusb_intr_complete+0x164/0x4c0 drivers/bluetooth/btusb.c:1481
 __usb_hcd_giveback_urb+0x3b3/0x5e0 drivers/usb/core/hcd.c:1657
 dummy_timer+0x8a9/0x47d0 drivers/usb/gadget/udc/dummy_hcd.c:2005
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x405/0xb10 kernel/time/hrtimer.c:2096
 hrtimer_run_softirq+0x18f/0x260 kernel/time/hrtimer.c:2113
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1155
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888029fc0000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 424 bytes inside of
 freed 4096-byte region [ffff888029fc0000, ffff888029fc1000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29fc0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813fea2140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813fea2140 dead000000000100 dead000000000122
head: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12506, tgid 12506 (udevd), ts 1311497819285, free_ts 1308795551293
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1861
 prep_new_page mm/page_alloc.c:1869 [inline]
 get_page_from_freelist+0x27d6/0x2850 mm/page_alloc.c:3949
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5292
 alloc_slab_page mm/slub.c:3289 [inline]
 allocate_slab+0x74/0x5e0 mm/slub.c:3404
 new_slab mm/slub.c:3447 [inline]
 refill_objects+0x33c/0x3d0 mm/slub.c:7319
 refill_sheaf mm/slub.c:2827 [inline]
 __pcs_replace_empty_main+0x373/0x720 mm/slub.c:4664
 alloc_from_pcs mm/slub.c:4762 [inline]
 slab_alloc_node mm/slub.c:4896 [inline]
 __do_kmalloc_node mm/slub.c:5307 [inline]
 __kmalloc_noprof+0x530/0x7b0 mm/slub.c:5320
 kmalloc_noprof include/linux/slab.h:954 [inline]
 tomoyo_realpath_from_path+0xe3/0x5d0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path2_perm+0x2e7/0x760 security/tomoyo/file.c:928
 tomoyo_path_rename+0x14e/0x1b0 security/tomoyo/tomoyo.c:300
 security_path_rename+0x248/0x460 security/security.c:1544
 filename_renameat2+0x4c1/0x9c0 fs/namei.c:6167
 __do_sys_rename fs/namei.c:6216 [inline]
 __se_sys_rename+0x55/0x2c0 fs/namei.c:6212
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 14890 tgid 14890 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1405 [inline]
 free_pages_prepare+0x900/0xa60 mm/page_alloc.c:1450
 __free_contig_range_common+0x174/0x340 mm/page_alloc.c:6883
 __free_contig_range mm/page_alloc.c:6928 [inline]
 free_pages_bulk+0x48/0x120 mm/page_alloc.c:5245
 vfree+0x292/0x390 mm/vmalloc.c:3467
 vb2_vmalloc_put+0x68/0xb0 drivers/media/common/videobuf2/videobuf2-vmalloc.c:68
 __vb2_buf_mem_free+0x119/0x2d0 drivers/media/common/videobuf2/videobuf2-core.c:275
 __vb2_free_mem drivers/media/common/videobuf2/videobuf2-core.c:571 [inline]
 __vb2_queue_free+0x414/0xb00 drivers/media/common/videobuf2/videobuf2-core.c:599
 vb2_core_reqbufs+0x7a0/0x1410 drivers/media/common/videobuf2/videobuf2-core.c:905
 __vb2_cleanup_fileio+0x109/0x1f0 drivers/media/common/videobuf2/videobuf2-core.c:2977
 vb2_core_queue_release+0x27/0x150 drivers/media/common/videobuf2/videobuf2-core.c:2676
 vb2_queue_release drivers/media/common/videobuf2/videobuf2-v4l2.c:956 [inline]
 _vb2_fop_release drivers/media/common/videobuf2/videobuf2-v4l2.c:1159 [inline]
 vb2_fop_release+0x171/0x200 drivers/media/common/videobuf2/videobuf2-v4l2.c:1173
 v4l2_release+0x1b2/0x370 drivers/media/v4l2-core/v4l2-dev.c:468
 __fput+0x461/0xa70 fs/file_table.c:510
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xf3/0x4d0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100

Memory state around the buggy address:
 ffff888029fc0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029fc0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888029fc0180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888029fc0200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029fc0280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
