Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Cody P Schafer <dev@codyps.com>
Date: Mon, 19 Dec 2016 16:25:46 -0500
Message-ID: <CAPoQQ-0UxVULhMJYD1ysWiO87MKkQoNfc=562a4rdm=Ktym3jg@mail.gmail.com>
Subject: mgmt-tester has a use-after-free, & ArchLinux kernel 4.4.37-1-lts has
 a kernel NULL pointer dereference occasionally triggered by mgmt-tester
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Not sure if the NULL deref is known or not, but I didn't see a patch
added in 4.4.38 or 4.4.39. Note that my kernel _is_ running the
parallels vm guest modules, so it is tainted. If someone is
interested, I can likely try to reproduce without them added.

bluez rev: dbe5c40981548c7fc15942e7bfc66a7e6a1e0002
kernel: ArchLinux's linux-stable 4.4.37-1-lts

Device info (should it be relevant):

[bluetooth]# show
Controller 00:AA:01:02:00:00
Name: two.na.cybexintl.com #3
Alias: two.na.cybexintl.com #3
Class: 0x000000
Powered: no
Discoverable: no
Pairable: yes
UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
UUID: SIM Access                (0000112d-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
Modalias: usb:v1D6Bp0246d052B
Discovering: no

Bus 004 Device 075: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)

mgmt-tester in bluez master does a use-after-free causing a segfault
(sometimes) when run against 4.4.37-1-lts (arch)

The use-after-free doesn't appear to happen every run, some runs do complete.
With sanitize=address is disabled, I see segfaults, but it isn't clear
if I always see segfaults when the use-after-free occurs.

Invalid access appears to always have the same backtrace/similar
backtrace, but occurs after different tests.


Output excerpt (built with `CFLAGS=-fno-omit-frame-pointer\
-fsanitize=undefined\ -fsanitize=address\ -ggdb3\
-fvar-tracking-assignments\ -Og ./configure --enable-experimental`)
```
Set SSP on - Success 2 - teardown
  New settings event received
=================================================================
==12205==ERROR: AddressSanitizer: heap-use-after-free on address
0x602000019638 at pc 0x00000048c2c2 bp 0x7fff277f2810 sp
0x7fff277f2800
READ of size 8 at 0x602000019638 thread T0
    #0 0x48c2c1 in queue_foreach src/shared/queue.c:219
    #1 0x48f434 in process_notify src/shared/mgmt.c:304
    #2 0x4923e2 in can_read_data src/shared/mgmt.c:370
    #3 0x49d90c in watch_callback src/shared/io-glib.c:170
    #4 0x7fa752861439 in g_main_context_dispatch
(/usr/lib/libglib-2.0.so.0+0x4a439)
    #5 0x7fa7528617ef  (/usr/lib/libglib-2.0.so.0+0x4a7ef)
    #6 0x7fa752861b11 in g_main_loop_run (/usr/lib/libglib-2.0.so.0+0x4ab11)
    #7 0x49d70e in tester_run src/shared/tester.c:830
    #8 0x436ede in main tools/mgmt-tester.c:8094
    #9 0x7fa751781290 in __libc_start_main (/usr/lib/libc.so.6+0x20290)
    #10 0x402d09 in _start (/home/cody/g/bluez/tools/mgmt-tester+0x402d09)

0x602000019638 is located 8 bytes inside of 16-byte region
[0x602000019630,0x602000019640)
freed by thread T0 here:
    #0 0x7fa752bf0b00 in __interceptor_free
/build/gcc-multilib/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:45
    #1 0x48c982 in queue_remove_if src/shared/queue.c:302
    #2 0x491575 in mgmt_unregister src/shared/mgmt.c:756
    #3 0x406e57 in command_generic_new_settings tools/mgmt-tester.c:6062
    #4 0x48edf0 in notify_handler src/shared/mgmt.c:292
    #5 0x48c35e in queue_foreach src/shared/queue.c:220
    #6 0x48f434 in process_notify src/shared/mgmt.c:304
    #7 0x4923e2 in can_read_data src/shared/mgmt.c:370
    #8 0x49d90c in watch_callback src/shared/io-glib.c:170
    #9 0x7fa752861439 in g_main_context_dispatch
(/usr/lib/libglib-2.0.so.0+0x4a439)

previously allocated by thread T0 here:
    #0 0x7fa752bf0e60 in __interceptor_malloc
/build/gcc-multilib/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:62
    #1 0x48cfaf in btd_malloc src/shared/util.c:45
    #2 0x48b5d8 in queue_entry_new src/shared/queue.c:82
    #3 0x48b78a in queue_push_tail src/shared/queue.c:95
    #4 0x491360 in mgmt_register src/shared/mgmt.c:741
    #5 0x40e513 in test_command_generic tools/mgmt-tester.c:6758
    #6 0x49a87d in run_callback src/shared/tester.c:415
    #7 0x7fa752861439 in g_main_context_dispatch
(/usr/lib/libglib-2.0.so.0+0x4a439)

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/queue.c:219
in queue_foreach
Shadow bytes around the buggy address:
  0x0c047fffb270: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fffb280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fffb290: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fffb2a0: fa fa fa fa fa fa fa fa fa fa fd fd fa fa fd fd
  0x0c047fffb2b0: fa fa fd fd fa fa fd fa fa fa fd fd fa fa fd fd
=>0x0c047fffb2c0: fa fa 00 00 fa fa fd[fd]fa fa fd fd fa fa fd fa
  0x0c047fffb2d0: fa fa fd fd fa fa fd fd fa fa 00 00 fa fa 00 00
  0x0c047fffb2e0: fa fa fd fd fa fa fd fd fa fa fd fd fa fa fd fa
  0x0c047fffb2f0: fa fa 00 00 fa fa 00 00 fa fa fd fd fa fa fd fa
  0x0c047fffb300: fa fa 00 00 fa fa 00 00 fa fa fd fd fa fa fd fd
  0x0c047fffb310: fa fa fd fd fa fa fd fa fa fa fd fd fa fa fd fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Heap right redzone:      fb
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack partial redzone:   f4
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==12205==ABORTING
```

The NULL deref shows up with the following in dmesg:

```
[201577.113050] usb 4-2: new full-speed USB device number 74 using uhci_hcd
[201577.268042] hub 4-2:1.0: USB hub found
[201577.268971] hub 4-2:1.0: 15 ports detected
[201577.573870] usb 4-2.1: new full-speed USB device number 75 using uhci_hcd
[201585.952918] Bluetooth: hci1 failed to generate new RPA
[201586.475220] Bluetooth: load_link_keys: expected 28 bytes, got 3 bytes
[201586.484745] Bluetooth: load_keys: expected 38 bytes, got 2 bytes
[201586.493678] Bluetooth: load_ltks: too big key_count value 1821
[201591.789550] Bluetooth: hci1 unexpected SMP command 0x03 from
00:aa:01:01:00:00
[201591.939499] Bluetooth: hci1 unexpected SMP command 0x03 from
00:aa:01:01:00:00
[201592.067890] Bluetooth: load_irks: expected 48 bytes, got 4 bytes
[201592.291644] Bluetooth: load_conn_param: too big param_count value 4370
[201596.494643] Bluetooth: hci1 advertising data length corrected
[201597.502272] Bluetooth: hci1 advertising data length corrected
[202097.859098] Bluetooth: hci1 failed to generate new RPA
[202179.308884] Bluetooth: hci1 failed to generate new RPA
[202179.870064] Bluetooth: load_link_keys: expected 28 bytes, got 3 bytes
[202179.879181] Bluetooth: load_keys: expected 38 bytes, got 2 bytes
[202179.888417] Bluetooth: load_ltks: too big key_count value 1821
[202181.819106] Bluetooth: hci2 unexpected SMP command 0x03 from
00:aa:01:03:00:00
[202181.819145] Bluetooth: hci2 unexpected SMP command 0x03 from
00:aa:01:03:00:00
[202181.894595] ------------[ cut here ]------------
[202181.894649] WARNING: CPU: 0 PID: 32266 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x62/0x80()
[202181.894650] sysfs: cannot create duplicate filename
'/devices/virtual/bluetooth/hci2/hci2:42'
[202181.894651] Modules linked in: hci_vhci algif_hash algif_skcipher
af_alg cmac ecb rfcomm omfs jfs xfs libcrc32c crc32c_generic reiserfs
hfs hfsplus nls_iso8859_1 nls_cp437 vfat fat isofs nls_utf8 udf
crc_itu_t uas usb_storage fuse mousedev cfg80211 bnep
prl_fs_freeze(PO) prl_fs(PO) prl_eth(PO) x86_pkg_temp_thermal coretemp
kvm_intel kvm snd_intel8x0 irqbypass btusb snd_ac97_codec btrtl
gpio_ich crct10dif_pclmul btbcm crc32_pclmul btintel ac97_bus ppdev
aesni_intel snd_pcm aes_x86_64 bluetooth evdev lrw snd_timer gf128mul
input_leds led_class glue_helper snd ablk_helper pl2303 cryptd psmouse
pcspkr soundcore mac_hid usbserial rfkill lpc_ich shpchp prl_tg(PO)
intel_agp intel_gtt sbs pvpanic parport_pc fjes parport sbshc battery
acpi_cpufreq tpm_tis tpm processor button ac sch_fq_codel ip_tables
x_tables
[202181.894689]  ext4 crc16 mbcache jbd2 dm_mod sr_mod cdrom sd_mod
ata_generic pata_acpi uhci_hcd virtio_balloon virtio_net serio_raw
atkbd libps2 ahci libahci ehci_pci ata_piix xhci_pci libata xhci_hcd
ehci_hcd crc32c_intel virtio_pci usbcore scsi_mod virtio_ring i8042
usb_common virtio serio
[202181.894708] CPU: 0 PID: 32266 Comm: kworker/u65:2 Tainted: P
 W  O    4.4.37-1-lts #1
[202181.894710] Hardware name: Parallels Software International Inc.
Parallels Virtual Platform/Parallels Virtual Platform, BIOS 11.2.2
(32651) 09/27/2016
[202181.894717] Workqueue: hci2 hci_rx_work [bluetooth]
[202181.894724]  0000000000000286 00000000237f8161 ffff880144693a50
ffffffff812c47af
[202181.894725]  ffff880144693a98 ffffffff817341a8 ffff880144693a88
ffffffff81076f82
[202181.894726]  ffff880117a08000 ffff8802734eb198 ffff880155209780
ffff88011096ab70
[202181.894728] Call Trace:
[202181.894754]  [<ffffffff812c47af>] dump_stack+0x63/0x84
[202181.894780]  [<ffffffff81076f82>] warn_slowpath_common+0x82/0xc0
[202181.894782]  [<ffffffff8107701c>] warn_slowpath_fmt+0x5c/0x80
[202181.894784]  [<ffffffff81253af8>] ? kernfs_path+0x48/0x60
[202181.894785]  [<ffffffff812570e2>] sysfs_warn_dup+0x62/0x80
[202181.894787]  [<ffffffff812571c7>] sysfs_create_dir_ns+0x77/0x90
[202181.894788]  [<ffffffff812c6e81>] kobject_add_internal+0xb1/0x340
[202181.894790]  [<ffffffff812c7635>] kobject_add+0x75/0xd0
[202181.894811]  [<ffffffff8117fdd1>] ? kfree_const+0x21/0x30
[202181.894812]  [<ffffffff8117fdd1>] ? kfree_const+0x21/0x30
[202181.894842]  [<ffffffff813e5801>] device_add+0x121/0x670
[202181.894846]  [<ffffffffa04190ff>] hci_conn_add_sysfs+0x4f/0xc0 [bluetooth]
[202181.894850]  [<ffffffffa03fdf16>]
hci_conn_complete_evt.isra.50+0xe6/0x430 [bluetooth]
[202181.894854]  [<ffffffffa040528f>] hci_event_packet+0x152f/0x31d0 [bluetooth]
[202181.894874]  [<ffffffff810aaaa5>] ? dequeue_entity+0x215/0xa60
[202181.894885]  [<ffffffff810dee87>] ? lock_timer_base.isra.0+0x57/0x70
[202181.894887]  [<ffffffff810ab3b2>] ? dequeue_task_fair+0xc2/0x8a0
[202181.894890]  [<ffffffffa03f3651>] hci_rx_work+0x1a1/0x360 [bluetooth]
[202181.894898]  [<ffffffff8108ebb8>] process_one_work+0x1e8/0x440
[202181.894900]  [<ffffffff8108ee5b>] worker_thread+0x4b/0x4b0
[202181.894902]  [<ffffffff8108ee10>] ? process_one_work+0x440/0x440
[202181.894903]  [<ffffffff8108ee10>] ? process_one_work+0x440/0x440
[202181.894910]  [<ffffffff81094988>] kthread+0xd8/0xf0
[202181.894911]  [<ffffffff810948b0>] ? kthread_worker_fn+0x160/0x160
[202181.894936]  [<ffffffff8158f4ff>] ret_from_fork+0x3f/0x70
[202181.894938]  [<ffffffff810948b0>] ? kthread_worker_fn+0x160/0x160
[202181.894959] ---[ end trace 5a07201d0623a57a ]---
[202181.894960] ------------[ cut here ]------------
[202181.894962] WARNING: CPU: 0 PID: 32266 at lib/kobject.c:240
kobject_add_internal+0x2ca/0x340()
[202181.894963] kobject_add_internal failed for hci2:42 with -EEXIST,
don't try to register things with the same name in the same directory.
[202181.894964] Modules linked in: hci_vhci algif_hash algif_skcipher
af_alg cmac ecb rfcomm omfs jfs xfs libcrc32c crc32c_generic reiserfs
hfs hfsplus nls_iso8859_1 nls_cp437 vfat fat isofs nls_utf8 udf
crc_itu_t uas usb_storage fuse mousedev cfg80211 bnep
prl_fs_freeze(PO) prl_fs(PO) prl_eth(PO) x86_pkg_temp_thermal coretemp
kvm_intel kvm snd_intel8x0 irqbypass btusb snd_ac97_codec btrtl
gpio_ich crct10dif_pclmul btbcm crc32_pclmul btintel ac97_bus ppdev
aesni_intel snd_pcm aes_x86_64 bluetooth evdev lrw snd_timer gf128mul
input_leds led_class glue_helper snd ablk_helper pl2303 cryptd psmouse
pcspkr soundcore mac_hid usbserial rfkill lpc_ich shpchp prl_tg(PO)
intel_agp intel_gtt sbs pvpanic parport_pc fjes parport sbshc battery
acpi_cpufreq tpm_tis tpm processor button ac sch_fq_codel ip_tables
x_tables
[202181.894985]  ext4 crc16 mbcache jbd2 dm_mod sr_mod cdrom sd_mod
ata_generic pata_acpi uhci_hcd virtio_balloon virtio_net serio_raw
atkbd libps2 ahci libahci ehci_pci ata_piix xhci_pci libata xhci_hcd
ehci_hcd crc32c_intel virtio_pci usbcore scsi_mod virtio_ring i8042
usb_common virtio serio
[202181.894993] CPU: 0 PID: 32266 Comm: kworker/u65:2 Tainted: P
 W  O    4.4.37-1-lts #1
[202181.894994] Hardware name: Parallels Software International Inc.
Parallels Virtual Platform/Parallels Virtual Platform, BIOS 11.2.2
(32651) 09/27/2016
[202181.894997] Workqueue: hci2 hci_rx_work [bluetooth]
[202181.894998]  0000000000000286 00000000237f8161 ffff880144693aa0
ffffffff812c47af
[202181.894999]  ffff880144693ae8 ffffffff8173c7ef ffff880144693ad8
ffffffff81076f82
[202181.895000]  ffff8800019a4b18 0000000000000000 00000000ffffffef
ffff88011096ab70
[202181.895006] Call Trace:
[202181.895008]  [<ffffffff812c47af>] dump_stack+0x63/0x84
[202181.895010]  [<ffffffff81076f82>] warn_slowpath_common+0x82/0xc0
[202181.895011]  [<ffffffff8107701c>] warn_slowpath_fmt+0x5c/0x80
[202181.895013]  [<ffffffff812570ea>] ? sysfs_warn_dup+0x6a/0x80
[202181.895014]  [<ffffffff812c709a>] kobject_add_internal+0x2ca/0x340
[202181.895016]  [<ffffffff812c7635>] kobject_add+0x75/0xd0
[202181.895017]  [<ffffffff8117fdd1>] ? kfree_const+0x21/0x30
[202181.895018]  [<ffffffff8117fdd1>] ? kfree_const+0x21/0x30
[202181.895020]  [<ffffffff813e5801>] device_add+0x121/0x670
[202181.895024]  [<ffffffffa04190ff>] hci_conn_add_sysfs+0x4f/0xc0 [bluetooth]
[202181.895027]  [<ffffffffa03fdf16>]
hci_conn_complete_evt.isra.50+0xe6/0x430 [bluetooth]
[202181.895030]  [<ffffffffa040528f>] hci_event_packet+0x152f/0x31d0 [bluetooth]
[202181.895031]  [<ffffffff810aaaa5>] ? dequeue_entity+0x215/0xa60
[202181.895033]  [<ffffffff810dee87>] ? lock_timer_base.isra.0+0x57/0x70
[202181.895034]  [<ffffffff810ab3b2>] ? dequeue_task_fair+0xc2/0x8a0
[202181.895037]  [<ffffffffa03f3651>] hci_rx_work+0x1a1/0x360 [bluetooth]
[202181.895039]  [<ffffffff8108ebb8>] process_one_work+0x1e8/0x440
[202181.895040]  [<ffffffff8108ee5b>] worker_thread+0x4b/0x4b0
[202181.895042]  [<ffffffff8108ee10>] ? process_one_work+0x440/0x440
[202181.895043]  [<ffffffff8108ee10>] ? process_one_work+0x440/0x440
[202181.895044]  [<ffffffff81094988>] kthread+0xd8/0xf0
[202181.895046]  [<ffffffff810948b0>] ? kthread_worker_fn+0x160/0x160
[202181.895047]  [<ffffffff8158f4ff>] ret_from_fork+0x3f/0x70
[202181.895048]  [<ffffffff810948b0>] ? kthread_worker_fn+0x160/0x160
[202181.895049] ---[ end trace 5a07201d0623a57b ]---
[202181.895050] Bluetooth: Failed to register connection device
[202181.977687] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000020
[202181.977695] IP: [<ffffffff81581918>] klist_next+0x18/0xf0
[202181.977723] PGD 110b51067 PUD 14b2a8067 PMD 0
[202181.977729] Oops: 0000 [#1] SMP
[202181.977759] Modules linked in: hci_vhci algif_hash algif_skcipher
af_alg cmac ecb rfcomm omfs jfs xfs libcrc32c crc32c_generic reiserfs
hfs hfsplus nls_iso8859_1 nls_cp437 vfat fat isofs nls_utf8 udf
crc_itu_t uas usb_storage fuse mousedev cfg80211 bnep
prl_fs_freeze(PO) prl_fs(PO) prl_eth(PO) x86_pkg_temp_thermal coretemp
kvm_intel kvm snd_intel8x0 irqbypass btusb snd_ac97_codec btrtl
gpio_ich crct10dif_pclmul btbcm crc32_pclmul btintel ac97_bus ppdev
aesni_intel snd_pcm aes_x86_64 bluetooth evdev lrw snd_timer gf128mul
input_leds led_class glue_helper snd ablk_helper pl2303 cryptd psmouse
pcspkr soundcore mac_hid usbserial rfkill lpc_ich shpchp prl_tg(PO)
intel_agp intel_gtt sbs pvpanic parport_pc fjes parport sbshc battery
acpi_cpufreq tpm_tis tpm processor button ac sch_fq_codel ip_tables
x_tables
[202181.977820]  ext4 crc16 mbcache jbd2 dm_mod sr_mod cdrom sd_mod
ata_generic pata_acpi uhci_hcd virtio_balloon virtio_net serio_raw
atkbd libps2 ahci libahci ehci_pci ata_piix xhci_pci libata xhci_hcd
ehci_hcd crc32c_intel virtio_pci usbcore scsi_mod virtio_ring i8042
usb_common virtio serio
[202181.977843] CPU: 2 PID: 12781 Comm: mgmt-tester Tainted: P
W  O    4.4.37-1-lts #1
[202181.977846] Hardware name: Parallels Software International Inc.
Parallels Virtual Platform/Parallels Virtual Platform, BIOS 11.2.2
(32651) 09/27/2016
[202181.977849] task: ffff880093b1c4c0 ti: ffff880105e58000 task.ti:
ffff880105e58000
[202181.977851] RIP: 0010:[<ffffffff81581918>]  [<ffffffff81581918>]
klist_next+0x18/0xf0
[202181.977863] RSP: 0018:ffff880105e5bc80  EFLAGS: 00010282
[202181.977864] RAX: 0000000000000000 RBX: ffff8800019a4800 RCX:
0000000000000000
[202181.977866] RDX: ffffffffa0418fe0 RSI: ffff880105e5bcb8 RDI:
0000000000000000
[202181.977867] RBP: ffff880105e5bca8 R08: ffff880105e58000 R09:
0000000000000000
[202181.977868] R10: 0000000101340991 R11: 0000000000000000 R12:
ffff880105e5bcb8
[202181.977870] R13: ffffffffa0418fe0 R14: 0000000000000000 R15:
ffffffffa044b050
[202181.977880] FS:  00007f67e458b7c0(0000) GS:ffff8802a2a40000(0000)
knlGS:0000000000000000
[202181.977882] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[202181.977883] CR2: 0000000000000020 CR3: 0000000122fed000 CR4:
00000000001406e0
[202181.977903] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[202181.977905] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[202181.977906] Stack:
[202181.977907]  ffff8800019a4800 0000000000000000 ffffffffa0418fe0
ffff88011096a000
[202181.977910]  ffffffffa044b050 ffff880105e5bce8 ffffffff813e3eea
0000000000000000
[202181.977913]  0000000000000000 00000000e20621c8 ffff8800019a4800
ffff8800019a4b08
[202181.977915] Call Trace:
[202181.977928]  [<ffffffffa0418fe0>] ? show_type+0x50/0x50 [bluetooth]
[202181.977933]  [<ffffffff813e3eea>] device_find_child+0x5a/0xb0
[202181.977940]  [<ffffffffa0418fe0>] ? show_type+0x50/0x50 [bluetooth]
[202181.977947]  [<ffffffffa04191c4>] hci_conn_del_sysfs+0x54/0xb0 [bluetooth]
[202181.977954]  [<ffffffffa03fa9ff>] hci_conn_cleanup+0x8f/0x140 [bluetooth]
[202181.977960]  [<ffffffffa03fac51>] hci_conn_del+0xb1/0x1f0 [bluetooth]
[202181.977966]  [<ffffffffa03fbf54>] hci_conn_hash_flush+0xb4/0xf0 [bluetooth]
[202181.977973]  [<ffffffffa03f550f>] hci_dev_do_close+0x1ef/0x590 [bluetooth]
[202181.977979]  [<ffffffffa03f81f1>] hci_unregister_dev+0x71/0x270 [bluetooth]
[202181.977983]  [<ffffffffa07b60b1>] vhci_release+0x31/0x60 [hci_vhci]
[202181.978010]  [<ffffffff811deabc>] __fput+0x9c/0x1f0
[202181.978012]  [<ffffffff811dec4e>] ____fput+0xe/0x10
[202181.978015]  [<ffffffff81092c03>] task_work_run+0x83/0xb0
[202181.978033]  [<ffffffff8100365a>] exit_to_usermode_loop+0xba/0xc0
[202181.978036]  [<ffffffff81003b6e>] syscall_return_slowpath+0x4e/0x60
[202181.978039]  [<ffffffff8158f308>] int_ret_from_sys_call+0x25/0x8f
[202181.978040] Code: c6 05 0f a8 34 00 01 eb 84 66 2e 0f 1f 84 00 00
00 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 4d 8b 74 24
08 48 8b 3f <4c> 8b 6f 20 e8 3f d4 00 00 4d 85 f6 74 77 49 8b 46 08 4c
89 f7
[202181.978075] RIP  [<ffffffff81581918>] klist_next+0x18/0xf0
[202181.978078]  RSP <ffff880105e5bc80>
[202181.978079] CR2: 0000000000000020
[202181.978131] ---[ end trace 5a07201d0623a57c ]---
```
