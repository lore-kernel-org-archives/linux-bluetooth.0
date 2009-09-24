Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <dd18b0c30909212047m46b7c85aybb113517423fc7ac@mail.gmail.com>
References: <dd18b0c30909212047m46b7c85aybb113517423fc7ac@mail.gmail.com>
Date: Thu, 24 Sep 2009 15:02:40 -0700
Message-ID: <dd18b0c30909241502u314212e6vf1317dcb754bd0ca@mail.gmail.com>
Subject: Re: [ 14.123127] BUG: spinlock bad magic on CPU#0, swapper/0
From: Justin Mattock <justinmattock@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 21, 2009 at 8:47 PM, Justin Mattock <justinmattock@gmail.com> w=
rote:
> I'm just trying to get the dam* bluetooth mighty mouse to
> work. anyways the system barfed up this:
> (FWIW: =A0had bluez installed at-least an hour without this
> showing up, as soon as I installed libusb
> this showed up)
>
> [ =A0 13.607016] type=3D1400 audit(1253565686.600:3): avc: =A0denied =A0{
> execmem } for =A0pid=3D1759 comm=3D"python"
> scontext=3Dsystem_u:system_r:kernel_t
> tcontext=3Dsystem_u:system_r:kernel_t tclass=3Dprocess
> [ =A0 14.123127] BUG: spinlock bad magic on CPU#0, swapper/0
> [ =A0 14.123322] =A0lock: ffff88002ad28430, .magic: 00000000, .owner:
> <none>/-1, .owner_cpu: 0
> [ =A0 14.123598] Pid: 0, comm: swapper Not tainted 2.6.31-05767-gdf58bee =
#4
> [ =A0 14.123784] Call Trace:
> [ =A0 14.123965] =A0<IRQ> =A0[<ffffffff811cfd1e>] spin_bug+0x9c/0xa3
> [ =A0 14.124256] =A0[<ffffffff811cfdd9>] _raw_spin_lock+0x29/0x13c
> [ =A0 14.124446] =A0[<ffffffff813bad6c>] _spin_lock_irqsave+0x1f/0x26
> [ =A0 14.124637] =A0[<ffffffff812f99f5>] skb_dequeue+0x1c/0x6b
> [ =A0 14.124839] =A0[<ffffffffa0092c5e>] ? uhci_urb_enqueue+0x83a/0x853 [=
uhci_hcd]
> [ =A0 14.125029] =A0[<ffffffff812fa571>] skb_queue_purge+0x1e/0x28
> [ =A0 14.125224] =A0[<ffffffffa004d783>] l2cap_recv_frame+0x118d/0x20f4 [=
l2cap]
> [ =A0 14.125417] =A0[<ffffffff810ddf9c>] ? __slab_free+0x2b3/0x2f9
> [ =A0 14.125617] =A0[<ffffffffa003c8cd>] ? hci_event_packet+0x2984/0x299f
> [bluetooth]
> [ =A0 14.125892] =A0[<ffffffff812fa217>] ? __kfree_skb+0x78/0x7c
> [ =A0 14.126079] =A0[<ffffffff812fa2aa>] ? kfree_skb+0x65/0x6d
> [ =A0 14.126276] =A0[<ffffffffa003c8cd>] ? hci_event_packet+0x2984/0x299f
> [bluetooth]
> [ =A0 14.126552] =A0[<ffffffff81299598>] ? usb_submit_urb+0x217/0x22e
> [ =A0 14.126745] =A0[<ffffffffa006063c>] ? btusb_bulk_complete+0x9f/0xd6 =
[btusb]
> [ =A0 14.126935] =A0[<ffffffff813bad1d>] ? _spin_lock+0x9/0xb
> [ =A0 14.127126] =A0[<ffffffffa009093d>] ? uhci_giveback_urb+0x124/0x1a5 =
[uhci_hcd]
> [ =A0 14.127322] =A0[<ffffffffa004e7fe>] l2cap_recv_acldata+0xc5/0x233 [l=
2cap]
> [ =A0 14.127526] =A0[<ffffffffa003809f>] hci_rx_task+0x155/0x253 [bluetoo=
th]
> [ =A0 14.127718] =A0[<ffffffff81064319>] tasklet_action+0x80/0xdf
> [ =A0 14.127906] =A0[<ffffffff81065ba7>] __do_softirq+0xe0/0x1a1
> [ =A0 14.128099] =A0[<ffffffff8102d9ac>] call_softirq+0x1c/0x28
> [ =A0 14.128288] =A0[<ffffffff8102ee35>] do_softirq+0x41/0x81
> [ =A0 14.128480] =A0[<ffffffff8106597a>] irq_exit+0x36/0x78
> [ =A0 14.128671] =A0[<ffffffff8102e513>] do_IRQ+0xa0/0xb7
> [ =A0 14.128860] =A0[<ffffffff8102d1d3>] ret_from_intr+0x0/0x11
> [ =A0 14.129043] =A0<EOI> =A0[<ffffffffa0018c88>] ?
> acpi_idle_enter_bm+0x2d7/0x30b [processor]
> [ =A0 14.129432] =A0[<ffffffffa0018c81>] ? acpi_idle_enter_bm+0x2d0/0x30b
> [processor]
> [ =A0 14.129709] =A0[<ffffffff812d65b9>] ? cpuidle_idle_call+0x88/0xbf
> [ =A0 14.129899] =A0[<ffffffff8102bbf7>] ? cpu_idle+0x58/0x93
> [ =A0 14.130086] =A0[<ffffffff813aa2ad>] ? rest_init+0x61/0x63
> [ =A0 14.130276] =A0[<ffffffff8162514e>] ? start_kernel+0x361/0x36c
> [ =A0 14.130466] =A0[<ffffffff81624785>] ? x86_64_start_reservations+0xac=
/0xb0
> [ =A0 14.130656] =A0[<ffffffff81624881>] ? x86_64_start_kernel+0xf8/0x107
> [ =A0 14.642763] applesmc: light sensor data length set to 6
>
> I can try and do a git bisect,
> but might not be right now.
>
> --
> Justin P. Mattock
>

I understand if you have too much time
to deal with things like this.
Anyways posted a few days ago, had no response,
so I decided to post again, except add marcel to the
CC. Anyways I seem to be hitting this during
boot, and once the mouse falls alseep upon
wake up this triggers.(not all the time though)

here's a cutout of upon waking the mouse up
from sleeping(not s2ram)

[ 4400.410296] BUG: spinlock bad magic on CPU#0, swapper/0
[ 4400.410307]  lock: ffff8800385a5700, .magic: 00000000, .owner:
<none>/-1, .owner_cpu: 0
[ 4400.410314] Pid: 0, comm: swapper Not tainted 2.6.31-05767-gdf58bee #5
[ 4400.410319] Call Trace:
[ 4400.410323]  <IRQ>  [<ffffffff811ae39e>] spin_bug+0x9c/0xa3
[ 4400.410343]  [<ffffffff811ae459>] _raw_spin_lock+0x29/0x13c
[ 4400.410352]  [<ffffffff8139a51c>] _spin_lock_irqsave+0x1f/0x26
[ 4400.410361]  [<ffffffff812d91a5>] skb_dequeue+0x1c/0x6b
[ 4400.410382]  [<ffffffffa0092c5e>] ? uhci_urb_enqueue+0x83a/0x853 [uhci_h=
cd]
[ 4400.410390]  [<ffffffff812d9d21>] skb_queue_purge+0x1e/0x28
[ 4400.410404]  [<ffffffffa004d783>] l2cap_recv_frame+0x118d/0x20f4 [l2cap]
[ 4400.410413]  [<ffffffff810bc61c>] ? __slab_free+0x2b3/0x2f9
[ 4400.410432]  [<ffffffffa003c8cd>] ? hci_event_packet+0x2984/0x299f
[bluetooth]
[ 4400.410439]  [<ffffffff812d99c7>] ? __kfree_skb+0x78/0x7c
[ 4400.410446]  [<ffffffff812d9a5a>] ? kfree_skb+0x65/0x6d
[ 4400.410463]  [<ffffffffa003c8cd>] ? hci_event_packet+0x2984/0x299f
[bluetooth]
[ 4400.410471]  [<ffffffff81277c18>] ? usb_submit_urb+0x217/0x22e
[ 4400.410483]  [<ffffffffa006063c>] ? btusb_bulk_complete+0x9f/0xd6 [btusb=
]
[ 4400.410491]  [<ffffffff8139a4cd>] ? _spin_lock+0x9/0xb
[ 4400.410501]  [<ffffffffa009093d>] ? uhci_giveback_urb+0x124/0x1a5 [uhci_=
hcd]
[ 4400.410514]  [<ffffffffa004e7fe>] l2cap_recv_acldata+0xc5/0x233 [l2cap]
[ 4400.410531]  [<ffffffffa003809f>] hci_rx_task+0x155/0x253 [bluetooth]
[ 4400.410539]  [<ffffffff81042999>] tasklet_action+0x80/0xdf
[ 4400.410547]  [<ffffffff81044227>] __do_softirq+0xe0/0x1a1
[ 4400.410556]  [<ffffffff8100c02c>] call_softirq+0x1c/0x28
[ 4400.410563]  [<ffffffff8100d4b5>] do_softirq+0x41/0x81
[ 4400.410570]  [<ffffffff81043ffa>] irq_exit+0x36/0x78
[ 4400.410576]  [<ffffffff8100cb93>] do_IRQ+0xa0/0xb7
[ 4400.410585]  [<ffffffff8100b853>] ret_from_intr+0x0/0x11
[ 4400.410589]  <EOI>  [<ffffffffa0018c88>] ?
acpi_idle_enter_bm+0x2d7/0x30b [processor]
[ 4400.410619]  [<ffffffffa0018c81>] ? acpi_idle_enter_bm+0x2d0/0x30b
[processor]
[ 4400.410629]  [<ffffffff812b4c39>] ? cpuidle_idle_call+0x88/0xbf
[ 4400.410637]  [<ffffffff8100a277>] ? cpu_idle+0x58/0x93
[ 4400.410645]  [<ffffffff81389a5d>] ? rest_init+0x61/0x63
[ 4400.410654]  [<ffffffff815f710e>] ? start_kernel+0x361/0x36c
[ 4400.410662]  [<ffffffff815f6745>] ? x86_64_start_reservations+0xac/0xb0
[ 4400.410670]  [<ffffffff815f6841>] ? x86_64_start_kernel+0xf8/0x107
[ 5158.248934] input: justinmattock=E2s mouse as
/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/bluetooth/hci0/hci0:46/in=
put12
[ 5158.249279] generic-bluetooth 0005:0000:0000.0007: input: BLUETOOTH
HID v0.00 Mouse [justinmattock=E2s mouse] on 00:17:F2:B4:BC:F5

everything seems o.k. after this triggers
mouse reacts as is.
In any case at least you have this info.

--=20
Justin P. Mattock
