Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89495C4332E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A0720637
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 18:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCWSql convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbgCWSqk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 14:46:40 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206515] Bluetooth drivers crashes the system randomly
Date:   Mon, 23 Mar 2020 18:46:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bgamari@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-206515-62941-GB7lzAgu3E@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206515-62941@https.bugzilla.kernel.org/>
References: <bug-206515-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206515

Ben Gamari (bgamari@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bgamari@gmail.com

--- Comment #3 from Ben Gamari (bgamari@gmail.com) ---
For what it's worth, I also see this periodically:

[1729857.264015] general protection fault: 0000 [#1] SMP PTI
[1729857.264034] CPU: 0 PID: 25043 Comm: kworker/u9:1 Not tainted 5.4.22
#1-NixOS
[1729857.264041] Hardware name: Dell Inc. Latitude E7470/0T6HHJ, BIOS 1.20.3
08/20/2018
[1729857.264088] Workqueue: hci0 hci_rx_work [bluetooth]
[1729857.264106] RIP: 0010:__wake_up_common+0xb3/0x140
[1729857.264118] Code: 16 4d 85 e4 74 24 83 c5 01 83 fd 40 7e 1c 49 8d 45 18 48
39 c3 75 70 8b 44 24 0c 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <49> 8b 55
18 49 8d 45 18 4c 89 ef 4c 8d 6a e8 48 39 c3 75 93 eb d7
[1729857.264127] RSP: 0018:ffff9e320351fca8 EFLAGS: 00010083
[1729857.264137] RAX: 0000000000000000 RBX: ffff9252d5f06408 RCX:
0000000000000000
[1729857.264143] RDX: 0000000000000001 RSI: 0000000000000046 RDI:
0000000000000046
[1729857.264148] RBP: 0000000000000001 R08: 0000000000000000 R09:
ffff9e320351fc38
[1729857.264153] R10: 0000000002f41000 R11: 0000000000000040 R12:
ffff9e320351fcf0
[1729857.264158] R13: dead0000000000e8 R14: 0000000000000000 R15:
0000000000000000
[1729857.264166] FS:  0000000000000000(0000) GS:ffff9252eda00000(0000)
knlGS:0000000000000000
[1729857.264172] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1729857.264178] CR2: 0000560495a27578 CR3: 000000079affc004 CR4:
00000000003606f0
[1729857.264185] DR0: 0000004200247d38 DR1: 000000420046dde8 DR2:
000000420046dde8
[1729857.264192] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000600
[1729857.264198] Call Trace:
[1729857.264220]  __wake_up_common_lock+0x7a/0xc0
[1729857.264235]  sock_def_wakeup+0x32/0x40
[1729857.264281]  l2cap_sock_teardown_cb+0x195/0x1f0 [bluetooth]
[1729857.264335]  l2cap_chan_del+0x45/0x2e0 [bluetooth]
[1729857.264392]  l2cap_recv_frame+0xec6/0x2a30 [bluetooth]
[1729857.264410]  ? __switch_to_asm+0x40/0x70
[1729857.264453]  hci_rx_work+0x326/0x350 [bluetooth]
[1729857.264467]  process_one_work+0x206/0x3c0
[1729857.264477]  worker_thread+0x2d/0x3e0
[1729857.264487]  ? process_one_work+0x3c0/0x3c0
[1729857.264497]  kthread+0x112/0x130
[1729857.264508]  ? kthread_park+0x80/0x80
[1729857.264518]  ret_from_fork+0x35/0x40
[1729857.264528] Modules linked in: sr_mod cdrom usb_storage snd_usb_audio
snd_usbmidi_lib snd_rawmidi snd_seq_device ftdi_sio usbserial cdc_acm hidp ctr
ccm rfcomm fuse nls_iso8859_1 nls_cp437 vfat fat af_packet cmac bnep msr
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic dell_wmi
wmi_bmof sparse_keymap ppdev mei_hdcp mei_wdt dell_laptop iTCO_wdt
ledtrig_audio watchdog intel_rapl_msr x86_pkg_temp_thermal intel_powerclamp
coretemp dell_smbios dell_wmi_descriptor crct10dif_pclmul dcdbas crc32_pclmul
ghash_clmulni_intel dell_smm_hwmon iwlmvm mac80211 deflate efi_pstore pstore
aesni_intel crypto_simd cryptd glue_helper intel_cstate libarc4 intel_uncore
btusb intel_rapl_perf btrtl btbcm iwlwifi psmouse btintel uvcvideo
videobuf2_vmalloc videobuf2_memops bluetooth serio_raw input_leds
videobuf2_v4l2 efivars led_class i915 videobuf2_common cfg80211 snd_soc_skl
evdev mousedev joydev mac_hid videodev rtsx_pci_ms memstick hid_multitouch
snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core
[1729857.264648]  snd_soc_acpi_intel_match snd_soc_acpi mc ecdh_generic ecc cec
thermal intel_xhci_usb_role_switch drm_kms_helper roles wmi snd_soc_core
snd_compress drm ac97_bus snd_pcm_dmaengine intel_gtt snd_hda_intel agpgart
parport_pc i2c_algo_bit fb_sys_fops snd_intel_nhlt parport video syscopyarea
snd_hda_codec sysfillrect e1000e sysimgblt backlight processor_thermal_device
battery snd_hda_core mei_me button intel_pmc_core i2c_i801 ptp mei i2c_core
intel_rapl_common snd_hwdep intel_soc_dts_iosf pps_core intel_pch_thermal
dell_rbtn int3400_thermal ac int3403_thermal acpi_pad acpi_thermal_rel
int340x_thermal_zone rfkill iptable_nat nf_nat xt_conntrack nf_conntrack
nf_defrag_ipv4 libcrc32c ip6t_rpfilter ipt_rpfilter ip6table_raw iptable_raw
xt_pkttype nf_log_ipv6 nf_log_ipv4 nf_log_common xt_LOG xt_tcpudp
ip6table_filter ip6_tables sch_fq_codel iptable_filter snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore loop cpufreq_powersave tun tap
macvlan bridge stp llc kvm_intel kvm
[1729857.264770]  irqbypass efivarfs ip_tables x_tables ipv6 nf_defrag_ipv6
crc_ccitt autofs4 ext4 crc32c_generic crc16 mbcache jbd2 hid_generic usbhid hid
rtsx_pci_sdmmc xhci_pci mmc_core ahci xhci_hcd libahci atkbd libps2 libata
usbcore nvme scsi_mod nvme_core crc32c_intel rtsx_pci usb_common i8042 rtc_cmos
serio dm_mod
[1729857.264838] ---[ end trace 6fd73ddd13890ee9 ]---
[1729858.493615] RIP: 0010:__wake_up_common+0xb3/0x140
[1729858.493619] Code: 16 4d 85 e4 74 24 83 c5 01 83 fd 40 7e 1c 49 8d 45 18 48
39 c3 75 70 8b 44 24 0c 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <49> 8b 55
18 49 8d 45 18 4c 89 ef 4c 8d 6a e8 48 39 c3 75 93 eb d7
[1729858.493621] RSP: 0018:ffff9e320351fca8 EFLAGS: 00010083
[1729858.493623] RAX: 0000000000000000 RBX: ffff9252d5f06408 RCX:
0000000000000000
[1729858.493624] RDX: 0000000000000001 RSI: 0000000000000046 RDI:
0000000000000046
[1729858.493625] RBP: 0000000000000001 R08: 0000000000000000 R09:
ffff9e320351fc38
[1729858.493626] R10: 0000000002f41000 R11: 0000000000000040 R12:
ffff9e320351fcf0
[1729858.493627] R13: dead0000000000e8 R14: 0000000000000000 R15:
0000000000000000
[1729858.493628] FS:  0000000000000000(0000) GS:ffff9252eda00000(0000)
knlGS:0000000000000000
[1729858.493630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1729858.493631] CR2: 0000560495a27578 CR3: 000000079affc004 CR4:
00000000003606f0
[1729858.493632] DR0: 0000004200247d38 DR1: 000000420046dde8 DR2:
000000420046dde8
[1729858.493633] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000600

-- 
You are receiving this mail because:
You are the assignee for the bug.
