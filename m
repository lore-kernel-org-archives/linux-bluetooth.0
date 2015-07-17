Return-Path: <cyrus@holtmann.org>
Message-ID: <dcf4c0f809904c54f453fe781e30adfe.squirrel@mungewell.org>
In-Reply-To: <a48f30f621c508955ba989117690fe73.squirrel@mungewell.org>
References: <a48f30f621c508955ba989117690fe73.squirrel@mungewell.org>
Date: Fri, 17 Jul 2015 00:00:28 -0400
Subject: Kernel Oops: btusb:  4.2rc1 System lockup with BT dongle insert -
 log attached
From: simon@mungewell.org
To: linux-bluetooth@vger.kernel.org
Cc: linux@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> Hi,
> Noticed that 4.2rc1 is locking up when I insert my USB BT dongle, this did
> not occur on 4.1 and older kernels. I've seen this on both 64 and 32 bit
> kernels on different machines (all on Xubuntu 15.04, ie with older Bluez
> if that makes a difference).
>
> Dongle is:
> http://www.memoryexpress.com/Products/MX43823

Managed to get a serial terminal hooked up which gave the following log,
Simon

--

[  112.931888] BUG: unable to handle kernel NULL pointer dereference at
0000000000000080
[  112.934953] IP: [<ffffffff814e8433>] firmware_uevent+0x23/0x80
[  112.934953] PGD 0
[  112.934953] Oops: 0000 [#1] SMP
[  112.934953] Modules linked in: btusb btrtl btbcm btintel bluetooth
cfg80211 nvidia(OE) snd_emu10k1_synth snd_emux_synth snd_seq_midi_emul
snd_seq_virmidi snd_emu10k1 snd_util_mem snd_hwdep snd_ac97_codec ac97_bus
snd_pcm snd_seq_midi coretemp snd_seq_midi_event gpio_ich kvm_intel
snd_rawmidi snd_seq kvm snd_seq_device snd_timer hostap_pci snd hostap
soundcore dcdbas lib80211 drm dell_smm_hwmon emu10k1_gp lpc_ich serio_raw
gameport i5000_edac edac_core i5k_amb shpchp mac_hid parport_pc ppdev lp
parport autofs4 hid_generic usbhid hid tg3 firewire_ohci ahci ptp libahci
firewire_core pata_acpi pps_core crc_itu_t
[  112.934953] CPU: 1 PID: 1398 Comm: kworker/u17:0 Tainted: G          
OE   4.2.0-rc1+ #5
[  112.934953] Hardware name: Dell Inc.                 Precision
WorkStation 490    /0GU083, BIOS A07 12/13/2007
[  112.934953] Workqueue: hci0 hci_power_on [bluetooth]
[  112.934953] task: ffff880133192d00 ti: ffff8800a7e8c000 task.ti:
ffff8800a7e8c000
[  112.934953] RIP: 0010:[<ffffffff814e8433>]  [<ffffffff814e8433>]
firmware_uevent+0x23/0x80
[  112.934953] RSP: 0018:ffff8800a7e8fa98  EFLAGS: 00010282
[  112.934953] RAX: 0000000000000000 RBX: ffff8800a7ee9000 RCX:
0000000000000075
[  112.934953] RDX: 0000000000000000 RSI: ffffffff81ae2d96 RDI:
ffff8800a7ee9000
[  112.934953] RBP: ffff8800a7e8faa8 R08: 000000000000ffff R09:
000000000000ffff
[  112.934953] R10: ffff8800aade2c00 R11: 0000000000000000 R12:
ffff8800ba919408
[  112.934953] R13: ffff8800a7ee9000 R14: ffff8800ba919408 R15:
ffff88013a508000
[  112.934953] FS:  0000000000000000(0000) GS:ffff88013fc40000(0000)
knlGS:0000000000000000
[  112.934953] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  112.934953] CR2: 0000000000000080 CR3: 000000003673c000 CR4:
00000000000007e0
[  112.934953] Stack:
[  112.934953]  ffff8800ba919418 0000000000000000 ffff8800a7e8faf8
ffffffff814d47c6
[  112.934953]  ffff8800a7e8faf8 ffffffff8138d848 ffffffff81af29e6
000000000000000e
[  112.934953]  0000000000000001 ffffffff8186a490 ffff8800a7ee9000
ffff8800ba919418
[  112.934953] Call Trace:
[  112.934953]  [<ffffffff814d47c6>] dev_uevent+0xb6/0x2b0
[  112.934953]  [<ffffffff8138d848>] ? kobject_get_path+0x98/0xf0
[  112.934953]  [<ffffffff8138eb1a>] kobject_uevent_env+0x2ea/0x660
[  112.934953]  [<ffffffff814e2157>] ? __pm_runtime_disable+0x27/0x140
[  112.934953]  [<ffffffff8138ee9b>] kobject_uevent+0xb/0x10
[  112.934953]  [<ffffffff814d2ccf>] device_del+0x18f/0x270
[  112.934953]  [<ffffffff8109b340>] ? wake_up_q+0x70/0x70
[  112.934953]  [<ffffffff814e97da>] _request_firmware+0x5aa/0xaf0
[  112.934953]  [<ffffffff814e9d55>] request_firmware+0x35/0x50
[  112.934953]  [<ffffffffc00fb881>] btbcm_setup_patchram+0x191/0x910 [btbcm]
[  112.934953]  [<ffffffff814e0994>] ? rpm_idle+0xc4/0x200
[  112.934953]  [<ffffffffc0e28488>] hci_dev_do_open+0xd8/0x500 [bluetooth]
[  112.934953]  [<ffffffffc0e29da0>] hci_power_on+0x40/0x1d0 [bluetooth]
[  112.934953]  [<ffffffff810d9628>] ? lock_timer_base.isra.34+0x58/0x80
[  112.934953]  [<ffffffff8108a6f7>] process_one_work+0x157/0x3e0
[  112.934953]  [<ffffffff8108b0de>] worker_thread+0x4e/0x470
[  112.934953]  [<ffffffff8108b090>] ? rescuer_thread+0x300/0x300
[  112.934953]  [<ffffffff81090569>] kthread+0xc9/0xe0
[  112.934953]  [<ffffffff810904a0>] ? kthread_create_on_node+0x180/0x180
[  112.934953]  [<ffffffff8178995f>] ret_from_fork+0x3f/0x70
[  112.934953]  [<ffffffff810904a0>] ? kthread_create_on_node+0x180/0x180
[  112.934953] Code: 0f 1f 84 00 00 00 00 00 66 66 66 66 90 55 48 89 e5 41
54 53 48 8b 87 c0 02 00 00 48 89 f3 49 89 fc 48 c7 c6 96 2d ae 81 48 89 df
<48> 8b 90 80 00 00 00 31 c0 e8 4f 62 ea ff 85 c0 75 39 8b 15 dd
[  112.934953] RIP  [<ffffffff814e8433>] firmware_uevent+0x23/0x80
[  112.934953]  RSP <ffff8800a7e8fa98>
[  112.934953] CR2: 0000000000000080
[  112.934953] ---[ end trace e0f226cc4d13a2bb ]---
[  117.232465] BUG: unable to handle kernel paging request at
ffffffffffffffd8
[  117.236007] IP: [<ffffffff81090b30>] kthread_data+0x10/0x20
[  117.236007] PGD 1c10067 PUD 1c12067 PMD 0
[  117.236007] Oops: 0000 [#2] SMP
[  117.236007] Modules linked in: btusb btrtl btbcm btintel bluetooth
cfg80211 nvidia(OE) snd_emu10k1_synth snd_emux_synth snd_seq_midi_emul
snd_seq_virmidi snd_emu10k1 snd_util_mem snd_hwdep snd_ac97_codec ac97_bus
snd_pcm snd_seq_midi coretemp snd_seq_midi_event gpio_ich kvm_intel
snd_rawmidi snd_seq kvm snd_seq_device snd_timer hostap_pci snd hostap
soundcore dcdbas lib80211 drm dell_smm_hwmon emu10k1_gp lpc_ich serio_raw
gameport i5000_edac edac_core i5k_amb shpchp mac_hid parport_pc ppdev lp
parport autofs4 hid_generic usbhid hid tg3 firewire_ohci ahci ptp libahci
firewire_core pata_acpi pps_core crc_itu_t
[  117.236007] CPU: 1 PID: 1398 Comm: kworker/u17:0 Tainted: G      D   
OE   4.2.0-rc1+ #5
[  117.236007] Hardware name: Dell Inc.                 Precision
WorkStation 490    /0GU083, BIOS A07 12/13/2007
[  117.236007] task: ffff880133192d00 ti: ffff8800a7e8c000 task.ti:
ffff8800a7e8c000
[  117.236007] RIP: 0010:[<ffffffff81090b30>]  [<ffffffff81090b30>]
kthread_data+0x10/0x20
[  117.236007] RSP: 0018:ffff8800a7e8f728  EFLAGS: 00010092
[  117.236007] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
000000000000000f
[  117.236007] RDX: 000000000000000f RSI: 0000000000000001 RDI:
ffff880133192d00
[  117.236007] RBP: ffff8800a7e8f728 R08: 0000000000000000 R09:
0000000000000315
[  117.236007] R10: 0000000000002aed R11: ffffea0002ab9100 R12:
00000000000168c0
[  117.236007] R13: ffff88013fc568c0 R14: ffff880133192d00 R15:
0000000000000001
[  117.236007] FS:  0000000000000000(0000) GS:ffff88013fc40000(0000)
knlGS:0000000000000000
[  117.236007] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  117.236007] CR2: 0000000000000028 CR3: 000000013a19a000 CR4:
00000000000007e0
[  117.236007] Stack:
[  117.236007]  ffff8800a7e8f748 ffffffff8108b585 ffff8800a7e8f748
ffff88013fc568c0
[  117.236007]  ffff8800a7e8f798 ffffffff817856be ffff880000000000
ffff880133192d00
[  117.236007]  ffff8800a7e8f798 ffff8800a7e90000 ffff880133193930
ffff8800a7e8f368
[  117.236007] Call Trace:
[  117.236007]  [<ffffffff8108b585>] wq_worker_sleeping+0x15/0xa0
[  117.236007]  [<ffffffff817856be>] __schedule+0x72e/0x920
[  117.236007]  [<ffffffff817858e7>] schedule+0x37/0x80
[  117.236007]  [<ffffffff810763b3>] do_exit+0x723/0xa40
[  117.236007]  [<ffffffff81017495>] oops_end+0xa5/0xe0
[  117.236007]  [<ffffffff8106119d>] no_context+0x10d/0x380
[  117.236007]  [<ffffffff8109a78d>] ?
ttwu_do_activate.constprop.83+0x5d/0x70
[  117.236007]  [<ffffffff8106148b>] __bad_area_nosemaphore+0x7b/0x1f0
[  117.236007]  [<ffffffff81061613>] bad_area_nosemaphore+0x13/0x20
[  117.236007]  [<ffffffff810618d3>] __do_page_fault+0x93/0x410
[  117.236007]  [<ffffffff810a6670>] ? dequeue_entity+0x150/0x720
[  117.236007]  [<ffffffff81061c7f>] do_page_fault+0x2f/0x80
[  117.236007]  [<ffffffff8178b488>] page_fault+0x28/0x30
[  117.236007]  [<ffffffff814e8433>] ? firmware_uevent+0x23/0x80
[  117.236007]  [<ffffffff8138e6f9>] ? add_uevent_var+0x69/0x100
[  117.236007]  [<ffffffff814d47c6>] dev_uevent+0xb6/0x2b0
[  117.236007]  [<ffffffff8138d848>] ? kobject_get_path+0x98/0xf0
[  117.236007]  [<ffffffff8138eb1a>] kobject_uevent_env+0x2ea/0x660
[  117.236007]  [<ffffffff814e2157>] ? __pm_runtime_disable+0x27/0x140
[  117.236007]  [<ffffffff8138ee9b>] kobject_uevent+0xb/0x10
[  117.236007]  [<ffffffff814d2ccf>] device_del+0x18f/0x270
[  117.236007]  [<ffffffff8109b340>] ? wake_up_q+0x70/0x70
[  117.236007]  [<ffffffff814e97da>] _request_firmware+0x5aa/0xaf0
[  117.236007]  [<ffffffff814e9d55>] request_firmware+0x35/0x50
[  117.236007]  [<ffffffffc00fb881>] btbcm_setup_patchram+0x191/0x910 [btbcm]
[  117.236007]  [<ffffffff814e0994>] ? rpm_idle+0xc4/0x200
[  117.236007]  [<ffffffffc0e28488>] hci_dev_do_open+0xd8/0x500 [bluetooth]
[  117.236007]  [<ffffffffc0e29da0>] hci_power_on+0x40/0x1d0 [bluetooth]
[  117.236007]  [<ffffffff810d9628>] ? lock_timer_base.isra.34+0x58/0x80
[  117.236007]  [<ffffffff8108a6f7>] process_one_work+0x157/0x3e0
[  117.236007]  [<ffffffff8108b0de>] worker_thread+0x4e/0x470
[  117.236007]  [<ffffffff8108b090>] ? rescuer_thread+0x300/0x300
[  117.236007]  [<ffffffff81090569>] kthread+0xc9/0xe0
[  117.236007]  [<ffffffff810904a0>] ? kthread_create_on_node+0x180/0x180
[  117.236007]  [<ffffffff8178995f>] ret_from_fork+0x3f/0x70
[  117.236007]  [<ffffffff810904a0>] ? kthread_create_on_node+0x180/0x180
[  117.236007] Code: 00 48 89 e5 5d 48 8b 40 c8 48 c1 e8 02 83 e0 01 c3 66
2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 48 8b 87 08 05 00 00 55 48 89 e5
<48> 8b 40 d8 5d c3 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90
[  117.236007] RIP  [<ffffffff81090b30>] kthread_data+0x10/0x20
[  117.236007]  RSP <ffff8800a7e8f728>
[  117.236007] CR2: ffffffffffffffd8
[  117.236007] ---[ end trace e0f226cc4d13a2bc ]---
[  117.236007] Fixing recursive fault but reboot is needed!
[  117.240013] ------------[ cut here ]------------
[  117.240013] WARNING: CPU: 0 PID: 1407 at kernel/watchdog.c:311
watchdog_overflow_callback+0x84/0xa0()
[  117.240013] Watchdog detected hard LOCKUP on cpu 0
[  117.240013] Modules linked in: btusb btrtl btbcm btintel bluetooth
cfg80211 nvidia(OE) snd_emu10k1_synth snd_emux_synth snd_seq_midi_emul
snd_seq_virmidi snd_emu10k1 snd_util_mem snd_hwdep snd_ac97_codec ac97_bus
snd_pcm snd_seq_midi coretemp snd_seq_midi_event gpio_ich kvm_intel
snd_rawmidi snd_seq kvm snd_seq_device snd_timer hostap_pci snd hostap
soundcore dcdbas lib80211 drm dell_smm_hwmon emu10k1_gp lpc_ich serio_raw
gameport i5000_edac edac_core i5k_amb shpchp mac_hid parport_pc ppdev lp
parport autofs4 hid_generic usbhid hid tg3 firewire_ohci ahci ptp libahci
firewire_core pata_acpi pps_core crc_itu_t
[  117.240013] CPU: 0 PID: 1407 Comm: thunar-volman Tainted: G      D   
OE   4.2.0-rc1+ #5
[  117.240013] Hardware name: Dell Inc.                 Precision
WorkStation 490    /0GU083, BIOS A07 12/13/2007
[  117.240013]  ffffffff81aa8e67 ffff88013fc05af0 ffffffff81782ae0
0000000000000007
[  117.240013]  ffff88013fc05b40 ffff88013fc05b30 ffffffff8107397a
0000000000000000
[  117.240013]  ffff88013b014800 0000000000000000 ffff88013fc05c40
ffff88013fc05ef8
[  117.240013] Call Trace:
[  117.240013]  <NMI>  [<ffffffff81782ae0>] dump_stack+0x45/0x57
[  117.240013]  [<ffffffff8107397a>] warn_slowpath_common+0x8a/0xc0
[  117.240013]  [<ffffffff810739f6>] warn_slowpath_fmt+0x46/0x50
[  117.240013]  [<ffffffff81123284>] watchdog_overflow_callback+0x84/0xa0
[  117.240013]  [<ffffffff8116196c>] __perf_event_overflow+0x8c/0x1b0
[  117.240013]  [<ffffffff811624c4>] perf_event_overflow+0x14/0x20
[  117.240013]  [<ffffffff810322f4>] intel_pmu_handle_irq+0x1d4/0x440
[  117.240013]  [<ffffffff81028fc6>] perf_event_nmi_handler+0x26/0x40
[  117.240013]  [<ffffffff81017c59>] nmi_handle+0x79/0x100
[  117.240013]  [<ffffffff810181a2>] default_do_nmi+0x42/0x100
[  117.240013]  [<ffffffff810182e3>] do_nmi+0x83/0xb0
[  117.240013]  [<ffffffff8178b7bf>] end_repeat_nmi+0x1e/0x2e
[  117.240013]  [<ffffffff810b9f0a>] ?
native_queued_spin_lock_slowpath+0x16a/0x180
[  117.240013]  [<ffffffff810b9f0a>] ?
native_queued_spin_lock_slowpath+0x16a/0x180
[  117.240013]  [<ffffffff810b9f0a>] ?
native_queued_spin_lock_slowpath+0x16a/0x180
[  117.240013]  <<EOE>>  <IRQ>  [<ffffffff81789171>] _raw_spin_lock+0x21/0x30
[  117.240013]  [<ffffffff8109b129>] try_to_wake_up+0x1c9/0x320
[  117.240013]  [<ffffffff8109b15e>] ? try_to_wake_up+0x1fe/0x320
[  117.240013]  [<ffffffff8109b352>] default_wake_function+0x12/0x20
[  117.240013]  [<ffffffff810b2c96>] autoremove_wake_function+0x16/0x40
[  117.240013]  [<ffffffff810b2602>] __wake_up_common+0x52/0x90
[  117.240013]  [<ffffffff810b285d>] __wake_up+0x3d/0x60
[  117.240013]  [<ffffffff810d3187>] rcu_gp_kthread_wake+0x47/0x50
[  117.240013]  [<ffffffff810d3440>] rcu_report_qs_rnp+0x140/0x180
[  117.240013]  [<ffffffff810d53ce>] rcu_process_callbacks+0x46e/0x5d0
[  117.240013]  [<ffffffff81077a7d>] __do_softirq+0xfd/0x280
[  117.240013]  [<ffffffff81077dd2>] irq_exit+0xe2/0xf0
[  117.240013]  [<ffffffff8178c1c6>] smp_apic_timer_interrupt+0x46/0x60
[  117.240013]  [<ffffffff8178a39b>] apic_timer_interrupt+0x6b/0x70
[  117.240013]  <EOI>
[  117.240013] ---[ end trace e0f226cc4d13a2bd ]---
[  117.236007] ------------[ cut here ]------------
[  117.236007] WARNING: CPU: 1 PID: 1398 at kernel/watchdog.c:311
watchdog_overflow_callback+0x84/0xa0()
[  117.236007] Watchdog detected hard LOCKUP on cpu 1
[  117.236007] Modules linked in: btusb btrtl btbcm btintel bluetooth
cfg80211 nvidia(OE) snd_emu10k1_synth snd_emux_synth snd_seq_midi_emul
snd_seq_virmidi snd_emu10k1 snd_util_mem snd_hwdep snd_ac97_codec ac97_bus
snd_pcm snd_seq_midi coretemp snd_seq_midi_event gpio_ich kvm_intel
snd_rawmidi snd_seq kvm snd_seq_device snd_timer hostap_pci snd hostap
soundcore dcdbas lib80211 drm dell_smm_hwmon emu10k1_gp lpc_ich serio_raw
gameport i5000_edac edac_core i5k_amb shpchp mac_hid parport_pc ppdev lp
parport autofs4 hid_generic usbhid hid tg3 firewire_ohci ahci ptp libahci
firewire_core pata_acpi pps_core crc_itu_t
[  117.236007] CPU: 1 PID: 1398 Comm: kworker/u17:0 Tainted: G      D W 
OE   4.2.0-rc1+ #5
[  117.236007] Hardware name: Dell Inc.                 Precision
WorkStation 490    /0GU083, BIOS A07 12/13/2007
[  117.236007]  ffffffff81aa8e67 ffff88013fc45af0 ffffffff81782ae0
0000000000000007
[  117.236007]  ffff88013fc45b40 ffff88013fc45b30 ffffffff8107397a
0000000000000000
[  117.236007]  ffff88013a460000 0000000000000001 ffff88013fc45c40
ffff88013fc45ef8
[  117.236007] Call Trace:
[  117.236007]  <NMI>  [<ffffffff81782ae0>] dump_stack+0x45/0x57
[  117.236007]  [<ffffffff8107397a>] warn_slowpath_common+0x8a/0xc0
[  117.236007]  [<ffffffff810739f6>] warn_slowpath_fmt+0x46/0x50
[  117.236007]  [<ffffffff81123284>] watchdog_overflow_callback+0x84/0xa0
[  117.236007]  [<ffffffff8116196c>] __perf_event_overflow+0x8c/0x1b0
[  117.236007]  [<ffffffff811624c4>] perf_event_overflow+0x14/0x20
[  117.236007]  [<ffffffff810322f4>] intel_pmu_handle_irq+0x1d4/0x440
[  117.236007]  [<ffffffff81028fc6>] perf_event_nmi_handler+0x26/0x40
[  117.236007]  [<ffffffff81017c59>] nmi_handle+0x79/0x100
[  117.236007]  [<ffffffff8101821d>] default_do_nmi+0xbd/0x100
[  117.236007]  [<ffffffff810182e3>] do_nmi+0x83/0xb0
[  117.236007]  [<ffffffff8178b7bf>] end_repeat_nmi+0x1e/0x2e
[  117.236007]  [<ffffffff810b9ebd>] ?
native_queued_spin_lock_slowpath+0x11d/0x180
[  117.236007]  [<ffffffff810b9ebd>] ?
native_queued_spin_lock_slowpath+0x11d/0x180
[  117.236007]  [<ffffffff810b9ebd>] ?
native_queued_spin_lock_slowpath+0x11d/0x180
[  117.236007]  <<EOE>>  [<ffffffff817891a8>] _raw_spin_lock_irq+0x28/0x30
[  117.236007]  [<ffffffff81785018>] __schedule+0x88/0x920
[  117.236007]  [<ffffffff817858e7>] schedule+0x37/0x80
[  117.236007]  [<ffffffff81076525>] do_exit+0x895/0xa40
[  117.236007]  [<ffffffff81017495>] oops_end+0xa5/0xe0
[  117.236007]  [<ffffffff8106119d>] no_context+0x10d/0x380
[  117.236007]  [<ffffffff81393cda>] ? put_dec+0x1a/0x80
[  117.236007]  [<ffffffff8106148b>] __bad_area_nosemaphore+0x7b/0x1f0
[  117.236007]  [<ffffffff81061613>] bad_area_nosemaphore+0x13/0x20
[  117.236007]  [<ffffffff810618d3>] __do_page_fault+0x93/0x410
[  117.236007]  [<ffffffff81396c90>] ? vsnprintf+0x340/0x510
[  117.236007]  [<ffffffff81061c7f>] do_page_fault+0x2f/0x80
[  117.236007]  [<ffffffff8178b488>] page_fault+0x28/0x30
[  117.236007]  [<ffffffff81090b30>] ? kthread_data+0x10/0x20
[  117.236007]  [<ffffffff8108b585>] wq_worker_sleeping+0x15/0xa0
[  117.236007]  [<ffffffff817856be>] __schedule+0x72e/0x920
[  117.236007]  [<ffffffff817858e7>] schedule+0x37/0x80
[  117.236007]  [<ffffffff810763b3>] do_exit+0x723/0xa40
[  117.236007]  [<ffffffff81017495>] oops_end+0xa5/0xe0
[  117.236007]  [<ffffffff8106119d>] no_context+0x10d/0x380
[  117.236007]  [<ffffffff8109a78d>] ?
ttwu_do_activate.constprop.83+0x5d/0x70
[  117.236007]  [<ffffffff8106148b>] __bad_area_nosemaphore+0x7b/0x1f0
[  117.236007]  [<ffffffff81061613>] bad_area_nosemaphore+0x13/0x20
[  117.236007]  [<ffffffff810618d3>] __do_page_fault+0x93/0x410
[  117.236007]  [<ffffffff810a6670>] ? dequeue_entity+0x150/0x720
[  117.236007]  [<ffffffff81061c7f>] do_page_fault+0x2f/0x80
[  117.236007]  [<ffffffff8178b488>] page_fault+0x28/0x30
[  117.236007]  [<ffffffff814e8433>] ? firmware_uevent+0x23/0x80
[  117.236007]  [<ffffffff8138e6f9>] ? add_uevent_var+0x69/0x100
[  117.236007]  [<ffffffff814d47c6>] dev_uevent+0xb6/0x2b0
[  117.236007]  [<ffffffff8138d848>] ? kobject_get_path+0x98/0xf0
[  117.236007]  [<ffffffff8138eb1a>] kobject_uevent_env+0x2ea/0x660
[  117.236007]  [<ffffffff814e2157>] ? __pm_runtime_disable+0x27/0x140
[  117.236007]  [<ffffffff8138ee9b>] kobject_uevent+0xb/0x10
[  117.236007]  [<ffffffff814d2ccf>] device_del+0x18f/0x270
[  117.236007]  [<ffffffff8109b340>] ? wake_up_q+0x70/0x70
[  117.236007]  [<ffffffff814e97da>] _request_firmware+0x5aa/0xaf0
[  117.236007]  [<ffffffff814e9d55>] request_firmware+0x35/0x50
[  117.236007]  [<ffffffffc00fb881>] btbcm_setup_patchram+0x191/0x910 [btbcm]
[  117.236007]  [<ffffffff814e0994>] ? rpm_idle+0xc4/0x200
[  117.236007]  [<ffffffffc0e28488>] hci_dev_do_open+0xd8/0x500 [bluetooth]
[  117.236007]  [<ffffffffc0e29da0>] hci_power_on+0x40/0x1d0 [bluetooth]
[  117.236007]  [<ffffffff810d9628>] ? lock_timer_base.isra.34+0x58/0x80
[  117.236007]  [<ffffffff8108a6f7>] process_one_work+0x157/0x3e0
[  117.236007]  [<ffffffff8108b0de>] worker_thread+0x4e/0x470
[  117.236007]  [<ffffffff8108b090>] ? rescuer_thread+0x300/0x300
[  117.236007]  [<ffffffff81090569>] kthread+0xc9/0xe0
[  117.236007]  [<ffffffff810904a0>] ? kthread_create_on_node+0x180/0x180
[  117.236007]  [<ffffffff8178995f>] ret_from_fork+0x3f/0x70
[  117.236007]  [<ffffffff810904a0>] ? kthread_create_on_node+0x180/0x180
[  117.236007] ---[ end trace e0f226cc4d13a2be ]---


