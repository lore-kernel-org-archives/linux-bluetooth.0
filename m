Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5C311C17
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373647; cv=none; b=nJr73vmCMTGMUinPZhVb+5WzPCiJmc11PhcNjGm050XSog6hFohLvEc5ulyGIQ8jlknWTjjOhrUh3tXaEfWu4yZJlZsg2g/zTFs5vsWMaCW2B40KX5xX2ZfKUPvfm7GEB/GVALSz8QzKWuG0O9GoDB0UwKzCI1u7QeEyjUfzKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373647; c=relaxed/simple;
	bh=uPjOc1URbsXEHho8lJ6TdSQaemzhmKmFHkd30M0ArgU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B6U2d/yHMBY5/2J7dkGQHu9J7IqB8i4sBw2omIfZOuwm7dkpPswlqw2GDgKnM9bsYob1nnfdEapv0/0Pz9ErveNtZlSlsbkVi4UVtoAtxS83TKyuAEWqp0lb3/5rNtVDLsHIo0p7PsAEACuTQpxElDYc5qBgiv0vTuNZEl/bA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e7f4f7bb1so14937339f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 12:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373644; x=1762978444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inKJ+Ait9GvhaOwIPQaH3rEcfwjqAUHdNvAsxiTC6zw=;
        b=Vrk9mmB6IS82NxqjVMQZRheDZcmJ5pIk7fH6OECeXOkdGkskKDk52xV4T0gd5CBqFS
         eC73/wowzC4TMQAPrb9Fz7WLoQg3iC2jfSJmYd+R4FMtHJttkUA0S6eImpyC9RfjPFxA
         fual917SPxQe8BlhIsjoLbbqLP8kLFerC7nsuC0UxOpxsSIFlKgzCUAzSsosVn7rRNmO
         FwfBQA4g3HsKD/+eLtqxlYcnZNBuKzT4HltZ/e+GQEaQ0mRirYTu7YFnG76dVYo3mbgO
         HCGsjKYXf4yNjzgTT2kHT5unxNSEBDr1kDjq28vasE0yDbRzPOrY6hV1eQ7vuhIetxJH
         oZpA==
X-Gm-Message-State: AOJu0Yyk1ahXPWaDxsYCTo0Xnh0v9evSkDPFzF6ylkkCXHnj4oVIEieY
	77HO3q2NQ1FaHo5ik8yqnvxzG+8lsgvApQUOmPmZ0QBABT7rwJBGZqCCQuj8OlcJt8HjdWIBi93
	/EJQDh74fvV5s6kumF56OfpPUlxfhyHmnVKilwtggkXVpPFIOoWUVoF3U0t4=
X-Google-Smtp-Source: AGHT+IG1H7SmaSNvosQvpZYx1EuOHtkXTc6KqSTp89YdEz5OWnfOapmFFP9wcy2ODvmcwK8xidme+iJ+f51GNVdgaevh5WWi4WLy
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d907:0:b0:433:4e9d:de90 with SMTP id
 e9e14a558f8ab-4334e9ddfa8mr12490115ab.21.1762373644276; Wed, 05 Nov 2025
 12:14:04 -0800 (PST)
Date: Wed, 05 Nov 2025 12:14:04 -0800
In-Reply-To: <8a4ec353-fe9d-4c7e-a56e-796280dc7f47@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690bb00c.050a0220.3d0d33.0096.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in l2cap_unregister_user

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_waiter_is_first kernel/locking/mutex.c:183 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock_common+0xd18/0x2678 kernel/locking/mutex.c:678
Read of size 8 at addr ffff0000de1180a0 by task khidpd_05c25886/7093

CPU: 0 UID: 0 PID: 7093 Comm: khidpd_05c25886 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 __mutex_waiter_is_first kernel/locking/mutex.c:183 [inline]
 __mutex_lock_common+0xd18/0x2678 kernel/locking/mutex.c:678
 __mutex_lock kernel/locking/mutex.c:760 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
 l2cap_unregister_user+0x74/0x190 net/bluetooth/l2cap_core.c:1728
 hidp_session_thread+0x3d0/0x46c net/bluetooth/hidp/core.c:1304
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

Allocated by task 6997:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:573
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5642 [inline]
 __kmalloc_noprof+0x3fc/0x728 mm/slub.c:5654
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 hci_alloc_dev_priv+0x2c/0x1b84 net/bluetooth/hci_core.c:2448
 hci_alloc_dev include/net/bluetooth/hci_core.h:1751 [inline]
 __vhci_create_device drivers/bluetooth/hci_vhci.c:421 [inline]
 vhci_create_device+0x108/0x638 drivers/bluetooth/hci_vhci.c:479
 vhci_get_user drivers/bluetooth/hci_vhci.c:536 [inline]
 vhci_write+0x314/0x3d4 drivers/bluetooth/hci_vhci.c:616
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x540/0xa3c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 7412:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 __kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x74/0xa4 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x184/0x600 mm/slub.c:6837
 hci_release_dev+0xf48/0x1060 net/bluetooth/hci_core.c:2776
 bt_host_release+0x70/0x8c net/bluetooth/hci_sysfs.c:87
 device_release+0x8c/0x1ac drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2b0/0x438 lib/kobject.c:737
 put_device+0x28/0x40 drivers/base/core.c:3797
 hci_free_dev+0x24/0x34 net/bluetooth/hci_core.c:2579
 vhci_release+0x134/0x17c drivers/bluetooth/hci_vhci.c:691
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x524/0x1a14 kernel/exit.c:966
 do_group_exit+0x194/0x22c kernel/exit.c:1107
 get_signal+0x11dc/0x12f8 kernel/signal.c:3034
 arch_do_signal_or_restart+0x274/0x4414 arch/arm64/kernel/signal.c:1619
 exit_to_user_mode_loop+0x7c/0x178 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:56
 kasan_record_aux_stack+0xb0/0xc8 mm/kasan/generic.c:559
 insert_work+0x54/0x2cc kernel/workqueue.c:2186
 __queue_work+0xc88/0x1210 kernel/workqueue.c:2345
 queue_work_on+0xdc/0x18c kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:669 [inline]
 hci_cmd_timeout+0x178/0x1c8 net/bluetooth/hci_core.c:1480
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3427
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

Second to last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:56
 kasan_record_aux_stack+0xb0/0xc8 mm/kasan/generic.c:559
 insert_work+0x54/0x2cc kernel/workqueue.c:2186
 __queue_work+0xdb0/0x1210 kernel/workqueue.c:2341
 delayed_work_timer_fn+0x74/0x90 kernel/workqueue.c:2487
 call_timer_fn+0x1b4/0x818 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1793 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x54c/0x76c kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xcc/0x194 kernel/time/timer.c:2403
 handle_softirqs+0x328/0xc88 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656

The buggy address belongs to the object at ffff0000de118000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 160 bytes inside of
 freed 8192-byte region [ffff0000de118000, ffff0000de11a000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11e118
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000040 ffff0000c0002280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 05ffc00000000040 ffff0000c0002280 0000000000000000 dead000000000001
head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 05ffc00000000003 fffffdffc3784601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000de117f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000de118000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000de118080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff0000de118100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000de118180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         8d59fba4 Bluetooth: MGMT: Fix OOB access in parse_adv_..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14d9a532580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eeb63aaf73b06da
dashboard link: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Note: no patches were applied.
