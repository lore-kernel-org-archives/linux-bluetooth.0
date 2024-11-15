Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE01898EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661299; cv=none; b=VuLzGXdpTwPCR6WdOuDqBa4Pa8jrEn8FofXJNbgZDYyFIqkM8sDswWl1Je4c1Yo03bh28pLz3mnfkdEggf34gw+Sbahiwh/6n0ekCuj+bWnkuHlaiUNKunXecbVyLVbm2UvvmrLZ5CRMU3gpPVb8lS4SrkgJdl/25v+JXq0mTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661299; c=relaxed/simple;
	bh=9dSOjcNyDb/zTukyY98jiQudUtsEr4+7Ty68oWXUJbw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=istgw41UfL4gXOrlLugCYE1TpXRMgvBq3NxUfZ2tzur5sD8lFzQIE1gwQsiwTMh8M/fNU2soSj/IptVTbd/DsEe9VzoE+qMLKmiaevXKOFNk78/UhDJWlb+9GVCjSI0v9k3/YbQmnUKdIrVeDXQPGC6ChIRTupD0x7j2NukTSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFLkrEVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFLkrEVz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 376BDC4CED4
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731661299;
	bh=9dSOjcNyDb/zTukyY98jiQudUtsEr4+7Ty68oWXUJbw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vFLkrEVzXFyst5ZHMKDRYbaIj0dZtx/CXztvQ19ePJz2Y5jI09LRZxzcp11lkUZzK
	 nrhA6cNi7DXz2RnDVB3/o0STPnmyf7ap98p/zvVeUx1RdHen1sCHtqqwG31MQoNoZK
	 h8mnPaeBwjuc5qN5p+rX+yh5vNjmoNGqVtEKYp37aWXwKQ0EXNVG9cVGxPSzayy/ng
	 objiYxL7LRWQG0vRnfT7QhfOfdxbNcqssM3v/tyrpOZpdU/kHq+tDRz6pUNLIc6Jmq
	 izJXlrcLNvpSzAyBKyocPb8PaX3kMXZs9dHlAoYBRp7DdkDKEmO74RlpCe0QcI7mmO
	 +3G44d15OtgmA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 22F75C53BC5; Fri, 15 Nov 2024 09:01:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219494] Mediatek MT7921U WIFI + bluetooth USB Dongle - System
 Crash - Cold Boot
Date: Fri, 15 Nov 2024 09:01:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: mail@nelsongaspar.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219494-62941-KUMF0uNMyQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219494-62941@https.bugzilla.kernel.org/>
References: <bug-219494-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219494

--- Comment #3 from nelsongas (mail@nelsongaspar.com) ---
Nov 14 20:03:11 darkstar kernel: Bluetooth: hci0: command 0xfd98 tx timeout
Nov 14 20:03:11 darkstar kernel: Bluetooth: hci0: Failed to apply iso setti=
ng
(-110)
Nov 14 20:03:11 darkstar kernel: Bluetooth: hci0: HCI Enhanced Setup
Synchronous Connection command is advertised, but not supported.
Nov 14 20:03:13 darkstar kernel: Bluetooth: hci0: Opcode 0x0c03 failed: -110
Nov 14 20:03:15 darkstar kernel: Bluetooth: hci0: Failed to read MSFT suppo=
rted
features (-110)
Nov 14 20:03:15 darkstar kernel: Oops: general protection fault, probably f=
or
non-canonical address 0xdead000000000108: 0000 [#1] PREEMPT SMP PTI
Nov 14 20:03:15 darkstar kernel: CPU: 6 UID: 0 PID: 9445 Comm: kworker/6:1
Tainted: P          IO       6.11.7 #1
Nov 14 20:03:15 darkstar kernel: Tainted: [P]=3DPROPRIETARY_MODULE,
[I]=3DFIRMWARE_WORKAROUND, [O]=3DOOT_MODULE
Nov 14 20:03:15 darkstar kernel: Hardware name: Dell Inc.=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
Precision WorkStation 690    /0MY171, BIOS A08 04/25/2008
Nov 14 20:03:15 darkstar kernel: Workqueue: events __usb_queue_reset_device
Nov 14 20:03:15 darkstar kernel: RIP: 0010:hci_unregister_dev+0x43/0x190
[bluetooth]
Nov 14 20:03:15 darkstar kernel: Code: f0 80 8b e1 0e 00 00 08 48 89 ef e8 =
47
10 58 d1 48 c7 c7 a8 86 ea c4 e8 bb 71 58 d1 48 8b 13 48 8b 43 08 48 c7 c7 =
a8
86 ea c4 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad
de 48 89 03 48 83
Nov 14 20:03:15 darkstar kernel: RSP: 0018:ffff974e43de7d28 EFLAGS: 00010246
Nov 14 20:03:15 darkstar kernel: RAX: dead000000000122 RBX: ffff88de69aa6000
RCX: 0000000000000000
Nov 14 20:03:15 darkstar kernel: RDX: dead000000000100 RSI: ffff88dc1b6d0a10
RDI: ffffffffc4ea86a8
Nov 14 20:03:15 darkstar kernel: RBP: ffff88de69aa64d0 R08: 0000000000000001
R09: 0000000000000000
Nov 14 20:03:15 darkstar kernel: R10: 0000000080150010 R11: 0000000000000000
R12: ffff88de69aa6000
Nov 14 20:03:15 darkstar kernel: R13: ffffffffc4f0c278 R14: ffffffffc4f0c278
R15: ffff88dc200e8450
Nov 14 20:03:15 darkstar kernel: FS:  0000000000000000(0000)
GS:ffff88e31fd80000(0000) knlGS:0000000000000000
Nov 14 20:03:15 darkstar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Nov 14 20:03:15 darkstar kernel: CR2: 00007fa25a5f7cf0 CR3: 000000014dab6000
CR4: 00000000000006f0
Nov 14 20:03:15 darkstar kernel: Call Trace:
Nov 14 20:03:15 darkstar kernel:  <TASK>
Nov 14 20:03:15 darkstar kernel:  ? die_addr.cold+0x8/0xd
Nov 14 20:03:15 darkstar kernel:  ? exc_general_protection+0x1c4/0x460
Nov 14 20:03:15 darkstar kernel:  ? asm_exc_general_protection+0x22/0x30
Nov 14 20:03:15 darkstar kernel:  ? hci_unregister_dev+0x43/0x190 [bluetoot=
h]
Nov 14 20:03:15 darkstar kernel:  ? hci_unregister_dev+0x35/0x190 [bluetoot=
h]
Nov 14 20:03:15 darkstar kernel:  btusb_disconnect+0x5e/0x130 [btusb]
Nov 14 20:03:15 darkstar kernel:  usb_unbind_interface+0x8f/0x280
Nov 14 20:03:15 darkstar kernel:  device_release_driver_internal+0x198/0x200
Nov 14 20:03:15 darkstar kernel:  usb_forced_unbind_intf+0x38/0x80
Nov 14 20:03:15 darkstar kernel:  usb_reset_device+0xe4/0x240
Nov 14 20:03:15 darkstar kernel:  __usb_queue_reset_device+0x35/0x50
Nov 14 20:03:15 darkstar kernel:  process_one_work+0x16b/0x320
Nov 14 20:03:15 darkstar kernel:  worker_thread+0x2da/0x410
Nov 14 20:03:15 darkstar kernel:  ? _raw_spin_lock_irqsave+0x17/0x50
Nov 14 20:03:15 darkstar kernel:  ? __pfx_worker_thread+0x10/0x10
Nov 14 20:03:15 darkstar kernel:  kthread+0xdd/0x110
Nov 14 20:03:15 darkstar kernel:  ? __pfx_kthread+0x10/0x10
Nov 14 20:03:15 darkstar kernel:  ret_from_fork+0x30/0x50
Nov 14 20:03:15 darkstar kernel:  ? __pfx_kthread+0x10/0x10
Nov 14 20:03:15 darkstar kernel:  ret_from_fork_asm+0x1a/0x30
Nov 14 20:03:15 darkstar kernel:  </TASK>
Nov 14 20:03:15 darkstar kernel: Modules linked in: btusb btrtl btintel btb=
cm
btmtk bluetooth fuse ipmi_devintf ipmi_msghandler smsc 8021q garp mrp xt_NF=
LOG
nfnetlink_log xt_multiport xt_tcpudp iptable_filter ip_tables xt_conntrack =
qrtr
x_tables nf_conntrack_tftp nf_conntrack_snmp nf_conntrack_sip nf_conntrack_=
sane
nf_conntrack_pptp nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns
nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp nf_conntrack_broadcast
ts_kmp nf_conntrack_amanda nf_conntrack_bridge nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 bridge stp llc ipv6 nvidia_uvm(PO) sg zram uvcvideo uvc
snd_usb_audio videobuf2_vmalloc vi
deobuf2_memops videobuf2_v4l2 snd_usbmidi_lib snd_ump st snd_rawmidi videod=
ev
snd_seq_device videobuf2_common joydev mc snd_ctl_led mt7921u mt792x_usb
mt7921_common mt792x_lib mt76_connac_lib mt76_usb mt76 mac80211
cfg80211 rfkill hid_generic usbhid uas hid usb_storage nvidia_drm(PO)
nvidia_modeset(PO) nvidia(PO) snd_hda_codec_idt snd_hda_codec_hdmi
snd_hda_codec_generic snd_hda_intel coretemp dell_pc
Nov 14 20:03:15 darkstar kernel:  snd_intel_dspcfg dell_smbios gpio_ich
dell_wmi_descriptor drm_ttm_helper platform_profile snd_intel_sdw_acpi ppdev
ttm kvm_intel dcdbas drm_kms_helper snd_hda_codec dell_smm_hwmon kvm
snd_hda_core sha512_ssse3 drm snd_hwdep i2c_i801 sha256_ssse3 agpgart tg3
mptsas sha1_ssse3 serio_raw i2c_mux snd_pcm video mptspi xhci_pci mptscsih =
wmi
uhci_hcd lpc_ich i2c_smbus xhci_pci_renesas snd_timer i2c_c
ore snd libphy mfd_core mptbase soundcore i5k_amb ehci_pci xhci_hcd ehci_hcd
intel_rng tpm_tis parport_pc tpm_tis_core parport evdev loop
Nov 14 20:03:15 darkstar kernel: ---[ end trace 0000000000000000 ]---
Nov 14 20:03:15 darkstar kernel: RIP: 0010:hci_unregister_dev+0x43/0x190
[bluetooth]
Nov 14 20:03:15 darkstar kernel: Code: f0 80 8b e1 0e 00 00 08 48 89 ef e8 =
47
10 58 d1 48 c7 c7 a8 86 ea c4 e8 bb 71 58 d1 48 8b 13 48 8b 43 08 48 c7 c7 =
a8
86 ea c4 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad
de 48 89 03 48 83
Nov 14 20:03:15 darkstar kernel: RSP: 0018:ffff974e43de7d28 EFLAGS: 00010246
Nov 14 20:03:15 darkstar kernel: RAX: dead000000000122 RBX: ffff88de69aa6000
RCX: 0000000000000000
Nov 14 20:03:15 darkstar kernel: RDX: dead000000000100 RSI: ffff88dc1b6d0a10
RDI: ffffffffc4ea86a8
Nov 14 20:03:15 darkstar kernel: RBP: ffff88de69aa64d0 R08: 0000000000000001
R09: 0000000000000000
Nov 14 20:03:15 darkstar kernel: R10: 0000000080150010 R11: 0000000000000000
R12: ffff88de69aa6000
Nov 14 20:03:15 darkstar kernel: R13: ffffffffc4f0c278 R14: ffffffffc4f0c278
R15: ffff88dc200e8450
Nov 14 20:03:15 darkstar kernel: FS:  0000000000000000(0000)
GS:ffff88e31fd80000(0000) knlGS:0000000000000000
Nov 14 20:03:15 darkstar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Nov 14 20:03:15 darkstar kernel: CR2: 00007fa25a5f7cf0 CR3: 000000014dab6000
CR4: 00000000000006f0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
