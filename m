Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351144;
	b=yHmsqfjaHEaardhs958LGgWRhZizIBRO090e6yEl+qXi4C0ZF8mqhGlmJVQY72LVb5wI
	 JMbKpLQjwDg+nzCImnJFYSKTbPrdZ5YmCzNZ5nTPoSrdAJ3ZH1abXc+Brut5bGQasTeDa
	 VK1tpzxQWgI1L3B0L8riS9ZARfYt6QKghXjoZAAHw8uM+W0tJhTzfuVaXChjKc9qndyag
	 iI28AZSgTZMzR+hUZcWjJEmbCStHrkO4r0sJkiAtyyHKAP2OuOaCwPcSSV9tMGyYTwuSF
	 NN3dri3VxdHjLqmr7/aScxuLliww3vARN/1IMmyk5BgoQ57aQkOoP+AN42Q64GfspkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351144;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=JoL/jOoPDIOGx8itzXUjLEeui0Cxk3PuFvg0KEYtyaw=;
	b=ILgc4Noawens8xAKW51R/polyhPWjfcJjySUqhU0/9cNW0eSpQtLBXK1OUVJwnVLTw9U
	 I1AVS/dqPCpwIzfyq9JdP7/KGQD3qQtSdWaikNMjaXuZ92T0bfkOsM8TtfCn2ZpPhgPdh
	 gAbG467kRkj5AaDlhocneLNBsjGFfAEz8FUGwNp93EDPBTkwPlDtR/e17Fq6q7hEJ5zfK
	 YDGZ0M0pRHkepOKlziD6LZunTQlCZJvTAuCsj9cjHuPrij/jDrU6wOkK8p/j1vL6dj+rK
	 PYQg+lbGWRFen1abHpnQeuO7y1sPUWGo5seJSMscVa0Z/ecaM2WlwfS/7ItiT+MgwPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbjuAYB8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834EA606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbjuAYB8
Received: by smtp.kernel.org (Postfix) with ESMTPS id 272191F0093D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351144;
	bh=JoL/jOoPDIOGx8itzXUjLEeui0Cxk3PuFvg0KEYtyaw=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=TbjuAYB8u98DpelpW42/o1Vwib/dCDk80iqfMe/bE4nztSqIrb8yv/j+nL6XBIuQa
	 Ij+neKy0qVt16Zq7XaLnP7GxujZjpzUvjCF4TUPI5PRHZN/zq6Vx/RtND/V0h+Cgpj
	 auSNFvf7QsLH3EhYkIzGoj7000FIlM70jHBjFHzHHnluXN8qp47u2T0FqrB2a0TG/V
	 /vTfpPgOTXGt+L1Z+UKSxRUs3S61CaxKMS+ATKYSSd0UXoV2ghF5u/hERdA+BY0no3
	 Ey8RPip3hWsjwrRcMlQjvoNRUu7dHd/QPv+OLpWy2ohz4oJgTbLOx/BaeaR+r6Ds8L
	 0XP2hBPi5BPfA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 182F0C41613; Tue, 10 Nov 2026 22:52:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222250] v7.4-rc2: Bluetooth: hci0: Opcode 0x041a failed: -22
Date: Tue, 10 Nov 2026 22:52:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fgbreel@posteo.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222250-62941-430dgeyx2Z@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222250-62941@https.bugzilla.kernel.org/>
References: <bug-222250-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222250

--- Comment #2 from Gabriel Francisco (fgbreel@posteo.com) ---
I just got the time to finish bisecting and this is the result:

git bisect start
# status: waiting for both good and bad commits
# good: [6628e7d4c6b25c8d18f1345e3a20d21829aae7e4] Linux 7.4-rc1
git bisect good 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
# status: waiting for bad commit, 1 good commit known
# bad: [7475ea8b58616b33c04afb976cf0fbaad9dd63fb] Linux 7.4-rc2
git bisect bad 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
# good: [f66469d9905b39d2c260a15d7d6db450f4db67c1] Merge tag 'net-7.4-rc2' =
of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good f66469d9905b39d2c260a15d7d6db450f4db67c1
# good: [543b7d2ca09b4b08d518d668ac2fdc361f231785] Merge tag
'drm-fixes-2026-11-07' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 543b7d2ca09b4b08d518d668ac2fdc361f231785
# good: [a41e364995bbcfa627418a70fe913c35b7510728] Merge tag 'scsi-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good a41e364995bbcfa627418a70fe913c35b7510728
# good: [2ebb9de23bbd942b1a2431384e4a62908c31bb2a] Merge tag
'sched-urgent-2026-11-08' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 2ebb9de23bbd942b1a2431384e4a62908c31bb2a
# good: [2651f6deb3326129a052897df193052dc28ea94f] Merge tag 'mips-fixes_7.=
4_1'
of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good 2651f6deb3326129a052897df193052dc28ea94f
# good: [a4845f077415ef32fe672c841e2fc58ae9e28273] ata: libata-scsi: reject
data-in commands with a data-out buffer
git bisect good a4845f077415ef32fe672c841e2fc58ae9e28273
# good: [8a65162514fbad21a2c58ffed65f42b27e92b163] Merge tag
'driver-core-7.4-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core
git bisect good 8a65162514fbad21a2c58ffed65f42b27e92b163
# good: [bcd347f31e84ecfb1e45be488b1c7c835b8feb4c] coccinelle: kmalloc_obj:
Include devm_kmalloc_obj conversion rules
git bisect good bcd347f31e84ecfb1e45be488b1c7c835b8feb4c
# bad: [e0d8e8de8bcb1ef7b749033b5af5518ba8df7bec] Merge tag
'devm_kmalloc_obj-v7.4-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect bad e0d8e8de8bcb1ef7b749033b5af5518ba8df7bec
# bad: [4dd10fbbeb9c33709edc89916e19c03c780a0751] treewide: Convert
devm_kmalloc() family to the devm_kmalloc_obj() family
git bisect bad 4dd10fbbeb9c33709edc89916e19c03c780a0751
# first bad commit: [4dd10fbbeb9c33709edc89916e19c03c780a0751] treewide:
Convert devm_kmalloc() family to the devm_kmalloc_obj() family


I also booted v7.4-rc2 once more to double check and this time I got a kern=
el
oops with a bit more info:

[   15.592533] BUG: kernel NULL pointer dereference, address: 0000000000000=
018
[   15.592546] #PF: supervisor write access in kernel mode
[   15.592549] #PF: error_code(0x0002) - not-present page
[   15.592552] PGD 0 P4D 0=20
[   15.592558] Oops: Oops: 0002 [#1] SMP NOPTI
[   15.592563] CPU: 14 UID: 60580 PID: 1634 Comm: wireplumber Not tainted
7.4.0-rc2 #45 PREEMPT(lazy)=20
[   15.592569] Hardware name: LENOVO 21QL003UGE/21QL003UGE, BIOS R2XET39W (=
1.19
) 03/19/2026
[   15.592572] RIP: 0010:acp_dmic_dai_startup+0x2d/0x70 [snd_acp_pdm]
[   15.592579] Code: fa 0f 1f 44 00 00 48 8b 87 c0 00 00 00 48 8b 90 a0 01 =
00
00 48 8b 46 70 48 be 00 00 00 02 00 04 00 00 48 8b 40 10 48 8b 40 70 <48> c=
7 42
18 00 00 01 00 48 89 72 30 48 8b 50 48 48 8b 48 28 8b 52
[   15.592582] RSP: 0018:ffffce5188357a48 EFLAGS: 00010286
[   15.592585] RAX: ffff8b4246cde500 RBX: 0000000000000000 RCX:
ffff8b42428b7000
[   15.592588] RDX: 0000000000000000 RSI: 0000040002000000 RDI:
ffff8b42428b7000
[   15.592590] RBP: ffff8b424576e838 R08: ffffffffc2ee5390 R09:
0000000000000002
[   15.592592] R10: 00000000ffffffff R11: ffff8b426494fc00 R12:
ffff8b42428b7000
[   15.592593] R13: 0000000000000000 R14: ffff8b424576e838 R15:
ffff8b424576eee8
[   15.592595] FS:  00007fd67f32cc80(0000) GS:ffff8b48e84e5000(0000)
knlGS:0000000000000000
[   15.592598] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.592600] CR2: 0000000000000018 CR3: 0000000188d05000 CR4:
0000000000f50ef0
[   15.592602] PKRU: 55555554
[   15.592604] Call Trace:
[   15.592605]  <TASK>
[   15.592608]  snd_soc_dai_startup+0x5d/0xa0 [snd_soc_core]
[   15.592642]  __soc_pcm_open+0x124/0x6b0 [snd_soc_core]
[   15.592665]  ? snd_refcount_init+0x2a/0x40 [snd]
[   15.592676]  soc_pcm_open+0x2a/0x50 [snd_soc_core]
[   15.592694]  snd_pcm_open_substream+0x57b/0x9c0 [snd_pcm]
[   15.592706]  ? snd_card_file_add+0x109/0x140 [snd]
[   15.592714]  ? add_wait_queue+0x6d/0xa0
[   15.592722]  snd_pcm_open+0x13d/0x310 [snd_pcm]
[   15.592730]  ? __pfx_default_wake_function+0x10/0x10
[   15.592737]  snd_pcm_capture_open+0x3c/0x60 [snd_pcm]
[   15.592745]  chrdev_open+0xc7/0x290
[   15.592751]  ? __pfx_chrdev_open+0x10/0x10
[   15.592755]  do_dentry_open+0x123/0x470
[   15.592760]  vfs_open_consume+0x3f/0x100
[   15.592764]  path_openat+0x48d/0xb90
[   15.592770]  do_file_open+0xe7/0x1a0
[   15.592775]  ? do_getname+0x62/0x1c0
[   15.592778]  do_sys_openat2+0xa5/0xe0
[   15.592783]  __x64_sys_openat+0x61/0xa0
[   15.592787]  do_syscall_64+0xc1/0x580
[   15.592791]  ? kmem_cache_free+0x288/0x480
[   15.592796]  ? __x64_sys_close+0x47/0xa0
[   15.592799]  ? trace_syscall_exit+0x5e/0xa0
[   15.592803]  ? do_syscall_64+0xfe/0x580
[   15.592805]  ? __x64_sys_openat+0x61/0xa0
[   15.592809]  ? trace_syscall_exit+0x5e/0xa0
[   15.592811]  ? do_syscall_64+0xfe/0x580
[   15.592813]  ? do_syscall_64+0x37/0x580
[   15.592815]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   15.592819] RIP: 0033:0x7fd67f8eaefe
[   15.592841] Code: 08 0f 85 35 4a ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce
4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 9=
0 48
83 ec 08 bf 01 00 00 00 e8 a2 dc 05 00 bf 01 00 00 00 89
[   15.592843] RSP: 002b:00007ffd5eabeb88 EFLAGS: 00000246 ORIG_RAX:
0000000000000101
[   15.592847] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX:
00007fd67f8eaefe
[   15.592848] RDX: 0000000000080802 RSI: 00007ffd5eabed90 RDI:
ffffffffffffff9c
[   15.592850] RBP: 0000000000000004 R08: 0000000000000000 R09:
0000000000000000
[   15.592851] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000080802
[   15.592853] R13: 00007ffd5eabed90 R14: 00007ffd5eabf0b0 R15:
0000000000000002
[   15.592856]  </TASK>
[   15.592858] Modules linked in: nft_queue nft_ct nfnetlink_queue tcp_diag
inet_diag overlay qrtr algif_hash algif_skcipher af_alg bnep binfmt_misc
nft_chain_nat xt_MASQUERADE nf_nat xt_addrtype xt_tcpudp xt_conntrack
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat x_tables nf_tables
nls_ascii nls_cp437 vfat fat snd_acp_legacy_mach snd_acp_mach snd_soc_nau88=
21
intel_rapl_msr intel_rapl_common snd_acp3x_rn snd_acp70 snd_acp_i2s snd_acp=
_pdm
snd_acp_pcm snd_soc_dmic mt7925e snd_sof_amd_rembrandt snd_hda_codec_alc269
mt7925_common snd_sof_amd_acp snd_sof_pci snd_hda_codec_realtek_lib
snd_sof_xtensa_dsp edac_mce_amd mt792x_lib snd_hda_scodec_component btusb
snd_sof snd_hda_codec_generic btmtk snd_hda_codec_atihdmi mt76_connac_lib
uvcvideo snd_hda_codec_hdmi btrtl snd_sof_utils kvm_amd mt76 snd_pci_acp7x
btbcm videobuf2_vmalloc snd_pci_ps btintel uvc snd_soc_acpi_amd_match
videobuf2_memops mac80211 snd_soc_sdca videobuf2_v4l2 amdxdna snd_hda_intel
snd_soc_core videodev snd_hda_codec bluetooth kvm think_lmi gpio_keys
[   15.592902]  videobuf2_common snd_ctl_led snd_hda_core snd_compress cfg8=
0211
snd_pcm_dmaengine mc snd_acp_pci irqbypass snd_intel_dspcfg rapl
snd_amd_acpi_mach pcspkr snd_acp_legacy_common snd_intel_sdw_acpi snd_hwdep
snd_pci_acp6x wmi_bmof firmware_attributes_class thinkpad_acpi snd_pcm spd5=
118
amd_pmf nvram snd_timer drm_shmem_helper sparse_keymap k10temp ac snd_pci_a=
cp5x
amdtee snd_rn_pci_acp3x snd rfkill snd_acp_config amd_sfh libarc4 ccp
snd_soc_acpi soundcore snd_pci_acp3x tee soc_button_array amd_pmc joydev ev=
dev
lp ppdev parport_pc i2c_dev parport msr nvme_fabrics efi_pstore autofs4 ext4
mbcache jbd2 btrfs libblake2b dm_crypt dm_mod raid10 raid456 async_raid6_re=
cov
async_memcpy async_pq async_xor async_tx raid6_pq xor raid1 raid0 md_mod am=
dgpu
drm_buddy amdxcp drm_panel_backlight_quirks gpu_sched ucsi_acpi drm_ttm_hel=
per
typec_ucsi ttm hid_multitouch typec drm_exec i2c_algo_bit hid_generic roles
drm_suballoc_helper drm_display_helper i2c_hid_acpi i2c_hid cec hid rc_core
xhci_pci drm_client_lib drm_panel
[   15.592933]  xhci_hcd drm_kms_helper r8169 psmouse aesni_intel realtek d=
rm
thunderbolt nvme phy_package gf128mul serio_raw usbcore video battery phyli=
nk
nvme_core sp5100_tco mdio_devres watchdog libphy configfs nvme_keyring fan
crc16 i2c_piix4 nvme_auth mdio_bus wmi button usb_common i2c_smbus efivarfs
[   15.592945] CR2: 0000000000000018
[   15.592947] ---[ end trace 0000000000000000 ]---
[   15.939478] RIP: 0010:acp_dmic_dai_startup+0x2d/0x70 [snd_acp_pdm]
[   15.939486] Code: fa 0f 1f 44 00 00 48 8b 87 c0 00 00 00 48 8b 90 a0 01 =
00
00 48 8b 46 70 48 be 00 00 00 02 00 04 00 00 48 8b 40 10 48 8b 40 70 <48> c=
7 42
18 00 00 01 00 48 89 72 30 48 8b 50 48 48 8b 48 28 8b 52
[   15.939487] RSP: 0018:ffffce5188357a48 EFLAGS: 00010286
[   15.939488] RAX: ffff8b4246cde500 RBX: 0000000000000000 RCX:
ffff8b42428b7000
[   15.939489] RDX: 0000000000000000 RSI: 0000040002000000 RDI:
ffff8b42428b7000
[   15.939490] RBP: ffff8b424576e838 R08: ffffffffc2ee5390 R09:
0000000000000002
[   15.939490] R10: 00000000ffffffff R11: ffff8b426494fc00 R12:
ffff8b42428b7000
[   15.939491] R13: 0000000000000000 R14: ffff8b424576e838 R15:
ffff8b424576eee8
[   15.939492] FS:  00007fd67f32cc80(0000) GS:ffff8b48e84e5000(0000)
knlGS:0000000000000000
[   15.939493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.939493] CR2: 0000000000000018 CR3: 0000000188d05000 CR4:
0000000000f50ef0
[   15.939494] PKRU: 55555554
[   15.939495] note: wireplumber[1634] exited with irqs disabled


It does look similar to bug bugzilla.kernel.org/show_bug.cgi?id=3D222249 wh=
ich
was reported a few minutes before this one and has a patch mentioned in a
comment there.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
