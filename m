Return-Path: <cyrus@holtmann.org>
Message-ID: <536BF9B7.9050605@totakura.in>
Date: Thu, 08 May 2014 23:40:07 +0200
From: Sree Harsha Totakura <sreeharsha@totakura.in>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth adapter not listed in linux-3.14.2
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am running linux-3.14.2 and currently issues with bluetooth where my
bluetooth card is not listed.  From the kernel I found this output which
I guess is relevant here.



> [ 2023.672864] ------------[ cut here ]------------
> [ 2023.672872] WARNING: CPU: 1 PID: 6316 at drivers/base/firmware_class.c:1100 _request_firmware+0x691/0x9f0()
> [ 2023.672876] Modules linked in: ctr ccm rfcomm bnep btusb bluetooth 6lowpan_iphc vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O) uinput binfmt_misc uvcvideo videobuf2_vmalloc videobuf2_
> memops videobuf2_core videodev media snd_hda_codec_hdmi iTCO_wdt iTCO_vendor_support joydev nls_iso8859_1 nls_cp437 vfat fat ext2 arc4 x86_pkg_temp_thermal intel_powerclamp psmouse serio_ra
> w intel_rapl snd_hda_codec_realtek snd_hda_codec_generic coretemp kvm_intel pcspkr iwlmvm kvm mac80211 evdev iwlwifi i2c_i801 cfg80211 lpc_ich rtsx_pci_ms memstick tpm_tis wmi i915 tpm snd_
> hda_intel snd_hda_codec battery snd_hwdep snd_pcm thinkpad_acpi ac i2c_algo_bit nvram drm_kms_helper rfkill drm snd_seq snd_timer snd_seq_device i2c_core video snd mei_me soundcore mei butt
> on processor fuse autofs4 ext4 crc16 jbd2 mbcache dm_crypt dm_mod rtsx_pci_sdmmc mmc_core thermal thermal_sys crc32_pclmul crc32c_intel ghash_clmulni_intel ahci libahci aesni_intel libata a
> es_x86_64 glue_helper lrw gf128mul ablk_helper cryptd rtsx_pci mfd_core e1000e ptp pps_core
> [ 2023.673026] CPU: 1 PID: 6316 Comm: kworker/u17:0 Tainted: G        W  O 3.14.2 #9
> [ 2023.673031] Hardware name: LENOVO 20AQS00600/20AQS00600, BIOS GJET75WW (2.25 ) 03/28/2014
> [ 2023.673045] Workqueue: hci0 hci_power_on [bluetooth]
> [ 2023.673049]  0000000000000000 0000000094af4841 ffffffff81502294 0000000000000000
> [ 2023.673059]  ffffffff8104ce32 ffff8802f1335d48 ffff8802de1e57a0 ffff88030aa19200
> [ 2023.673069]  ffff8802f13b9a38 00000000fffffff5 ffffffff81366961 ffff8802f1335d38
> [ 2023.673078] Call Trace:
> [ 2023.673089]  [<ffffffff81502294>] ? dump_stack+0x41/0x51
> [ 2023.673098]  [<ffffffff8104ce32>] ? warn_slowpath_common+0x72/0x90
> [ 2023.673107]  [<ffffffff81366961>] ? _request_firmware+0x691/0x9f0
> [ 2023.673117]  [<ffffffff81289d89>] ? snprintf+0x49/0x60
> [ 2023.673125]  [<ffffffff81366ce7>] ? request_firmware+0x27/0x40
> [ 2023.673136]  [<ffffffffa04f0c75>] ? btusb_setup_intel+0x425/0x770 [btusb]
> [ 2023.673147]  [<ffffffff81363541>] ? __pm_runtime_idle+0x61/0x80
> [ 2023.673163]  [<ffffffffa0755d85>] ? hci_dev_do_open+0x225/0x720 [bluetooth]
> [ 2023.673172]  [<ffffffff8107c99f>] ? ttwu_do_wakeup+0xf/0xc0
> [ 2023.673187]  [<ffffffffa075669a>] ? hci_power_on+0x2a/0x180 [bluetooth]
> [ 2023.673198]  [<ffffffff81068a5e>] ? process_one_work+0x16e/0x450
> [ 2023.673207]  [<ffffffff810696f1>] ? worker_thread+0x121/0x3d0
> [ 2023.673218]  [<ffffffff810695d0>] ? flush_delayed_work+0x40/0x40
> [ 2023.673226]  [<ffffffff8106f92a>] ? kthread+0xda/0xf0
> [ 2023.673236]  [<ffffffff8106f850>] ? kthread_create_on_node+0x1a0/0x1a0
> [ 2023.673244]  [<ffffffff8151048c>] ? ret_from_fork+0x7c/0xb0
> [ 2023.673253]  [<ffffffff8106f850>] ? kthread_create_on_node+0x1a0/0x1a0
> [ 2023.673259] ---[ end trace 75f0db041f2f5570 ]---
> [ 2023.673266] bluetooth hci0: firmware: intel/ibt-hw-37.7.bseq will not be loaded
> [ 2023.673272] Bluetooth: hci0 failed to open default Intel fw file: intel/ibt-hw-37.7.bseq
> [ 2023.719504] done.

Is this a hardware failure?

Regards,
Sree
