Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   kernel-janitors@lists.osdl.org
In-Reply-To: <20050203002502.GB2546@us.ibm.com>
References: <20050202225855.GY2546@us.ibm.com>
	 <1107386189.11944.21.camel@pegasus>  <20050203002502.GB2546@us.ibm.com>
Content-Type: text/plain
Message-Id: <1107562301.6921.115.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH 19/20] bluetooth/bluecard_cs: remove
 interruptible_sleep_on_timeout() usage
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 05 Feb 2005 01:11:41 +0100

Hi Nish,

> > > Please consider applying.
> > > 
> > > Description: Remove deprecated interruptible_sleep_on_timeout() function calls
> > > and replace with direct wait-queue usage. Some naming conflicts occurred, which
> > > I tried to resolve appropriately. Patch is compile-tested.
> > 
> > you introduce more code than you remove. Is our code a special case or
> > why don't exists a simple API function as replacement?
> 
> Yes, I do. *sleep_on*() was the API, which has been replaced with wait_event*().
> However, wait_event*() explicitly needs a condition (the "event"), which in
> thise case does not exist. If I had more background, I would have gone the
> wait_event*() route. I am looking into a better API to mask away all of the
> DEFINE_WAIT(), prepare_to_wait(), schedule()/schedule_timeout(), finish_wait()
> additions (the KJ list can attest to how many of these replacements I'm doing),
> but there simply does not exist such an API right now.
> 
> Any input you could provide, though, would be greatly appreciated.

I gave your patch a shot and the oops below happens on a 2.6.11-rc3
after plugging in the card. Without the patch it is working.

Regards

Marcel


Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0130b72
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: bluecard_cs twofish rfcomm hidp l2cap pcmcia binfmt_misc md5 ipv6 capi kernelcapi xfrm_user xfrm4_tunnel ipcomp esp4 ah4 af_key ehci_hcd hci_usb bluetooth ohci_hcd usbcore i2c_ali1535 yenta_socket rsrc_nonstatic pcmcia_core ath_pci ath_rate_onoe wlan ath_hal 8250_pci 8250 serial_core snd_ali5451 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc evdev vfat fat nls_base i2c_sensor i2c_core radeon drm agpgart tg3 unix
CPU:    0
EIP:    0060:[<c0130b72>]    Tainted: P      VLI
EFLAGS: 00010046   (2.6.11-rc3) 
EIP is at prepare_to_wait+0x32/0xa0
eax: 00000000   ebx: d42f3ea0   ecx: 00000001   edx: d42f3eac
esi: d42f3e80   edi: 00000246   ebp: 00000001   esp: d42f3e4c
ds: 007b   es: 007b   ss: 0068
Process hcid (pid: 7206, threadinfo=d42f2000 task=d3bc7560)
Stack: dda0eb00 dc4f6840 c0130d10 00000005 ded652ee 00000340 00000000 dac21008 
       00000005 02000150 dc4f68fc 01000292 00000340 00000000 d3bc7560 c0130d10 
       d42f3eac d42f3eac 000000d0 00000150 c0148da0 00000000 d3bc7560 c0130d10 
Call Trace:
 [<c0130d10>] autoremove_wake_function+0x0/0x60
 [<ded652ee>] bluecard_write_wakeup+0x20e/0x2d0 [bluecard_cs]
 [<c0130d10>] autoremove_wake_function+0x0/0x60
 [<c0148da0>] do_wp_page+0x1d0/0x340
 [<c0130d10>] autoremove_wake_function+0x0/0x60
 [<c0258607>] alloc_skb+0x47/0xf0
 [<ded65a45>] bluecard_hci_set_baud_rate+0xe5/0x160 [bluecard_cs]
 [<ded65b53>] bluecard_hci_open+0x73/0x80 [bluecard_cs]
 [<dece72e1>] hci_dev_open+0x51/0x240 [bluetooth]
 [<c0254b59>] sock_ioctl+0xd9/0x260
 [<c016cfce>] do_ioctl+0x8e/0xa0
 [<c016d215>] vfs_ioctl+0x65/0x1f0
 [<c016d407>] sys_ioctl+0x67/0x90
 [<c01031af>] syscall_call+0x7/0xb
Code: d3 89 74 24 04 89 c6 89 6c 24 0c 89 cd 89 7c 24 08 83 22 fe 9c 5f fa b8 01 00 00 00 e8 68 71 fe ff 8d 53 0c 39 53 0c 75 0d 8b 06 <89> 50 04 89 43 0c 89 72 04 89 16 8b 43 04 85 c0 74 0b b8 00 e0 
 <6>note: hcid[7206] exited with preempt_count 1
scheduling while atomic: hcid/0x10000001/7206
 [<c02b2e42>] schedule+0x522/0x530
 [<c0147e6e>] unmap_page_range+0x7e/0xa0
 [<c02b36da>] cond_resched+0x2a/0x50
 [<c0148040>] unmap_vmas+0x1b0/0x210
 [<c014ceac>] exit_mmap+0x7c/0x170
 [<c01192d7>] mmput+0x37/0xb0
 [<c011dc83>] do_exit+0x93/0x3c0
 [<c010439b>] die+0x18b/0x190
 [<c011baf7>] printk+0x17/0x20
 [<c0115fea>] do_page_fault+0x2da/0x5d5
 [<c0115eac>] do_page_fault+0x19c/0x5d5
 [<c0117038>] recalc_task_prio+0x88/0x150
 [<c013ddf1>] __rmqueue+0xb1/0xf0
 [<c013de5e>] rmqueue_bulk+0x2e/0x90
 [<c013dd30>] prep_new_page+0x60/0x70
 [<c013e2af>] buffered_rmqueue+0xdf/0x210
 [<c0115d10>] do_page_fault+0x0/0x5d5
 [<c0103be7>] error_code+0x2b/0x30
 [<c0130b72>] prepare_to_wait+0x32/0xa0
 [<c0130d10>] autoremove_wake_function+0x0/0x60
 [<ded652ee>] bluecard_write_wakeup+0x20e/0x2d0 [bluecard_cs]
 [<c0130d10>] autoremove_wake_function+0x0/0x60
 [<c0148da0>] do_wp_page+0x1d0/0x340
 [<c0130d10>] autoremove_wake_function+0x0/0x60
 [<c0258607>] alloc_skb+0x47/0xf0
 [<ded65a45>] bluecard_hci_set_baud_rate+0xe5/0x160 [bluecard_cs]
 [<ded65b53>] bluecard_hci_open+0x73/0x80 [bluecard_cs]
 [<dece72e1>] hci_dev_open+0x51/0x240 [bluetooth]
 [<c0254b59>] sock_ioctl+0xd9/0x260
 [<c016cfce>] do_ioctl+0x8e/0xa0
 [<c016d215>] vfs_ioctl+0x65/0x1f0
 [<c016d407>] sys_ioctl+0x67/0x90
 [<c01031af>] syscall_call+0x7/0xb




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
