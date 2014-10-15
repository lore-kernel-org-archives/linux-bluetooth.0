Return-Path: <cyrus@holtmann.org>
Message-ID: <543EDD20.8050508@hurleysoftware.com>
Date: Wed, 15 Oct 2014 16:46:24 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Incorrect locking when sending data in softirq
References: <1413376985-25812-1-git-send-email-jukka.rissanen@linux.intel.com>	 <543E7414.8090209@hurleysoftware.com> <1413379948.2705.120.camel@jrissane-mobl.ger.corp.intel.com>
In-Reply-To: <1413379948.2705.120.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/15/2014 09:32 AM, Jukka Rissanen wrote:
> Hi Peter,
> 
> On ke, 2014-10-15 at 09:18 -0400, Peter Hurley wrote:
>> Hi Jukka,
>>
>> On 10/15/2014 08:43 AM, Jukka Rissanen wrote:
>>> Use spin_lock_irqsave() when sending data to hci channel. Otherwise
>>> the lockdep gives inconsistent lock state warning when sending data
>>> to 6lowpan channel.
>>>
>>>  [ INFO: inconsistent lock state ]
>>>  3.17.0-rc1-bt6lowpan #1 Not tainted
>>>  ---------------------------------
>>>  inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>>>  kworker/u3:0/321 [HC0[0]:SC0[0]:HE1:SE1] takes:
>>>   (&(&list->lock)->rlock#6){+.?...}, at: [<f845fdac>] hci_send_acl+0xac/0x290 [bluetooth]
>>>  {IN-SOFTIRQ-W} state was registered at:
>>>    [<c10915a3>] __lock_acquire+0x6d3/0x1d20
>>>    [<c109325d>] lock_acquire+0x9d/0x140
>>>    [<c1889c25>] _raw_spin_lock+0x45/0x80
>>>    [<f845fdac>] hci_send_acl+0xac/0x290 [bluetooth]
>>>    [<f8480c60>] l2cap_do_send+0x60/0x100 [bluetooth]
>>>    [<f8484830>] l2cap_chan_send+0x7f0/0x10e0 [bluetooth]
>>>    [<f873191e>] send_pkt+0x4e/0xa0 [bluetooth_6lowpan]
>>>    [<f8731d20>] bt_xmit+0x3b0/0x770 [bluetooth_6lowpan]
>>>    [<c17742f4>] dev_hard_start_xmit+0x344/0x670
>>>    [<c17749ad>] __dev_queue_xmit+0x38d/0x680
>>>    [<c1774caf>] dev_queue_xmit+0xf/0x20
>>>    [<c177b8b0>] neigh_connected_output+0x130/0x1a0
>>>    [<c1812a63>] ip6_finish_output2+0x173/0x8c0
>>>    [<c18182db>] ip6_finish_output+0x7b/0x1b0
>>>    [<c18184a7>] ip6_output+0x97/0x2a0
>>>    [<c183a46b>] mld_sendpack+0x5eb/0x650
>>>    [<c183acc1>] mld_ifc_timer_expire+0x191/0x2f0
>>>    [<c10ac385>] call_timer_fn+0x85/0x1c0
>>>    [<c10acb72>] run_timer_softirq+0x192/0x280
>>>    [<c104fd84>] __do_softirq+0xd4/0x300
>>>    [<c10049fc>] do_softirq_own_stack+0x2c/0x40
>>>    [<c1050136>] irq_exit+0x86/0xb0
>>>    [<c188bd98>] smp_apic_timer_interrupt+0x38/0x50
>>>    [<c188b6ce>] apic_timer_interrupt+0x32/0x38
>>>
>>> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
>>> ---
>>> Hi,
>>>
>>> this patch fixes the locking issue when sending larger amount of
>>> data via 6lowpan link. After this patch the lockdep no longer warns
>>> about softirq issues. 
>>>
>>> Cheers,
>>> Jukka
>>>
>>>
>>>  net/bluetooth/hci_core.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index 8aea4be..3e295ff 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -4642,6 +4642,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
>>>  	struct hci_conn *conn = chan->conn;
>>>  	struct hci_dev *hdev = conn->hdev;
>>>  	struct sk_buff *list;
>>> +	unsigned long irq_flags;
>>>  
>>>  	skb->len = skb_headlen(skb);
>>>  	skb->data_len = 0;
>>> @@ -4673,7 +4674,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
>>>  		skb_shinfo(skb)->frag_list = NULL;
>>>  
>>>  		/* Queue all fragments atomically */
>>> -		spin_lock(&queue->lock);
>>> +		spin_lock_irqsave(&queue->lock, irq_flags);
>>
>> spin_lock_bh(&queue->lock) will suffice.
> 
> I thought so too but when using spin_lock_bh() I saw this warning
> 
> WARNING: CPU: 0 PID: 269 at .../linux/kernel/softirq.c:146
> __local_bh_enable_ip+0x98/0xf0()
> Modules linked in: bluetooth_6lowpan 6lowpan rfcomm ecb btusb bnep
> bluetooth nfc rfkill ohci_pci snd_intel8x0 snd_ac97_codec ac97_bus
> parport_pc parport
> CPU: 0 PID: 269 Comm: systemd-journal Not tainted 3.17.0-rc1-bt6lowpan
> #1
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox
> 12/01/2006
>  00000000 00000000 f600bb4c c18821c1 00000000 f600bb80 c104c472 c1ac7860
>  00000000 0000010d c1ac7c68 00000092 c104fc58 00000092 c104fc58 00000201
>  f82d6e39 00000000 f600bb90 c104c532 00000009 00000000 f600bba0 c104fc58
> Call Trace:
>  [<c18821c1>] dump_stack+0x4b/0x75
>  [<c104c472>] warn_slowpath_common+0x82/0xa0
>  [<c104fc58>] ? __local_bh_enable_ip+0x98/0xf0
>  [<c104fc58>] ? __local_bh_enable_ip+0x98/0xf0
>  [<f82d6e39>] ? hci_send_acl+0x199/0x290 [bluetooth]
>  [<c104c532>] warn_slowpath_null+0x22/0x30
>  [<c104fc58>] __local_bh_enable_ip+0x98/0xf0
>  [<c1889fff>] _raw_spin_unlock_bh+0x2f/0x40
>  [<f82d6e39>] hci_send_acl+0x199/0x290 [bluetooth]
>  [<c108c956>] ? trace_hardirqs_off_caller+0x66/0x160
>  [<f82f7bf0>] l2cap_do_send+0x60/0x100 [bluetooth]
>  [<c108ca5b>] ? trace_hardirqs_off+0xb/0x10
>  [<c188a051>] ? _raw_spin_unlock_irqrestore+0x41/0x70
>  [<c1763125>] ? skb_dequeue+0x45/0x60
>  [<f82fb7c0>] l2cap_chan_send+0x7f0/0x10e0 [bluetooth]
>  [<c108ca5b>] ? trace_hardirqs_off+0xb/0x10
>  [<c188a6d1>] ? _raw_write_unlock_irqrestore+0x41/0x70
>  [<c187f10c>] ? kmemleak_alloc+0x3c/0xb0
>  [<f84f591e>] send_pkt+0x4e/0xa0 [bluetooth_6lowpan]
>  [<f84f5d20>] bt_xmit+0x3b0/0x770 [bluetooth_6lowpan]
>  [<c176f2a0>] ? netif_napi_del+0x50/0x50
>  [<c17742f4>] dev_hard_start_xmit+0x344/0x670
>  [<c1889c4b>] ? _raw_spin_lock+0x6b/0x80
>  [<c17749ad>] __dev_queue_xmit+0x38d/0x680
>  [<c177465b>] ? __dev_queue_xmit+0x3b/0x680
>  [<c108f1d4>] ? trace_hardirqs_on_caller+0xf4/0x240
>  [<f84f5820>] ? lookup_peer+0xb0/0xb0 [bluetooth_6lowpan]
>  [<c1774caf>] dev_queue_xmit+0xf/0x20
>  [<c177b8b0>] neigh_connected_output+0x130/0x1a0
>  [<c1812a63>] ? ip6_finish_output2+0x173/0x8c0
>  [<c1812a63>] ip6_finish_output2+0x173/0x8c0
>  [<c181293c>] ? ip6_finish_output2+0x4c/0x8c0
>  [<c18182db>] ip6_finish_output+0x7b/0x1b0
>  [<c18184a7>] ip6_output+0x97/0x2a0
>  [<c1825cb0>] ? ip6_blackhole_route+0x250/0x250
>  [<c183a46b>] mld_sendpack+0x5eb/0x650
>  [<c183acc1>] ? mld_ifc_timer_expire+0x191/0x2f0
>  [<c183acc1>] mld_ifc_timer_expire+0x191/0x2f0
>  [<c10ac385>] call_timer_fn+0x85/0x1c0
>  [<c10ac300>] ? process_timeout+0x10/0x10
>  [<c108f1d4>] ? trace_hardirqs_on_caller+0xf4/0x240
>  [<c183ab30>] ? mld_send_initial_cr.part.31+0xa0/0xa0
>  [<c10acb72>] run_timer_softirq+0x192/0x280
>  [<c104fcb0>] ? __local_bh_enable_ip+0xf0/0xf0
>  [<c13d09ff>] ? __this_cpu_preempt_check+0xf/0x20
>  [<c183ab30>] ? mld_send_initial_cr.part.31+0xa0/0xa0
>  [<c104fd84>] __do_softirq+0xd4/0x300
>  [<c104fcb0>] ? __local_bh_enable_ip+0xf0/0xf0
>  [<c10049fc>] do_softirq_own_stack+0x2c/0x40
>  <IRQ>  [<c1050136>] irq_exit+0x86/0xb0
>  [<c188bd98>] smp_apic_timer_interrupt+0x38/0x50
>  [<c188b6ce>] apic_timer_interrupt+0x32/0x38
>  [<c106e240>] ? __sched_fork.isra.74+0x140/0x140
>  [<c10c8dbb>] ? is_module_text_address+0x2b/0x50
>  [<c1065772>] __kernel_text_address+0x32/0x80
>  [<c1005c2f>] print_context_stack+0x3f/0xe0
>  [<c1004b65>] dump_trace+0xc5/0x1f0
>  [<c100fcf0>] save_stack_trace+0x30/0x50
>  [<c116aa8a>] create_object+0x10a/0x280
>  [<c187f10c>] kmemleak_alloc+0x3c/0xb0
>  [<c10718bb>] ? preempt_count_add+0x4b/0xa0
>  [<c115e693>] kmem_cache_alloc+0x1a3/0x290
>  [<c116fe47>] ? get_empty_filp+0x57/0x1d0
>  [<c116fe47>] get_empty_filp+0x57/0x1d0
>  [<c10761ef>] ? sched_clock_cpu+0x10f/0x160
>  [<c117bcd8>] path_openat+0x28/0x5c0
>  [<c13d09e2>] ? debug_smp_processor_id+0x12/0x20
>  [<c117d331>] do_filp_open+0x31/0x90
>  [<c118a2f8>] ? __alloc_fd+0x88/0x100
>  [<c1889fac>] ? _raw_spin_unlock+0x2c/0x50
>  [<c118a2f8>] ? __alloc_fd+0x88/0x100
>  [<c116d887>] do_sys_open+0x117/0x210
>  [<c188aeef>] ? restore_all+0xf/0xf
>  [<c13d09ff>] ? __this_cpu_preempt_check+0xf/0x20
>  [<c1080000>] ? dequeue_rt_stack+0x1a0/0x2e0
>  [<c116d9a2>] SyS_open+0x22/0x30
>  [<c188aeb6>] syscall_call+0x7/0x7
>  [<c1880000>] ? hpet_reserve_platform_timers+0x6e/0x111
> ---[ end trace 81f9756f84a67848 ]---

That's happening because 6lowpan.c:send_mcast_pkt() is disabling
interrupts with the read_lock_irqsave() before calling send_pkt().

It's unclear browsing through the lowpan driver why the
irqflags save/restore read_lock flavors are being used; is there a
place where the bluetooth core is calling the driver in atomic
context (ie., where interrupts are disabled)?

The devices_lock/bt_6lowpan_devices list looks ideal for
converting to RCU.

Regards,
Peter Hurley

PS - list_for_each_entry_safe() is only required when the reference
to the list entry may become invalid _while_ still iterating the list.
So not necessary in peer_lookup_conn(), lookup_peer(), lookup_dev(),
peer_lookup_chan(), peer_lookup_ba(), send_mcast_pkt(), maybe others.

