Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889E6F510
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271042; cv=none; b=ZXLvLYj1XngqF91/Hhn2V1+5izAHpBwsBFeSHe5aiPrVsM0WWnnU0sQt2+K2hFVI9B/QKaTcwufzSSGGVZea8HSUKXlqxA4R020rCa5ZFyz0NmNS2Mr+/cmuQYHfWrIIlxmZr+xHuM9kawvvAuO5Dhoz0av77OS+taos6w40isQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271042; c=relaxed/simple;
	bh=B38muDSIS4HOg0jQ0v0MpkalH6xl5rDYIL4kifaIgZc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyFdfPNT2sU3NA+sf/gioa4tBMEHo/+k+wXvUIFO5Wp/6cHStJkvPRXspIb+aAZV7PhrkYyL9P5brQARhfdKm9GXtPPrsCaf4eNHPoBFJwuYCeVVh4sB1nBxpqD5VkBGka4O+TU6tJVZUjaHskd9O8umnMNUpPcEWWKOkzeq/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxWtpX9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxWtpX9J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 376B3C433A6
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 22:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712271042;
	bh=B38muDSIS4HOg0jQ0v0MpkalH6xl5rDYIL4kifaIgZc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HxWtpX9JcROEXoZ4bnOpQeeX/2lHNx7bSrSUg/i9bwHE5e80tc49x+GZNpoDQrDgT
	 iONFWuShb9sf9+6KuEkgHY/oHknLrW9KsNXmMzoMJPhfwKrAKQ7R+Ye3l6NfwD4sBy
	 djUSvu2VpRpEOKmpJY/okvm7hksQ0NZsYxgnj26vxnvUOUyfl385tnP2Ua6gjvpiIh
	 0799Tw10fNfdriXKBi3qAYXPOSVX6oaDzAaWLURSRd4+NjzKQEJ7OCww1R4sdUmEmd
	 YnY1XcCpvNdEalP67I6th0i97TQGT5eVFNoVwJ2VucJYSnPHxMyJnhboOdYVwp2C8A
	 ayO1r4k34Bq5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2FC45C53BD3; Thu,  4 Apr 2024 22:50:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Thu, 04 Apr 2024 22:50:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: robert@robertholt.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218416-62941-A43KFKJBGv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

Robert Holt (robert@robertholt.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |robert@robertholt.net

--- Comment #17 from Robert Holt (robert@robertholt.net) ---
(In reply to Luiz Von Dentz from comment #16)
> Can you guys try with the following change:
>=20
> https://patchwork.kernel.org/project/bluetooth/patch/20240401193515.25252=
01-
> 1-luiz.dentz@gmail.com/

I have the same issue and applied this patch to my kernel, but it seems to =
have
broken the btintel module. I get a null pointer deref on boot and bluetooth=
 is
broken:

[    2.317366] BUG: kernel NULL pointer dereference, address: 0000000000000=
070
[    2.317699] #PF: supervisor read access in kernel mode
[    2.317993] #PF: error_code(0x0000) - not-present page
[    2.318280] PGD 0 P4D 0
[    2.318283] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    2.318842] CPU: 3 PID: 185 Comm: kworker/u33:0 Not tainted
6.8.3-gentoo-dist #1
[    2.318844] Hardware name: AZW SER/SER, BIOS SER7PRO_P5C8V30 09/15/2023
[    2.318845] Workqueue: hci0 hci_alloc_dev_priv [bluetooth]
[    2.319426] RIP: 0010:btintel_configure_setup+0x245/0x970 [btintel]
[    2.320365] Code: 85 ff 75 a1 f0 41 80 8e 51 06 00 00 02 f0 41 80 8e 51 =
06
00 00 04 f0 41 80 8e 51 06 00 00 08 49 c7 86 38 17 00 00 b0 63 66 c1 <83> 7=
b 70
0a 75 7b 48 8b 83 d0 00 00 00 80 78 01 37 75 6e 0f 1f 44
[    2.320691] RSP: 0018:ffffa215005cfd48 EFLAGS: 00010202
[    2.321452] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000080200006
[    2.321760] RDX: 0000000080200007 RSI: ffffd3238404d700 RDI:
0000000000000000
[    2.322437] RBP: ffff91a940ccc6c8 R08: 0000000080200007 R09:
0000000080200006
[    2.322438] R10: 0000000000000001 R11: 0000000000000000 R12:
ffff91a940ccc6d0
[    2.322439] R13: ffff91a947f50c00 R14: ffff91a940ccc000 R15:
ffff91a940ccca88
[    2.322441] FS:  0000000000000000(0000) GS:ffff91af820c0000(0000)
knlGS:0000000000000000
[    2.323737] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.323739] CR2: 0000000000000070 CR3: 000000010dfa2000 CR4:
0000000000f50ef0
[    2.323740] PKRU: 55555554
[    2.323740] Call Trace:
[    2.323743]  <TASK>
[    2.326248]  ? __die_body+0x68/0xb0
[    2.326253]  ? page_fault_oops+0x3a3/0x400
[    2.326256]  ? exc_page_fault+0x60/0xf0
[    2.326265]  ? asm_exc_page_fault+0x26/0x30
[    2.326269]  ? btintel_configure_setup+0x245/0x970 [btintel]
[    2.328091]  ? btintel_configure_setup+0x16c/0x970 [btintel]
[    2.328093]  ? __ia32_compat_sys_sysinfo+0x230/0x270
[    2.329006]  hci_dev_open_sync+0x166/0x1610 [bluetooth]
[    2.329013]  ? srso_alias_return_thunk+0x5/0xfbef5
[    2.329015]  ? srso_alias_return_thunk+0x5/0xfbef5
[    2.329016]  ? srso_alias_return_thunk+0x5/0xfbef5
[    2.329018]  hci_alloc_dev_priv+0x164e/0x1bc0 [bluetooth]
[    2.329023]  process_scheduled_works+0x24b/0x450
[    2.329026]  worker_thread+0x2c3/0x420
[    2.329028]  ? __pfx_worker_thread+0x10/0x10
[    2.329030]  kthread+0xe8/0x110
[    2.329032]  ? __pfx_kthread+0x10/0x10
[    2.329033]  ret_from_fork+0x37/0x50
[    2.329036]  ? __pfx_kthread+0x10/0x10
[    2.329038]  ret_from_fork_asm+0x1b/0x30
[    2.329043]  </TASK>
[    2.329043] Modules linked in: amdxcp(+) ac97_bus(+) iwlwifi(+)
snd_hda_codec(+) btusb snd_pcm_dmaengine gpu_sched vfat btbcm snd_pci_ps
drm_suballoc_helper btintel i2c_algo_bit fat snd_rpl_pci_acp6x kvm(+)
drm_ttm_helper snd_hda_core snd_acp_pci btrtl ttm snd_acp_legacy_common btm=
tk
snd_pci_acp6x irqbypass drm_exec snd_hwdep snd_pci_acp5x snd_pcm
drm_display_helper bluetooth snd_rn_pci_acp3x wmi_bmof cfg80211 snd_timer
snd_acp_config rapl cec snd_soc_acpi snd pcspkr drm_buddy soundcore i2c_pii=
x4
k10temp snd_pci_acp3x rfkill amd_pmc fuse loop nfnetlink crct10dif_pclmul
crc32_pclmul crc32c_intel nvme polyval_clmulni polyval_generic
ghash_clmulni_intel thunderbolt sha512_ssse3 sha256_ssse3 sha1_ssse3 nvme_c=
ore
amd_sfh ccp sp5100_tco r8169 nvme_auth realtek video wmi i2c_hid_acpi i2c_h=
id
serio_raw
[    2.329083] CR2: 0000000000000070
[    2.329085] ---[ end trace 0000000000000000 ]---
[    2.329087] RIP: 0010:btintel_configure_setup+0x245/0x970 [btintel]
[    2.329089] Code: 85 ff 75 a1 f0 41 80 8e 51 06 00 00 02 f0 41 80 8e 51 =
06
00 00 04 f0 41 80 8e 51 06 00 00 08 49 c7 86 38 17 00 00 b0 63 66 c1 <83> 7=
b 70
0a 75 7b 48 8b 83 d0 00 00 00 80 78 01 37 75 6e 0f 1f 44
[    2.329090] RSP: 0018:ffffa215005cfd48 EFLAGS: 00010202
[    2.329091] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000080200006
[    2.329092] RDX: 0000000080200007 RSI: ffffd3238404d700 RDI:
0000000000000000
[    2.329093] RBP: ffff91a940ccc6c8 R08: 0000000080200007 R09:
0000000080200006
[    2.329093] R10: 0000000000000001 R11: 0000000000000000 R12:
ffff91a940ccc6d0
[    2.329094] R13: ffff91a947f50c00 R14: ffff91a940ccc000 R15:
ffff91a940ccca88
[    2.329095] FS:  0000000000000000(0000) GS:ffff91af820c0000(0000)
knlGS:0000000000000000
[    2.329096] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.329096] CR2: 0000000000000070 CR3: 000000010dfa2000 CR4:
0000000000f50ef0
[    2.329097] PKRU: 55555554
[    2.329098] note: kworker/u33:0[185] exited with irqs disabled

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
