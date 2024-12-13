Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067041ADFFE
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081613; cv=none; b=YhueFRVap5Q+hozjlzjT9DmvbVMmf4GljFYlMdDbrRdlaYs/52MzZKuExmBYPL7Xj8Of4AvbE8fNwjRIVVdTtAHX7URUlRxADZllXV9a48ygAoxbGQF28zgvsWtnaU27E2A1ZUZNaLgBlOMfpmv7uYoDcDopw8oI7wAknYxmhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081613; c=relaxed/simple;
	bh=h5xX/cf6zTzPJQxxags+VvxwBQE3ySODJsWhJtZtiQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHzKrGs+5rPeRDUH8hZ2MzDIOCNa/yO8hfKnZH3e6ba7ZXNFIz/1itRHP4K5T+g+p4P5Si8BjQ07mT88MaIk54lJubLmUJKj8fquMuo2IvuabCMinhn0qj/tIMnTmZfkvMxO74KWaUXnCgd1/7f6VPBE3ezGOMcfLvj8E9pZpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbaNHNph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbaNHNph"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D77C1C4CED6
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734081612;
	bh=h5xX/cf6zTzPJQxxags+VvxwBQE3ySODJsWhJtZtiQk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NbaNHNph5QdcA6A7Q/BSxPtv/DoOqgwWi8xnj5We3RHj7sEW67LG/lfZUBL/QqRFQ
	 MixCnzrtrPhjwU75Jxxlm45U2j5LLG0FXW+JL/Sv3RzO9GJU9SYqOTHNc2MxdahHW+
	 13KdEgKKJaqUdacVfwcjWS6SCTt6uzvYzBMALGazT3+bjz5pfEOe3/VWTVMAU7gLdc
	 QTSTeDVfX49+kSPjRbitvnkvQHgftwa40eefwkKfNVrAW1J0Gm2zupISYvNApwn1tV
	 8kllS+vTToyjnAHMSTmRm/273j65YkYo83RidRbhTHJPixb+Ojloultl3aBR2UhvxI
	 0LTzUyQaGvx3g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C532AC4160E; Fri, 13 Dec 2024 09:20:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] NULL dereference pointer in Bluetooth at boot
Date: Fri, 13 Dec 2024 09:20:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: js@alien8.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219294-62941-U81rBR5AjB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219294-62941@https.bugzilla.kernel.org/>
References: <bug-219294-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219294

Julian Stecklina (js@alien8.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |js@alien8.de

--- Comment #5 from Julian Stecklina (js@alien8.de) ---
I also see this occasionally on boot on my Framework 13 laptop running Linux
6.12.3. The result is a hang after the GDM login screen and the user session
doesn't start. I think it also happened on 6.12.1.

Dec 13 10:11:46 avalon kernel: Bluetooth: RFCOMM TTY layer initialized
Dec 13 10:11:46 avalon kernel: Bluetooth: RFCOMM socket layer initialized
Dec 13 10:11:46 avalon kernel: Bluetooth: RFCOMM ver 1.11
Dec 13 10:11:49 avalon kernel: BUG: kernel NULL pointer dereference, addres=
s:
0000000000000000
Dec 13 10:11:49 avalon kernel: #PF: supervisor read access in kernel mode
Dec 13 10:11:49 avalon kernel: #PF: error_code(0x0000) - not-present page
Dec 13 10:11:49 avalon kernel: PGD 0 P4D 0=20
Dec 13 10:11:49 avalon kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
Dec 13 10:11:49 avalon kernel: CPU: 12 UID: 0 PID: 196 Comm: kworker/12:1 N=
ot
tainted 6.12.3 #1-NixOS
Dec 13 10:11:49 avalon kernel: Hardware name: Framework Laptop 13 (AMD Ryzen
7040Series)/FRANMDCP07, BIOS 03.05 03/29/2024
Dec 13 10:11:49 avalon kernel: Workqueue: pm pm_runtime_work
Dec 13 10:11:49 avalon kernel: RIP: 0010:btusb_suspend+0x161/0x200 [btusb]
Dec 13 10:11:49 avalon kernel: Code: 00 00 01 e9 fb fe ff ff 48 89 fa 48 c7=
 c6
3f f2 32 c2 48 c7 c7 58 a3 32 c2 e8 7b f6 c1 e0 81 e5 00 04 00 00 0f 84 c6 =
fe
ff ff <48> 8b 13 8b 82 bc 09 00 00 03 82 b8 09 00 00 03 82 c4 09 00 00 03
Dec 13 10:11:49 avalon kernel: RSP: 0018:ffffae7ac066fca0 EFLAGS: 00010206
Dec 13 10:11:49 avalon kernel: RAX: ffffffffc2322a30 RBX: 0000000000000000 =
RCX:
0000000000000003
Dec 13 10:11:49 avalon kernel: RDX: ffff94f941331000 RSI: 0000000000000402 =
RDI:
ffff94f941344800
Dec 13 10:11:49 avalon kernel: RBP: 0000000000000400 R08: 0000000000000000 =
R09:
0000000000000000
Dec 13 10:11:49 avalon kernel: R10: 0000000000000000 R11: 0000000000000000 =
R12:
0000000000000402
Dec 13 10:11:49 avalon kernel: R13: 0000000000000003 R14: 0000000000000000 =
R15:
ffff94f954df0000
Dec 13 10:11:49 avalon kernel: FS:  0000000000000000(0000)
GS:ffff95009e600000(0000) knlGS:0000000000000000
Dec 13 10:11:49 avalon kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Dec 13 10:11:49 avalon kernel: CR2: 0000000000000000 CR3: 0000000036e22000 =
CR4:
0000000000f50ef0
Dec 13 10:11:49 avalon kernel: PKRU: 55555554
Dec 13 10:11:49 avalon kernel: Call Trace:
Dec 13 10:11:49 avalon kernel:  <TASK>
Dec 13 10:11:49 avalon kernel:  ? __die+0x23/0x80
Dec 13 10:11:49 avalon kernel:  ? page_fault_oops+0x173/0x5b0
Dec 13 10:11:49 avalon kernel:  ? page_counter_uncharge+0x21/0x50
Dec 13 10:11:49 avalon kernel:  ? exc_page_fault+0x71/0x160
Dec 13 10:11:49 avalon kernel:  ? asm_exc_page_fault+0x26/0x30
Dec 13 10:11:49 avalon kernel:  ? __pfx_btusb_suspend+0x10/0x10 [btusb]
Dec 13 10:11:49 avalon kernel:  ? btusb_suspend+0x161/0x200 [btusb]
Dec 13 10:11:49 avalon kernel:  usb_suspend_both+0x94/0x290
Dec 13 10:11:49 avalon kernel:  usb_runtime_suspend+0x2e/0x80
Dec 13 10:11:49 avalon kernel:  ? __pfx_usb_runtime_suspend+0x10/0x10
Dec 13 10:11:49 avalon kernel:  __rpm_callback+0x41/0x170
Dec 13 10:11:49 avalon kernel:  ? __pfx_usb_runtime_suspend+0x10/0x10
Dec 13 10:11:49 avalon kernel:  rpm_callback+0x59/0x70
Dec 13 10:11:49 avalon kernel:  ? __pfx_usb_runtime_suspend+0x10/0x10
Dec 13 10:11:49 avalon kernel:  rpm_suspend+0xe8/0x5e0
Dec 13 10:11:49 avalon kernel:  ? psi_task_switch+0xfb/0x200
Dec 13 10:11:49 avalon kernel:  ? finish_task_switch.isra.0+0x9c/0x2f0
Dec 13 10:11:49 avalon kernel:  __pm_runtime_suspend+0x3c/0xd0
Dec 13 10:11:49 avalon kernel:  ? __pfx_usb_runtime_idle+0x10/0x10
Dec 13 10:11:49 avalon kernel:  usb_runtime_idle+0x39/0x50
Dec 13 10:11:49 avalon kernel:  rpm_idle+0xbd/0x280
Dec 13 10:11:49 avalon kernel:  pm_runtime_work+0x84/0xb0
Dec 13 10:11:49 avalon kernel:  process_one_work+0x18f/0x3b0
Dec 13 10:11:49 avalon kernel:  worker_thread+0x230/0x340
Dec 13 10:11:49 avalon kernel:  ? __pfx_worker_thread+0x10/0x10
Dec 13 10:11:49 avalon kernel:  ? __pfx_worker_thread+0x10/0x10
Dec 13 10:11:49 avalon kernel:  kthread+0xcd/0x100
Dec 13 10:11:49 avalon kernel:  ? __pfx_kthread+0x10/0x10
Dec 13 10:11:49 avalon kernel:  ret_from_fork+0x31/0x50
Dec 13 10:11:49 avalon kernel:  ? __pfx_kthread+0x10/0x10
Dec 13 10:11:49 avalon kernel:  ret_from_fork_asm+0x1a/0x30
Dec 13 10:11:49 avalon kernel:  </TASK>
Dec 13 10:11:49 avalon kernel: Modules linked in: rfcomm snd_seq_dummy
snd_hrtimer snd_seq qrtr cmac algif_hash algif_skcipher af_alg af_packet
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp
nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
nf_tables bnep msr nls_>
Dec 13 10:11:49 avalon kernel:  hid_sensor_trigger snd_rpl_pci_acp6x
snd_hda_intel industrialio_triggered_buffer kfifo_buf snd_acp_pci
hid_sensor_iio_common snd_intel_dspcfg sch_fq_codel cros_ec_dev industrialio
snd_usb_audio spd5118 snd_intel_sdw_acpi snd_acp_legacy_common cfg80211
uvcvideo sp5100_tco snd_hda_codec>
Dec 13 10:11:49 avalon kernel:  tpm_tis i2c_hid_acpi tpm_tis_core tap button
i2c_hid macvlan evdev mac_hid amd_pmc serio_raw bridge stp llc kvm_amd ccp =
kvm
fuse efi_pstore configfs nfnetlink zram 842_decompress 842_compress
lz4hc_compress lz4_compress efivarfs dmi_sysfs ip_tables x_tables autofs4 x=
fs
libcrc32c crc32>
Dec 13 10:11:49 avalon kernel: CR2: 0000000000000000
Dec 13 10:11:49 avalon kernel: ---[ end trace 0000000000000000 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
