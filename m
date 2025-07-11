Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE113D531
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245929; cv=none; b=SwcatKgZ7sNJhW8zBm8ZyuaPHyTDK6SOYb2+mv/Xh7XpYapCbE7/5K+OWkpJcm+vCtIra/n7ZZmwSr81gQqGfuJrDs1flF/3Z/UQv00roxeczTa+WvU4EPff3q272seU2oydNk8Ee2oK3L6YMKQi73rSpDkCxRPQXx5JlMm77uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245929; c=relaxed/simple;
	bh=t+BuUHwoDNCKSQAjLKv7XMmZycgWcfZa6HD5WCg0zt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+6GsVcCGaW+jMJ8B5QMTNZhJIDczCxoE1CWgdDdh+9AN9B8Cuc4RDEyMOxSRD322Ud/KEvJL2IQ5U8Bhg6sjjPTlJbw7cMfYIMN2zbOxNaeYYRLQJkawGZNXrANO5aAh/u0TOUe426RBW77dDwR13gkdARn5VJuJWZr9dTafh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdxH8ZPU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdxH8ZPU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4C3BC4CEED
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752245928;
	bh=t+BuUHwoDNCKSQAjLKv7XMmZycgWcfZa6HD5WCg0zt4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZdxH8ZPU1pMDslJpAuRI+hCNVe7XHn6zfC00EvP+pYhYdhaSGJOKygh9ItMUGemNz
	 7CHWKk/sNNo8IPsiEGMb7l9UY8PBiU9jPRSo3y97Zbhna4KQODQBpIhnpIOZNOkz7C
	 CLl3G4yOVFiyzaVcYJ9+y6MhX2xwirycwUI3SpzLkWa7Zv73SMc53HjaUP6OZ9xvPL
	 xHo/XE8Hd+9HezoS5eUtlQzhPl+7fkdLgktHtnIcSh4BGjwKCL4xFi7Fom6GTzgnMO
	 znr0ilIoWwJd0LwgCHHj9poJ0c5f8XzOOFeEKb/8mUTfURv0I97B9nj3N3dX+rGDsR
	 Kc9nRqZdaoqMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C2AF3C4160E; Fri, 11 Jul 2025 14:58:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] bluetooth and wireplumber stop working after some time
 - dmesg report BUG
Date: Fri, 11 Jul 2025 14:58:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218952-62941-WASq9flcKC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218952-62941@https.bugzilla.kernel.org/>
References: <bug-218952-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218952

Martin Hignett (martin@hignett.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |martin@hignett.net

--- Comment #5 from Martin Hignett (martin@hignett.net) ---
I am having similar issues with bluetooth falling over. This has happened
several times in the last week on a new ThinkPad X1 Carbon Gen 13 laptop. E=
ach
time about 40 minutes into a video call.

This is the relevant part of my dmesg log

[Fri Jul 11 14:41:40 2025] [  T15110] BTRFS info (device dm-1): qgroup scan
completed (inconsistency flag cleared)
[Fri Jul 11 14:43:30 2025] [   T1966] Bluetooth: hci0: Received hw exception
interrupt
[Fri Jul 11 14:43:30 2025] [  T15346] Bluetooth: hci0: 00000000: ff 32 87 8=
0 03
01 01 01 03 01 05 0d 02 00 06 0e
[Fri Jul 11 14:43:30 2025] [  T15346] Bluetooth: hci0: 00000010: 01 00 05 1=
4 0e
1e 00 10 fa 53 06 b0 00 00 00 00
[Fri Jul 11 14:43:30 2025] [  T15346] Bluetooth: hci0: 00000020: 00 00 00 0=
0 00
00 00 00 fa 04 00 00 00 00 40 04
[Fri Jul 11 14:43:30 2025] [  T15346] Bluetooth: hci0: 00000030: 10 00 00 00
[Fri Jul 11 14:43:30 2025] [  T15346] Bluetooth: hci0: 00000000: 10 01 0a
[Fri Jul 11 14:43:30 2025] [  T15892] Bluetooth: hci0: Hardware error 0x0a
[Fri Jul 11 14:43:33 2025] [  T15590] Bluetooth: hci0: No alive interrupt
received for hci_reset
[Fri Jul 11 14:43:33 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:33 2025] [  T15892] Bluetooth: hci0: Reset after hardware
error failed (-62)
[Fri Jul 11 14:43:36 2025] [  T15590] Bluetooth: hci0: No alive interrupt
received for hci_reset
[Fri Jul 11 14:43:36 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:36 2025] [  T15892] Bluetooth: hci0: HCI reset during
shutdown failed
[Fri Jul 11 14:43:36 2025] [  T15590] Bluetooth: hci0: command tx timeout
[Fri Jul 11 14:43:36 2025] [   T3077] ------------[ cut here ]------------
[Fri Jul 11 14:43:36 2025] [   T3077] workqueue: cannot queue hci_tx_work
[bluetooth] on wq hci0
[Fri Jul 11 14:43:36 2025] [   T3077] WARNING: CPU: 7 PID: 3077 at
kernel/workqueue.c:2257 __queue_work+0x428/0x430
[Fri Jul 11 14:43:36 2025] [   T3077] Modules linked in: uinput usblp
snd_seq_dummy snd_hrtimer rfcomm snd_seq af_packet nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reje=
ct
nft_ct nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_=
ipv4
iptable_mangle iptable_raw iptable_security ip6table_filter ip6_tables qrtr
cmac algif_hash algif_skcipher af_alg bnep nf_tables nfnetlink iptable_filt=
er
binfmt_misc snd_soc_rt712_sdca snd_soc_rt1318_sdw regmap_sdw_mbq regmap_sdw
snd_soc_dmic snd_sof_pci_intel_lnl snd_sof_pci_intel_mtl
snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt
snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink
snd_sof_intel_hda snd_hda_codec_hdmi soundwire_cadence snd_sof_pci
snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks
soundwire_generic_allocation snd_soc_acpi soundwire_bus snd_soc_sdca
snd_soc_core
[Fri Jul 11 14:43:36 2025] [   T3077]  snd_compress snd_pcm_dmaengine
intel_uncore_frequency crc8 intel_uncore_frequency_common snd_hda_intel
processor_thermal_device_pci snd_usb_audio x86_pkg_temp_thermal
snd_intel_dspcfg processor_thermal_device intel_powerclamp iwlmld
snd_usbmidi_lib snd_intel_sdw_acpi processor_thermal_wt_hint coretemp
snd_hda_codec snd_ump mac80211 uvcvideo processor_thermal_rfim r8153_ecm
kvm_intel snd_hda_core snd_rawmidi libarc4 videobuf2_vmalloc spi_nor
intel_rapl_msr processor_thermal_rapl snd_ctl_led cdc_ether btintel_pcie
snd_hwdep snd_seq_device kvm uvc mei_gsc_proxy mtd intel_rapl_common iwlwifi
usbnet btintel think_lmi thinkpad_acpi snd_pcm irqbypass videobuf2_memops
processor_thermal_wt_req pcspkr r8152 spi_intel_pci mei_me cfg80211 bluetoo=
th
platform_profile snd_timer firmware_attributes_class wmi_bmof videobuf2_v4l2
processor_thermal_power_floor mii tiny_power_button spi_intel mei thunderbo=
lt
intel_pmc_core rfkill crc16 snd int3403_thermal videobuf2_common
processor_thermal_mbox videodev intel_hid libphy
[Fri Jul 11 14:43:36 2025] [   T3077]  thermal int3400_thermal button fan
pmt_telemetry soundcore soc_button_array int340x_thermal_zone ac sparse_key=
map
mc acpi_tad acpi_pad acpi_thermal_rel pmt_class joydev fuse loop efi_pstore
nvme_fabrics configfs ip_tables x_tables dm_crypt essiv authenc trusted
asn1_encoder tee sr_mod cdrom hid_logitech_hidpp hid_logitech_dj uas
usb_storage sd_mod scsi_dh_emc scsi_dh_rdac usbhid scsi_dh_alua sg scsi_mod
scsi_common xe drm_ttm_helper ttm nls_iso8859_1 polyval_clmulni i2c_algo_bit
nls_cp437 polyval_generic drm_suballoc_helper vfat ghash_clmulni_intel
drm_buddy fat sha512_ssse3 gpu_sched sha256_ssse3 hid_multitouch drm_gpuvm
sha1_ssse3 drm_exec hid_generic nvme aesni_intel drm_gpusvm ucsi_acpi
typec_ucsi crypto_simd nvme_core drm_display_helper xhci_pci i2c_hid_acpi r=
oles
cryptd video intel_lpss_pci nvme_keyring xhci_hcd cec intel_lpss i2c_hid
battery typec wmi pinctrl_intel_platform nvme_auth usbcore intel_vpu rc_core
idma64 intel_vsec serio_raw btrfs blake2b_generic xor raid6_pq dm_mod msr
i2c_dev efivarfs
[Fri Jul 11 14:43:36 2025] [   T3077]  dmi_sysfs
[Fri Jul 11 14:43:36 2025] [   T3077] CPU: 7 UID: 1000 PID: 3077 Comm:
data-loop.0 Not tainted 6.15.5-1-default #1 PREEMPT(voluntary) openSUSE
Tumbleweed  28b123572e8ac77e02fe7d437ecda8584e6863fe
[Fri Jul 11 14:43:36 2025] [   T3077] Hardware name: LENOVO
21NSCTO1WW/21NSCTO1WW, BIOS N4BET64W (1.34 ) 04/22/2025
[Fri Jul 11 14:43:36 2025] [   T3077] RIP: 0010:__queue_work+0x428/0x430
[Fri Jul 11 14:43:36 2025] [   T3077] Code: ce 8f fd ff 0f 0b e9 a8 fc ff f=
f 48
8b 73 18 49 8d 94 24 c0 00 00 00 48 c7 c7 90 ce 46 9e c6 05 9d 86 f5 01 01 =
e8
a8 8f fd ff <0f> 0b e9 ba fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90
[Fri Jul 11 14:43:36 2025] [   T3077] RSP: 0018:ffffccfd0de7b9f8 EFLAGS:
00010046
[Fri Jul 11 14:43:36 2025] [   T3077] RAX: 0000000000000000 RBX:
ffff89a3e8d086f0 RCX: 0000000000000027
[Fri Jul 11 14:43:36 2025] [   T3077] RDX: ffff89aaff99fac8 RSI:
0000000000000001 RDI: ffff89aaff99fac0
[Fri Jul 11 14:43:36 2025] [   T3077] RBP: ffff89a3c7c00400 R08:
0000000000000000 R09: 00000000ffffbfff
[Fri Jul 11 14:43:36 2025] [   T3077] R10: ffffffff9f8b1120 R11:
ffffccfd0de7b8a0 R12: ffff89a3c74fba00
[Fri Jul 11 14:43:36 2025] [   T3077] R13: 0000000000002000 R14:
ffff89a3c74fba00 R15: 0000000000004040
[Fri Jul 11 14:43:36 2025] [   T3077] FS:  00007fae0d4256c0(0000)
GS:ffff89ab60174000(0000) knlGS:0000000000000000
[Fri Jul 11 14:43:36 2025] [   T3077] CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[Fri Jul 11 14:43:36 2025] [   T3077] CR2: 00007f293678ffe0 CR3:
0000000246eaf002 CR4: 0000000000f72ef0
[Fri Jul 11 14:43:36 2025] [   T3077] PKRU: 55555554
[Fri Jul 11 14:43:36 2025] [   T3077] Call Trace:
[Fri Jul 11 14:43:36 2025] [   T3077]  <TASK>
[Fri Jul 11 14:43:36 2025] [   T3077]  queue_work_on+0x73/0x80
[Fri Jul 11 14:43:36 2025] [   T3077]  sco_sock_sendmsg+0x2c1/0x350 [blueto=
oth
a31b217d1c321b05fbefe6b514c3f8335ab856d9]
[Fri Jul 11 14:43:36 2025] [   T3077]  __sys_sendto+0x1d6/0x1e0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? __seccomp_filter+0x33/0x4b0
[Fri Jul 11 14:43:36 2025] [   T3077]  __x64_sys_sendto+0x24/0x30
[Fri Jul 11 14:43:36 2025] [   T3077]  do_syscall_64+0x7b/0x820
[Fri Jul 11 14:43:36 2025] [   T3077]  ? __schedule+0x3f3/0x13d0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? __wake_up_common+0x6f/0xa0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? ep_done_scan+0xe7/0x130
[Fri Jul 11 14:43:36 2025] [   T3077]  ? ep_send_events+0x291/0x2e0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? ep_poll_callback+0x192/0x2c0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? __wake_up_common+0x6f/0xa0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? eventfd_read+0xe0/0x230
[Fri Jul 11 14:43:36 2025] [   T3077]  ? security_file_permission+0x50/0xf0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? vfs_read+0x271/0x350
[Fri Jul 11 14:43:36 2025] [   T3077]  ? ksys_read+0x9f/0xe0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? syscall_exit_to_user_mode+0x37/0x1=
c0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? do_syscall_64+0x87/0x820
[Fri Jul 11 14:43:36 2025] [   T3077]  ? syscall_exit_to_user_mode+0x37/0x1=
c0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? do_syscall_64+0x87/0x820
[Fri Jul 11 14:43:36 2025] [   T3077]  ? __irq_exit_rcu+0x3d/0xe0
[Fri Jul 11 14:43:36 2025] [   T3077]  ? irqentry_exit_to_user_mode+0x2c/0x=
1c0
[Fri Jul 11 14:43:36 2025] [   T3077]  entry_SYSCALL_64_after_hwframe+0x76/=
0x7e
[Fri Jul 11 14:43:36 2025] [   T3077] RIP: 0033:0x7fae106a30b2
[Fri Jul 11 14:43:36 2025] [   T3077] Code: 08 0f 85 8f 38 ff ff 49 89 fb 4=
8 89
f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 =
5c
24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 9=
0 90
[Fri Jul 11 14:43:36 2025] [   T3077] RSP: 002b:00007fae0d424858 EFLAGS:
00000246 ORIG_RAX: 000000000000002c
[Fri Jul 11 14:43:36 2025] [   T3077] RAX: ffffffffffffffda RBX:
0000000000000078 RCX: 00007fae106a30b2
[Fri Jul 11 14:43:36 2025] [   T3077] RDX: 000000000000003c RSI:
000055d71208ebd0 RDI: 000000000000005d
[Fri Jul 11 14:43:36 2025] [   T3077] RBP: 000055d71208ebd0 R08:
0000000000000000 R09: 0000000000000000
[Fri Jul 11 14:43:36 2025] [   T3077] R10: 0000000000004040 R11:
0000000000000246 R12: 000055d7121347a0
[Fri Jul 11 14:43:36 2025] [   T3077] R13: 000000000000003c R14:
000000000000003c R15: 000055d71208ebd0
[Fri Jul 11 14:43:36 2025] [   T3077]  </TASK>
[Fri Jul 11 14:43:36 2025] [   T3077] ---[ end trace 0000000000000000 ]---
[Fri Jul 11 14:43:37 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:37 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:37 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:37 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:38 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:38 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:38 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:38 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:39 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:39 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:39 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:39 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:40 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:40 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:40 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:40 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:52 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:52 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:52 2025] [  T15892] Bluetooth: hci0: Opcode 0x0c03 failed:
-62
[Fri Jul 11 14:43:52 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:43:52 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:43:52 2025] [  T15892] Bluetooth: hci0: Failed to read MSFT
supported features (-62)
[Fri Jul 11 14:46:16 2025] [  T15590] Bluetooth: hci0: Failed to send frame
(-62)
[Fri Jul 11 14:46:16 2025] [  T15590] Bluetooth: hci0: sending frame failed
(-62)
[Fri Jul 11 14:46:16 2025] [  T15892] Bluetooth: hci0: Opcode 0x0c03 failed:
-62
[Fri Jul 11 14:46:16 2025] [  T15892] Bluetooth: hci0: MSFT extension not
registered


The laptop is branch new so I can't say if this is a regression or just
something about the hardware in this laptop.=20

I'm not sure how much use this will be, but lspci -k shows

martin@localhost:~> lspci -k
00:00.0 Host bridge: Intel Corporation Device 6400 (rev 04)
        Subsystem: Lenovo Device 2339
00:02.0 VGA compatible controller: Intel Corporation Lunar Lake [Intel Arc
Graphics 130V / 140V] (rev 04)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: xe
        Kernel modules: xe
00:04.0 Signal processing controller: Intel Corporation Device 641d (rev 04)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: proc_thermal_pci
        Kernel modules: processor_thermal_device_pci
00:07.0 PCI bridge: Intel Corporation Lunar Lake-M Thunderbolt 4 PCI Express
Root Port #0 (rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: pcieport
00:07.2 PCI bridge: Intel Corporation Lunar Lake-M Thunderbolt 4 PCI Express
Root Port #2 (rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: pcieport
00:0a.0 Signal processing controller: Intel Corporation Device 647d (rev 04)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: intel_vsec
        Kernel modules: intel_vsec
00:0b.0 Processing accelerators: Intel Corporation Lunar Lake NPU (rev 04)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: intel_vpu
        Kernel modules: intel_vpu
00:0d.0 USB controller: Intel Corporation Lunar Lake-M Thunderbolt 4 USB
Controller (rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci
00:0d.2 USB controller: Intel Corporation Lunar Lake-M Thunderbolt 4 NHI #0
(rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: thunderbolt
        Kernel modules: thunderbolt
00:0d.3 USB controller: Intel Corporation Lunar Lake-M Thunderbolt 4 NHI #1
(rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: thunderbolt
        Kernel modules: thunderbolt
00:13.0 Communication controller: Intel Corporation Device a862 (rev 10)
        Subsystem: Lenovo Device 2339
00:14.0 USB controller: Intel Corporation Lunar Lake-M USB 3.2 Gen 2x1 xHCI
Host Controller (rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci
00:14.2 RAM memory: Intel Corporation Device a87f (rev 10)
        Subsystem: Lenovo Device 2339
00:14.3 Network controller: Intel Corporation BE201 320MHz (rev 10)
        Subsystem: Intel Corporation Device 00e0
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi
00:14.7 Bluetooth: Intel Corporation Device a876 (rev 10)
        Subsystem: Intel Corporation Device 000e
        Kernel driver in use: btintel_pcie
        Kernel modules: btintel_pcie
00:15.0 Serial bus controller: Intel Corporation Lunar Lake-M Serial IO I2C
Controller #0 (rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: intel-lpss
        Kernel modules: intel_lpss_pci
00:15.3 Serial bus controller: Intel Corporation Lunar Lake-M Serial IO I2C
Controller #3 (rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: intel-lpss
        Kernel modules: intel_lpss_pci
00:16.0 Communication controller: Intel Corporation Device a870 (rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: mei_me
        Kernel modules: mei_me
00:1c.0 PCI bridge: Intel Corporation Lunar Lake-M PCI Express Root Port #1
(rev 10)
        Kernel driver in use: pcieport
00:1c.4 PCI bridge: Intel Corporation Lunar Lake-M PCI Express Root Port #5
(rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: pcieport
00:1f.0 ISA bridge: Intel Corporation Device a807 (rev 10)
        Subsystem: Lenovo Device 2339
00:1f.3 Multimedia audio controller: Intel Corporation Lunar Lake-M HD Audio
Controller (rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: sof-audio-pci-intel-lnl
        Kernel modules: snd_hda_intel, snd_sof_pci_intel_lnl
00:1f.4 SMBus: Intel Corporation Lunar Lake-M SMbus Controller (rev 10)
        Subsystem: Lenovo Device 2339
00:1f.5 Serial bus controller: Intel Corporation Lunar Lake-M SPI Controller
(rev 10)
        Subsystem: Lenovo Device 2339
        Kernel driver in use: intel-spi
        Kernel modules: spi_intel_pci
04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a=
810
        Subsystem: Samsung Electronics Co Ltd Device a801
        Kernel driver in use: nvme
        Kernel modules: nvme
20:00.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C step)
[Alpine Ridge 4C 2016] (rev 02)
        Subsystem: Device 1d2d:d01e
        Kernel driver in use: pcieport
21:01.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C step)
[Alpine Ridge 4C 2016] (rev 02)
        Subsystem: Device 1d2d:d01e
        Kernel driver in use: pcieport
21:02.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C step)
[Alpine Ridge 4C 2016] (rev 02)
        Subsystem: Device 1d2d:d01e
        Kernel driver in use: pcieport
21:03.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C step)
[Alpine Ridge 4C 2016] (rev 02)
        Subsystem: Device 1d2d:d01e
        Kernel driver in use: pcieport
21:04.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C step)
[Alpine Ridge 4C 2016] (rev 02)
        Subsystem: Device 1d2d:d01e
        Kernel driver in use: pcieport
22:00.0 USB controller: ASMedia Technology Inc. ASM1142 USB 3.1 Host Contro=
ller
        Subsystem: Device 1d2d:f032
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci
23:00.0 USB controller: Fresco Logic FL1100 USB 3.0 Host Controller (rev 10)
        Subsystem: Device 1d2d:f030
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci
24:00.0 USB controller: Fresco Logic FL1100 USB 3.0 Host Controller (rev 10)
        Subsystem: Device 1d2d:f031
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci

Let me know if you need more information.

Thanks!

Martin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
