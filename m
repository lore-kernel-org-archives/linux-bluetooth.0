Return-Path: <cyrus@holtmann.org>
Message-ID: <4C56D89B.2060603@csr.com>
Date: Mon, 02 Aug 2010 15:39:23 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Dan Tian <Dan.Tian@Atheros.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Haijun Liu <Haijun.Liu@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Subject: Re: [PATCH 1/3] Add BT3 AMP device support, by Atheros Linux BT3
 team.
References: <CDAFEDABF718A54BABD0DA5476695307CE881EC1@SHEXMB-01.global.atheros.com>
In-Reply-To: <CDAFEDABF718A54BABD0DA5476695307CE881EC1@SHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've now given these patches a brief try and have successfully
established a physical and logical link and used these to transfer data.

Some general comments:

1. There is almost zero documentation.  This is particularly a problem
for the userspace ABI (e.g., the additional fields in struct
l2cap_options).  It would also be useful to add comments for code that
handles the more quirky parts of the spec (e.g., the use of the physical
link handle in Rx'd AMP ACL packets).

2. Lockdep identifies a locking bug (see below for complete trace) when
creating a physical link on the responder.

3. The decision on whether to use the AMP logical link or the BR radio
is taken too late.  The L2CAP packet are fragmented using the MTU of the
BR radio and this MTU is far too small to get good performance out of
AMP radios.

4. There is no API to signal to the user space application/profile that
the channel has moved to/from the AMP.

[  470.022933] =======================================================
[  470.022936] [ INFO: possible circular locking dependency detected ]
[  470.022939] 2.6.35-rc4 #1
[  470.022941] -------------------------------------------------------
[  470.022944] ksoftirqd/0/3 is trying to acquire lock:
[  470.022946]  (slock-AF_BLUETOOTH){+.-...}, at: [<f829bfdf>]
l2cap_phylink_update+0x2ef/0x11b0 [l2cap]
[  470.022961]
[  470.022962] but task is already holding lock:
[  470.022964]  (&amp_contr->context_q.lock){+.-...}, at: [<f82af8f7>]
amp_create_phy_link_cfm+0x57/0x5c0 [l2cap]
[  470.022977]
[  470.022977] which lock already depends on the new lock.
[  470.022978]
[  470.022981]
[  470.022981] the existing dependency chain (in reverse order) is:
[  470.022984]
[  470.022985] -> #1 (&amp_contr->context_q.lock){+.-...}:
[  470.022990]        [<c01691b8>] __lock_acquire+0x2f8/0xac0
[  470.022998]        [<c0169a06>] lock_acquire+0x86/0x100
[  470.023002]        [<c03f37e0>] _raw_spin_lock_irqsave+0x50/0x70
[  470.023008]        [<c0135030>] __wake_up+0x20/0x60
[  470.023013]        [<f829a3c4>] l2cap_drop_acked_frames+0x84/0xb0 [l2cap]
[  470.023023]        [<f82a7343>] l2cap_recv_frame+0x3d83/0x7cf0 [l2cap]
[  470.023032]        [<f82abdbd>] l2cap_recv_acldata+0x43d/0x450 [l2cap]
[  470.023041]        [<f9a23186>] hci_rx_task+0x376/0x620 [bluetooth]
[  470.023053]        [<c013f26b>] tasklet_action+0x5b/0xd0
[  470.023059]        [<c013e4d7>] __do_softirq+0xa7/0x1e0
[  470.023063]        [<c013e677>] do_softirq+0x67/0x70
[  470.023067]        [<c013eae6>] irq_exit+0x76/0x80
[  470.023071]        [<c03fa664>] do_IRQ+0x54/0xc0
[  470.023075]        [<c01031ae>] common_interrupt+0x2e/0x40
[  470.023080]        [<c03438f6>] cpuidle_idle_call+0x76/0x100
[  470.023085]        [<c0101c61>] cpu_idle+0x51/0x90
[  470.023089]        [<c03df6aa>] rest_init+0xba/0xd0
[  470.023094]        [<c05a1aea>] start_kernel+0x2fa/0x390
[  470.023099]        [<c05a109c>] i386_start_kernel+0x9c/0xe0
[  470.023103]
[  470.023104] -> #0 (slock-AF_BLUETOOTH){+.-...}:
[  470.023109]        [<c0168eb6>] validate_chain+0x1076/0x1080
[  470.023114]        [<c01691b8>] __lock_acquire+0x2f8/0xac0
[  470.023118]        [<c0169a06>] lock_acquire+0x86/0x100
[  470.023122]        [<c03f36b8>] _raw_spin_lock+0x38/0x50
[  470.023126]        [<f829bfdf>] l2cap_phylink_update+0x2ef/0x11b0 [l2cap]
[  470.023136]        [<f82af9e1>] amp_create_phy_link_cfm+0x141/0x5c0
[l2cap]
[  470.023145]        [<f9a289b1>] hci_phylink_complete_evt+0xc1/0x130
[bluetooth]
[  470.023157]        [<f9a2b536>] hci_event_packet+0x236/0x3cb0 [bluetooth]
[  470.023167]        [<f9a230f9>] hci_rx_task+0x2e9/0x620 [bluetooth]
[  470.023178]        [<c013f26b>] tasklet_action+0x5b/0xd0
[  470.023182]        [<c013e4d7>] __do_softirq+0xa7/0x1e0
[  470.023186]        [<c013e677>] do_softirq+0x67/0x70
[  470.023190]        [<c013e89e>] run_ksoftirqd+0x6e/0x110
[  470.023193]        [<c0153324>] kthread+0x74/0x80
[  470.023198]        [<c01031c6>] kernel_thread_helper+0x6/0x10
[  470.023202]
[  470.023203] other info that might help us debug this:
[  470.023204]
[  470.023207] 5 locks held by ksoftirqd/0/3:
[  470.023209]  #0:  (hci_task_lock){++.-..}, at: [<f9a22e52>]
hci_rx_task+0x42/0x620 [bluetooth]
[  470.023223]  #1:  (&(&hdev->lock)->rlock){+.-...}, at: [<f9a2893d>]
hci_phylink_complete_evt+0x4d/0x130 [bluetooth]
[  470.023236]  #2:  (hci_cb_list_lock){++.-..}, at: [<f9a28986>]
hci_phylink_complete_evt+0x96/0x130 [bluetooth]
[  470.023250]  #3:  (&amp_contr->context_q.lock){+.-...}, at:
[<f82af8f7>] amp_create_phy_link_cfm+0x57/0x5c0 [l2cap]
[  470.023263]  #4:  (&conn->chan_list.lock){++--..}, at: [<f829bfa4>]
l2cap_phylink_update+0x2b4/0x11b0 [l2cap]
[  470.023274]
[  470.023275] stack backtrace:
[  470.023279] Pid: 3, comm: ksoftirqd/0 Not tainted 2.6.35-rc4 #1
[  470.023281] Call Trace:
[  470.023286]  [<c016774b>] print_circular_bug+0xbb/0xc0
[  470.023290]  [<c0168eb6>] validate_chain+0x1076/0x1080
[  470.023294]  [<c01655ba>] ? save_trace+0x3a/0xc0
[  470.023299]  [<c01691b8>] __lock_acquire+0x2f8/0xac0
[  470.023303]  [<c0169a06>] lock_acquire+0x86/0x100
[  470.023312]  [<f829bfdf>] ? l2cap_phylink_update+0x2ef/0x11b0 [l2cap]
[  470.023317]  [<c03f36b8>] _raw_spin_lock+0x38/0x50
[  470.023325]  [<f829bfdf>] ? l2cap_phylink_update+0x2ef/0x11b0 [l2cap]
[  470.023334]  [<f829bfdf>] l2cap_phylink_update+0x2ef/0x11b0 [l2cap]
[  470.023338]  [<c0166615>] ? mark_held_locks+0x55/0x70
[  470.023342]  [<c03f3e85>] ? _raw_spin_unlock_irqrestore+0x55/0x70
[  470.023346]  [<c0166686>] ? trace_hardirqs_on_caller+0x56/0x170
[  470.023350]  [<c01667ab>] ? trace_hardirqs_on+0xb/0x10
[  470.023358]  [<f8295cca>] ? amp_clear_phylink_timer+0x3a/0x70 [l2cap]
[  470.023368]  [<f82af9e1>] amp_create_phy_link_cfm+0x141/0x5c0 [l2cap]
[  470.023372]  [<c0167f29>] ? validate_chain+0xe9/0x1080
[  470.023384]  [<f82af8a0>] ? amp_create_phy_link_cfm+0x0/0x5c0 [l2cap]
[  470.023394]  [<f9a289b1>] hci_phylink_complete_evt+0xc1/0x130 [bluetooth]
[  470.023405]  [<f9a2b536>] hci_event_packet+0x236/0x3cb0 [bluetooth]
[  470.023410]  [<c0127a1c>] ? scale_rt_power+0x2c/0xb0
[  470.023414]  [<c01691b8>] ? __lock_acquire+0x2f8/0xac0
[  470.023427]  [<f9a2f705>] ? hci_send_to_sock+0x45/0x1c0 [bluetooth]
[  470.023438]  [<f9a2f7ab>] ? hci_send_to_sock+0xeb/0x1c0 [bluetooth]
[  470.023444]  [<c03f3c02>] ? _raw_read_unlock+0x22/0x30
[  470.023453]  [<f9a2f7ab>] ? hci_send_to_sock+0xeb/0x1c0 [bluetooth]
[  470.023458]  [<c01667ab>] ? trace_hardirqs_on+0xb/0x10
[  470.023468]  [<f9a230f9>] hci_rx_task+0x2e9/0x620 [bluetooth]
[  470.023472]  [<c03f3e27>] ? _raw_spin_unlock_irq+0x27/0x30
[  470.023476]  [<c013f24b>] ? tasklet_action+0x3b/0xd0
[  470.023480]  [<c0166686>] ? trace_hardirqs_on_caller+0x56/0x170
[  470.023484]  [<c013f26b>] tasklet_action+0x5b/0xd0
[  470.023488]  [<c013e4d7>] __do_softirq+0xa7/0x1e0
[  470.023492]  [<c03f1080>] ? schedule+0x220/0x600
[  470.023496]  [<c013e677>] do_softirq+0x67/0x70
[  470.023500]  [<c013e89e>] run_ksoftirqd+0x6e/0x110
[  470.023504]  [<c013e830>] ? run_ksoftirqd+0x0/0x110
[  470.023508]  [<c0153324>] kthread+0x74/0x80
[  470.023512]  [<c01532b0>] ? kthread+0x0/0x80
[  470.023516]  [<c01031c6>] kernel_thread_helper+0x6/0x10

-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
