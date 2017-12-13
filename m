Return-Path: <alban.browaeys@gmail.com>
Message-ID: <1513181917.22430.11.camel@gmail.com>
Subject: rfcomm - bug - sleeping in atomic context
From: Alban Browaeys <alban.browaeys@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>,  Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 13 Dec 2017 17:18:37 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

To me rfcomm_connect_ind calls bt_accept_enqueue under bh_lock_sock
(spinlock) while bt_accept_enqueue might sleep (lock_sock_nessted)

I got this bug once. The bug did not escalate and the effects seems
limited to this connection but the box recovered (I did suspend/resume
in the meantime).

>From the look of it this issue predates the switch to git.

[ 6157.449801] BUG: sleeping function called from invalid context at net/core/sock.c:2761
[ 6157.449809] in_atomic(): 1, irqs_disabled(): 0, pid: 5073, name: krfcommd
[ 6157.449814] 2 locks held by krfcommd/5073:
[ 6157.449816]  #0:  (rfcomm_mutex){....}, at: [<00000000daacba7f>] rfcomm_run+0x6d8/0x5300 [rfcomm]
[ 6157.449837]  #1:  (slock-AF_BLUETOOTH-BTPROTO_RFCOMM){....}, at: [<00000000fbe9fa39>] rfcomm_connect_ind+0x32a/0x970 [rfcomm]
[ 6157.449853] CPU: 2 PID: 5073 Comm: krfcommd Not tainted 4.15.0-rc3prahal+intel+ #202
[ 6157.449856] Hardware name: LENOVO 20CDCTO1WW/20CDCTO1WW, BIOS GQET53WW (1.33 ) 09/15/2017
[ 6157.449859] Call Trace:
[ 6157.449866]  dump_stack+0xa6/0x125
[ 6157.449872]  ? _atomic_dec_and_lock+0x13b/0x13b
[ 6157.449881]  ? lockdep_print_held_locks+0xbb/0x120
[ 6157.449889]  ___might_sleep+0x29e/0x330
[ 6157.449893]  ? cpumask_next+0x16/0x20
[ 6157.449897]  ? rq_clock+0xf0/0xf0
[ 6157.449907]  ? is_module_address+0x11/0x20
[ 6157.449913]  lock_sock_nested+0x32/0x100
[ 6157.449948]  bt_accept_enqueue+0x81/0x2b0 [bluetooth]
[ 6157.449957]  ? rfcomm_sock_alloc.constprop.4+0x306/0x400 [rfcomm]
[ 6157.449984]  ? bt_sock_reclassify_lock+0x2a0/0x2a0 [bluetooth]
[ 6157.449990]  ? rfcomm_sock_getsockopt+0x8b0/0x8b0 [rfcomm]
[ 6157.450000]  ? rfcomm_sock_init+0x35b/0x470 [rfcomm]
[ 6157.450010]  rfcomm_connect_ind+0x6cb/0x970 [rfcomm]
[ 6157.450017]  ? lock_release+0x10b0/0x10b0
[ 6157.450024]  ? rfcomm_sock_create+0x140/0x140 [rfcomm]
[ 6157.450032]  ? rfcomm_session_add+0x241/0x3b0 [rfcomm]
[ 6157.450038]  ? do_raw_spin_trylock+0x180/0x180
[ 6157.450044]  ? wait_woken+0x116/0x260
[ 6157.450059]  rfcomm_run+0x3bfc/0x5300 [rfcomm]
[ 6157.450076]  ? rfcomm_check_accept+0x1e0/0x1e0 [rfcomm]
[ 6157.450080]  ? _raw_spin_unlock_irq+0x24/0x40
[ 6157.450085]  ? finish_task_switch+0x1d8/0x700
[ 6157.450088]  ? finish_task_switch+0x1af/0x700
[ 6157.450096]  ? preempt_notifier_dec+0x20/0x20
[ 6157.450108]  ? __schedule+0x7d4/0x1e10
[ 6157.450118]  ? __sched_text_start+0x8/0x8
[ 6157.450123]  ? __lock_acquire.isra.33+0x35a/0x1c70
[ 6157.450132]  ? tsc_resume+0x10/0x10
[ 6157.450137]  ? lockdep_rcu_suspicious+0x150/0x150
[ 6157.450140]  ? _raw_spin_unlock+0x24/0x30
[ 6157.450150]  ? __init_waitqueue_head+0x130/0x130
[ 6157.450155]  ? sched_clock_cpu+0x18/0x170
[ 6157.450158]  ? find_held_lock+0x39/0x1c0
[ 6157.450171]  ? schedule+0xe7/0x380
[ 6157.450174]  ? lock_downgrade+0x690/0x690
[ 6157.450178]  ? __schedule+0x1e10/0x1e10
[ 6157.450184]  ? do_wait_intr_irq+0x330/0x330
[ 6157.450194]  ? do_raw_spin_trylock+0x180/0x180
[ 6157.450208]  ? rfcomm_check_accept+0x1e0/0x1e0 [rfcomm]
[ 6157.450213]  kthread+0x312/0x3d0
[ 6157.450217]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[ 6157.450225]  ret_from_fork+0x1f/0x30
[ 6171.628395] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 6187.745374] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 6203.744416] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 6219.743384] Bluetooth: hci0: last event is not cmd complete (0x0f)




this decode as:

BUG: sleeping function called from invalid context at net/core/sock.c:2761
in_atomic(): 1, irqs_disabled(): 0, pid: 5073, name: krfcommd
2 locks held by krfcommd/5073:
#0: (rfcomm_mutex){....}, at: rfcomm_run (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:1983 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:2087) rfcomm
#1: (slock-AF_BLUETOOTH-BTPROTO_RFCOMM){....}, at: rfcomm_connect_ind (/home/prahal/Projects/Admin/Linux/linux/include/net/sock.h:835 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/sock.c:974) rfcomm
CPU: 2 PID: 5073 Comm: krfcommd Not tainted 4.15.0-rc3prahal+intel+ #202
Hardware name: LENOVO 20CDCTO1WW/20CDCTO1WW, BIOS GQET53WW (1.33 ) 09/15/2017
Call Trace:
dump_stack (/home/prahal/Projects/Admin/Linux/linux/lib/dump_stack.c:55) 
? _atomic_dec_and_lock (/home/prahal/Projects/Admin/Linux/linux/lib/dump_stack.c:29) 
? lockdep_print_held_locks (/home/prahal/Projects/Admin/Linux/linux/kernel/locking/lockdep.c:591 (discriminator 3)) 
___might_sleep (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:6061) 
? cpumask_next (/home/prahal/Projects/Admin/Linux/linux/lib/cpumask.c:22) 
? rq_clock (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:6018) 
? is_module_address (/home/prahal/Projects/Admin/Linux/linux/arch/x86/include/asm/preempt.h:81 /home/prahal/Projects/Admin/Linux/linux/kernel/module.c:4273) 
lock_sock_nested (/home/prahal/Projects/Admin/Linux/linux/net/core/sock.c:2761) 
bt_accept_enqueue (/home/prahal/Projects/Admin/Linux/linux/include/linux/list.h:93 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/af_bluetooth.c:163) bluetooth
? rfcomm_sock_alloc.constprop.4 (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/sock.c:308 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/sock.c:310) rfcomm
? bt_sock_reclassify_lock (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/af_bluetooth.c:158) bluetooth
? rfcomm_sock_getsockopt (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/sock.c:273) rfcomm
? rfcomm_sock_init (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/sock.c:255) rfcomm
rfcomm_connect_ind (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/sock.c:994) rfcomm
? lock_release (/home/prahal/Projects/Admin/Linux/linux/kernel/locking/lockdep.c:3993) 
? rfcomm_sock_create (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/sock.c:957) rfcomm
? rfcomm_session_add (/home/prahal/Projects/Admin/Linux/linux/include/linux/list.h:60 /home/prahal/Projects/Admin/Linux/linux/include/linux/list.h:79 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:670) rfcomm
? do_raw_spin_trylock (/home/prahal/Projects/Admin/Linux/linux/kernel/locking/spinlock_debug.c:133) 
? wait_woken (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/wait.c:419) 
rfcomm_run (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:1430 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:1622 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:1755 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:1907 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:2000 /home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:2087) rfcomm
? rfcomm_check_accept (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:2075) rfcomm
? _raw_spin_unlock_irq (/home/prahal/Projects/Admin/Linux/linux/arch/x86/include/asm/paravirt.h:787 /home/prahal/Projects/Admin/Linux/linux/include/linux/spinlock_api_smp.h:168 /home/prahal/Projects/Admin/Linux/linux/kernel/locking/spinlock.c:199) 
? finish_task_switch (/home/prahal/Projects/Admin/Linux/linux/arch/x86/include/asm/current.h:15 /home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:2669) 
? finish_task_switch (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/sched.h:1360 /home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:2666) 
? preempt_notifier_dec (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:2619) 
? __schedule (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:2802 /home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:3375) 
? __sched_text_start (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:3288) 
? __lock_acquire.isra.33 (/home/prahal/Projects/Admin/Linux/linux/kernel/locking/lockdep.c:3453) 
? tsc_resume (/home/prahal/Projects/Admin/Linux/linux/arch/x86/kernel/tsc.c:193) 
? lockdep_rcu_suspicious (/home/prahal/Projects/Admin/Linux/linux/kernel/locking/lockdep.c:3353) 
? _raw_spin_unlock (/home/prahal/Projects/Admin/Linux/linux/arch/x86/include/asm/preempt.h:81 /home/prahal/Projects/Admin/Linux/linux/include/linux/spinlock_api_smp.h:152 /home/prahal/Projects/Admin/Linux/linux/kernel/locking/spinlock.c:183) 
? __init_waitqueue_head (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/wait.c:435) 
? sched_clock_cpu (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/clock.c:363) 
? find_held_lock (/home/prahal/Projects/Admin/Linux/linux/kernel/locking/lockdep.c:3612) 
? schedule (/home/prahal/Projects/Admin/Linux/linux/arch/x86/include/asm/current.h:15 (discriminator 1) /home/prahal/Projects/Admin/Linux/linux/include/linux/sched.h:1620 (discriminator 1) /home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:3436 (discriminator 1)) 
? lock_downgrade (/home/prahal/Projects/Admin/Linux/linux/kernel/locking/lockdep.c:4013) 
? __schedule (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/core.c:3428) 
? do_wait_intr_irq (/home/prahal/Projects/Admin/Linux/linux/kernel/sched/wait.c:75) 
? do_raw_spin_trylock (/home/prahal/Projects/Admin/Linux/linux/kernel/locking/spinlock_debug.c:133) 
? rfcomm_check_accept (/home/prahal/Projects/Admin/Linux/linux/net/bluetooth/rfcomm/core.c:2075) rfcomm
kthread (/home/prahal/Projects/Admin/Linux/linux/kernel/kthread.c:238) 
? kthread_create_worker_on_cpu (/home/prahal/Projects/Admin/Linux/linux/kernel/kthread.c:198) 
ret_from_fork (/home/prahal/Projects/Admin/Linux/linux/arch/x86/entry/entry_64.S:447)
 
