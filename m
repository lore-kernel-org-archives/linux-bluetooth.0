Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
From: Jack Mitchell <ml@embed.me.uk>
Subject: btwilink: deadlock with omap-serial 4.2.0-rc4
Message-ID: <55B62BB0.205@embed.me.uk>
Date: Mon, 27 Jul 2015 14:01:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Ran into this deadlock in the btwilink coupled with the omap-serial 
driver.Kernel is only tainted with a custom dts and small kim dts 
enablement patch, nothing which would cause this error.

Please CC as I'm not on list.

[ 1144.307220]
[ 1144.308837] ======================================================
[ 1144.310821] [ INFO: possible circular locking dependency detected ]
[ 1144.321960] 4.2.0-rc4-00001-gaa22fe1-dirty #1 Not tainted
[ 1144.321960] -------------------------------------------------------
[ 1144.334259] connmand/322 is trying to acquire lock:
[ 1144.334259] (&(&st_gdata->lock)->rlock){-.....}, at: [<c040f0b8>] 
st_tx_wakeup+0x48/0xf4
[ 1144.340820]
[ 1144.340820] but task is already holding lock:
[ 1144.354248]  (&port_lock_key){-.-...}, at: [<c03e64a8>] 
serial_omap_irq+0x14/0x3ec
[ 1144.362304]
[ 1144.362304] which lock already depends on the new lock.
[ 1144.362304]
[ 1144.370819]
[ 1144.370819] the existing dependency chain (in reverse order) is:
[ 1144.370941]
-> #1 (&port_lock_key){-.-...}:
[ 1144.383453]        [<c03dc41c>] uart_write+0x34/0xdc
[ 1144.383453]        [<c040f0dc>] st_tx_wakeup+0x6c/0xf4
[ 1144.390777]        [<c040f57c>] st_write+0xa0/0x100
[ 1144.390777]        [<bf44b0f0>] ti_st_send_frame+0x3c/0xdc [btwilink]
[ 1144.406127]        [<bf3c441c>] hci_send_frame+0x6c/0xbc [bluetooth]
[ 1144.413116]        [<bf3c44e8>] hci_cmd_work+0x7c/0xe0 [bluetooth]
[ 1144.415313]        [<c0058f9c>] process_one_work+0x1b4/0x4b4
[ 1144.420776]        [<c00592d8>] worker_thread+0x3c/0x4a4
[ 1144.430786]        [<c005ef24>] kthread+0xd4/0xf0
[ 1144.431396]        [<c000f618>] ret_from_fork+0x14/0x3c
[ 1144.440673]
-> #0 (&(&st_gdata->lock)->rlock){-.....}:
[ 1144.447540]        [<c0602090>] _raw_spin_lock_irqsave+0x40/0x54
[ 1144.450805]        [<c040f0b8>] st_tx_wakeup+0x48/0xf4
[ 1144.459350]        [<c03be994>] tty_wakeup+0x50/0x5c
[ 1144.464630]        [<c03e67e0>] serial_omap_irq+0x34c/0x3ec
[ 1144.464630]        [<c009c338>] handle_irq_event_percpu+0x40/0x1e8
[ 1144.470794]        [<c009c520>] handle_irq_event+0x40/0x64
[ 1144.480773]        [<c009f5dc>] handle_fasteoi_irq+0xcc/0x1c4
[ 1144.480773]        [<c009b9d4>] generic_handle_irq+0x28/0x3c
[ 1144.494689]        [<c009bcbc>] __handle_domain_irq+0x64/0xe0
[ 1144.500915]        [<c00094dc>] gic_handle_irq+0x20/0x60
[ 1144.500915]        [<c0602cc8>] __irq_usr+0x48/0x60
[ 1144.511596]        [<b6d9b094>] 0xb6d9b094
[ 1144.515319]
[ 1144.515319] other info that might help us debug this:
[ 1144.515319]
[ 1144.524261]  Possible unsafe locking scenario:
[ 1144.524261]
[ 1144.530456]        CPU0                    CPU1
[ 1144.530670]        ----                    ----
[ 1144.538269]   lock(&port_lock_key);
[ 1144.540832] lock(&(&st_gdata->lock)->rlock);
[ 1144.550872] lock(&port_lock_key);
[ 1144.551422] lock(&(&st_gdata->lock)->rlock);
[ 1144.551422]
[ 1144.551422]  *** DEADLOCK ***
[ 1144.551422]
[ 1144.565277] 2 locks held by connmand/322:
[ 1144.569366]  #0:  (&port_lock_key){-.-...}, at: [<c03e64a8>] 
serial_omap_irq+0x14/0x3ec
[ 1144.569366]  #1:  (&tty->ldisc_sem){++++++}, at: [<c03c7c80>] 
tty_ldisc_ref+0x14/0x48
[ 1144.588378]
[ 1144.588378] stack backtrace:
[ 1144.593383] CPU: 0 PID: 322 Comm: connmand Not tainted 
4.2.0-rc4-00001-gaa22fe1-dirty #1
[ 1144.601837] Hardware name: Generic OMAP4 (Flattened Device Tree)
[ 1144.608123] [<c0016e8c>] (unwind_backtrace) from [<c001335c>] 
(show_stack+0x10/0x14)
[ 1144.616241] [<c001335c>] (show_stack) from [<c05fb570>] 
(dump_stack+0x84/0x9c)
[ 1144.622070] [<c05fb570>] (dump_stack) from [<c008cf1c>] 
(print_circular_bug+0x1c8/0x30c)
[ 1144.631408] [<c008cf1c>] (print_circular_bug) from [<c00908b4>] 
(__lock_acquire+0x1ba0/0x1eb0)
[ 1144.641296] [<c00908b4>] (__lock_acquire) from [<c00914a0>] 
(lock_acquire+0xa8/0x120)
[ 1144.649475] [<c00914a0>] (lock_acquire) from [<c0602090>] 
(_raw_spin_lock_irqsave+0x40/0x54)
[ 1144.658325] [<c0602090>] (_raw_spin_lock_irqsave) from [<c040f0b8>] 
(st_tx_wakeup+0x48/0xf4)
[ 1144.666839] [<c040f0b8>] (st_tx_wakeup) from [<c03be994>] 
(tty_wakeup+0x50/0x5c)
[ 1144.674468] [<c03be994>] (tty_wakeup) from [<c03e67e0>] 
(serial_omap_irq+0x34c/0x3ec)
[ 1144.681823] [<c03e67e0>] (serial_omap_irq) from [<c009c338>] 
(handle_irq_event_percpu+0x40/0x1e8)
[ 1144.692382] [<c009c338>] (handle_irq_event_percpu) from [<c009c520>] 
(handle_irq_event+0x40/0x64)
[ 1144.700897] [<c009c520>] (handle_irq_event) from [<c009f5dc>] 
(handle_fasteoi_irq+0xcc/0x1c4)
[ 1144.708312] [<c009f5dc>] (handle_fasteoi_irq) from [<c009b9d4>] 
(generic_handle_irq+0x28/0x3c)
[ 1144.710998] [<c009b9d4>] (generic_handle_irq) from [<c009bcbc>] 
(__handle_domain_irq+0x64/0xe0)
[ 1144.722015] [<c009bcbc>] (__handle_domain_irq) from [<c00094dc>] 
(gic_handle_irq+0x20/0x60)
[ 1144.731201] [<c00094dc>] (gic_handle_irq) from [<c0602cc8>] 
(__irq_usr+0x48/0x60)
[ 1144.745239] Exception stack(0xdcda5fb0 to 0xdcda5ff8)
[ 1144.750457] 5fa0: 000d30c8 000d1bc4 00000000 00000000
[ 1144.754516] 5fc0: 000d30c8 000000e4 000000e4 bedd2ae4 bedd2aec 
bedd2ae8 00000000 b6e4e85c
[ 1144.767639] 5fe0: 00000000 bedd2ad8 b6d9b958 b6d9b094 20070110 ffffffff
[ 1165.444732] BUG: spinlock lockup suspected on CPU#0, connmand/322
[ 1165.453247]  lock: 0xddbf2410, .magic: dead4ead, .owner: 
connmand/322, .owner_cpu: 0
[ 1165.460327] CPU: 0 PID: 322 Comm: connmand Not tainted 
4.2.0-rc4-00001-gaa22fe1-dirty #1
[ 1165.461822] Hardware name: Generic OMAP4 (Flattened Device Tree)
[ 1165.475250] [<c0016e8c>] (unwind_backtrace) from [<c001335c>] 
(show_stack+0x10/0x14)
[ 1165.483093] [<c001335c>] (show_stack) from [<c05fb570>] 
(dump_stack+0x84/0x9c)
[ 1165.491729] [<c05fb570>] (dump_stack) from [<c00944a4>] 
(do_raw_spin_lock+0xec/0x1b0)
[ 1165.499908] [<c00944a4>] (do_raw_spin_lock) from [<c0602098>] 
(_raw_spin_lock_irqsave+0x48/0x54)
[ 1165.508636] [<c0602098>] (_raw_spin_lock_irqsave) from [<c03dc41c>] 
(uart_write+0x34/0xdc)
[ 1165.515411] [<c03dc41c>] (uart_write) from [<c040f0dc>] 
(st_tx_wakeup+0x6c/0xf4)
[ 1165.525482] [<c040f0dc>] (st_tx_wakeup) from [<c03be994>] 
(tty_wakeup+0x50/0x5c)
[ 1165.530853] [<c03be994>] (tty_wakeup) from [<c03e67e0>] 
(serial_omap_irq+0x34c/0x3ec)
[ 1165.541412] [<c03e67e0>] (serial_omap_irq) from [<c009c338>] 
(handle_irq_event_percpu+0x40/0x1e8)
[ 1165.550689] [<c009c338>] (handle_irq_event_percpu) from [<c009c520>] 
(handle_irq_event+0x40/0x64)
[ 1165.559967] [<c009c520>] (handle_irq_event) from [<c009f5dc>] 
(handle_fasteoi_irq+0xcc/0x1c4)
[ 1165.568878] [<c009f5dc>] (handle_fasteoi_irq) from [<c009b9d4>] 
(generic_handle_irq+0x28/0x3c)
[ 1165.576568] [<c009b9d4>] (generic_handle_irq) from [<c009bcbc>] 
(__handle_domain_irq+0x64/0xe0)
[ 1165.581909] [<c009bcbc>] (__handle_domain_irq) from [<c00094dc>] 
(gic_handle_irq+0x20/0x60)
[ 1165.593353] [<c00094dc>] (gic_handle_irq) from [<c0602cc8>] 
(__irq_usr+0x48/0x60)
[ 1165.593353] Exception stack(0xdcda5fb0 to 0xdcda5ff8)
[ 1165.604461] 5fa0: 000d30c8 000d1bc4 00000000 00000000
[ 1165.617401] 5fc0: 000d30c8 000000e4 000000e4 bedd2ae4 bedd2aec 
bedd2ae8 00000000 b6e4e85c
[ 1165.620697] 5fe0: 00000000 bedd2ad8 b6d9b958 b6d9b094 20070110 ffffffff
[ 1170.528594] INFO: rcu_sched detected stalls on CPUs/tasks:
[ 1170.534362]  0: (1 GPs behind) idle=7f7/140000000000001/0 
softirq=2274/2274 fqs=19
[ 1170.534362]  (detected by 1, t=2622 jiffies, g=707, c=706, q=5)
[ 1170.534362] Task dump for CPU 0:
[ 1170.534362] connmand        R running      0   322 1 0x00000002
[ 1170.558593] [<c05fcd6c>] (__schedule) from [<c03639e0>] 
(vsnprintf+0x2e4/0x3c8)
[ 1170.558593] [<c03639e0>] (vsnprintf) from [<c0364074>] 
(sprintf+0x24/0x34)
[ 1170.566253] [<c0364074>] (sprintf) from [<c00c9e68>] 
(__sprint_symbol+0xa0/0xc8)
[ 1170.566253] [<c00c9e68>] (__sprint_symbol) from [<00000000>] (  (null))
[ 1170.581176] rcu_sched kthread starved for 2603 jiffies! g707 c706 f0x0
