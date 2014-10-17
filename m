Return-Path: <cyrus@holtmann.org>
Message-ID: <1413549465.2705.149.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Locking issue when running out of credits in 6lowpan connection
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann
	 <marcel@holtmann.org>
Date: Fri, 17 Oct 2014 15:37:45 +0300
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have seen the deadlock warnings from lockdep when pushing lot of data
through a 6lowpan link. I was converting the read/write locks in 6lowpan
to use RCU and it helped the situation slightly as I see the lockdep
warning less now. I will send these patches soon to ml.

I noticed that if I add huge amount of credits for the connection, then
the issue is not seen. So when the credits are exhausted in receiving
end, the l2cap sends message to other end, see the backtrace below
(l2cap_recv_frame() followed by l2cap_do_send()).

At the same time a lot of data is pushed through the 6lowpan link. These
operations then conflict as seen in the log below.

One way to reproduce the issue is like this:

host1# nc -6 -l 9999 > /dev/null

host2# nc -6 fe80::21e:abff:fe4c:5257%bt0 9999 < /dev/urandom


Any ideas how to solve this?

Is there a bug in l2cap/hci layers or am I doing something wrong with
6lowpan connection?


 =================================
 [ INFO: inconsistent lock state ]
 3.17.0-rc1-bt6lowpan #1 Not tainted
 ---------------------------------
 inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
 kworker/u3:1/384 [HC0[0]:SC0[0]:HE1:SE1] takes:
  (&(&list->lock)->rlock#6){+.?...}, at: [<f831dd4c>] hci_send_acl
+0xac/0x290 [bluetooth]
 {IN-SOFTIRQ-W} state was registered at:
   [<c10915a3>] __lock_acquire+0x6d3/0x1d20
   [<c109325d>] lock_acquire+0x9d/0x140
   [<c1889c25>] _raw_spin_lock+0x45/0x80
   [<f831dd4c>] hci_send_acl+0xac/0x290 [bluetooth]
   [<f833efe0>] l2cap_do_send+0x60/0x100 [bluetooth]
   [<f8342bb0>] l2cap_chan_send+0x7f0/0x10e0 [bluetooth]
   [<f88dc8ee>] send_pkt+0x4e/0xa0 [bluetooth_6lowpan]
   [<f88dcd6e>] bt_xmit+0x42e/0x890 [bluetooth_6lowpan]
   [<c17742f4>] dev_hard_start_xmit+0x344/0x670
   [<c17749ad>] __dev_queue_xmit+0x38d/0x680
   [<c1774caf>] dev_queue_xmit+0xf/0x20
   [<c177b8b0>] neigh_connected_output+0x130/0x1a0
   [<c1812a63>] ip6_finish_output2+0x173/0x8c0
   [<c18182db>] ip6_finish_output+0x7b/0x1b0
   [<c18184a7>] ip6_output+0x97/0x2a0
   [<c183a46b>] mld_sendpack+0x5eb/0x650
   [<c183acc1>] mld_ifc_timer_expire+0x191/0x2f0
   [<c10ac385>] call_timer_fn+0x85/0x1c0
   [<c10acb72>] run_timer_softirq+0x192/0x280
   [<c104fd84>] __do_softirq+0xd4/0x300
   [<c10049fc>] do_softirq_own_stack+0x2c/0x40
   [<c1050136>] irq_exit+0x86/0xb0
   [<c188bd98>] smp_apic_timer_interrupt+0x38/0x50
   [<c188b6ce>] apic_timer_interrupt+0x32/0x38
 irq event stamp: 17003
 hardirqs last  enabled at (17003): [<c188a065>]
_raw_spin_unlock_irqrestore+0x55/0x70
 hardirqs last disabled at (17002): [<c1889e03>] _raw_spin_lock_irqsave
+0x23/0x90
 softirqs last  enabled at (6648): [<c104ff5c>] __do_softirq+0x2ac/0x300
 softirqs last disabled at (6619): [<c10049fc>] do_softirq_own_stack
+0x2c/0x40
 
 other info that might help us debug this:
  Possible unsafe locking scenario:
 
        CPU0
        ----
   lock(&(&list->lock)->rlock#6);
   <Interrupt>
     lock(&(&list->lock)->rlock#6);
 
  *** DEADLOCK ***
 
 3 locks held by kworker/u3:1/384:
  #0:  ("%s"hdev->name#2){.+.+.+}, at: [<c10622c3>] process_one_work
+0x113/0x4a0
  #1:  ((&hdev->rx_work)){+.+.+.}, at: [<c10622c3>] process_one_work
+0x113/0x4a0
  #2:  (&chan->lock){+.+.+.}, at: [<f833e569>] l2cap_get_chan_by_dcid
+0x89/0x90 [bluetooth]
 
 stack backtrace:
 CPU: 0 PID: 384 Comm: kworker/u3:1 Not tainted 3.17.0-rc1-bt6lowpan #1
 Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox
12/01/2006
 Workqueue: hci0 hci_rx_work [bluetooth]
  f4700000 00000000 f466bb90 c18821c1 c2344320 f466bbb0 c1880a94
c1ad9264
  c1ad9201 c1ad95f8 f4700614 00000006 c108e0c0 f466bbe0 c108ea8c
00000006
  f4700000 f466bffc 323ca8b2 0000002a 00000004 f4700000 f4700618
00000003
 Call Trace:
  [<c18821c1>] dump_stack+0x4b/0x75
  [<c1880a94>] print_usage_bug.part.36+0x209/0x213
  [<c108e0c0>] ? check_usage_forwards+0x110/0x110
  [<c108ea8c>] mark_lock+0x11c/0x6e0
  [<c10915e4>] __lock_acquire+0x714/0x1d20
  [<c1004b6f>] ? dump_trace+0xcf/0x1f0
  [<c100a5f8>] ? sched_clock+0x8/0x10
  [<c1075da9>] ? sched_clock_local+0x49/0x180
  [<c109325d>] lock_acquire+0x9d/0x140
  [<f831dd4c>] ? hci_send_acl+0xac/0x290 [bluetooth]
  [<c1889c25>] _raw_spin_lock+0x45/0x80
  [<f831dd4c>] ? hci_send_acl+0xac/0x290 [bluetooth]
  [<f831dd4c>] hci_send_acl+0xac/0x290 [bluetooth]
  [<c108f0b4>] ? mark_held_locks+0x64/0x90
  [<c188a065>] ? _raw_spin_unlock_irqrestore+0x55/0x70
  [<f833efe0>] l2cap_do_send+0x60/0x100 [bluetooth]
  [<c108f32b>] ? trace_hardirqs_on+0xb/0x10
  [<c188a051>] ? _raw_spin_unlock_irqrestore+0x41/0x70
  [<c1763125>] ? skb_dequeue+0x45/0x60
  [<f8349785>] l2cap_recv_frame+0x23e5/0x2dc0 [bluetooth]
  [<c1075da9>] ? sched_clock_local+0x49/0x180
  [<c100a5f8>] ? sched_clock+0x8/0x10
  [<c1075da9>] ? sched_clock_local+0x49/0x180
  [<c10761ef>] ? sched_clock_cpu+0x10f/0x160
  [<c107183b>] ? get_parent_ip+0xb/0x40
  [<c10718bb>] ? preempt_count_add+0x4b/0xa0
  [<c13d09e2>] ? debug_smp_processor_id+0x12/0x20
  [<c108cc04>] ? get_lock_stats+0x24/0x40
  [<c108f0b4>] ? mark_held_locks+0x64/0x90
  [<c188716d>] ? __mutex_unlock_slowpath+0xcd/0x1b0
  [<c13d09ff>] ? __this_cpu_preempt_check+0xf/0x20
  [<c108f1d4>] ? trace_hardirqs_on_caller+0xf4/0x240
  [<c108c9a6>] ? trace_hardirqs_off_caller+0xb6/0x160
  [<f834b6a9>] l2cap_recv_acldata+0x2f9/0x340 [bluetooth]
  [<f8316a13>] ? hci_rx_work+0x113/0x4a0 [bluetooth]
  [<f8316c69>] hci_rx_work+0x369/0x4a0 [bluetooth]
  [<f8316a13>] ? hci_rx_work+0x113/0x4a0 [bluetooth]
  [<c106234a>] process_one_work+0x19a/0x4a0
  [<c10622c3>] ? process_one_work+0x113/0x4a0
  [<c10629e9>] worker_thread+0x39/0x440
  [<c10629b0>] ? init_pwq+0xc0/0xc0
  [<c1066dc8>] kthread+0xa8/0xc0
  [<c108f32b>] ? trace_hardirqs_on+0xb/0x10
  [<c188ad01>] ret_from_kernel_thread+0x21/0x30
  [<c1066d20>] ? kthread_create_on_node+0x160/0x160



Cheers,
Jukka
