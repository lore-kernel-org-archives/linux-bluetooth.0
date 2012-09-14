Return-Path: <cyrus@holtmann.org>
Message-ID: <1347618394.6586.1.camel@maxim-laptop>
Subject: Re: [PATCH] Bluetooth: Free the l2cap channel list only when
 refcount is zero
From: Maxim Levitsky <maximlevitsky@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Jaganath <jaganath.k@samsung.com>, linux-bluetooth@vger.kernel.org,
	s.syam@samsung.com
Date: Fri, 14 Sep 2012 13:26:34 +0300
In-Reply-To: <20120914094458.GD7483@aemeltch-MOBL1>
References: <1342165923-4901-1-git-send-email-jaganath.k@samsung.com>
	 <20120713084859.GC2729@aemeltch-MOBL1>
	 <4368C8F191BB414F84A70D30771FE893@sisodomain.com>
	 <1347580581.5975.4.camel@maxim-laptop>
	 <20120914094458.GD7483@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-09-14 at 12:45 +0300, Andrei Emeltchenko wrote: 
> Hi Maxim,
> 
> On Fri, Sep 14, 2012 at 02:56:21AM +0300, Maxim Levitsky wrote:
> > On Fri, 2012-07-13 at 16:56 +0530, Jaganath wrote: 
> > > Hi Andrei,
> > > 
> > > --------------------------------------------------
> > > From: "Andrei Emeltchenko" <andrei.emeltchenko.news@gmail.com>
> > > Sent: Friday, July 13, 2012 2:19 PM
> > > To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
> > > Cc: <linux-bluetooth@vger.kernel.org>; <s.syam@samsung.com>
> > > Subject: Re: [PATCH] Bluetooth: Free the l2cap channel list only when 
> > > refcount is zero
> > > 
> > > > Hi Jaganath,
> > > >
> > > > On Fri, Jul 13, 2012 at 01:22:03PM +0530, Jaganath Kanakkassery wrote:
> > > >> Move the l2cap channel list chan->global_l under the refcnt
> > > >> protection and free it based on the refcnt.
> > > >
> > > > The idea is good.
> > > >
> > Note that in 3.6-rc5 which soon to be released, it trivial to trigger a
> > crash by suspending the system with a2dp headphones connected.
> > I also have seem (and I strongly suspect the same) crash in 3.5
> > This patch seems to fix this so far.
> > Could you sent it to Linus, to fix this kernel panic?
> 
> AFAIK the updated patch has been applied. Concerning your crash you can
> also check my patch in the mail archive "Bluetooth: Add refcnt to l2cap_conn"
> 
> Best regards 
> Andrei Emeltchenko 

I'll will.
Even if it is applied, its not yet in Linus's tree of today.

Thanks for  your patch!

Best regards,
Maxim Levitsky

> 
> > 
> > Best  regards,
> > Maxim Levitsky
> > 
> > PS:
> > The backtrace:
> > 
> > 
> > fg80211: Calling CRDA to update world regulatory domain
> > cfg80211: World regulatory domain updated:
> > cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain,
> > max_eirp)
> > cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000
> > mBm)2
> > cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
> > cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000
> > mBm)T:
> > cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> > cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> > 8
> > cfg80211: World regulatory domain updated:
> > cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain,
> > max_eirp)
> > cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000
> > mBm)<
> > cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000
> > mBm)P@
> > cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
> > cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> > cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> > general protection fault: 0000 [#1] PREEMPT SMP 
> > Modules linked in: hidp af_packet bnep rfcomm iwl3945
> > snd_hda_codec_realtek iwlegacy mac80211 snd_hda_intel nfsd btusb
> > snd_hda_codec uvcvideo snd_hwdep videobuf2_core snd_pcm bluetooth
> > videobuf2_vmalloc videobuf2_memops nfs_acl auth_rpcgss r592 cfg80211
> > microcode nfs psmouse memstick serio_raw snd_page_alloc ene_ir battery
> > ac lockd sunrpc rc_lirc ir_lirc_codec lirc_dev ir_rc6_decoder
> > firewire_net iTCO_wdt firewire_sbp2 nouveau ttm drm_kms_helper mxm_wmi
> > usb_storage video wmi uhci_hcd sdhci_pci firewire_ohci firewire_core
> > sdhci mmc_core atkbd ehci_hcd thermal [last unloaded: tg3]
> > CPU 0 
> > Pid: 3512, comm: bluetoothd Not tainted 3.6.0-rc5+ #34 Acer       Aspire
> > 5720     /Nettiling?b
> > RIP: 0010:[<ffffffffa03a1d56>]  [<ffffffffa03a1d56>] l2cap_chan_destroy
> > +0x46/0xb0 [bluetooth]
> > RSP: 0018:ffff8800619dbca8  EFLAGS: 00010296
> > RAX: dead000000200200 RBX: ffff88007d3f1000 RCX: dead000000100100
> > RDX: dead000000100100 RSI: dead000000200200 RDI: ffffffffa03b7cc0
> > RBP: ffff8800619dbcb8 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0001cc0f349b43de R11: ffffffffa03a1d2d R12: ffff88007d3f1000
> > R13: ffff88007d3f1014 R14: ffff88005f922570 R15: ffff88005f9229e0
> > FS:  00007f8aa4634740(0000) GS:ffff88007fa00000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f8aa46b7d90 CR3: 000000005f945000 CR4: 00000000000007f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > Process bluetoothd (pid: 3512, threadinfo ffff8800619da000, task
> > ffff88005ec4bde0)
> > Stack:
> > ffff8800619dbcd8 ffff880079945800 ffff8800619dbcd8 ffffffffa03a7b3c
> > ffff88007d3f1000 ffff88005f922800 ffff8800619dbce8 ffffffffa03a7b85
> > ffff8800619dbd48 ffffffffa03a231e ffff88007d3f14a0 ffff88005f9229f0
> > Call Trace:
> > [<ffffffffa03a7b3c>] l2cap_sock_kill+0x7c/0xb0 [bluetooth]
> > [<ffffffffa03a7b85>] l2cap_sock_close_cb+0x15/0x20 [bluetooth]
> > [<ffffffffa03a231e>] l2cap_conn_del+0x11e/0x1f0 [bluetooth]
> > [<ffffffffa038301a>] ? hci_dev_do_close+0x18a/0x370 [bluetooth]
> > [<ffffffffa03a6db3>] l2cap_disconn_cfm+0x53/0x60 [bluetooth]
> > [<ffffffffa0388c55>] hci_conn_hash_flush+0x95/0x100 [bluetooth]
> > [<ffffffffa038302a>] hci_dev_do_close+0x19a/0x370 [bluetooth]
> > [<ffffffffa0384af0>] hci_dev_close+0x50/0x80 [bluetooth]
> > [<ffffffffa039af3a>] hci_sock_ioctl+0x15a/0x420 [bluetooth]
> > [<ffffffff8144c6e0>] sock_do_ioctl+0x30/0x60
> > [<ffffffff8105f3e0>] ? task_work_run+0x30/0xa0
> > [<ffffffff8144d570>] sock_ioctl+0x290/0x2b0
> > [<ffffffff81147f20>] do_vfs_ioctl+0x580/0x5e0
> > [<ffffffff8151630b>] ? _raw_spin_unlock_irq+0x3b/0x60
> > [<ffffffff81147fcf>] sys_ioctl+0x4f/0x80
> > [<ffffffff81517016>] system_call_fastpath+0x1a/0x1f
> > Code: 17 e1 48 8b 93 80 04 00 00 48 b9 00 01 10 00 00 00 ad de 48 8b 83
> > 88 04 00 00 48 c7 c7 c0 7c 3b a0 48 be 00 02 20 00 00 00 ad de <48> 89
> > 42 08 48 89 10 48 89 8b 80 04 00 00 48 89 b3 88 04 00 00 
> > "RIP  [<ffffffffa03a1d56>] l2cap_chan_destroy+0x46/0xb0 [bluetooth]
> > RSP <ffff8800619dbca8>
> > ---[ end trace 6e537072816e99b2 ]---+qZ
> > Kernel panic - not syncing: Fatal exception
> > fpanic occurred, switching back to text console
> > Rebooting in 10 seconds..
> > ACPI MEMORY or I/O RESET_REG.
> > 

-- 
Best regards,
        Maxim Levitsky

Visit my blog: http://maximlevitsky.wordpress.com
Warning: Above blog contains rants.

