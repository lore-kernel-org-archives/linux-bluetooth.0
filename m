Return-Path: <cyrus@holtmann.org>
Message-ID: <1402918352.27142.84.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v6 1/4] Bluetooth: 6LoWPAN: Use connected oriented
 channel instead of fixed one
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Jun 2014 14:32:32 +0300
In-Reply-To: <2A263CED-602C-48AD-830F-77DA72D89514@holtmann.org>
References: 
	<1402664013-29358-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1402664013-29358-2-git-send-email-jukka.rissanen@linux.intel.com>
	 <2A263CED-602C-48AD-830F-77DA72D89514@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ma, 2014-06-16 at 11:45 +0200, Marcel Holtmann wrote:
> Hi Jukka,
> 
> > Create a CoC dynamically instead of one fixed channel for communication
> > to peer devices.
> > 

> > +static struct l2cap_ops bt_6lowpan_chan_ops;
> 
> Why this does need a forward declaration. Lets avoid this. And just a reminder that l2cap_ops need to be const now.

The chan_ops is needed when setting up the channel in new_connection cb,
I did not see a way to avoid forward declaration here.


> 
> > +	/* Remember the skb so that we can send EAGAIN to the caller if
> > +	 * we run out of credits.
> > +	 */
> > +	chan->data = skb;
> 
> Isn't this one dangerous? Who owns the skb and also more important who frees it? Don't we have to reference the skb somehow?

Sure, I will add ref here.



> > +static struct sk_buff *chan_alloc_skb_cb(struct l2cap_chan *chan,
> > +					 unsigned long hdr_len,
> > +					 unsigned long len, int nb)
> > +{
> > +	return bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
> > +}
> 
> this should no longer be there and just use the default one.
> 

Using GFP_KERNEL in standard l2cap_chan_no_alloc_skb() will lead to this
"might sleep" bug:


[   43.409028] WARNING: CPU: 0 PID: 282
at /home/jukka/src/linux/kernel/locking/lockdep.c:2742
lockdep_trace_alloc+0x100/0x110()
[   43.409028] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
[   43.409028] Modules linked in: bluetooth_6lowpan 6lowpan_iphc rfcomm
bnep nfc ecb btusb bluetooth rfkill snd_intel8x0 snd_ac97_codec ac97_bus
parport_pc parport
[   43.409028] CPU: 0 PID: 282 Comm: systemd-journal Not tainted
3.14.0-bt6lowpan #2
[   43.409028] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[   43.409028]  00000000 00000000 f5c09b60 c181a1b8 f5c09ba0 f5c09b90
c1045b2e c1a59112
[   43.409028]  f5c09bbc 0000011a c1a4eb90 00000ab6 c108e2d0 c108e2d0
00000046 00000080
[   43.409028]  00000023 f5c09ba8 c1045b83 00000009 f5c09ba0 c1a59112
f5c09bbc f5c09bc8
[   43.409028] Call Trace:
[   43.409028]  [<c181a1b8>] dump_stack+0x4b/0x75
[   43.409028]  [<c1045b2e>] warn_slowpath_common+0x7e/0xa0
[   43.409028]  [<c108e2d0>] ? lockdep_trace_alloc+0x100/0x110
[   43.409028]  [<c108e2d0>] ? lockdep_trace_alloc+0x100/0x110
[   43.409028]  [<c1045b83>] warn_slowpath_fmt+0x33/0x40
[   43.409028]  [<c108e2d0>] lockdep_trace_alloc+0x100/0x110
[   43.409028]  [<c1141068>] kmem_cache_alloc+0x28/0x220
[   43.409028]  [<c1700cd4>] ? __alloc_skb+0x44/0x280
[   43.409028]  [<c1700cd4>] __alloc_skb+0x44/0x280
[   43.409028]  [<f848f04d>] l2cap_chan_no_alloc_skb+0x1d/0x40
[bluetooth_6lowpan]
[   43.409028]  [<f826c999>] l2cap_chan_send+0x5a9/0xfb0 [bluetooth]
[   43.409028]  [<c108b6f6>] ? get_lock_stats+0x16/0x40
[   43.409028]  [<c108b8ad>] ? put_lock_stats.isra.21+0xd/0x30
[   43.409028]  [<f848f895>] send_pkt+0x55/0xc0 [bluetooth_6lwwpan]
[   43.409028]  [<f848faf2>] bt_xmit+0x1f2/0x2f0 [bluetooth_6lowpan]
[   43.409028]  [<c1710a1c>] dev_hard_start_xmit+0x2ec/0x5e0
[   43.409028]  [<c18221ab>] ? _raw_spin_lock+0x6b/0x80
[   43.409028]  [<c1711080>] __dev_queue_xmit+0x370/0x630
[   43.409028]  [<c1710d10>] ? dev_hard_start_xmit+0x5e0/0x5e0
[   43.409028]  [<f848fbf0>] ? bt_xmit+0x2f0/0x2f0 [bluetooth_6lowpan]
[   43.409028]  [<c171134f>] dev_queue_xmit+0xf/0x20
[   43.409028]  [<c1717d42>] neigh_connected_output+0x132/0x190
[   43.409028]  [<c17a9e73>] ? ip6_finish_output2+0x173/0x8d0
[   43.409028]  [<c17a9e73>] ip6_finish_output2+0x173/0x8d0
[   43.409028]  [<c17a9d4a>] ? ip6_finish_output2+0x4a/0x8d0
[   43.409028]  [<c17af445>] ip6_finish_output+0x75/0x1c0
[   43.409028]  [<c17af617>] ip6_output+0x87/0x270
[   43.409028]  [<c17bc7f0>] ? ip6_blackhole_route+0x2a0/0x2a0
[   43.409028]  [<c17cf61d>] mld_sendpack+0x49d/0x640
[   43.409028]  [<c17cff51>] ? mld_ifc_timer_expire+0x191/0x2c0
[   43.409028]  [<c17cff51>] mld_ifc_timer_expire+0x191/0x2c0
[   43.409028]  [<c1050b65>] call_timer_fn+0x85/0x190
[   43.409028]  [<c1050ae0>] ? process_timeout+0x10/0x10
[   43.409028]  [<c108d8b4>] ? trace_hardirqs_on_caller+0xe4/0x210
[   43.409028]  [<c17cfdc0>] ? mld_send_initial_cr.part.31+0xa0/0xa0
[   43.409028]  [<c1051322>] run_timer_softirq+0x182/0x260
[   43.409028]  [<c104a040>] ? __tasklet_hrtimer_trampoline+0x40/0x40
[   43.409028]  [<c139acbf>] ? __this_cpu_preempt_check+0xf/0x20
[   43.409028]  [<c17cfdc0>] ? mld_send_initial_cr.part.31+0xa0/0xa0
[   43.409028]  [<c104a14d>] __do_softirq+0x10d/0x2e0
[   43.409028]  [<c104a040>] ? __tasklet_hrtimer_trampoline+0x40/0x40
[   43.409028]  [<c100410c>] do_softirq_own_stack+0x2c/0x40
[   43.409028]  <IRQ>  [<c104a5e6>] irq_exit+0x86/0xb0
[   43.409028]  [<c182aa28>] smp_apic_timer_interrupt+0x38/0x50
[   43.409028]  [<c182372a>] apic_timer_interrupt+0x32/0x38
[   43.409028]  [<c1140a3a>] ? kmem_cache_free+0x8a/0x240
[   43.409028]  [<c108b8ad>] ? put_lock_stats.isra.21+0xd/0x30
[   43.409028]  [<c112f00a>] ? remove_vma+0x4a/0x50
[   43.409028]  [<c112f00a>] remove_vma+0x4a/0x50
[   43.409028]  [<c1130b2d>] do_munmap+0x20d/0x2c0
[   43.409028]  [<c1130c17>] vm_munmap+0x37/0x50
[   43.409028]  [<c1131890>] SyS_munmap+0x20/0x30
[   43.409028]  [<c18232f6>] syscall_call+0x7/0xb
[   43.409028]  [<c1820000>] ? mutex_unlock+0x10/0x10
[   43.409028] ---[ end trace c7c40884ae627621 ]---
[   43.409028] BUG: sleeping function called from invalid context
at /home/jukka/src//linux/mm/slub.c:969
[   43.409028] in_atomic(): 1, irqs_disabled(): 1, pid: 282, name:
systemd-journal
[   43.409028] INFO: lockdep is turned off.



Cheers,
Jukka
