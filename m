Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A751922F9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101302; cv=none; b=F326CjDUPG4wcB/xm2hgUPQsuC/GEB/ifKNB0bi6BSBIUFnlmGHN25nBYgeiHGPdsEsX1MN4uAd9es5xxm9BJpqcBvFhwU9lYZfkWvFWB+Pjd069Xrg2LH2Nub0Z1C/8DdQl/Dfp5DlJ8vZ5Wl+7cXfd6fvW3180e+3BiKbt4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101302; c=relaxed/simple;
	bh=sd2hZ19m3w6zeS6VNz/ngjXZDcL+GeHZR/J5MJlMTG4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sJ/hrS9vaL8PQiASmiqys7wMbbQHOrmfPyD5lOVPc2YK67xMEORa3dJcRbupnw69KVIf5y0vWANxPTX1Tcfcpe00GHd4RL6wi5hICxdqpr+tOfVv8MwIlbZSPQP1a4dZNBm5qYgd1uXXH4tb9LJOzZ4tku6WPdRd4GWLakj6SEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avLisv9u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avLisv9u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 771E5C4CEC7
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730101301;
	bh=sd2hZ19m3w6zeS6VNz/ngjXZDcL+GeHZR/J5MJlMTG4=;
	h=From:To:Subject:Date:From;
	b=avLisv9ueIW4KpwI1zex7PWiEM+yXZ396myAysrytHeIMuO/1zb9d33vL/TxMLBI2
	 J1TMxS+jk71K0VR78IqpBayGiJXAT/4KTBP4pZ0SqXL2BgsNT3SrA+9PtLNZmDfrqU
	 93h3Tatijxw0Q5nBpyFOj1jurgjPceL5PEwHBrC7LmMnyIwNcebAhS5esNuMWeq7lt
	 k7uk9L63SQqqyQlGiME2Uoj6lHI9OKMEQUda4OtbCXJxcrPlOlfTo+oB6BLDO9upQo
	 qqVHXoCU4H0/juYo7cTYimAJyKDfqKJRDNBlMHUSKl7u5kkrA1M7dcVn+aczDp8vrr
	 mRTrrhpHHxZcw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6430AC53BC2; Mon, 28 Oct 2024 07:41:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219433] New: RIP: 0010:btusb_suspend+0x1b/0x1d0 [btusb]
Date: Mon, 28 Oct 2024 07:41:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219433-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219433

            Bug ID: 219433
           Summary: RIP: 0010:btusb_suspend+0x1b/0x1d0 [btusb]
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Hello Kernel Team,

I notice today this:


[    8.592547] Bluetooth: hci0: Device setup in 3533529 usecs
[    8.592553] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[   10.689336] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[   10.689341] #PF: supervisor read access in kernel mode
[   10.689344] #PF: error_code(0x0000) - not-present page
[   10.689346] PGD 0 P4D 0
[   10.689351] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[   10.689355] CPU: 13 UID: 0 PID: 145 Comm: kworker/13:1 Not tainted
6.11.2-lowlatency-sunlight1 #1-NixOS=20
[   10.689361] Hardware name: ASUSTeK COMPUTER INC. ROG Zephyrus G14
GA401QM_GA401QM/GA401QM, BIOS GA401QM.415 08/11/2023
[   10.689363] Workqueue: pm pm_runtime_work
[   10.689371] RIP: 0010:btusb_suspend+0x1b/0x1d0 [btusb]
[   10.689380] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e =
fa
0f 1f 44 00 00 41 54 55 89 f5 53 48 8b 9f c8 00 00 00 0f 1f 44 00 00 <48> 8=
b 13
8b 82 bc 09 00 00 03 82 b8 09 00 00 03 82 c4 09 00 00 03
[   10.689383] RSP: 0018:ffffb8b08077fca0 EFLAGS: 00010206
[   10.689386] RAX: ffffffffc2959a50 RBX: 0000000000000000 RCX:
0000000000000003
[   10.689388] RDX: ffff9ace8d78d400 RSI: 0000000000000402 RDI:
ffff9ace80df3c00
[   10.689391] RBP: 0000000000000402 R08: 0000000000000000 R09:
0000000000000000
[   10.689393] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000402
[   10.689395] R13: 0000000000000003 R14: 0000000000000000 R15:
ffff9ace8e712000
[   10.689397] FS:  0000000000000000(0000) GS:ffff9ad54e880000(0000)
knlGS:0000000000000000
[   10.689400] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.689402] CR2: 0000000000000000 CR3: 00000006ec222000 CR4:
0000000000f50ef0
[   10.689404] PKRU: 55555554
[   10.689406] Call Trace:
[   10.689409]  <TASK>
[   10.689414]  ? __die+0x23/0x80
[   10.689423]  ? page_fault_oops+0x173/0x5b0
[   10.689434]  ? exc_page_fault+0x71/0x160
[   10.689441]  ? asm_exc_page_fault+0x26/0x30
[   10.689449]  ? __pfx_btusb_suspend+0x10/0x10 [btusb]
[   10.689455]  ? btusb_suspend+0x1b/0x1d0 [btusb]
[   10.689461]  usb_suspend_both+0x97/0x290
[   10.689467]  ? srso_alias_return_thunk+0x5/0xfbef5
[   10.689474]  usb_runtime_suspend+0x2e/0x80
[   10.689479]  ? __pfx_usb_runtime_suspend+0x10/0x10
[   10.689483]  __rpm_callback+0x44/0x170
[   10.689488]  ? __pfx_usb_runtime_suspend+0x10/0x10
[   10.689493]  rpm_callback+0x59/0x70
[   10.689497]  ? __pfx_usb_runtime_suspend+0x10/0x10
[   10.689501]  rpm_suspend+0xe8/0x5e0
[   10.689506]  ? srso_alias_return_thunk+0x5/0xfbef5
[   10.689511]  ? psi_task_switch+0x122/0x240
[   10.689516]  ? srso_alias_return_thunk+0x5/0xfbef5
[   10.689521]  ? finish_task_switch.isra.0+0x9c/0x310
[   10.689529]  __pm_runtime_suspend+0x3c/0xd0
[   10.689535]  ? __pfx_usb_runtime_idle+0x10/0x10
[   10.689539]  usb_runtime_idle+0x39/0x50
[   10.689543]  rpm_idle+0xc0/0x280
[   10.689548]  pm_runtime_work+0x84/0xb0
[   10.689554]  process_one_work+0x192/0x3b0
[   10.689560]  worker_thread+0x230/0x340
[   10.689563]  ? __pfx_worker_thread+0x10/0x10
[   10.689568]  ? __pfx_worker_thread+0x10/0x10
[   10.689571]  kthread+0xd0/0x100
[   10.689577]  ? __pfx_kthread+0x10/0x10
[   10.689582]  ret_from_fork+0x34/0x50
[   10.689587]  ? __pfx_kthread+0x10/0x10
[   10.689591]  ret_from_fork_asm+0x1a/0x30
[   10.689600]  </TASK>
[   10.689602] Modules linked in: xt_CHECKSUM xt_MASQUERADE ipt_REJECT
nf_reject_ipv4 nft_chain_nat af_packet input_leds xt_conntrack
snd_sof_amd_acp63 snd_sof_amd_vangogh snd_sof_amd_rembrandt ip6t_rpfilter
snd_sof_amd_renoir ipt_rpfilter snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_=
dsp
snd_usb_audio btusb mt7921e nls_iso8859_1 snd_sof btrtl nls_cp437 xt_pkttype
btintel mt7921_common vfat snd_usbmidi_lib btbcm btmtk snd_ump
snd_hda_codec_realtek fat mt792x_lib snd_sof_utils snd_rawmidi xt_LOG bluet=
ooth
hid_asus snd_seq_device nf_log_syslog mt76_connac_lib snd_hda_codec_generic
snd_pci_ps snd_hda_scodec_component snd_hda_codec_hdmi xt_tcpudp
snd_amd_sdw_acpi amdgpu nft_compat mt76 soundwire_amd
soundwire_generic_allocation nf_tables soundwire_bus nouveau sch_fq_codel
snd_soc_core mac80211 msr uinput snd_compress atkbd ac97_bus libps2
snd_pcm_dmaengine vivaldi_fmap snd_rpl_pci_acp6x loop edac_mce_amd edac_core
xt_nat snd_acp_pci nf_nat amd_atl intel_rapl_msr snd_acp_legacy_common
snd_hda_intel intel_rapl_common nf_conntrack
[   10.689706]  crct10dif_pclmul mxm_wmi snd_intel_dspcfg polyval_clmulni
joydev amdxcp drm_gpuvm snd_intel_sdw_acpi polyval_generic snd_hda_codec
mousedev snd_pci_acp6x ghash_clmulni_intel nf_defrag_ipv6 drm_exec sha512_s=
sse3
drm_buddy snd_hda_core asus_nb_wmi cfg80211 nf_defrag_ipv4 snd_pci_acp5x ee=
1004
sha256_ssse3 gpu_sched libcrc32c drm_suballoc_helper crc32c_generic asus_wmi
snd_hwdep sha1_ssse3 drm_ttm_helper br_netfilter platform_profile
snd_rn_pci_acp3x aesni_intel snd_pcm veth drm_display_helper gf128mul
snd_acp_config i8042 ucsi_acpi crypto_simd snd_soc_acpi tun i2c_piix4
hid_multitouch typec_ucsi snd_timer cryptd i2c_algo_bit sparse_keymap wmi_b=
mof
rfkill evdev mac_hid snd video rapl typec tiny_power_button libarc4 crc16
soundcore i2c_smbus k10temp snd_pci_acp3x thermal roles wmi ac battery butt=
on
backlight tpm_crb tap asus_wireless i2c_hid_acpi macvlan amd_pmc i2c_hid
tpm_tis led_class tpm_tis_core serio bridge stp llc kvm_amd ccp kvm fuse
efi_pstore configfs nfnetlink efivarfs tpm libaescfb ecdh_generic ecc
[   10.689836]  rng_core dmi_sysfs ip_tables x_tables autofs4 f2fs
crc32_generic lz4hc_compress lz4_compress hid_generic usbhid xhci_pci
xhci_pci_renesas nvme xhci_hcd nvme_core crc32_pclmul crc32c_intel nvme_auth
rtc_cmos dm_mod dax
[   10.689867] CR2: 0000000000000000
[   10.689870] ---[ end trace 0000000000000000 ]---
[   12.854962] RIP: 0010:btusb_suspend+0x1b/0x1d0 [btusb]
[   12.854967] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e =
fa
0f 1f 44 00 00 41 54 55 89 f5 53 48 8b 9f c8 00 00 00 0f 1f 44 00 00 <48> 8=
b 13
8b 82 bc 09 00 00 03 82 b8 09 00 00 03 82 c4 09 00 00 03
[   12.854969] RSP: 0018:ffffb8b08077fca0 EFLAGS: 00010206
[   12.854972] RAX: ffffffffc2959a50 RBX: 0000000000000000 RCX:
0000000000000003
[   12.854973] RDX: ffff9ace8d78d400 RSI: 0000000000000402 RDI:
ffff9ace80df3c00
[   12.854974] RBP: 0000000000000402 R08: 0000000000000000 R09:
0000000000000000
[   12.854975] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000402
[   12.854976] R13: 0000000000000003 R14: 0000000000000000 R15:
ffff9ace8e712000
[   12.854977] FS:  0000000000000000(0000) GS:ffff9ad54e880000(0000)
knlGS:0000000000000000
[   12.854979] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.854980] CR2: 0000000000000000 CR3: 0000000103768000 CR4:
0000000000f50ef0
[   12.854982] PKRU: 55555554
[   12.854983] note: kworker/13:1[145] exited with irqs disabled


# lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root
Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost
Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Brid=
ge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost
Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP
Bridge
00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP
Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost
Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe=
 GPP
Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 7
01:00.0 VGA compatible controller: NVIDIA Corporation GA106M [GeForce RTX 3=
060
Mobile / Max-Q] (rev a1)
01:00.1 Audio device: NVIDIA Corporation GA106 High Definition Audio Contro=
ller
(rev a1)
02:00.0 Network controller: MEDIATEK Corp. MT7921 802.11ax PCI Express Wire=
less
Network Adapter
03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD
Controller PM9A1/PM9A3/980PRO
04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c4)
04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon =
High
Definition Audio Controller
04:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 10h-1fh) Platform Security Processor
04:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne U=
SB
3.1
04:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne U=
SB
3.1
04:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
04:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD
Audio Controller

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
