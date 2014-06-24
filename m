Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 24 Jun 2014 23:53:50 +0200
Message-ID: <CAA7pwKPXFO3cAHSCkwk8xqbPrshquOimBvtx=FHF4idYncJsVQ@mail.gmail.com>
Subject: Bluetooth: hci0 failed to open Intel firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq(-11)
From: Patrik Lundquist <patrik.lundquist@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

the Bluetooth firmware sometimes fail to load during hci_power_on with
an Intel 7260 in a ThinkPad X240. Running Ubuntu 14.04 but with their
mainline kernel 3.15.1-031501-generic. Fails maybe one out of ten
times when resuming from standby.

Not sure if it's a Bluetooth bug or another part of the kernel. Do you
want me to file a bug report in the kernel Bugzilla?

/Patrik


[ 4960.609125] Bluetooth: hci0: read Intel version: 370710018002030d00
[ 4960.609219] Bluetooth: hci0: Intel Bluetooth firmware file:
intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
[ 4960.721239] Bluetooth: hci0: Intel Bluetooth firmware patch
completed and activated

[suspend/resume]

[ 5802.489224] Bluetooth: hci0: read Intel version: 370710018002030d00
[ 5802.489233] ------------[ cut here ]------------
[ 5802.489240] WARNING: CPU: 2 PID: 615 at
/home/apw/COD/linux/drivers/base/firmware_class.c:1105
_request_firmware+0x1be/0x1e0()
[ 5802.489241] Modules linked in: ctr ccm arc4 rfcomm bnep intel_rapl
iwlmvm thinkpad_acpi mac80211 nvram x86_pkg_temp_thermal
intel_powerclamp coretemp snd_hda_codec_hdmi snd_seq_midi
snd_hda_codec_realtek kvm_intel snd_seq_midi_event
snd_hda_codec_generic kvm snd_rawmidi snd_hda_intel snd_hda_controller
iwlwifi btusb snd_hda_codec bluetooth nls_iso8859_1 snd_hwdep snd_seq
snd_pcm joydev serio_raw cfg80211 6lowpan_iphc rtsx_pci_ms
snd_seq_device lpc_ich memstick snd_timer snd soundcore parport_pc
ppdev intel_smartconnect lp mac_hid parport dm_crypt rtsx_pci_sdmmc
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
aes_x86_64 lrw gf128mul glue_helper i915 ablk_helper cryptd psmouse
i2c_algo_bit e1000e drm_kms_helper ahci libahci drm rtsx_pci ptp
pps_core wmi video
[ 5802.489291] CPU: 2 PID: 615 Comm: kworker/u17:2 Not tainted
3.15.1-031501-generic #201406161841
[ 5802.489292] Hardware name: LENOVO 20AM009DMS/20AM009DMS, BIOS
GIET74WW (2.24 ) 05/13/2014
[ 5802.489307] Workqueue: hci0 hci_power_on [bluetooth]
[ 5802.489309]  0000000000000451 ffff8802314ebb48 ffffffff8176e144
0000000000000007
[ 5802.489312]  0000000000000000 ffff8802314ebb88 ffffffff8106ce2c
0000000000000000
[ 5802.489314]  ffff8802314ebc68 ffff8800a2b11a88 0000000000003a98
0000000000000005
[ 5802.489317] Call Trace:
[ 5802.489323]  [<ffffffff8176e144>] dump_stack+0x46/0x58
[ 5802.489326]  [<ffffffff8106ce2c>] warn_slowpath_common+0x8c/0xc0
[ 5802.489328]  [<ffffffff8106ce7a>] warn_slowpath_null+0x1a/0x20
[ 5802.489331]  [<ffffffff814c75ae>] _request_firmware+0x1be/0x1e0
[ 5802.489334]  [<ffffffff814c76cc>] request_firmware+0x3c/0x60
[ 5802.489339]  [<ffffffffa03f1bd2>] btusb_setup_intel_get_fw+0x92/0x160 [btusb]
[ 5802.489342]  [<ffffffffa03f2877>] btusb_setup_intel+0x127/0x450 [btusb]
[ 5802.489347]  [<ffffffff81572450>] ? usb_autopm_put_interface+0x30/0x40
[ 5802.489356]  [<ffffffffa0387fc5>] hci_dev_do_open+0x245/0x330 [bluetooth]
[ 5802.489365]  [<ffffffffa03880ee>] hci_power_on+0x3e/0x160 [bluetooth]
[ 5802.489369]  [<ffffffff8108935f>] process_one_work+0x17f/0x4c0
[ 5802.489372]  [<ffffffff8108a57b>] worker_thread+0x11b/0x3d0
[ 5802.489375]  [<ffffffff8108a460>] ? manage_workers.isra.21+0x190/0x190
[ 5802.489377]  [<ffffffff810913c9>] kthread+0xc9/0xe0
[ 5802.489380]  [<ffffffff81091300>] ? flush_kthread_worker+0xb0/0xb0
[ 5802.489384]  [<ffffffff817845bc>] ret_from_fork+0x7c/0xb0
[ 5802.489386]  [<ffffffff81091300>] ? flush_kthread_worker+0xb0/0xb0
[ 5802.489388] ---[ end trace 82f5306631f275cf ]---
[ 5802.489392] bluetooth hci0: firmware:
intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq will not be loaded
[ 5802.489396] Bluetooth: hci0 failed to open Intel firmware file:
intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq(-11)
[ 5802.489398] ------------[ cut here ]------------
[ 5802.489402] WARNING: CPU: 2 PID: 615 at
/home/apw/COD/linux/drivers/base/firmware_class.c:1105
_request_firmware+0x1be/0x1e0()
[ 5802.489403] Modules linked in: ctr ccm arc4 rfcomm bnep intel_rapl
iwlmvm thinkpad_acpi mac80211 nvram x86_pkg_temp_thermal
intel_powerclamp coretemp snd_hda_codec_hdmi snd_seq_midi
snd_hda_codec_realtek kvm_intel snd_seq_midi_event
snd_hda_codec_generic kvm snd_rawmidi snd_hda_intel snd_hda_controller
iwlwifi btusb snd_hda_codec bluetooth nls_iso8859_1 snd_hwdep snd_seq
snd_pcm joydev serio_raw cfg80211 6lowpan_iphc rtsx_pci_ms
snd_seq_device lpc_ich memstick snd_timer snd soundcore parport_pc
ppdev intel_smartconnect lp mac_hid parport dm_crypt rtsx_pci_sdmmc
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
aes_x86_64 lrw gf128mul glue_helper i915 ablk_helper cryptd psmouse
i2c_algo_bit e1000e drm_kms_helper ahci libahci drm rtsx_pci ptp
pps_core wmi video
[ 5802.489439] CPU: 2 PID: 615 Comm: kworker/u17:2 Tainted: G        W
    3.15.1-031501-generic #201406161841
[ 5802.489441] Hardware name: LENOVO 20AM009DMS/20AM009DMS, BIOS
GIET74WW (2.24 ) 05/13/2014
[ 5802.489449] Workqueue: hci0 hci_power_on [bluetooth]
[ 5802.489451]  0000000000000451 ffff8802314ebb48 ffffffff8176e144
0000000000000007
[ 5802.489453]  0000000000000000 ffff8802314ebb88 ffffffff8106ce2c
0000000000000000
[ 5802.489456]  ffff8802314ebc68 ffff8800a2b11a88 0000000000003a98
0000000000000005
[ 5802.489458] Call Trace:
[ 5802.489462]  [<ffffffff8176e144>] dump_stack+0x46/0x58
[ 5802.489464]  [<ffffffff8106ce2c>] warn_slowpath_common+0x8c/0xc0
[ 5802.489466]  [<ffffffff8106ce7a>] warn_slowpath_null+0x1a/0x20
[ 5802.489469]  [<ffffffff814c75ae>] _request_firmware+0x1be/0x1e0
[ 5802.489472]  [<ffffffff814c76cc>] request_firmware+0x3c/0x60
[ 5802.489476]  [<ffffffffa03f1c5c>]
btusb_setup_intel_get_fw+0x11c/0x160 [btusb]
[ 5802.489480]  [<ffffffffa03f2877>] btusb_setup_intel+0x127/0x450 [btusb]
[ 5802.489483]  [<ffffffff81572450>] ? usb_autopm_put_interface+0x30/0x40
[ 5802.489491]  [<ffffffffa0387fc5>] hci_dev_do_open+0x245/0x330 [bluetooth]
[ 5802.489500]  [<ffffffffa03880ee>] hci_power_on+0x3e/0x160 [bluetooth]
[ 5802.489503]  [<ffffffff8108935f>] process_one_work+0x17f/0x4c0
[ 5802.489505]  [<ffffffff8108a57b>] worker_thread+0x11b/0x3d0
[ 5802.489508]  [<ffffffff8108a460>] ? manage_workers.isra.21+0x190/0x190
[ 5802.489511]  [<ffffffff810913c9>] kthread+0xc9/0xe0
[ 5802.489513]  [<ffffffff81091300>] ? flush_kthread_worker+0xb0/0xb0
[ 5802.489516]  [<ffffffff817845bc>] ret_from_fork+0x7c/0xb0
[ 5802.489518]  [<ffffffff81091300>] ? flush_kthread_worker+0xb0/0xb0
[ 5802.489519] ---[ end trace 82f5306631f275d0 ]---
[ 5802.489522] bluetooth hci0: firmware: intel/ibt-hw-37.7.bseq will
not be loaded
[ 5802.489523] Bluetooth: hci0 failed to open default Intel fw file:
intel/ibt-hw-37.7.bseq
