Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1241488563.3319.2.camel@localhost.localdomain>
References: <2da21fe50905031022o73481d88tdaecb88491cfcfd2@mail.gmail.com>
	<1241381725.2785.0.camel@localhost.localdomain> <2da21fe50905041506m2d9fc879l715e34f1a2027046@mail.gmail.com>
	<1241488563.3319.2.camel@localhost.localdomain>
From: Davide Pesavento <davidepesa@gmail.com>
Date: Wed, 6 May 2009 18:33:59 +0200
Message-ID: <2da21fe50905060933y587fbd79m2bfa4ec8ad53a2fa@mail.gmail.com>
Subject: Re: [regression] connecting a bluetooth mouse triggers multiple BUGs
	and warnings
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, May 5, 2009 at 03:56, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Davide,
>
>> the NULL pointer dereference and the warnings are indeed fixed in
>> bluetooth-testing, and the mouse works. Thanks!
>> However the following issue remains:
>>
>> [ =C2=A0110.012125] BUG: sleeping function called from invalid context a=
t
>> mm/slub.c:1595
>> [ =C2=A0110.012135] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name:
>> swapper
>> [ =C2=A0110.012141] 2 locks held by swapper/0:
>> [ =C2=A0110.012145] =C2=A0#0: =C2=A0(hci_task_lock){++.-.+}, at: [<fffff=
fffa01f822f>]
>> hci_rx_task+0x2f/0x2d0 [bluetooth]
>> [ =C2=A0110.012173] =C2=A0#1: =C2=A0(&hdev->lock){+.-.+.}, at: [<fffffff=
fa01fb9e2>]
>> hci_event_packet+0x72/0x25c0 [bluetooth]
>> [ =C2=A0110.012198] Pid: 0, comm: swapper Tainted: G =C2=A0 =C2=A0 =C2=
=A0 =C2=A0W
>> 2.6.30-rc4-g953cdaa #1
>> [ =C2=A0110.012203] Call Trace:
>> [ =C2=A0110.012207] =C2=A0<IRQ> =C2=A0[<ffffffff8023eabd>] __might_sleep=
+0x14d/0x170
>> [ =C2=A0110.012228] =C2=A0[<ffffffff802cfbe1>] __kmalloc+0x111/0x170
>> [ =C2=A0110.012239] =C2=A0[<ffffffff803c2094>] kvasprintf+0x64/0xb0
>> [ =C2=A0110.012248] =C2=A0[<ffffffff803b7a5b>] kobject_set_name_vargs+0x=
3b/0xa0
>> [ =C2=A0110.012257] =C2=A0[<ffffffff80465326>] dev_set_name+0x76/0xa0
>> [ =C2=A0110.012273] =C2=A0[<ffffffffa01fb9e2>] ? hci_event_packet+0x72/0=
x25c0
>> [bluetooth]
>> [ =C2=A0110.012289] =C2=A0[<ffffffffa01ffc1d>] hci_conn_add_sysfs+0x3d/0=
x70
>> [bluetooth]
>> [ =C2=A0110.012303] =C2=A0[<ffffffffa01fba2c>] hci_event_packet+0xbc/0x2=
5c0
>> [bluetooth]
>> [ =C2=A0110.012312] =C2=A0[<ffffffff80516eb0>] ? sock_def_readable+0x80/=
0xa0
>> [ =C2=A0110.012328] =C2=A0[<ffffffffa01fee0c>] ? hci_send_to_sock+0xfc/0=
x1c0
>> [bluetooth]
>> [ =C2=A0110.012343] =C2=A0[<ffffffff80516eb0>] ? sock_def_readable+0x80/=
0xa0
>> [ =C2=A0110.012347] =C2=A0[<ffffffff805e88c5>] ? _read_unlock+0x75/0x80
>> [ =C2=A0110.012354] =C2=A0[<ffffffffa01fee0c>] ? hci_send_to_sock+0xfc/0=
x1c0
>> [bluetooth]
>> [ =C2=A0110.012360] =C2=A0[<ffffffffa01f8403>] hci_rx_task+0x203/0x2d0
>> [bluetooth]
>> [ =C2=A0110.012365] =C2=A0[<ffffffff80250ab5>] tasklet_action+0xb5/0x160
>> [ =C2=A0110.012369] =C2=A0[<ffffffff8025116c>] __do_softirq+0x9c/0x150
>> [ =C2=A0110.012372] =C2=A0[<ffffffff805e850f>] ? _spin_unlock+0x3f/0x80
>> [ =C2=A0110.012376] =C2=A0[<ffffffff8020cbbc>] call_softirq+0x1c/0x30
>> [ =C2=A0110.012380] =C2=A0[<ffffffff8020f01d>] do_softirq+0x8d/0xe0
>> [ =C2=A0110.012383] =C2=A0[<ffffffff80250df5>] irq_exit+0xc5/0xe0
>> [ =C2=A0110.012386] =C2=A0[<ffffffff8020e71d>] do_IRQ+0x9d/0x120
>> [ =C2=A0110.012389] =C2=A0[<ffffffff8020c3d3>] ret_from_intr+0x0/0xf
>> [ =C2=A0110.012391] =C2=A0<EOI> =C2=A0[<ffffffff80431832>] ? acpi_idle_e=
nter_bm+0x264/0x2a6
>> [ =C2=A0110.012399] =C2=A0[<ffffffff80431828>] ? acpi_idle_enter_bm+0x25=
a/0x2a6
>> [ =C2=A0110.012403] =C2=A0[<ffffffff804f50d5>] ? cpuidle_idle_call+0xc5/=
0x130
>> [ =C2=A0110.012407] =C2=A0[<ffffffff8020a4b4>] ? cpu_idle+0xc4/0x130
>> [ =C2=A0110.012411] =C2=A0[<ffffffff805d2268>] ? rest_init+0x88/0xb0
>> [ =C2=A0110.012416] =C2=A0[<ffffffff807e2fbd>] ? start_kernel+0x3b5/0x41=
2
>> [ =C2=A0110.012420] =C2=A0[<ffffffff807e2281>] ? x86_64_start_reservatio=
ns+0x91/0xb5
>> [ =C2=A0110.012424] =C2=A0[<ffffffff807e2394>] ? x86_64_start_kernel+0xe=
f/0x11b
>> [ =C2=A0110.320835] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
>> [ =C2=A0110.349150] input: Mighty Mouse as
>> /devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/bluetooth/hci0/hci0:46=
/input10
>> [ =C2=A0110.351343] apple 0005:05AC:030C.0004: input: BLUETOOTH HID v2.0=
0
>> Mouse [Mighty Mouse] on 00:17:F2:AB:8D:45
>
> try the attached patch. It should fix this.
>

Yes, the patch fixes the BUG. Thanks a lot!

Regards,
Davide
