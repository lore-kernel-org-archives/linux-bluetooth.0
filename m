Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 2 Feb 2018 03:02:56 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-bluetooth@vger.kernel.org
Subject: BUG: list_add double add
Message-ID: <20180202020255.GA2196@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm getting this bug since 4.9 (I do not remember I was ever running
older kernel on this machine). Just connecting BT Headset is enough
to trigger it. If anyone has a clue and can come with a patch to try
I'll be happy to do so.

Thank you.

[139881.419387] Bluetooth: hci0: last event is not cmd complete (0x0f)
[139931.787386] list_add double add: new=00000000fef33ead, prev=00000000fef33ead, next=000000009711acbc.
[139931.787400] ------------[ cut here ]------------
[139931.787403] kernel BUG at lib/list_debug.c:31!
[139931.787419] invalid opcode: 0000 [#1] SMP
[139931.787423] Modules linked in: snd_seq_dummy snd_seq snd_seq_device uas usb_storage ftdi_sio usbserial fuse rfcomm ctr ccm cmac bnep binfmt_misc nls_ascii nls_cp437 vfat intel_rapl fat x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel uvcvideo pcbc aesni_intel btusb videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 btrtl videobuf2_core aes_x86_64 btbcm crypto_simd videodev glue_helper cryptd btintel arc4 media intel_cstate snd_hda_codec_conexant snd_hda_codec_generic iwlmvm mac80211 bluetooth iwlwifi intel_uncore drbg ansi_cprng snd_hda_intel snd_hda_codec rtsx_pci_ms memstick snd_hda_core snd_hwdep nvidiafb vgastate ecdh_generic mei_me snd_pcm sg cfg80211 fb_ddc joydev intel_rapl_perf pcspkr iTCO_wdt serio_raw iTCO_vendor_support
[139931.787524]  snd_timer intel_pch_thermal mei shpchp snd soundcore tpm_infineon evdev efi_pstore hp_wmi sparse_keymap hp_accel lis3lv02d input_polldev acpi_pad battery efivars ac rfkill wmi_bmof parport_pc ppdev nfsd auth_rpcgss lp nfs_acl lockd grace sunrpc parport efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto sd_mod hid_generic usbhid hid rtsx_pci_sdmmc mmc_core nouveau mxm_wmi i915 ttm i2c_algo_bit ahci drm_kms_helper libahci syscopyarea e1000e sysfillrect sysimgblt fb_sys_fops crc32c_intel ptp xhci_pci libata psmouse xhci_hcd pps_core i2c_i801 rtsx_pci mfd_core scsi_mod drm usbcore thermal wmi video button
[139931.787624] CPU: 7 PID: 12090 Comm: kworker/u17:1 Not tainted 4.15.0 #79
[139931.787628] Hardware name: HP HP ZBook 17 G3/80D6, BIOS N81 Ver. 01.21 12/19/2017
[139931.787663] Workqueue: hci0 hci_rx_work [bluetooth]
[139931.787674] RIP: 0010:__list_add_valid+0x61/0x70
[139931.787679] RSP: 0018:ffffbfc8c5307c28 EFLAGS: 00010282
[139931.787685] RAX: 0000000000000058 RBX: ffff9af72c3e7278 RCX: 0000000000000000
[139931.787690] RDX: 0000000000000000 RSI: ffff9af73f5d56f8 RDI: ffff9af73f5d56f8
[139931.787694] RBP: ffff9af5c4752c20 R08: 0000000000000731 R09: 0000000000000003
[139931.787698] R10: ffffbfc8c5307ce8 R11: 0000000000000001 R12: ffff9af735121f00
[139931.787702] R13: ffff9af72c3e7280 R14: ffff9af72c3e7280 R15: 0000000000000003
[139931.787708] FS:  0000000000000000(0000) GS:ffff9af73f5c0000(0000) knlGS:0000000000000000
[139931.787712] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[139931.787717] CR2: 00007f7a101233a8 CR3: 0000000118809006 CR4: 00000000003606e0
[139931.787721] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[139931.787725] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[139931.787728] Call Trace:
[139931.787741]  kobject_add_internal+0x7c/0x2e0
[139931.787751]  kobject_add+0x71/0xd0
[139931.787761]  device_add+0x129/0x670
[139931.787770]  ? start_creating+0xb4/0x100
[139931.787806]  hci_conn_add_sysfs+0x43/0xb0 [bluetooth]
[139931.787837]  hci_conn_complete_evt.isra.44+0xc0/0x400 [bluetooth]
[139931.787845]  ? __switch_to_asm+0x40/0x70
[139931.787873]  hci_event_packet+0x1737/0x2c50 [bluetooth]
[139931.787879]  ? __switch_to_asm+0x40/0x70
[139931.787884]  ? __switch_to_asm+0x34/0x70
[139931.787888]  ? __switch_to_asm+0x40/0x70
[139931.787893]  ? __switch_to_asm+0x34/0x70
[139931.787898]  ? __switch_to_asm+0x40/0x70
[139931.787902]  ? __switch_to_asm+0x34/0x70
[139931.787907]  ? __switch_to_asm+0x40/0x70
[139931.787912]  ? __switch_to_asm+0x40/0x70
[139931.787916]  ? __switch_to_asm+0x34/0x70
[139931.787921]  ? __switch_to_asm+0x40/0x70
[139931.787946]  ? hci_rx_work+0x17e/0x340 [bluetooth]
[139931.787969]  hci_rx_work+0x17e/0x340 [bluetooth]
[139931.787978]  process_one_work+0x181/0x380
[139931.787985]  worker_thread+0x2e/0x370
[139931.787992]  ? process_one_work+0x380/0x380
[139931.788000]  kthread+0x113/0x130
[139931.788008]  ? kthread_create_worker_on_cpu+0x70/0x70
[139931.788014]  ret_from_fork+0x35/0x40
[139931.788019] Code: 0f 0b 48 89 c1 4c 89 c6 48 c7 c7 58 82 a3 83 e8 20 28 d5 ff 0f 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 a8 82 a3 83 e8 09 28 d5 ff <0f> 0b 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 48 8b 07 48 b9 00 
[139931.788110] RIP: __list_add_valid+0x61/0x70 RSP: ffffbfc8c5307c28
[139931.788118] ---[ end trace 6e1afcbf41230f2a ]---

