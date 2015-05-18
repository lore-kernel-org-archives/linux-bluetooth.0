Return-Path: <cyrus@holtmann.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 81821] btusb logs error drivers/base/firmware_class.c:1105
 _request_firmware+0x431/0x7b0()
Date: Mon, 18 May 2015 20:06:07 +0000
Message-ID: <bug-81821-62941-4emy6fECEh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-81821-62941@https.bugzilla.kernel.org/>
References: <bug-81821-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=81821

Michael Lipp <mnl@mnl.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mnl@mnl.de

--- Comment #8 from Michael Lipp <mnl@mnl.de> ---
Okay, here's my trace.

[  167.502444] ------------[ cut here ]------------
[  167.502455] WARNING: CPU: 6 PID: 3864 at drivers/base/firmware_class.c:1126
_request_firmware+0x558/0x810()
[  167.502547] Modules linked in: rfcomm fuse hidp ccm xt_CHECKSUM
ipt_MASQUERADE nf_nat_masquerade_ipv4 tun nf_conntrack_netbios_ns
nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack
ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_nat
nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security
iptable_raw bnep intel_rapl arc4 iosf_mbi x86_pkg_temp_thermal uvcvideo
snd_hda_codec_realtek coretemp iwldvm snd_hda_codec_generic kvm_intel
videobuf2_vmalloc mac80211 kvm btusb snd_hda_intel videobuf2_core iTCO_wdt
iTCO_vendor_support bluetooth snd_hda_controller videobuf2_memops snd_hda_codec
[  167.502549]  v4l2_common videodev snd_hwdep crct10dif_pclmul snd_seq iwlwifi
crc32_pclmul snd_seq_device crc32c_intel sdhci_pci snd_pcm cfg80211
ghash_clmulni_intel sdhci media cdc_acm thinkpad_acpi joydev mmc_core snd_timer
serio_raw i2c_i801 snd mei_me lpc_ich tpm_tis mei mfd_core shpchp
[  167.502583] PM: Finishing wakeup.
[  167.502589] Restarting tasks ... 
[  167.502589]  soundcore rfkill tpm wmi intel_rst binfmt_misc i915
i2c_algo_bit drm_kms_helper e1000e drm cdc_mbim firewire_ohci cdc_ncm
firewire_core usbnet ptp cdc_wdm crc_itu_t pps_core mii video [last unloaded:
ipmi_msghandler]
[  167.502618] CPU: 6 PID: 3864 Comm: kworker/u17:0 Not tainted
3.19.7-200.fc21.x86_64 #1
[  167.502622] Hardware name: LENOVO 24297XG/24297XG, BIOS G4ETA4WW (2.64 )
03/31/2015
[  167.502648] Workqueue: hci0 hci_power_on [bluetooth]
[  167.502652]  0000000000000000 00000000ccb2203a ffff88021343fb78
ffffffff8176f1f7
[  167.502658]  0000000000000000 0000000000000000 ffff88021343fbb8
ffffffff8109bc1a
[  167.502676]  0000000000000000 ffff88021343fcd0 00000000fffffff5
ffff880213e829c0
[  167.502680] Call Trace:
[  167.502687]  [<ffffffff8176f1f7>] dump_stack+0x45/0x57
[  167.502694]  [<ffffffff8109bc1a>] warn_slowpath_common+0x8a/0xc0
[  167.502698]  [<ffffffff8109bd4a>] warn_slowpath_null+0x1a/0x20
[  167.502703]  [<ffffffff814dc7d8>] _request_firmware+0x558/0x810
[  167.502708]  [<ffffffff814dcac5>] request_firmware+0x35/0x50
[  167.502715]  [<ffffffffa0365886>] btusb_setup_bcm_patchram+0x86/0x590
[btusb]
[  167.502720]  [<ffffffff814d4a46>] ? rpm_idle+0xd6/0x230
[  167.502726] usb 1-4: USB disconnect, device number 2
[  167.502742]  [<ffffffffa0511801>] hci_dev_do_open+0xe1/0xa90 [bluetooth]
[  167.502748]  [<ffffffff810c525d>] ? ttwu_do_activate.constprop.90+0x5d/0x70
[  167.502766]  [<ffffffffa0512980>] hci_power_on+0x40/0x200 [bluetooth]
[  167.502775]  [<ffffffff810b48fc>] process_one_work+0x14c/0x3f0
[  167.502781]  [<ffffffff810b5373>] worker_thread+0x53/0x470
[  167.502787]  [<ffffffff810b5320>] ? rescuer_thread+0x300/0x300
[  167.502793]  [<ffffffff810ba5c8>] kthread+0xd8/0xf0
[  167.502798]  [<ffffffff810ba4f0>] ? kthread_create_on_node+0x1b0/0x1b0
[  167.502806]  [<ffffffff81775958>] ret_from_fork+0x58/0x90
[  167.502811]  [<ffffffff810ba4f0>] ? kthread_create_on_node+0x1b0/0x1b0
[  167.502815] ---[ end trace 0db0055f5709df7f ]---
[  167.502820] bluetooth hci0: firmware: brcm/BCM20702A0-0a5c-21e6.hcd will not
be loaded
[  167.502828] Bluetooth: hci0: BCM: patch brcm/BCM20702A0-0a5c-21e6.hcd not
found

-- 
You are receiving this mail because:
You are the assignee for the bug.
