Return-Path: <cyrus@holtmann.org>
Subject: Re: [regression] connecting a bluetooth mouse triggers multiple
 BUGs and  warnings
From: Marcel Holtmann <marcel@holtmann.org>
To: Davide Pesavento <davidepesa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2da21fe50905031022o73481d88tdaecb88491cfcfd2@mail.gmail.com>
References: <2da21fe50905031022o73481d88tdaecb88491cfcfd2@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 03 May 2009 13:15:25 -0700
Message-Id: <1241381725.2785.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Davide,

> with 2.6.30-rc4, when I connect my bluetooth mouse to the laptop, the
> kernel breaks with a lot of noise.
> (the kernel is already tainted because of a reiserfs warning happened earlier)
> 
> [  417.555941] BUG: sleeping function called from invalid context at
> mm/slub.c:1595
> [  417.555951] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name:
> swapper
> [  417.555958] 2 locks held by swapper/0:
> [  417.555962]  #0:  (hci_task_lock){++.-.+}, at: [<ffffffffa01f822f>]
> hci_rx_task+0x2f/0x2d0 [bluetooth]
> [  417.555991]  #1:  (&hdev->lock){+.-.+.}, at: [<ffffffffa01fb9d2>]
> hci_event_packet+0x72/0x25c0 [bluetooth]
> [  417.556017] Pid: 0, comm: swapper Tainted: G        W
> 2.6.30-rc4-wl #40
> [  417.556022] Call Trace:
> [  417.556026]  <IRQ>  [<ffffffff8023eabd>] __might_sleep+0x14d/0x170
> [  417.556047]  [<ffffffff802cfbe1>] __kmalloc+0x111/0x170
> [  417.556058]  [<ffffffff803c2094>] kvasprintf+0x64/0xb0
> [  417.556067]  [<ffffffff803b7a5b>] kobject_set_name_vargs+0x3b/0xa0
> [  417.556076]  [<ffffffff80465326>] dev_set_name+0x76/0xa0
> [  417.556092]  [<ffffffffa01fb9d2>] ? hci_event_packet+0x72/0x25c0
> [bluetooth]
> [  417.556108]  [<ffffffffa01ffdab>] hci_conn_add_sysfs+0x6b/0x100
> [bluetooth]
> [  417.556123]  [<ffffffffa01fba1c>] hci_event_packet+0xbc/0x25c0
> [bluetooth]
> [  417.556132]  [<ffffffff80516eb0>] ? sock_def_readable+0x80/0xa0
> [  417.556148]  [<ffffffffa01fedfc>] ? hci_send_to_sock+0xfc/0x1c0
> [bluetooth]
> [  417.556155]  [<ffffffff80516eb0>] ? sock_def_readable+0x80/0xa0
> [  417.556165]  [<ffffffff805e88c5>] ? _read_unlock+0x75/0x80
> [  417.556179]  [<ffffffffa01fedfc>] ? hci_send_to_sock+0xfc/0x1c0
> [bluetooth]
> [  417.556195]  [<ffffffffa01f8403>] hci_rx_task+0x203/0x2d0
> [bluetooth]
> [  417.556205]  [<ffffffff80250ab5>] tasklet_action+0xb5/0x160
> [  417.556213]  [<ffffffff8025116c>] __do_softirq+0x9c/0x150
> [  417.556220]  [<ffffffff805e850f>] ? _spin_unlock+0x3f/0x80
> [  417.556230]  [<ffffffff8020cbbc>] call_softirq+0x1c/0x30
> [  417.556237]  [<ffffffff8020f01d>] do_softirq+0x8d/0xe0
> [  417.556245]  [<ffffffff80250df5>] irq_exit+0xc5/0xe0
> [  417.556252]  [<ffffffff8020e71d>] do_IRQ+0x9d/0x120
> [  417.556260]  [<ffffffff8020c3d3>] ret_from_intr+0x0/0xf
> [  417.556265]  <EOI>  [<ffffffff80431832>] ?
> acpi_idle_enter_bm+0x264/0x2a6
> [  417.556281]  [<ffffffff80431828>] ? acpi_idle_enter_bm+0x25a/0x2a6
> [  417.556290]  [<ffffffff804f50d5>] ? cpuidle_idle_call+0xc5/0x130
> [  417.556299]  [<ffffffff8020a4b4>] ? cpu_idle+0xc4/0x130
> [  417.556308]  [<ffffffff805d2268>] ? rest_init+0x88/0xb0
> [  417.556318]  [<ffffffff807e2fbd>] ? start_kernel+0x3b5/0x412
> [  417.556326]  [<ffffffff807e2281>] ?
> x86_64_start_reservations+0x91/0xb5
> [  417.556334]  [<ffffffff807e2394>] ? x86_64_start_kernel+0xef/0x11b
> [  417.557510]
> [  417.557513] =============================================
> [  417.557521] [ INFO: possible recursive locking detected ]
> [  417.557529] 2.6.30-rc4-wl #40
> [  417.557538] ---------------------------------------------
> [  417.557544] bluetooth/2100 is trying to acquire lock:
> [  417.557550]  (bluetooth){+.+...}, at: [<ffffffff80262620>]
> flush_workqueue+0x0/0xe0
> [  417.557578]
> [  417.557579] but task is already holding lock:
> [  417.557585]  (bluetooth){+.+...}, at: [<ffffffff80261841>]
> worker_thread+0x161/0x320
> [  417.557607]
> [  417.557608] other info that might help us debug this:
> [  417.557615] 2 locks held by bluetooth/2100:
> [  417.557620]  #0:  (bluetooth){+.+...}, at: [<ffffffff80261841>]
> worker_thread+0x161/0x320
> [  417.557649]  #1:  (&conn->work_add){+.+...}, at:
> [<ffffffff80261841>] worker_thread+0x161/0x320
> [  417.557675]
> [  417.557676] stack backtrace:
> [  417.557686] Pid: 2100, comm: bluetooth Tainted: G        W
> 2.6.30-rc4-wl #40
> [  417.557694] Call Trace:
> [  417.557711]  [<ffffffff8027e2f9>] __lock_acquire+0x10a9/0x1350
> [  417.557721]  [<ffffffff8027cee5>] ?
> trace_hardirqs_on_caller+0x195/0x200
> [  417.557737]  [<ffffffff805e79c2>] ?
> trace_hardirqs_on_thunk+0x3a/0x3f
> [  417.557750]  [<ffffffff80262620>] ? flush_workqueue+0x0/0xe0
> [  417.557761]  [<ffffffff8027e640>] lock_acquire+0xa0/0xe0
> [  417.557770]  [<ffffffff80262620>] ? flush_workqueue+0x0/0xe0
> [  417.557790]  [<ffffffffa01ffe40>] ? add_conn+0x0/0x70 [bluetooth]
> [  417.557800]  [<ffffffff80262687>] flush_workqueue+0x67/0xe0
> [  417.557811]  [<ffffffff80262620>] ? flush_workqueue+0x0/0xe0
> [  417.557824]  [<ffffffff80261841>] ? worker_thread+0x161/0x320
> [  417.557844]  [<ffffffffa01ffe6b>] add_conn+0x2b/0x70 [bluetooth]
> [  417.557855]  [<ffffffff80261893>] worker_thread+0x1b3/0x320
> [  417.557865]  [<ffffffff80261841>] ? worker_thread+0x161/0x320
> [  417.557876]  [<ffffffff80267940>] ?
> autoremove_wake_function+0x0/0x60
> [  417.557887]  [<ffffffff802616e0>] ? worker_thread+0x0/0x320
> [  417.557899]  [<ffffffff80267449>] kthread+0x69/0xc0
> [  417.557914]  [<ffffffff8020caba>] child_rip+0xa/0x20
> [  417.557924]  [<ffffffff8020c480>] ? restore_args+0x0/0x30
> [  417.557935]  [<ffffffff802673e0>] ? kthread+0x0/0xc0
> [  417.557945]  [<ffffffff8020cab0>] ? child_rip+0x0/0x20
> [  417.557986] ------------[ cut here ]------------
> [  417.557994] WARNING: at kernel/workqueue.c:371
> flush_cpu_workqueue+0xc0/0xd0()
> [  417.558002] Hardware name: MacBookPro2,2
> [  417.558007] Modules linked in: radeon drm btusb coretemp rfcomm
> l2cap bluetooth snd_seq snd_seq_device fuse uvcvideo videodev
> v4l1_compat v4l2_compat_ioctl32 ath9k
> mac80211 isight_firmware snd_hda_codec_idt snd_hda_intel firewire_ohci
> snd_hda_codec applesmc ath firewire_core snd_hwdep hwmon rtc snd_pcm
> led_class i2c_i801 i2c_core
> crc_itu_t cfg80211 sky2 snd_timer snd_page_alloc appletouch
> [  417.558206] Pid: 2100, comm: bluetooth Tainted: G        W
> 2.6.30-rc4-wl #40
> [  417.558212] Call Trace:
> [  417.558226]  [<ffffffff8024a258>] warn_slowpath+0xe8/0x150
> [  417.558236]  [<ffffffff8020f638>] ? dump_trace+0x138/0x330
> [  417.558246]  [<ffffffff80210df4>] ? show_trace_log_lvl+0x64/0x90
> [  417.558258]  [<ffffffff80262620>] ? flush_workqueue+0x0/0xe0
> [  417.558268]  [<ffffffff805e79c2>] ?
> trace_hardirqs_on_thunk+0x3a/0x3f
> [  417.558280]  [<ffffffff8020c480>] ? restore_args+0x0/0x30
> [  417.558298]  [<ffffffffa01ffe40>] ? add_conn+0x0/0x70 [bluetooth]
> [  417.558309]  [<ffffffff80261d70>] flush_cpu_workqueue+0xc0/0xd0
> [  417.558321]  [<ffffffff8027e655>] ? lock_acquire+0xb5/0xe0
> [  417.558332]  [<ffffffff802626bc>] flush_workqueue+0x9c/0xe0
> [  417.558343]  [<ffffffff80262620>] ? flush_workqueue+0x0/0xe0
> [  417.558353]  [<ffffffff80261841>] ? worker_thread+0x161/0x320
> [  417.558372]  [<ffffffffa01ffe6b>] add_conn+0x2b/0x70 [bluetooth]
> [  417.558382]  [<ffffffff80261893>] worker_thread+0x1b3/0x320
> [  417.558392]  [<ffffffff80261841>] ? worker_thread+0x161/0x320
> [  417.558403]  [<ffffffff80267940>] ?
> autoremove_wake_function+0x0/0x60
> [  417.558425]  [<ffffffff802616e0>] ? worker_thread+0x0/0x320
> [  417.558434]  [<ffffffff80267449>] kthread+0x69/0xc0
> [  417.558446]  [<ffffffff8020caba>] child_rip+0xa/0x20
> [  417.558459]  [<ffffffff8020c480>] ? restore_args+0x0/0x30
> [  417.558472]  [<ffffffff802673e0>] ? kthread+0x0/0xc0
> [  417.558484]  [<ffffffff8020cab0>] ? child_rip+0x0/0x20
> [  417.558491] ---[ end trace a9e8ac35e98239d3 ]---
> [  417.750503] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [  417.751223] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000038
> [  417.751236] IP: [<ffffffff8033ddba>] sysfs_addrm_start+0x4a/0x100
> [  417.751252] PGD 0
> [  417.751259] Oops: 0000 [#1] PREEMPT SMP
> [  417.751269] last sysfs file: /sys/module/l2cap/initstate
> [  417.751275] CPU 0
> [  417.751281] Modules linked in: hidp radeon drm btusb coretemp
> rfcomm l2cap bluetooth snd_seq snd_seq_device fuse uvcvideo videodev
> v4l1_compat v4l2_compat_ioctl32 ath9k
> mac80211 isight_firmware snd_hda_codec_idt snd_hda_intel firewire_ohci
> snd_hda_codec applesmc ath firewire_core snd_hwdep hwmon rtc snd_pcm
> led_class i2c_i801 i2c_core
> crc_itu_t cfg80211 sky2 snd_timer snd_page_alloc appletouch
> [  417.751376] Pid: 2092, comm: hcid Tainted: G        W
> 2.6.30-rc4-wl #40 MacBookPro2,2
> [  417.751382] RIP: 0010:[<ffffffff8033ddba>]  [<ffffffff8033ddba>]
> sysfs_addrm_start+0x4a/0x100
> [  417.751392] RSP: 0018:ffff88007d3778f8  EFLAGS: 00010246
> [  417.751398] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000001
> [  417.751404] RDX: 0000000000000000 RSI: ffff88007d377858 RDI:
> 0000000000000001
> [  417.751409] RBP: ffff88007d377918 R08: 0000000000000000 R09:
> 0000000000000000
> [  417.751415] R10: 0000000000000000 R11: ffff88007ef90f30 R12:
> ffff88007d377928
> [  417.751420] R13: 00000000fffffff4 R14: 0000000000000000 R15:
> ffff88007d3779a0
> [  417.751427] FS:  00007fd7be6836f0(0000) GS:ffff880001024000(0000)
> knlGS:0000000000000000
> [  417.751433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  417.751439] CR2: 0000000000000038 CR3: 000000007aeb5000 CR4:
> 00000000000006e0
> [  417.751444] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  417.751450] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [  417.751457] Process hcid (pid: 2092, threadinfo ffff88007d376000,
> task ffff88007ef90f30)
> [  417.751462] Stack:
> [  417.751466]  ffff88007cb87898 00000000561d17c1 ffff88007d377928
> ffff880076fc6f00
> [  417.751478]  ffff88007d377988 ffffffff8033ed57 0000000000000000
> 0000000000000000
> [  417.751491]  0000000000000000 0000000000000000 ffff88007ec0b0e8
> 00000000561d17c1
> [  417.751506] Call Trace:
> [  417.751511]  [<ffffffff8033ed57>] create_dir+0x67/0xe0
> [  417.751520]  [<ffffffff8033ee13>] sysfs_create_dir+0x43/0x80
> [  417.751529]  [<ffffffff803b784c>] ? kobject_add_internal+0xcc/0x220
> [  417.751540]  [<ffffffff803beede>] ? vsnprintf+0x35e/0xaf0
> [  417.751550]  [<ffffffff803b7887>] kobject_add_internal+0x107/0x220
> [  417.751559]  [<ffffffff803b7b07>] kobject_add_varg+0x47/0x80
> [  417.751568]  [<ffffffff803b7c6b>] kobject_add+0x7b/0xc0
> [  417.751577]  [<ffffffff803d4287>] ? __spin_lock_init+0x47/0x90
> [  417.751587]  [<ffffffff8027cf70>] ? trace_hardirqs_on+0x20/0x40
> [  417.751599]  [<ffffffff803b7699>] ? kobject_get+0x29/0x50
> [  417.751607]  [<ffffffff805d1a3b>] ? klist_init+0x4b/0x80
> [  417.751618]  [<ffffffff80466155>] device_add+0x115/0x610
> [  417.751628]  [<ffffffffa01fb20f>] ? hci_get_route+0x5f/0x170 [bluetooth]
> [  417.751648]  [<ffffffff804f8c33>] hid_add_device+0x1a3/0x220
> [  417.751659]  [<ffffffffa02b8e07>] hidp_add_connection+0x677/0x6a0 [hidp]
> [  417.751673]  [<ffffffffa02b914b>] hidp_sock_ioctl+0x26b/0x2d0 [hidp]
> [  417.751686]  [<ffffffff805e850f>] ? _spin_unlock+0x3f/0x80
> [  417.751696]  [<ffffffff805125fa>] sock_ioctl+0x7a/0x2c0
> [  417.751707]  [<ffffffff80513a5a>] ? sys_sendto+0x11a/0x170
> [  417.751715]  [<ffffffff802e6950>] vfs_ioctl+0x40/0xd0
> [  417.751726]  [<ffffffff802e6a82>] do_vfs_ioctl+0xa2/0x5a0
> [  417.751736]  [<ffffffff802e6fd9>] sys_ioctl+0x59/0xb0
> [  417.751745]  [<ffffffff8020ba2b>] system_call_fastpath+0x16/0x1b
> [  417.751757] Code: c0 48 c7 47 08 00 00 00 00 48 c7 47 10 00 00 00
> 00 48 c7 47 18 00 00 00 00 49 89 34 24 48 c7 c7 40 7c 77 80 31 f6 e8
> 76 86 2a 00 <48> 8b 73 38 48 89 d9
> 48 8b 3d20 d6 c2 00 48 c7 c2 70 d6 33 80
> [  417.751889] RIP  [<ffffffff8033ddba>] sysfs_addrm_start+0x4a/0x100
> [  417.751899]  RSP <ffff88007d3778f8>
> [  417.751903] CR2: 0000000000000038
> [  417.751910] ---[ end trace a9e8ac35e98239d4 ]---
> 
> Bluetooth doesn't work and the system locks up incrementally, it is
> not possible to shut it down cleanly.
> The "sleeping function called from invalid context" BUG was also
> present in -rc2 and -rc3, but there weren't NULL pointers dereferences
> and the kernel kept working (bluetooth included).
> 2.6.29 was working almost perfectly.

can you try the bluetooth-testing.git, because that should include a fix
for exactly this.

Regards

Marcel


