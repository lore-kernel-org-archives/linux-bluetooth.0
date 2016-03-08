Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: bluetooth: use-after-free in vhci_send_frame
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACT4Y+Y25MbZ9nvfTuW9imKV9B9-cpfZGK8orXuVwE6d_f4zQA@mail.gmail.com>
Date: Tue, 8 Mar 2016 10:32:16 -0800
Cc: Jiri Slaby <jslaby@suse.cz>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	syzkaller <syzkaller@googlegroups.com>,
	Kostya Serebryany <kcc@google.com>,
	Alexander Potapenko <glider@google.com>,
	Sasha Levin <sasha.levin@oracle.com>
Message-Id: <054BECDB-E7C1-4241-B298-FED0CEE6F3B2@holtmann.org>
References: <CACT4Y+beTdUrUdwb1Drri=eFx5Cb9b4bT7uoyBMXHvxjvDxsVw@mail.gmail.com> <CACT4Y+YcwPCUYmc96Pq5ReZes4O64HdMqSGzmZJjvah7bqjTMQ@mail.gmail.com> <56DDAC0F.7060500@suse.cz> <8FB90CCF-CB45-44C9-BF62-CFEE2B2B7CC5@holtmann.org> <CACT4Y+Y25MbZ9nvfTuW9imKV9B9-cpfZGK8orXuVwE6d_f4zQA@mail.gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

>>>>> I've got the following use-after-free reports while running syzkaller
>>>>> fuzzer. Unfortunately no reproducer. But this happened when system was
>>>>> busy reacting on sysrq t, so probably some unexpected delay happended.
>>>>> 
>>>>> On commit 92e963f50fc74041b5e9e744c330dca48e04f08d.
>>>>> 
>>>>> ==================================================================
>>>>> BUG: KASAN: use-after-free in do_raw_spin_unlock+0x228/0x240 at addr
>>>>> ffff88003a8a9ed8
>>>>> Write of size 8 by task kworker/u12:2/10322
>>>>> =============================================================================
>>>>> BUG kmalloc-512 (Tainted: G    B          ): kasan: bad access detected
>>>>> -----------------------------------------------------------------------------
>>>>> 
>>>>> INFO: Allocated in vhci_open+0x50/0x350 age=6743 cpu=0 pid=10397
>>>>> [<      none      >] ___slab_alloc+0x564/0x5b0 mm/slub.c:2470
>>>>> [<      none      >] __slab_alloc+0x66/0xc0 mm/slub.c:2499
>>>>> [<     inline     >] slab_alloc_node mm/slub.c:2562
>>>>> [<     inline     >] slab_alloc mm/slub.c:2604
>>>>> [<      none      >] kmem_cache_alloc_trace+0x25c/0x300 mm/slub.c:2621
>>>>> [<     inline     >] kmalloc include/linux/slab.h:463
>>>>> [<     inline     >] kzalloc include/linux/slab.h:607
>>>>> [<      none      >] vhci_open+0x50/0x350 drivers/bluetooth/hci_vhci.c:316
>>>>> [<      none      >] misc_open+0x388/0x520 drivers/char/misc.c:153
>>>>> [<      none      >] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
>>>>> [<      none      >] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
>>>>> [<      none      >] vfs_open+0x17b/0x1f0 fs/open.c:853
>>>>> [<     inline     >] do_last fs/namei.c:3254
>>>>> [<      none      >] path_openat+0xde9/0x5e30 fs/namei.c:3386
>>>>> [<      none      >] do_filp_open+0x18e/0x250 fs/namei.c:3421
>>>>> [<      none      >] do_sys_open+0x1fc/0x420 fs/open.c:1022
>>>>> [<     inline     >] SYSC_open fs/open.c:1040
>>>>> [<      none      >] SyS_open+0x2d/0x40 fs/open.c:1035
>>>>> [<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
>>>>> arch/x86/entry/entry_64.S:185
>>>>> 
>>>>> INFO: Freed in vhci_release+0xae/0xe0 age=2072 cpu=2 pid=10397
>>>>> [<      none      >] __slab_free+0x1fc/0x320 mm/slub.c:2680
>>>>> [<     inline     >] slab_free mm/slub.c:2835
>>>>> [<      none      >] kfree+0x2ac/0x2c0 mm/slub.c:3664
>>>>> [<      none      >] vhci_release+0xae/0xe0 drivers/bluetooth/hci_vhci.c:346
>>>>> [<      none      >] __fput+0x236/0x780 fs/file_table.c:208
>>>>> [<      none      >] ____fput+0x15/0x20 fs/file_table.c:244
>>>>> [<      none      >] task_work_run+0x170/0x210 kernel/task_work.c:115
>>>>> [<     inline     >] exit_task_work include/linux/task_work.h:21
>>>>> [<      none      >] do_exit+0x8b5/0x2cb0 kernel/exit.c:748
>>>>> [<      none      >] do_group_exit+0x108/0x330 kernel/exit.c:878
>>>>> [<      none      >] get_signal+0x5e4/0x14f0 kernel/signal.c:2307
>>>>> [<      none      >] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
>>>>> [<      none      >] exit_to_usermode_loop+0x1a5/0x210
>>>>> arch/x86/entry/common.c:247
>>>>> [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
>>>>> [<      none      >] syscall_return_slowpath+0x2ba/0x340
>>>>> arch/x86/entry/common.c:344
>>>>> [<      none      >] int_ret_from_sys_call+0x25/0x9f
>>>>> arch/x86/entry/entry_64.S:281
>>>>> 
>>>>> INFO: Slab 0xffffea0000ea2a00 objects=16 used=14 fp=0xffff88003a8a9ec0
>>>>> flags=0x1fffc0000004080
>>>>> INFO: Object 0xffff88003a8a9ec0 @offset=7872 fp=0xffff88003a8a9ae8
>>>>> CPU: 1 PID: 10322 Comm: kworker/u12:2 Tainted: G    B           4.5.0-rc1+ #300
>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>>>>> Workqueue: hci0 hci_cmd_work
>>>>> 00000000ffffffff ffff88003634f9f8 ffffffff82be118d ffff88003e804f00
>>>>> ffff88003a8a9ec0 ffff88003a8a8000 ffff88003634fa28 ffffffff8175b434
>>>>> ffff88003e804f00 ffffea0000ea2a00 ffff88003a8a9ec0 0000000000000001
>>>>> 
>>>>> Call Trace:
>>>>> [<     inline     >] kasan_report mm/kasan/report.c:274
>>>>> [<ffffffff81764f9e>] __asan_report_store8_noabort+0x3e/0x40
>>>>> mm/kasan/report.c:300
>>>>> [<     inline     >] debug_spin_unlock kernel/locking/spinlock_debug.c:102
>>>>> [<ffffffff81466608>] do_raw_spin_unlock+0x228/0x240
>>>>> kernel/locking/spinlock_debug.c:158
>>>>> [<     inline     >] __raw_spin_unlock_irqrestore
>>>>> include/linux/spinlock_api_smp.h:161
>>>>> [<ffffffff86652cf7>] _raw_spin_unlock_irqrestore+0x27/0xc0
>>>>> kernel/locking/spinlock.c:191
>>>>> [<     inline     >] spin_unlock_irqrestore include/linux/spinlock.h:362
>>>>> [<ffffffff8143975f>] __wake_up+0x3f/0x50 kernel/sched/wait.c:96
>>>>> [<ffffffff8484b983>] vhci_send_frame+0xc3/0x100 drivers/bluetooth/hci_vhci.c:86
>>>>> [<ffffffff85d38315>] hci_send_frame+0x1f5/0x310 net/bluetooth/hci_core.c:3316
>>>>> [<ffffffff85d385bf>] hci_cmd_work+0x18f/0x2e0 net/bluetooth/hci_core.c:4196
>>>>> [<ffffffff813a2386>] process_one_work+0x796/0x1440 kernel/workqueue.c:2037
>>>>> [<ffffffff813a310b>] worker_thread+0xdb/0xfc0 kernel/workqueue.c:2171
>>>>> [<ffffffff813b637f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
>>>>> [<ffffffff866535ef>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
>>>>> ==================================================================
>>>>> 
>>>>> ==================================================================
>>>>> BUG: KASAN: use-after-free in do_raw_spin_lock+0x281/0x2b0 at addr
>>>>> ffff88003a8a9f2c
>>>>> Read of size 4 by task kworker/u12:0/3554
>>>>> =============================================================================
>>>>> BUG kmalloc-512 (Tainted: G    B          ): kasan: bad access detected
>>>>> -----------------------------------------------------------------------------
>>>>> 
>>>>> INFO: Allocated in vhci_open+0x50/0x350 age=16305 cpu=0 pid=10397
>>>>> [<      none      >] ___slab_alloc+0x564/0x5b0 mm/slub.c:2470
>>>>> [<      none      >] __slab_alloc+0x66/0xc0 mm/slub.c:2499
>>>>> [<     inline     >] slab_alloc_node mm/slub.c:2562
>>>>> [<     inline     >] slab_alloc mm/slub.c:2604
>>>>> [<      none      >] kmem_cache_alloc_trace+0x25c/0x300 mm/slub.c:2621
>>>>> [<     inline     >] kmalloc include/linux/slab.h:463
>>>>> [<     inline     >] kzalloc include/linux/slab.h:607
>>>>> [<      none      >] vhci_open+0x50/0x350 drivers/bluetooth/hci_vhci.c:316
>>>>> [<      none      >] misc_open+0x388/0x520 drivers/char/misc.c:153
>>>>> [<      none      >] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
>>>>> [<      none      >] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
>>>>> [<      none      >] vfs_open+0x17b/0x1f0 fs/open.c:853
>>>>> [<     inline     >] do_last fs/namei.c:3254
>>>>> [<      none      >] path_openat+0xde9/0x5e30 fs/namei.c:3386
>>>>> [<      none      >] do_filp_open+0x18e/0x250 fs/namei.c:3421
>>>>> [<      none      >] do_sys_open+0x1fc/0x420 fs/open.c:1022
>>>>> [<     inline     >] SYSC_open fs/open.c:1040
>>>>> [<      none      >] SyS_open+0x2d/0x40 fs/open.c:1035
>>>>> [<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
>>>>> arch/x86/entry/entry_64.S:185
>>>>> 
>>>>> INFO: Freed in vhci_release+0xae/0xe0 age=11634 cpu=2 pid=10397
>>>>> [<      none      >] __slab_free+0x1fc/0x320 mm/slub.c:2680
>>>>> [<     inline     >] slab_free mm/slub.c:2835
>>>>> [<      none      >] kfree+0x2ac/0x2c0 mm/slub.c:3664
>>>>> [<      none      >] vhci_release+0xae/0xe0 drivers/bluetooth/hci_vhci.c:346
>>>>> [<      none      >] __fput+0x236/0x780 fs/file_table.c:208
>>>>> [<      none      >] ____fput+0x15/0x20 fs/file_table.c:244
>>>>> [<      none      >] task_work_run+0x170/0x210 kernel/task_work.c:115
>>>>> [<     inline     >] exit_task_work include/linux/task_work.h:21
>>>>> [<      none      >] do_exit+0x8b5/0x2cb0 kernel/exit.c:748
>>>>> [<      none      >] do_group_exit+0x108/0x330 kernel/exit.c:878
>>>>> [<      none      >] get_signal+0x5e4/0x14f0 kernel/signal.c:2307
>>>>> [<      none      >] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
>>>>> [<      none      >] exit_to_usermode_loop+0x1a5/0x210
>>>>> arch/x86/entry/common.c:247
>>>>> [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
>>>>> [<      none      >] syscall_return_slowpath+0x2ba/0x340
>>>>> arch/x86/entry/common.c:344
>>>>> [<      none      >] int_ret_from_sys_call+0x25/0x9f
>>>>> arch/x86/entry/entry_64.S:281
>>>>> 
>>>>> INFO: Slab 0xffffea0000ea2a00 objects=16 used=12 fp=0xffff88003a8aaa48
>>>>> flags=0x1fffc0000004080
>>>>> INFO: Object 0xffff88003a8a9ec0 @offset=7872 fp=0xffff88003a8a9338
>>>>> CPU: 0 PID: 3554 Comm: kworker/u12:0 Tainted: G    B           4.5.0-rc1+ #300
>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>>>>> Workqueue: hci0 hci_power_on
>>>>> 00000000ffffffff ffff880036abf838 ffffffff82be118d ffff88003e804f00
>>>>> ffff88003a8a9ec0 ffff88003a8a8000 ffff880036abf868 ffffffff8175b434
>>>>> ffff88003e804f00 ffffea0000ea2a00 ffff88003a8a9ec0 ffff880036abfb30
>>>>> 
>>>>> Call Trace:
>>>>> [<     inline     >] kasan_report mm/kasan/report.c:274
>>>>> [<ffffffff81764e1e>] __asan_report_load4_noabort+0x3e/0x40
>>>>> mm/kasan/report.c:294
>>>>> [<     inline     >] debug_spin_lock_before kernel/locking/spinlock_debug.c:83
>>>>> [<ffffffff814662e1>] do_raw_spin_lock+0x281/0x2b0
>>>>> kernel/locking/spinlock_debug.c:135
>>>>> [<     inline     >] __raw_spin_lock_irqsave
>>>>> include/linux/spinlock_api_smp.h:119
>>>>> [<ffffffff86652bd7>] _raw_spin_lock_irqsave+0xa7/0xd0
>>>>> kernel/locking/spinlock.c:159
>>>>> [<ffffffff854da1b2>] skb_dequeue+0x22/0x180 net/core/skbuff.c:2333
>>>>> [<ffffffff854de656>] skb_queue_purge+0x26/0x40 net/core/skbuff.c:2371
>>>>> [<ffffffff8484b9fb>] vhci_flush+0x3b/0x50 drivers/bluetooth/hci_vhci.c:74
>>>>> [<ffffffff85d3a02f>] hci_dev_do_open+0x62f/0xf60 net/bluetooth/hci_core.c:1417
>>>>> [<ffffffff85d42b98>] hci_power_on+0x108/0x4b0 net/bluetooth/hci_core.c:2027
>>>>> [<ffffffff813a2386>] process_one_work+0x796/0x1440 kernel/workqueue.c:2037
>>>>> [<ffffffff813a310b>] worker_thread+0xdb/0xfc0 kernel/workqueue.c:2171
>>>>> [<ffffffff813b637f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
>>>>> [<ffffffff866535ef>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
>>>>> ==================================================================
>>>>> ==================================================================
>>>>> BUG: KASAN: use-after-free in skb_dequeue+0x153/0x180 at addr ffff88003a8a9f10
>>>>> Read of size 8 by task kworker/u12:0/3554
>>>>> =============================================================================
>>>>> BUG kmalloc-512 (Tainted: G    B          ): kasan: bad access detected
>>>>> -----------------------------------------------------------------------------
>>>>> 
>>>>> INFO: Allocated in vhci_open+0x50/0x350 age=16913 cpu=0 pid=10397
>>>>> [<     inline     >] slab_alloc_node mm/slub.c:2562
>>>>> [<     inline     >] slab_alloc mm/slub.c:2604
>>>>> [<      none      >] kmem_cache_alloc_trace+0x25c/0x300 mm/slub.c:2621
>>>>> [<     inline     >] kmalloc include/linux/slab.h:463
>>>>> [<     inline     >] kzalloc include/linux/slab.h:607
>>>>> [<      none      >] vhci_open+0x50/0x350 drivers/bluetooth/hci_vhci.c:316
>>>>> [<      none      >] misc_open+0x388/0x520 drivers/char/misc.c:153
>>>>> [<      none      >] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
>>>>> [<      none      >] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
>>>>> [<      none      >] vfs_open+0x17b/0x1f0 fs/open.c:853
>>>>> [<     inline     >] do_last fs/namei.c:3254
>>>>> [<      none      >] path_openat+0xde9/0x5e30 fs/namei.c:3386
>>>>> [<      none      >] do_filp_open+0x18e/0x250 fs/namei.c:3421
>>>>> [<      none      >] do_sys_open+0x1fc/0x420 fs/open.c:1022
>>>>> [<     inline     >] SYSC_open fs/open.c:1040
>>>>> [<      none      >] SyS_open+0x2d/0x40 fs/open.c:1035
>>>>> [<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
>>>>> arch/x86/entry/entry_64.S:185
>>>>> 
>>>>> INFO: Freed in vhci_release+0xae/0xe0 age=12241 cpu=2 pid=10397
>>>>> [<     inline     >] slab_free mm/slub.c:2835
>>>>> [<      none      >] kfree+0x2ac/0x2c0 mm/slub.c:3664
>>>>> [<      none      >] vhci_release+0xae/0xe0 drivers/bluetooth/hci_vhci.c:346
>>>>> [<      none      >] __fput+0x236/0x780 fs/file_table.c:208
>>>>> [<      none      >] ____fput+0x15/0x20 fs/file_table.c:244
>>>>> [<      none      >] task_work_run+0x170/0x210 kernel/task_work.c:115
>>>>> [<     inline     >] exit_task_work include/linux/task_work.h:21
>>>>> [<      none      >] do_exit+0x8b5/0x2cb0 kernel/exit.c:748
>>>>> [<      none      >] do_group_exit+0x108/0x330 kernel/exit.c:878
>>>>> [<      none      >] get_signal+0x5e4/0x14f0 kernel/signal.c:2307
>>>>> [<      none      >] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
>>>>> [<      none      >] exit_to_usermode_loop+0x1a5/0x210
>>>>> arch/x86/entry/common.c:247
>>>>> [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
>>>>> [<      none      >] syscall_return_slowpath+0x2ba/0x340
>>>>> arch/x86/entry/common.c:344
>>>>> [<      none      >] int_ret_from_sys_call+0x25/0x9f
>>>>> arch/x86/entry/entry_64.S:281
>>>>> 
>>>>> INFO: Slab 0xffffea0000ea2a00 objects=16 used=12 fp=0xffff88003a8aaa48
>>>>> flags=0x1fffc0000004080
>>>>> INFO: Object 0xffff88003a8a9ec0 @offset=7872 fp=0xffff88003a8a9338
>>>>> CPU: 0 PID: 3554 Comm: kworker/u12:0 Tainted: G    B           4.5.0-rc1+ #300
>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>>>>> Workqueue: hci0 hci_power_on
>>>>> 00000000ffffffff ffff880036abf898 ffffffff82be118d ffff88003e804f00
>>>>> ffff88003a8a9ec0 ffff88003a8a8000 ffff880036abf8c8 ffffffff8175b434
>>>>> ffff88003e804f00 ffffea0000ea2a00 ffff88003a8a9ec0 0000000000000282
>>>>> 
>>>>> Call Trace:
>>>>> [<     inline     >] kasan_report mm/kasan/report.c:274
>>>>> [<ffffffff81764e5e>] __asan_report_load8_noabort+0x3e/0x40
>>>>> mm/kasan/report.c:295
>>>>> [<     inline     >] skb_peek include/linux/skbuff.h:1453
>>>>> [<     inline     >] __skb_dequeue include/linux/skbuff.h:1735
>>>>> [<ffffffff854da2e3>] skb_dequeue+0x153/0x180 net/core/skbuff.c:2334
>>>>> [<ffffffff854de656>] skb_queue_purge+0x26/0x40 net/core/skbuff.c:2371
>>>>> [<ffffffff8484b9fb>] vhci_flush+0x3b/0x50 drivers/bluetooth/hci_vhci.c:74
>>>>> [<ffffffff85d3a02f>] hci_dev_do_open+0x62f/0xf60 net/bluetooth/hci_core.c:1417
>>>>> [<ffffffff85d42b98>] hci_power_on+0x108/0x4b0 net/bluetooth/hci_core.c:2027
>>>>> [<ffffffff813a2386>] process_one_work+0x796/0x1440 kernel/workqueue.c:2037
>>>>> [<ffffffff813a310b>] worker_thread+0xdb/0xfc0 kernel/workqueue.c:2171
>>>>> [<ffffffff813b637f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
>>>>> [<ffffffff866535ef>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
>>>>> ==================================================================
>>>> 
>>>> 
>>>> 
>>>> Ping.
>>>> Just got another one on 4.5-rc6
>>> 
>>> FWIW I've just hit that too right now.
>>> 
>>> But I haven't hit it with 4.4 which I am fuzzing by the orders of
>>> magnitude longer. But take it with grain of salt -- it could be a
>>> coincidence, of course.
>> 
>> do you know what the fuzzer was doing at this point. Is the fuzzer opening /dev/vhci device node? Since that would be the only way to actually get into that driver.
> 
> Check out the KASAN reports. They should answer your question.

that means very little to me actually. So is the real issue caused by opening /dev/vhci or is that theoretical one via some internal kernel compile time feature.

Regards

Marcel

