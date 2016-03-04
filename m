Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <CACT4Y+beTdUrUdwb1Drri=eFx5Cb9b4bT7uoyBMXHvxjvDxsVw@mail.gmail.com>
References: <CACT4Y+beTdUrUdwb1Drri=eFx5Cb9b4bT7uoyBMXHvxjvDxsVw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 4 Mar 2016 10:15:52 +0100
Message-ID: <CACT4Y+YcwPCUYmc96Pq5ReZes4O64HdMqSGzmZJjvah7bqjTMQ@mail.gmail.com>
Subject: Re: bluetooth: use-after-free in vhci_send_frame
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>,
	Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 29, 2016 at 9:50 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Hello,
>
> I've got the following use-after-free reports while running syzkaller
> fuzzer. Unfortunately no reproducer. But this happened when system was
> busy reacting on sysrq t, so probably some unexpected delay happended.
>
> On commit 92e963f50fc74041b5e9e744c330dca48e04f08d.
>
> ==================================================================
> BUG: KASAN: use-after-free in do_raw_spin_unlock+0x228/0x240 at addr
> ffff88003a8a9ed8
> Write of size 8 by task kworker/u12:2/10322
> =============================================================================
> BUG kmalloc-512 (Tainted: G    B          ): kasan: bad access detected
> -----------------------------------------------------------------------------
>
> INFO: Allocated in vhci_open+0x50/0x350 age=6743 cpu=0 pid=10397
> [<      none      >] ___slab_alloc+0x564/0x5b0 mm/slub.c:2470
> [<      none      >] __slab_alloc+0x66/0xc0 mm/slub.c:2499
> [<     inline     >] slab_alloc_node mm/slub.c:2562
> [<     inline     >] slab_alloc mm/slub.c:2604
> [<      none      >] kmem_cache_alloc_trace+0x25c/0x300 mm/slub.c:2621
> [<     inline     >] kmalloc include/linux/slab.h:463
> [<     inline     >] kzalloc include/linux/slab.h:607
> [<      none      >] vhci_open+0x50/0x350 drivers/bluetooth/hci_vhci.c:316
> [<      none      >] misc_open+0x388/0x520 drivers/char/misc.c:153
> [<      none      >] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
> [<      none      >] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
> [<      none      >] vfs_open+0x17b/0x1f0 fs/open.c:853
> [<     inline     >] do_last fs/namei.c:3254
> [<      none      >] path_openat+0xde9/0x5e30 fs/namei.c:3386
> [<      none      >] do_filp_open+0x18e/0x250 fs/namei.c:3421
> [<      none      >] do_sys_open+0x1fc/0x420 fs/open.c:1022
> [<     inline     >] SYSC_open fs/open.c:1040
> [<      none      >] SyS_open+0x2d/0x40 fs/open.c:1035
> [<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
> arch/x86/entry/entry_64.S:185
>
> INFO: Freed in vhci_release+0xae/0xe0 age=2072 cpu=2 pid=10397
> [<      none      >] __slab_free+0x1fc/0x320 mm/slub.c:2680
> [<     inline     >] slab_free mm/slub.c:2835
> [<      none      >] kfree+0x2ac/0x2c0 mm/slub.c:3664
> [<      none      >] vhci_release+0xae/0xe0 drivers/bluetooth/hci_vhci.c:346
> [<      none      >] __fput+0x236/0x780 fs/file_table.c:208
> [<      none      >] ____fput+0x15/0x20 fs/file_table.c:244
> [<      none      >] task_work_run+0x170/0x210 kernel/task_work.c:115
> [<     inline     >] exit_task_work include/linux/task_work.h:21
> [<      none      >] do_exit+0x8b5/0x2cb0 kernel/exit.c:748
> [<      none      >] do_group_exit+0x108/0x330 kernel/exit.c:878
> [<      none      >] get_signal+0x5e4/0x14f0 kernel/signal.c:2307
> [<      none      >] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
> [<      none      >] exit_to_usermode_loop+0x1a5/0x210
> arch/x86/entry/common.c:247
> [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
> [<      none      >] syscall_return_slowpath+0x2ba/0x340
> arch/x86/entry/common.c:344
> [<      none      >] int_ret_from_sys_call+0x25/0x9f
> arch/x86/entry/entry_64.S:281
>
> INFO: Slab 0xffffea0000ea2a00 objects=16 used=14 fp=0xffff88003a8a9ec0
> flags=0x1fffc0000004080
> INFO: Object 0xffff88003a8a9ec0 @offset=7872 fp=0xffff88003a8a9ae8
> CPU: 1 PID: 10322 Comm: kworker/u12:2 Tainted: G    B           4.5.0-rc1+ #300
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Workqueue: hci0 hci_cmd_work
>  00000000ffffffff ffff88003634f9f8 ffffffff82be118d ffff88003e804f00
>  ffff88003a8a9ec0 ffff88003a8a8000 ffff88003634fa28 ffffffff8175b434
>  ffff88003e804f00 ffffea0000ea2a00 ffff88003a8a9ec0 0000000000000001
>
> Call Trace:
>  [<     inline     >] kasan_report mm/kasan/report.c:274
>  [<ffffffff81764f9e>] __asan_report_store8_noabort+0x3e/0x40
> mm/kasan/report.c:300
>  [<     inline     >] debug_spin_unlock kernel/locking/spinlock_debug.c:102
>  [<ffffffff81466608>] do_raw_spin_unlock+0x228/0x240
> kernel/locking/spinlock_debug.c:158
>  [<     inline     >] __raw_spin_unlock_irqrestore
> include/linux/spinlock_api_smp.h:161
>  [<ffffffff86652cf7>] _raw_spin_unlock_irqrestore+0x27/0xc0
> kernel/locking/spinlock.c:191
>  [<     inline     >] spin_unlock_irqrestore include/linux/spinlock.h:362
>  [<ffffffff8143975f>] __wake_up+0x3f/0x50 kernel/sched/wait.c:96
>  [<ffffffff8484b983>] vhci_send_frame+0xc3/0x100 drivers/bluetooth/hci_vhci.c:86
>  [<ffffffff85d38315>] hci_send_frame+0x1f5/0x310 net/bluetooth/hci_core.c:3316
>  [<ffffffff85d385bf>] hci_cmd_work+0x18f/0x2e0 net/bluetooth/hci_core.c:4196
>  [<ffffffff813a2386>] process_one_work+0x796/0x1440 kernel/workqueue.c:2037
>  [<ffffffff813a310b>] worker_thread+0xdb/0xfc0 kernel/workqueue.c:2171
>  [<ffffffff813b637f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
>  [<ffffffff866535ef>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
> ==================================================================
>
> ==================================================================
> BUG: KASAN: use-after-free in do_raw_spin_lock+0x281/0x2b0 at addr
> ffff88003a8a9f2c
> Read of size 4 by task kworker/u12:0/3554
> =============================================================================
> BUG kmalloc-512 (Tainted: G    B          ): kasan: bad access detected
> -----------------------------------------------------------------------------
>
> INFO: Allocated in vhci_open+0x50/0x350 age=16305 cpu=0 pid=10397
> [<      none      >] ___slab_alloc+0x564/0x5b0 mm/slub.c:2470
> [<      none      >] __slab_alloc+0x66/0xc0 mm/slub.c:2499
> [<     inline     >] slab_alloc_node mm/slub.c:2562
> [<     inline     >] slab_alloc mm/slub.c:2604
> [<      none      >] kmem_cache_alloc_trace+0x25c/0x300 mm/slub.c:2621
> [<     inline     >] kmalloc include/linux/slab.h:463
> [<     inline     >] kzalloc include/linux/slab.h:607
> [<      none      >] vhci_open+0x50/0x350 drivers/bluetooth/hci_vhci.c:316
> [<      none      >] misc_open+0x388/0x520 drivers/char/misc.c:153
> [<      none      >] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
> [<      none      >] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
> [<      none      >] vfs_open+0x17b/0x1f0 fs/open.c:853
> [<     inline     >] do_last fs/namei.c:3254
> [<      none      >] path_openat+0xde9/0x5e30 fs/namei.c:3386
> [<      none      >] do_filp_open+0x18e/0x250 fs/namei.c:3421
> [<      none      >] do_sys_open+0x1fc/0x420 fs/open.c:1022
> [<     inline     >] SYSC_open fs/open.c:1040
> [<      none      >] SyS_open+0x2d/0x40 fs/open.c:1035
> [<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
> arch/x86/entry/entry_64.S:185
>
> INFO: Freed in vhci_release+0xae/0xe0 age=11634 cpu=2 pid=10397
> [<      none      >] __slab_free+0x1fc/0x320 mm/slub.c:2680
> [<     inline     >] slab_free mm/slub.c:2835
> [<      none      >] kfree+0x2ac/0x2c0 mm/slub.c:3664
> [<      none      >] vhci_release+0xae/0xe0 drivers/bluetooth/hci_vhci.c:346
> [<      none      >] __fput+0x236/0x780 fs/file_table.c:208
> [<      none      >] ____fput+0x15/0x20 fs/file_table.c:244
> [<      none      >] task_work_run+0x170/0x210 kernel/task_work.c:115
> [<     inline     >] exit_task_work include/linux/task_work.h:21
> [<      none      >] do_exit+0x8b5/0x2cb0 kernel/exit.c:748
> [<      none      >] do_group_exit+0x108/0x330 kernel/exit.c:878
> [<      none      >] get_signal+0x5e4/0x14f0 kernel/signal.c:2307
> [<      none      >] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
> [<      none      >] exit_to_usermode_loop+0x1a5/0x210
> arch/x86/entry/common.c:247
> [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
> [<      none      >] syscall_return_slowpath+0x2ba/0x340
> arch/x86/entry/common.c:344
> [<      none      >] int_ret_from_sys_call+0x25/0x9f
> arch/x86/entry/entry_64.S:281
>
> INFO: Slab 0xffffea0000ea2a00 objects=16 used=12 fp=0xffff88003a8aaa48
> flags=0x1fffc0000004080
> INFO: Object 0xffff88003a8a9ec0 @offset=7872 fp=0xffff88003a8a9338
> CPU: 0 PID: 3554 Comm: kworker/u12:0 Tainted: G    B           4.5.0-rc1+ #300
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Workqueue: hci0 hci_power_on
>  00000000ffffffff ffff880036abf838 ffffffff82be118d ffff88003e804f00
>  ffff88003a8a9ec0 ffff88003a8a8000 ffff880036abf868 ffffffff8175b434
>  ffff88003e804f00 ffffea0000ea2a00 ffff88003a8a9ec0 ffff880036abfb30
>
> Call Trace:
>  [<     inline     >] kasan_report mm/kasan/report.c:274
>  [<ffffffff81764e1e>] __asan_report_load4_noabort+0x3e/0x40
> mm/kasan/report.c:294
>  [<     inline     >] debug_spin_lock_before kernel/locking/spinlock_debug.c:83
>  [<ffffffff814662e1>] do_raw_spin_lock+0x281/0x2b0
> kernel/locking/spinlock_debug.c:135
>  [<     inline     >] __raw_spin_lock_irqsave
> include/linux/spinlock_api_smp.h:119
>  [<ffffffff86652bd7>] _raw_spin_lock_irqsave+0xa7/0xd0
> kernel/locking/spinlock.c:159
>  [<ffffffff854da1b2>] skb_dequeue+0x22/0x180 net/core/skbuff.c:2333
>  [<ffffffff854de656>] skb_queue_purge+0x26/0x40 net/core/skbuff.c:2371
>  [<ffffffff8484b9fb>] vhci_flush+0x3b/0x50 drivers/bluetooth/hci_vhci.c:74
>  [<ffffffff85d3a02f>] hci_dev_do_open+0x62f/0xf60 net/bluetooth/hci_core.c:1417
>  [<ffffffff85d42b98>] hci_power_on+0x108/0x4b0 net/bluetooth/hci_core.c:2027
>  [<ffffffff813a2386>] process_one_work+0x796/0x1440 kernel/workqueue.c:2037
>  [<ffffffff813a310b>] worker_thread+0xdb/0xfc0 kernel/workqueue.c:2171
>  [<ffffffff813b637f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
>  [<ffffffff866535ef>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
> ==================================================================
> ==================================================================
> BUG: KASAN: use-after-free in skb_dequeue+0x153/0x180 at addr ffff88003a8a9f10
> Read of size 8 by task kworker/u12:0/3554
> =============================================================================
> BUG kmalloc-512 (Tainted: G    B          ): kasan: bad access detected
> -----------------------------------------------------------------------------
>
> INFO: Allocated in vhci_open+0x50/0x350 age=16913 cpu=0 pid=10397
> [<     inline     >] slab_alloc_node mm/slub.c:2562
> [<     inline     >] slab_alloc mm/slub.c:2604
> [<      none      >] kmem_cache_alloc_trace+0x25c/0x300 mm/slub.c:2621
> [<     inline     >] kmalloc include/linux/slab.h:463
> [<     inline     >] kzalloc include/linux/slab.h:607
> [<      none      >] vhci_open+0x50/0x350 drivers/bluetooth/hci_vhci.c:316
> [<      none      >] misc_open+0x388/0x520 drivers/char/misc.c:153
> [<      none      >] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
> [<      none      >] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
> [<      none      >] vfs_open+0x17b/0x1f0 fs/open.c:853
> [<     inline     >] do_last fs/namei.c:3254
> [<      none      >] path_openat+0xde9/0x5e30 fs/namei.c:3386
> [<      none      >] do_filp_open+0x18e/0x250 fs/namei.c:3421
> [<      none      >] do_sys_open+0x1fc/0x420 fs/open.c:1022
> [<     inline     >] SYSC_open fs/open.c:1040
> [<      none      >] SyS_open+0x2d/0x40 fs/open.c:1035
> [<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
> arch/x86/entry/entry_64.S:185
>
> INFO: Freed in vhci_release+0xae/0xe0 age=12241 cpu=2 pid=10397
> [<     inline     >] slab_free mm/slub.c:2835
> [<      none      >] kfree+0x2ac/0x2c0 mm/slub.c:3664
> [<      none      >] vhci_release+0xae/0xe0 drivers/bluetooth/hci_vhci.c:346
> [<      none      >] __fput+0x236/0x780 fs/file_table.c:208
> [<      none      >] ____fput+0x15/0x20 fs/file_table.c:244
> [<      none      >] task_work_run+0x170/0x210 kernel/task_work.c:115
> [<     inline     >] exit_task_work include/linux/task_work.h:21
> [<      none      >] do_exit+0x8b5/0x2cb0 kernel/exit.c:748
> [<      none      >] do_group_exit+0x108/0x330 kernel/exit.c:878
> [<      none      >] get_signal+0x5e4/0x14f0 kernel/signal.c:2307
> [<      none      >] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
> [<      none      >] exit_to_usermode_loop+0x1a5/0x210
> arch/x86/entry/common.c:247
> [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
> [<      none      >] syscall_return_slowpath+0x2ba/0x340
> arch/x86/entry/common.c:344
> [<      none      >] int_ret_from_sys_call+0x25/0x9f
> arch/x86/entry/entry_64.S:281
>
> INFO: Slab 0xffffea0000ea2a00 objects=16 used=12 fp=0xffff88003a8aaa48
> flags=0x1fffc0000004080
> INFO: Object 0xffff88003a8a9ec0 @offset=7872 fp=0xffff88003a8a9338
> CPU: 0 PID: 3554 Comm: kworker/u12:0 Tainted: G    B           4.5.0-rc1+ #300
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Workqueue: hci0 hci_power_on
>  00000000ffffffff ffff880036abf898 ffffffff82be118d ffff88003e804f00
>  ffff88003a8a9ec0 ffff88003a8a8000 ffff880036abf8c8 ffffffff8175b434
>  ffff88003e804f00 ffffea0000ea2a00 ffff88003a8a9ec0 0000000000000282
>
> Call Trace:
>  [<     inline     >] kasan_report mm/kasan/report.c:274
>  [<ffffffff81764e5e>] __asan_report_load8_noabort+0x3e/0x40
> mm/kasan/report.c:295
>  [<     inline     >] skb_peek include/linux/skbuff.h:1453
>  [<     inline     >] __skb_dequeue include/linux/skbuff.h:1735
>  [<ffffffff854da2e3>] skb_dequeue+0x153/0x180 net/core/skbuff.c:2334
>  [<ffffffff854de656>] skb_queue_purge+0x26/0x40 net/core/skbuff.c:2371
>  [<ffffffff8484b9fb>] vhci_flush+0x3b/0x50 drivers/bluetooth/hci_vhci.c:74
>  [<ffffffff85d3a02f>] hci_dev_do_open+0x62f/0xf60 net/bluetooth/hci_core.c:1417
>  [<ffffffff85d42b98>] hci_power_on+0x108/0x4b0 net/bluetooth/hci_core.c:2027
>  [<ffffffff813a2386>] process_one_work+0x796/0x1440 kernel/workqueue.c:2037
>  [<ffffffff813a310b>] worker_thread+0xdb/0xfc0 kernel/workqueue.c:2171
>  [<ffffffff813b637f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
>  [<ffffffff866535ef>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
> ==================================================================



Ping.
Just got another one on 4.5-rc6

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x4864/0x49c0 at addr
ffff8800353b8c08
Read of size 8 by task kworker/u12:2/1443
=============================================================================
BUG kmalloc-512 (Not tainted): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in vhci_open+0x50/0x350 age=1048 cpu=0 pid=1394
[<      none      >] ___slab_alloc+0x574/0x5c0 mm/slub.c:2464
[<      none      >] __slab_alloc+0x66/0xc0 mm/slub.c:2493
[<     inline     >] slab_alloc_node mm/slub.c:2556
[<     inline     >] slab_alloc mm/slub.c:2598
[<      none      >] kmem_cache_alloc_trace+0x27c/0x350 mm/slub.c:2615
[<     inline     >] kmalloc include/linux/slab.h:463
[<     inline     >] kzalloc include/linux/slab.h:607
[<      none      >] vhci_open+0x50/0x350 drivers/bluetooth/hci_vhci.c:316
[<      none      >] misc_open+0x388/0x520 drivers/char/misc.c:153
[<      none      >] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
[<      none      >] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
[<      none      >] vfs_open+0x17b/0x1f0 fs/open.c:853
[<     inline     >] do_last fs/namei.c:3258
[<      none      >] path_openat+0x4849/0x5840 fs/namei.c:3394
[<      none      >] do_filp_open+0x18e/0x250 fs/namei.c:3429
[<      none      >] do_sys_open+0x1fc/0x420 fs/open.c:1022
[<     inline     >] SYSC_open fs/open.c:1040
[<      none      >] SyS_open+0x2d/0x40 fs/open.c:1035
[<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185

INFO: Freed in vhci_release+0xae/0xe0 age=23 cpu=2 pid=1394
[<      none      >] __slab_free+0x1fc/0x320 mm/slub.c:2674
[<     inline     >] slab_free mm/slub.c:2829
[<      none      >] kfree+0x303/0x320 mm/slub.c:3660
[<      none      >] vhci_release+0xae/0xe0 drivers/bluetooth/hci_vhci.c:346
[<      none      >] __fput+0x236/0x780 fs/file_table.c:208
[<      none      >] ____fput+0x15/0x20 fs/file_table.c:244
[<      none      >] task_work_run+0x170/0x210 kernel/task_work.c:115
[<     inline     >] exit_task_work include/linux/task_work.h:21
[<      none      >] do_exit+0xaf0/0x2d20 kernel/exit.c:748
[<      none      >] do_group_exit+0x108/0x330 kernel/exit.c:878
[<      none      >] get_signal+0x628/0x1560 kernel/signal.c:2307
[<      none      >] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
[<      none      >] exit_to_usermode_loop+0x1a5/0x210
arch/x86/entry/common.c:247
[<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
[<      none      >] syscall_return_slowpath+0x2ba/0x340
arch/x86/entry/common.c:344
[<      none      >] int_ret_from_sys_call+0x25/0x9f
arch/x86/entry/entry_64.S:281

INFO: Slab 0xffffea0000d4ee00 objects=16 used=15 fp=0xffff8800353b8b88
flags=0x1fffc0000004080
INFO: Object 0xffff8800353b8b88 @offset=2952 fp=0x          (null)
CPU: 0 PID: 1443 Comm: kworker/u12:2 Tainted: G    B           4.5.0-rc6+ #335
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: hci0 hci_cmd_work
 ffffffff87b4d480 ffff880031427800 ffffffff82c0664f ffffffff00d4ee00
 fffffbfff0f69a90 ffff88003e804f00 ffff8800353b8b88 ffff8800353b8000
 ffffea0000d4ee00 0000000000000000 ffff880031427830 ffffffff81767194

Call Trace:
 [<     inline     >] __dump_stack lib/dump_stack.c:15
 [<ffffffff82c0664f>] dump_stack+0x12e/0x18f lib/dump_stack.c:51
 [<ffffffff81767194>] print_trailer+0xf4/0x150 mm/slub.c:661
 [<ffffffff8176e46f>] object_err+0x2f/0x40 mm/slub.c:691
 [<     inline     >] print_address_description mm/kasan/report.c:138
 [<ffffffff81770d96>] kasan_report_error+0x256/0x550 mm/kasan/report.c:251
 [<     inline     >] kasan_report mm/kasan/report.c:274
 [<ffffffff8177118e>] __asan_report_load8_noabort+0x3e/0x40
mm/kasan/report.c:295
 [<ffffffff81460c04>] __lock_acquire+0x4864/0x49c0 kernel/locking/lockdep.c:3096
 [<ffffffff81463269>] lock_acquire+0x1f9/0x460 kernel/locking/lockdep.c:3589
 [<     inline     >] __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:112
 [<ffffffff866a1eaf>] _raw_spin_lock_irqsave+0x9f/0xd0
kernel/locking/spinlock.c:159
 [<ffffffff85516c76>] skb_queue_tail+0x26/0x150 net/core/skbuff.c:2414
 [<ffffffff84881fee>] vhci_send_frame+0xae/0x100 drivers/bluetooth/hci_vhci.c:84
 [<ffffffff85d769b5>] hci_send_frame+0x1f5/0x310 net/bluetooth/hci_core.c:3316
 [<ffffffff85d76c5f>] hci_cmd_work+0x18f/0x2e0 net/bluetooth/hci_core.c:4198
 [<ffffffff813abf3b>] process_one_work+0x79b/0x1510 kernel/workqueue.c:2096
 [<ffffffff813acd8b>] worker_thread+0xdb/0xfc0 kernel/workqueue.c:2230
 [<ffffffff813bdd3f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
 [<ffffffff866a28af>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
==================================================================
