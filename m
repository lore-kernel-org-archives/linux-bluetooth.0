Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1241381725.2785.0.camel@localhost.localdomain>
References: <2da21fe50905031022o73481d88tdaecb88491cfcfd2@mail.gmail.com>
	<1241381725.2785.0.camel@localhost.localdomain>
From: Davide Pesavento <davidepesa@gmail.com>
Date: Tue, 5 May 2009 00:06:47 +0200
Message-ID: <2da21fe50905041506m2d9fc879l715e34f1a2027046@mail.gmail.com>
Subject: Re: [regression] connecting a bluetooth mouse triggers multiple BUGs
	and warnings
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, May 3, 2009 at 22:15, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Davide,
>
>> with 2.6.30-rc4, when I connect my bluetooth mouse to the laptop, the
>> kernel breaks with a lot of noise.
>> (the kernel is already tainted because of a reiserfs warning happened ea=
rlier)
>>
>> [ =C2=A0417.555941] BUG: sleeping function called from invalid context a=
t
>> mm/slub.c:1595
>> [ =C2=A0417.555951] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name:
>> swapper
>> [ =C2=A0417.555958] 2 locks held by swapper/0:
>> [ =C2=A0417.555962] =C2=A0#0: =C2=A0(hci_task_lock){++.-.+}, at: [<fffff=
fffa01f822f>]
>> hci_rx_task+0x2f/0x2d0 [bluetooth]
>> [ =C2=A0417.555991] =C2=A0#1: =C2=A0(&hdev->lock){+.-.+.}, at: [<fffffff=
fa01fb9d2>]
>> hci_event_packet+0x72/0x25c0 [bluetooth]
>> [ =C2=A0417.556017] Pid: 0, comm: swapper Tainted: G =C2=A0 =C2=A0 =C2=
=A0 =C2=A0W
>> 2.6.30-rc4-wl #40
>> [ =C2=A0417.556022] Call Trace:
>> [ =C2=A0417.556026] =C2=A0<IRQ> =C2=A0[<ffffffff8023eabd>] __might_sleep=
+0x14d/0x170
>> [ =C2=A0417.556047] =C2=A0[<ffffffff802cfbe1>] __kmalloc+0x111/0x170
>> [ =C2=A0417.556058] =C2=A0[<ffffffff803c2094>] kvasprintf+0x64/0xb0
>> [ =C2=A0417.556067] =C2=A0[<ffffffff803b7a5b>] kobject_set_name_vargs+0x=
3b/0xa0
>> [ =C2=A0417.556076] =C2=A0[<ffffffff80465326>] dev_set_name+0x76/0xa0
>> [ =C2=A0417.556092] =C2=A0[<ffffffffa01fb9d2>] ? hci_event_packet+0x72/0=
x25c0
>> [bluetooth]
>> [ =C2=A0417.556108] =C2=A0[<ffffffffa01ffdab>] hci_conn_add_sysfs+0x6b/0=
x100
>> [bluetooth]
>> [ =C2=A0417.556123] =C2=A0[<ffffffffa01fba1c>] hci_event_packet+0xbc/0x2=
5c0
>> [bluetooth]
>> [ =C2=A0417.556132] =C2=A0[<ffffffff80516eb0>] ? sock_def_readable+0x80/=
0xa0
>> [ =C2=A0417.556148] =C2=A0[<ffffffffa01fedfc>] ? hci_send_to_sock+0xfc/0=
x1c0
>> [bluetooth]
>> [ =C2=A0417.556155] =C2=A0[<ffffffff80516eb0>] ? sock_def_readable+0x80/=
0xa0
>> [ =C2=A0417.556165] =C2=A0[<ffffffff805e88c5>] ? _read_unlock+0x75/0x80
>> [ =C2=A0417.556179] =C2=A0[<ffffffffa01fedfc>] ? hci_send_to_sock+0xfc/0=
x1c0
>> [bluetooth]
>> [ =C2=A0417.556195] =C2=A0[<ffffffffa01f8403>] hci_rx_task+0x203/0x2d0
>> [bluetooth]
>> [ =C2=A0417.556205] =C2=A0[<ffffffff80250ab5>] tasklet_action+0xb5/0x160
>> [ =C2=A0417.556213] =C2=A0[<ffffffff8025116c>] __do_softirq+0x9c/0x150
>> [ =C2=A0417.556220] =C2=A0[<ffffffff805e850f>] ? _spin_unlock+0x3f/0x80
>> [ =C2=A0417.556230] =C2=A0[<ffffffff8020cbbc>] call_softirq+0x1c/0x30
>> [ =C2=A0417.556237] =C2=A0[<ffffffff8020f01d>] do_softirq+0x8d/0xe0
>> [ =C2=A0417.556245] =C2=A0[<ffffffff80250df5>] irq_exit+0xc5/0xe0
>> [ =C2=A0417.556252] =C2=A0[<ffffffff8020e71d>] do_IRQ+0x9d/0x120
>> [ =C2=A0417.556260] =C2=A0[<ffffffff8020c3d3>] ret_from_intr+0x0/0xf
>> [ =C2=A0417.556265] =C2=A0<EOI> =C2=A0[<ffffffff80431832>] ?
>> acpi_idle_enter_bm+0x264/0x2a6
>> [ =C2=A0417.556281] =C2=A0[<ffffffff80431828>] ? acpi_idle_enter_bm+0x25=
a/0x2a6
>> [ =C2=A0417.556290] =C2=A0[<ffffffff804f50d5>] ? cpuidle_idle_call+0xc5/=
0x130
>> [ =C2=A0417.556299] =C2=A0[<ffffffff8020a4b4>] ? cpu_idle+0xc4/0x130
>> [ =C2=A0417.556308] =C2=A0[<ffffffff805d2268>] ? rest_init+0x88/0xb0
>> [ =C2=A0417.556318] =C2=A0[<ffffffff807e2fbd>] ? start_kernel+0x3b5/0x41=
2
>> [ =C2=A0417.556326] =C2=A0[<ffffffff807e2281>] ?
>> x86_64_start_reservations+0x91/0xb5
>> [ =C2=A0417.556334] =C2=A0[<ffffffff807e2394>] ? x86_64_start_kernel+0xe=
f/0x11b
>> [ =C2=A0417.557510]
>> [ =C2=A0417.557513] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> [ =C2=A0417.557521] [ INFO: possible recursive locking detected ]
>> [ =C2=A0417.557529] 2.6.30-rc4-wl #40
>> [ =C2=A0417.557538] ---------------------------------------------
>> [ =C2=A0417.557544] bluetooth/2100 is trying to acquire lock:
>> [ =C2=A0417.557550] =C2=A0(bluetooth){+.+...}, at: [<ffffffff80262620>]
>> flush_workqueue+0x0/0xe0
>> [ =C2=A0417.557578]
>> [ =C2=A0417.557579] but task is already holding lock:
>> [ =C2=A0417.557585] =C2=A0(bluetooth){+.+...}, at: [<ffffffff80261841>]
>> worker_thread+0x161/0x320
>> [ =C2=A0417.557607]
>> [ =C2=A0417.557608] other info that might help us debug this:
>> [ =C2=A0417.557615] 2 locks held by bluetooth/2100:
>> [ =C2=A0417.557620] =C2=A0#0: =C2=A0(bluetooth){+.+...}, at: [<ffffffff8=
0261841>]
>> worker_thread+0x161/0x320
>> [ =C2=A0417.557649] =C2=A0#1: =C2=A0(&conn->work_add){+.+...}, at:
>> [<ffffffff80261841>] worker_thread+0x161/0x320
>> [ =C2=A0417.557675]
>> [ =C2=A0417.557676] stack backtrace:
>> [ =C2=A0417.557686] Pid: 2100, comm: bluetooth Tainted: G =C2=A0 =C2=A0 =
=C2=A0 =C2=A0W
>> 2.6.30-rc4-wl #40
>> [ =C2=A0417.557694] Call Trace:
>> [ =C2=A0417.557711] =C2=A0[<ffffffff8027e2f9>] __lock_acquire+0x10a9/0x1=
350
>> [ =C2=A0417.557721] =C2=A0[<ffffffff8027cee5>] ?
>> trace_hardirqs_on_caller+0x195/0x200
>> [ =C2=A0417.557737] =C2=A0[<ffffffff805e79c2>] ?
>> trace_hardirqs_on_thunk+0x3a/0x3f
>> [ =C2=A0417.557750] =C2=A0[<ffffffff80262620>] ? flush_workqueue+0x0/0xe=
0
>> [ =C2=A0417.557761] =C2=A0[<ffffffff8027e640>] lock_acquire+0xa0/0xe0
>> [ =C2=A0417.557770] =C2=A0[<ffffffff80262620>] ? flush_workqueue+0x0/0xe=
0
>> [ =C2=A0417.557790] =C2=A0[<ffffffffa01ffe40>] ? add_conn+0x0/0x70 [blue=
tooth]
>> [ =C2=A0417.557800] =C2=A0[<ffffffff80262687>] flush_workqueue+0x67/0xe0
>> [ =C2=A0417.557811] =C2=A0[<ffffffff80262620>] ? flush_workqueue+0x0/0xe=
0
>> [ =C2=A0417.557824] =C2=A0[<ffffffff80261841>] ? worker_thread+0x161/0x3=
20
>> [ =C2=A0417.557844] =C2=A0[<ffffffffa01ffe6b>] add_conn+0x2b/0x70 [bluet=
ooth]
>> [ =C2=A0417.557855] =C2=A0[<ffffffff80261893>] worker_thread+0x1b3/0x320
>> [ =C2=A0417.557865] =C2=A0[<ffffffff80261841>] ? worker_thread+0x161/0x3=
20
>> [ =C2=A0417.557876] =C2=A0[<ffffffff80267940>] ?
>> autoremove_wake_function+0x0/0x60
>> [ =C2=A0417.557887] =C2=A0[<ffffffff802616e0>] ? worker_thread+0x0/0x320
>> [ =C2=A0417.557899] =C2=A0[<ffffffff80267449>] kthread+0x69/0xc0
>> [ =C2=A0417.557914] =C2=A0[<ffffffff8020caba>] child_rip+0xa/0x20
>> [ =C2=A0417.557924] =C2=A0[<ffffffff8020c480>] ? restore_args+0x0/0x30
>> [ =C2=A0417.557935] =C2=A0[<ffffffff802673e0>] ? kthread+0x0/0xc0
>> [ =C2=A0417.557945] =C2=A0[<ffffffff8020cab0>] ? child_rip+0x0/0x20
>> [ =C2=A0417.557986] ------------[ cut here ]------------
>> [ =C2=A0417.557994] WARNING: at kernel/workqueue.c:371
>> flush_cpu_workqueue+0xc0/0xd0()
>> [ =C2=A0417.558002] Hardware name: MacBookPro2,2
>> [ =C2=A0417.558007] Modules linked in: radeon drm btusb coretemp rfcomm
>> l2cap bluetooth snd_seq snd_seq_device fuse uvcvideo videodev
>> v4l1_compat v4l2_compat_ioctl32 ath9k
>> mac80211 isight_firmware snd_hda_codec_idt snd_hda_intel firewire_ohci
>> snd_hda_codec applesmc ath firewire_core snd_hwdep hwmon rtc snd_pcm
>> led_class i2c_i801 i2c_core
>> crc_itu_t cfg80211 sky2 snd_timer snd_page_alloc appletouch
>> [ =C2=A0417.558206] Pid: 2100, comm: bluetooth Tainted: G =C2=A0 =C2=A0 =
=C2=A0 =C2=A0W
>> 2.6.30-rc4-wl #40
>> [ =C2=A0417.558212] Call Trace:
>> [ =C2=A0417.558226] =C2=A0[<ffffffff8024a258>] warn_slowpath+0xe8/0x150
>> [ =C2=A0417.558236] =C2=A0[<ffffffff8020f638>] ? dump_trace+0x138/0x330
>> [ =C2=A0417.558246] =C2=A0[<ffffffff80210df4>] ? show_trace_log_lvl+0x64=
/0x90
>> [ =C2=A0417.558258] =C2=A0[<ffffffff80262620>] ? flush_workqueue+0x0/0xe=
0
>> [ =C2=A0417.558268] =C2=A0[<ffffffff805e79c2>] ?
>> trace_hardirqs_on_thunk+0x3a/0x3f
>> [ =C2=A0417.558280] =C2=A0[<ffffffff8020c480>] ? restore_args+0x0/0x30
>> [ =C2=A0417.558298] =C2=A0[<ffffffffa01ffe40>] ? add_conn+0x0/0x70 [blue=
tooth]
>> [ =C2=A0417.558309] =C2=A0[<ffffffff80261d70>] flush_cpu_workqueue+0xc0/=
0xd0
>> [ =C2=A0417.558321] =C2=A0[<ffffffff8027e655>] ? lock_acquire+0xb5/0xe0
>> [ =C2=A0417.558332] =C2=A0[<ffffffff802626bc>] flush_workqueue+0x9c/0xe0
>> [ =C2=A0417.558343] =C2=A0[<ffffffff80262620>] ? flush_workqueue+0x0/0xe=
0
>> [ =C2=A0417.558353] =C2=A0[<ffffffff80261841>] ? worker_thread+0x161/0x3=
20
>> [ =C2=A0417.558372] =C2=A0[<ffffffffa01ffe6b>] add_conn+0x2b/0x70 [bluet=
ooth]
>> [ =C2=A0417.558382] =C2=A0[<ffffffff80261893>] worker_thread+0x1b3/0x320
>> [ =C2=A0417.558392] =C2=A0[<ffffffff80261841>] ? worker_thread+0x161/0x3=
20
>> [ =C2=A0417.558403] =C2=A0[<ffffffff80267940>] ?
>> autoremove_wake_function+0x0/0x60
>> [ =C2=A0417.558425] =C2=A0[<ffffffff802616e0>] ? worker_thread+0x0/0x320
>> [ =C2=A0417.558434] =C2=A0[<ffffffff80267449>] kthread+0x69/0xc0
>> [ =C2=A0417.558446] =C2=A0[<ffffffff8020caba>] child_rip+0xa/0x20
>> [ =C2=A0417.558459] =C2=A0[<ffffffff8020c480>] ? restore_args+0x0/0x30
>> [ =C2=A0417.558472] =C2=A0[<ffffffff802673e0>] ? kthread+0x0/0xc0
>> [ =C2=A0417.558484] =C2=A0[<ffffffff8020cab0>] ? child_rip+0x0/0x20
>> [ =C2=A0417.558491] ---[ end trace a9e8ac35e98239d3 ]---
>> [ =C2=A0417.750503] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
>> [ =C2=A0417.751223] BUG: unable to handle kernel NULL pointer dereferenc=
e
>> at 0000000000000038
>> [ =C2=A0417.751236] IP: [<ffffffff8033ddba>] sysfs_addrm_start+0x4a/0x10=
0
>> [ =C2=A0417.751252] PGD 0
>> [ =C2=A0417.751259] Oops: 0000 [#1] PREEMPT SMP
>> [ =C2=A0417.751269] last sysfs file: /sys/module/l2cap/initstate
>> [ =C2=A0417.751275] CPU 0
>> [ =C2=A0417.751281] Modules linked in: hidp radeon drm btusb coretemp
>> rfcomm l2cap bluetooth snd_seq snd_seq_device fuse uvcvideo videodev
>> v4l1_compat v4l2_compat_ioctl32 ath9k
>> mac80211 isight_firmware snd_hda_codec_idt snd_hda_intel firewire_ohci
>> snd_hda_codec applesmc ath firewire_core snd_hwdep hwmon rtc snd_pcm
>> led_class i2c_i801 i2c_core
>> crc_itu_t cfg80211 sky2 snd_timer snd_page_alloc appletouch
>> [ =C2=A0417.751376] Pid: 2092, comm: hcid Tainted: G =C2=A0 =C2=A0 =C2=
=A0 =C2=A0W
>> 2.6.30-rc4-wl #40 MacBookPro2,2
>> [ =C2=A0417.751382] RIP: 0010:[<ffffffff8033ddba>] =C2=A0[<ffffffff8033d=
dba>]
>> sysfs_addrm_start+0x4a/0x100
>> [ =C2=A0417.751392] RSP: 0018:ffff88007d3778f8 =C2=A0EFLAGS: 00010246
>> [ =C2=A0417.751398] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000000001
>> [ =C2=A0417.751404] RDX: 0000000000000000 RSI: ffff88007d377858 RDI:
>> 0000000000000001
>> [ =C2=A0417.751409] RBP: ffff88007d377918 R08: 0000000000000000 R09:
>> 0000000000000000
>> [ =C2=A0417.751415] R10: 0000000000000000 R11: ffff88007ef90f30 R12:
>> ffff88007d377928
>> [ =C2=A0417.751420] R13: 00000000fffffff4 R14: 0000000000000000 R15:
>> ffff88007d3779a0
>> [ =C2=A0417.751427] FS: =C2=A000007fd7be6836f0(0000) GS:ffff880001024000=
(0000)
>> knlGS:0000000000000000
>> [ =C2=A0417.751433] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
>> [ =C2=A0417.751439] CR2: 0000000000000038 CR3: 000000007aeb5000 CR4:
>> 00000000000006e0
>> [ =C2=A0417.751444] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [ =C2=A0417.751450] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
>> 0000000000000400
>> [ =C2=A0417.751457] Process hcid (pid: 2092, threadinfo ffff88007d376000=
,
>> task ffff88007ef90f30)
>> [ =C2=A0417.751462] Stack:
>> [ =C2=A0417.751466] =C2=A0ffff88007cb87898 00000000561d17c1 ffff88007d37=
7928
>> ffff880076fc6f00
>> [ =C2=A0417.751478] =C2=A0ffff88007d377988 ffffffff8033ed57 000000000000=
0000
>> 0000000000000000
>> [ =C2=A0417.751491] =C2=A00000000000000000 0000000000000000 ffff88007ec0=
b0e8
>> 00000000561d17c1
>> [ =C2=A0417.751506] Call Trace:
>> [ =C2=A0417.751511] =C2=A0[<ffffffff8033ed57>] create_dir+0x67/0xe0
>> [ =C2=A0417.751520] =C2=A0[<ffffffff8033ee13>] sysfs_create_dir+0x43/0x8=
0
>> [ =C2=A0417.751529] =C2=A0[<ffffffff803b784c>] ? kobject_add_internal+0x=
cc/0x220
>> [ =C2=A0417.751540] =C2=A0[<ffffffff803beede>] ? vsnprintf+0x35e/0xaf0
>> [ =C2=A0417.751550] =C2=A0[<ffffffff803b7887>] kobject_add_internal+0x10=
7/0x220
>> [ =C2=A0417.751559] =C2=A0[<ffffffff803b7b07>] kobject_add_varg+0x47/0x8=
0
>> [ =C2=A0417.751568] =C2=A0[<ffffffff803b7c6b>] kobject_add+0x7b/0xc0
>> [ =C2=A0417.751577] =C2=A0[<ffffffff803d4287>] ? __spin_lock_init+0x47/0=
x90
>> [ =C2=A0417.751587] =C2=A0[<ffffffff8027cf70>] ? trace_hardirqs_on+0x20/=
0x40
>> [ =C2=A0417.751599] =C2=A0[<ffffffff803b7699>] ? kobject_get+0x29/0x50
>> [ =C2=A0417.751607] =C2=A0[<ffffffff805d1a3b>] ? klist_init+0x4b/0x80
>> [ =C2=A0417.751618] =C2=A0[<ffffffff80466155>] device_add+0x115/0x610
>> [ =C2=A0417.751628] =C2=A0[<ffffffffa01fb20f>] ? hci_get_route+0x5f/0x17=
0 [bluetooth]
>> [ =C2=A0417.751648] =C2=A0[<ffffffff804f8c33>] hid_add_device+0x1a3/0x22=
0
>> [ =C2=A0417.751659] =C2=A0[<ffffffffa02b8e07>] hidp_add_connection+0x677=
/0x6a0 [hidp]
>> [ =C2=A0417.751673] =C2=A0[<ffffffffa02b914b>] hidp_sock_ioctl+0x26b/0x2=
d0 [hidp]
>> [ =C2=A0417.751686] =C2=A0[<ffffffff805e850f>] ? _spin_unlock+0x3f/0x80
>> [ =C2=A0417.751696] =C2=A0[<ffffffff805125fa>] sock_ioctl+0x7a/0x2c0
>> [ =C2=A0417.751707] =C2=A0[<ffffffff80513a5a>] ? sys_sendto+0x11a/0x170
>> [ =C2=A0417.751715] =C2=A0[<ffffffff802e6950>] vfs_ioctl+0x40/0xd0
>> [ =C2=A0417.751726] =C2=A0[<ffffffff802e6a82>] do_vfs_ioctl+0xa2/0x5a0
>> [ =C2=A0417.751736] =C2=A0[<ffffffff802e6fd9>] sys_ioctl+0x59/0xb0
>> [ =C2=A0417.751745] =C2=A0[<ffffffff8020ba2b>] system_call_fastpath+0x16=
/0x1b
>> [ =C2=A0417.751757] Code: c0 48 c7 47 08 00 00 00 00 48 c7 47 10 00 00 0=
0
>> 00 48 c7 47 18 00 00 00 00 49 89 34 24 48 c7 c7 40 7c 77 80 31 f6 e8
>> 76 86 2a 00 <48> 8b 73 38 48 89 d9
>> 48 8b 3d20 d6 c2 00 48 c7 c2 70 d6 33 80
>> [ =C2=A0417.751889] RIP =C2=A0[<ffffffff8033ddba>] sysfs_addrm_start+0x4=
a/0x100
>> [ =C2=A0417.751899] =C2=A0RSP <ffff88007d3778f8>
>> [ =C2=A0417.751903] CR2: 0000000000000038
>> [ =C2=A0417.751910] ---[ end trace a9e8ac35e98239d4 ]---
>>
>> Bluetooth doesn't work and the system locks up incrementally, it is
>> not possible to shut it down cleanly.
>> The "sleeping function called from invalid context" BUG was also
>> present in -rc2 and -rc3, but there weren't NULL pointers dereferences
>> and the kernel kept working (bluetooth included).
>> 2.6.29 was working almost perfectly.
>
> can you try the bluetooth-testing.git, because that should include a fix
> for exactly this.
>

Hi Marcel,

the NULL pointer dereference and the warnings are indeed fixed in
bluetooth-testing, and the mouse works. Thanks!
However the following issue remains:

[  110.012125] BUG: sleeping function called from invalid context at
mm/slub.c:1595
[  110.012135] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name:
swapper
[  110.012141] 2 locks held by swapper/0:
[  110.012145]  #0:  (hci_task_lock){++.-.+}, at: [<ffffffffa01f822f>]
hci_rx_task+0x2f/0x2d0 [bluetooth]
[  110.012173]  #1:  (&hdev->lock){+.-.+.}, at: [<ffffffffa01fb9e2>]
hci_event_packet+0x72/0x25c0 [bluetooth]
[  110.012198] Pid: 0, comm: swapper Tainted: G        W
2.6.30-rc4-g953cdaa #1
[  110.012203] Call Trace:
[  110.012207]  <IRQ>  [<ffffffff8023eabd>] __might_sleep+0x14d/0x170
[  110.012228]  [<ffffffff802cfbe1>] __kmalloc+0x111/0x170
[  110.012239]  [<ffffffff803c2094>] kvasprintf+0x64/0xb0
[  110.012248]  [<ffffffff803b7a5b>] kobject_set_name_vargs+0x3b/0xa0
[  110.012257]  [<ffffffff80465326>] dev_set_name+0x76/0xa0
[  110.012273]  [<ffffffffa01fb9e2>] ? hci_event_packet+0x72/0x25c0
[bluetooth]
[  110.012289]  [<ffffffffa01ffc1d>] hci_conn_add_sysfs+0x3d/0x70
[bluetooth]
[  110.012303]  [<ffffffffa01fba2c>] hci_event_packet+0xbc/0x25c0
[bluetooth]
[  110.012312]  [<ffffffff80516eb0>] ? sock_def_readable+0x80/0xa0
[  110.012328]  [<ffffffffa01fee0c>] ? hci_send_to_sock+0xfc/0x1c0
[bluetooth]
[  110.012343]  [<ffffffff80516eb0>] ? sock_def_readable+0x80/0xa0
[  110.012347]  [<ffffffff805e88c5>] ? _read_unlock+0x75/0x80
[  110.012354]  [<ffffffffa01fee0c>] ? hci_send_to_sock+0xfc/0x1c0
[bluetooth]
[  110.012360]  [<ffffffffa01f8403>] hci_rx_task+0x203/0x2d0
[bluetooth]
[  110.012365]  [<ffffffff80250ab5>] tasklet_action+0xb5/0x160
[  110.012369]  [<ffffffff8025116c>] __do_softirq+0x9c/0x150
[  110.012372]  [<ffffffff805e850f>] ? _spin_unlock+0x3f/0x80
[  110.012376]  [<ffffffff8020cbbc>] call_softirq+0x1c/0x30
[  110.012380]  [<ffffffff8020f01d>] do_softirq+0x8d/0xe0
[  110.012383]  [<ffffffff80250df5>] irq_exit+0xc5/0xe0
[  110.012386]  [<ffffffff8020e71d>] do_IRQ+0x9d/0x120
[  110.012389]  [<ffffffff8020c3d3>] ret_from_intr+0x0/0xf
[  110.012391]  <EOI>  [<ffffffff80431832>] ? acpi_idle_enter_bm+0x264/0x2a=
6
[  110.012399]  [<ffffffff80431828>] ? acpi_idle_enter_bm+0x25a/0x2a6
[  110.012403]  [<ffffffff804f50d5>] ? cpuidle_idle_call+0xc5/0x130
[  110.012407]  [<ffffffff8020a4b4>] ? cpu_idle+0xc4/0x130
[  110.012411]  [<ffffffff805d2268>] ? rest_init+0x88/0xb0
[  110.012416]  [<ffffffff807e2fbd>] ? start_kernel+0x3b5/0x412
[  110.012420]  [<ffffffff807e2281>] ? x86_64_start_reservations+0x91/0xb5
[  110.012424]  [<ffffffff807e2394>] ? x86_64_start_kernel+0xef/0x11b
[  110.320835] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[  110.349150] input: Mighty Mouse as
/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/bluetooth/hci0/hci0:46/in=
put10
[  110.351343] apple 0005:05AC:030C.0004: input: BLUETOOTH HID v2.00
Mouse [Mighty Mouse] on 00:17:F2:AB:8D:45

Regards,
Davide
