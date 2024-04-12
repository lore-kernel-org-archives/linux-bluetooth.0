Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A2147C7D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934732; cv=none; b=Toj5hxc8Mdg0UMEVcQ+QOcLgKre6kVHskb4UMtSaxu6pT9WtoiNhUD4WfvigkMt4KUeuuMKWL4th9qggOSL3q0rR4V5CZ6gEDx7XwDaMzeDWSknOkceNpL+1XnT1uGLSZ0hNxUQbFzEldFGfiq9AXfVrupnbOQbpG3gHdcIQo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934732; c=relaxed/simple;
	bh=X1nyse5xP1KVaQ59JEStng9RUSs4xN31nwobbmlY6Iw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gQzRCyi9rKIEOydE1mbHfHxIbGIfT6GWxVtWHTTtcvNiuebsfgDFMeXBBz4Ru90R81lsLmp+qw/oHw4cRBOlhqwU35clIyXJZW/2iEqgsWsvywc/TBs/hFDSwG/yd0SX7IPpNNm/KIKuRIeh35zetwUZ3UifrqZuuaijQrOPQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaidekw0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaidekw0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F6C4C113CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934732;
	bh=X1nyse5xP1KVaQ59JEStng9RUSs4xN31nwobbmlY6Iw=;
	h=From:To:Subject:Date:From;
	b=eaidekw0G5pBMTZuDxwTNyHGrz2sC+g6C2b/IPfwT0HXOjZweYRDeABjiipJpv9I/
	 f1eKCOB0N7U4ePK8jBdvy3uQcszES+ftCysxaHnNeYy/Hz+TjLS2pUDPJE6Y2+AuPi
	 rn/0RJGiEVnofYeLBsZ91TXJqA5llAeQY0pjHVV4Hb88Tap7U9pqzpaqpP3ICaFq9T
	 7kHaH/Lti+sL2ewUVQfo3Gjz95ySlYkVgy+1FnAWbIojVsPVi6rEaKf+s8BaACO7+2
	 kEnLn7yt5eG1Va4D0S9QMlyE336q3C/KvaszU2orNnLaduM5M38v2GgWTit/jYC68p
	 WdgMGoGbO8DFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EF0BDC433DE; Fri, 12 Apr 2024 15:12:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218717] New: Lots of oopses from btintel
Date: Fri, 12 Apr 2024 15:12:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218717-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218717

            Bug ID: 218717
           Summary: Lots of oopses from btintel
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

6.8.3 produces quite a lot of oopses:

Bluetooth: hci0: FW download error recovery failed (-19)
Bluetooth: hci0: sending frame failed (-19)
BUG: kernel NULL pointer dereference, address: 0000000000000070
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0=20
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 8 PID: 1778 Comm: kworker/u41:0 Tainted: P           O       6.8.2-zen=
3 #1
Hardware name: System manufacturer System Product Name/TUF GAMING X570-PLUS
(WI-FI), BIOS 5013 03/22/2024
Workqueue: hci0 hci_power_on [bluetooth]
RIP: 0010:btintel_read_debug_features+0x3b/0xe0 [btintel]
Code: 49 89 fd 41 54 48 8d 4d e7 49 89 f4 be a6 fc 00 00 53 48 83 ec 08 c6 =
45
e7 01 e8 d0 6e 5a 03 48 89 c3 48 3d 00 f0 ff ff 77 3c <83> 78 70 13 75 66 4=
8 8b
80 c8 00 00 00 be 02 00 00 00 48 89 df 48
RSP: 0018:ffffb5c500697ce0 EFLAGS: 00010207
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffa0121e5f6ab0
RDX: 0000000000000013 RSI: 0000000000000202 RDI: ffffa0121e5f6aa8
RBP: ffffb5c500697d00 R08: ffffa0121e5f6ab0 R09: ffffa020ef01cc00
R10: ffffa0120594e990 R11: 0000000000000001 R12: ffffb5c500697d10
R13: ffffa0121e5f6000 R14: ffffb5c500697d50 R15: ffffa01201d8e005
FS:  0000000000000000(0000) GS:ffffa020ef000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000070 CR3: 000000010c4d0000 CR4: 0000000000b50ef0
Call Trace:
 <TASK>
 ? show_regs+0x60/0x70
 ? __die+0x1f/0x70
 ? page_fault_oops+0x14c/0x410
 ? __timer_delete_sync+0x68/0xb0
 ? exc_page_fault+0x3de/0x6c0
 ? __hci_cmd_sync_sk.part.0+0xf3/0x1a0 [bluetooth]
 ? asm_exc_page_fault+0x27/0x30
 ? btintel_read_debug_features+0x3b/0xe0 [btintel]
 btintel_register_devcoredump_support.isra.0+0x18/0x70 [btintel]
 ? btintel_read_version+0x59/0xd0 [btintel]
 btintel_setup_combined+0x23f/0x660 [btintel]
 hci_dev_open_sync+0xbc/0xaa0 [bluetooth]
 ? try_to_wake_up+0x6b/0x3f0
 hci_power_on+0x4a/0x1f0 [bluetooth]
 process_one_work+0x14f/0x260
 worker_thread+0x27c/0x3c0
 ? process_one_work+0x260/0x260
 kthread+0xed/0x120
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x38/0x60
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in: msr nf_log_syslog nft_limit nft_ct nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 vboxnetadp(O) vboxnetflt(O) nfnetlink_log nft=
_log
bnep btusb btintel btbcm bluetooth ecdh_generic ecc vboxdrv(O) nf_tables
libcrc32c nfnetlink nct6775 nct6775_core hwmon_vid nvidia_drm(PO+)
nvidia_modeset(PO) ntfs3 nvidia(PO) kvm_amd kvm iwlmvm snd_hda_codec_realtek
ptp irqbypass snd_hda_codec_generic pps_core crct10dif_pclmul crc32_pclmul
led_class mac80211 snd_hda_codec_hdmi libarc4 crc32c_intel polyval_clmulni
polyval_generic wmi_bmof gf128mul sha512_ssse3 snd_hda_intel sha512_generic
snd_intel_dspcfg sha256_ssse3 sha1_ssse3 snd_hda_codec aesni_intel snd_hwdep
snd_hda_core snd_seq snd_seq_device crypto_simd pcspkr efi_pstore cryptd
snd_pcm iwlwifi ccp k10temp sha1_generic i2c_nvidia_gpu snd_timer i2c_ccgx_=
ucsi
snd cfg80211 backlight r8169 rfkill sr_mod cdrom realtek i2c_piix4 mdio_dev=
res
xhci_pci libphy xhci_hcd 8250 8250_base wmi tpm_crb serial_base evdev tpm_t=
is
tpm_tis_core fuse dm_mod tpm rng_core ipv6
CR2: 0000000000000070
---[ end trace 0000000000000000 ]---
usb 7-3: new low-speed USB device number 3 using xhci_hcd
RIP: 0010:btintel_read_debug_features+0x3b/0xe0 [btintel]
Code: 49 89 fd 41 54 48 8d 4d e7 49 89 f4 be a6 fc 00 00 53 48 83 ec 08 c6 =
45
e7 01 e8 d0 6e 5a 03 48 89 c3 48 3d 00 f0 ff ff 77 3c <83> 78 70 13 75 66 4=
8 8b
80 c8 00 00 00 be 02 00 00 00 48 89 df 48
RSP: 0018:ffffb5c500697ce0 EFLAGS: 00010207
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffa0121e5f6ab0
RDX: 0000000000000013 RSI: 0000000000000202 RDI: ffffa0121e5f6aa8
RBP: ffffb5c500697d00 R08: ffffa0121e5f6ab0 R09: ffffa020ef01cc00
R10: ffffa0120594e990 R11: 0000000000000001 R12: ffffb5c500697d10
R13: ffffa0121e5f6000 R14: ffffb5c500697d50 R15: ffffa01201d8e005
FS:  0000000000000000(0000) GS:ffffa020ef000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000070 CR3: 000000010c4d0000 CR4: 0000000000b50ef0

6.7.x had none. It's a regression. That's on boot without even using the HW.

Device: ID 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
