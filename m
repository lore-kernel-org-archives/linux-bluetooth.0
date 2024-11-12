Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AA21A4D9
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449432; cv=none; b=OMwRtBSvSr1ULYxmxKwVP7uq+l3KLy7CGvNk09sWa/4W+eCOPpg9RnX+ijSz2LTc6axVMLmrKMb2jB1CNnLdy4j5T6y9Qexx8cHWfnTO55sbc5jQSfuRIuvQsZ6SDpCBoLNEfIWQm4mEdS+89LKoDwFSypr3N/aAr/eaESFhF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449432; c=relaxed/simple;
	bh=GG0vqdEBQgWJXrVPHGIt6nE9sWFQA+XIuie6njSLRh0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jRpv+KcoN4VwIqiQLBaTjd1Apa6h1j1ne6jMM3+4TtmHHWxzbODodWcbp+ehyNmZvU1x/quxOxWwmYFsns/DRVYY7K+SoMlnfby2yJHgL0VtGPTik+2e75QwHh3SuvR6eQg1Fn8S0VRVIFyEmIUORDk85q7/q/vFPl9txp8llJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBU6r74c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBU6r74c"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C9F0C4CED5
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 22:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731449432;
	bh=GG0vqdEBQgWJXrVPHGIt6nE9sWFQA+XIuie6njSLRh0=;
	h=From:To:Subject:Date:From;
	b=IBU6r74c9C7D3UwYY827TzCr2qXOnpNKCPPAwNiaPKHTPJuj9j8/tsdso04LIHWWb
	 emngYiTJfU73mbGGwzrBILlbL7EKgxhsYx03n9bdqdmoZxqBOx4MGUWovF2efhxC4u
	 nnYPthLtctJAlJqWvlnlXctey9zQAFHrox1yqNm4FsIJkn0Dksw+RoSh3no51mgbkO
	 Pi+66QV0D9cKPbevT/Q99CqNKHvhVDDmOohFPOVi9SpkZqGxETmlQ0P11I3nWCRgeB
	 Vi4+innDJV3yFINehw8u0tgwZz7SNK+2CjN4hVnh7ES++Rt2lW2S038kpY7zLxxMaf
	 KCHK66+xXnRRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F23CBC53BC2; Tue, 12 Nov 2024 22:10:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219494] New: Mediatek MT7921U WIFI + bluetooth USB Dongle -
 System Crash - Cold Boot
Date: Tue, 12 Nov 2024 22:10:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219494-62941@https.bugzilla.kernel.org/>
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

            Bug ID: 219494
           Summary: Mediatek MT7921U WIFI + bluetooth USB Dongle - System
                    Crash - Cold Boot
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mail@nelsongaspar.com
        Regression: No

Everything ok in 6.10.13, after this kernel version, including in 6.11.7,
system crashes at boot.

System info (with bluetooth blacklisted):
Linux darkstar.lan 6.11.7 #1 SMP PREEMPT_DYNAMIC Fri Nov  8 14:44:36 CST 20=
24
x86_64 Intel(R) Xeon(R) CPU           X5355  @ 2.66GHz GenuineIntel GNU/Lin=
ux

Distribution: Slackware Current x86_64

The issue is in Bluetooth, if I blacklist bluetooth system boots ok.


with: 6.10.13 (device info, COMFAST AX1800 WIFI 6 CF-953AX):
[ 123.826015] mt7921u 7-3:1.3: timed out waiting for pending tx
[ 126.103753] usb 7-3: new SuperSpeed USB device number 6 using xhci_hcd
[ 126.119468] usb 7-3: New USB device found, idVendor=3D0e8d, idProduct=3D7=
961,
bcdDevice=3D 1.00
[ 126.119482] usb 7-3: New USB device strings: Mfr=3D6, Product=3D7, Serial=
Number=3D8
[ 126.119485] usb 7-3: Product: Wireless_Device
[ 126.119488] usb 7-3: Manufacturer: MediaTek Inc.
[ 126.119490] usb 7-3: SerialNumber: 000000000
[ 126.163757] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time:
20240826151221
[ 128.744826] Bluetooth: hci0: Device setup in 2524215 usecs
[ 128.744850] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.


With more recent kernel versions (syslog):

Oct 21 20:07:16 darkstar kernel: RIP: 0010:hci_unregister_dev+0x43/0x190
[bluetooth]
Oct 21 20:07:16 darkstar kernel: Code: f0 80 8b e1 0e 00 00 08 48 89 ef e8 =
c7
80 8d d0 48 c7 c7 a8 f6 b4 c0 e8 3b e2 8d d0 48 8b 13 48 8b 43 08 48 c7 c7 =
a8
f6 b4 c0 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 03 48 83
Oct 21 20:07:16 darkstar kernel: RSP: 0018:ffff9bcf81503a60 EFLAGS: 00010246
Oct 21 20:07:16 darkstar kernel: RAX: dead000000000122 RBX: ffff8d1c02c52000
RCX: 0000000000000000
Oct 21 20:07:16 darkstar kernel: RDX: dead000000000100 RSI: ffff8d1c0869c890
RDI: ffffffffc0b4f6a8
Oct 21 20:07:16 darkstar kernel: RBP: ffff8d1c02c524d0 R08: 0000000000000001
R09: 0000000000000000
Oct 21 20:07:16 darkstar kernel: R10: 000000008015000c R11: 0000000000000000
R12: ffff8d1c02c52000
Oct 21 20:07:16 darkstar kernel: R13: ffffffffc0bbc278 R14: ffffffffc0bbc278
R15: ffff8d1c06291c50
Oct 21 20:07:16 darkstar kernel: FS: 00007f9f6f416740(0000)
GS:ffff8d233fd40000(0000) knlGS:0000000000000000
Oct 21 20:07:16 darkstar kernel: CS: 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 21 20:07:16 darkstar kernel: CR2: 00007ffe8a296658 CR3: 000000010277e000
CR4: 00000000000006f0
Oct 21 20:07:16 darkstar kernel: Call Trace:
Oct 21 20:07:16 darkstar kernel: <TASK>
Oct 21 20:07:16 darkstar kernel: ? die_addr.cold+0x8/0xd
Oct 21 20:07:16 darkstar kernel: ? exc_general_protection+0x1c4/0x460
Oct 21 20:07:16 darkstar kernel: ? asm_exc_general_protection+0x22/0x30
Oct 21 20:07:16 darkstar kernel: ? hci_unregister_dev+0x43/0x190 [bluetooth]
Oct 21 20:07:16 darkstar kernel: btusb_disconnect+0x5e/0x130 [btusb]
Oct 21 20:07:16 darkstar kernel: usb_unbind_interface+0x8f/0x280
Oct 21 20:07:16 darkstar kernel: device_release_driver_internal+0x198/0x200
Oct 21 20:07:16 darkstar kernel: usb_forced_unbind_intf+0x38/0x80
Oct 21 20:07:16 darkstar kernel: usb_reset_device+0xe4/0x240
Oct 21 20:07:16 darkstar kernel: mt7921u_probe+0xa7/0x200 [mt7921u]
Oct 21 20:07:16 darkstar kernel: usb_probe_interface+0xda/0x250
Oct 21 20:07:16 darkstar kernel: really_probe+0xd9/0x270
Oct 21 20:07:16 darkstar kernel: ? pm_runtime_barrier+0x50/0x90
Oct 21 20:07:16 darkstar kernel: ? __pfx___driver_attach+0x10/0x10
Oct 21 20:07:16 darkstar kernel: __driver_probe_device+0x73/0xf0
Oct 21 20:07:16 darkstar kernel: driver_probe_device+0x1f/0xf0
Oct 21 20:07:16 darkstar kernel: __driver_attach+0x84/0x180
Oct 21 20:07:16 darkstar kernel: bus_for_each_dev+0x8b/0xe0
Oct 21 20:07:16 darkstar kernel: bus_add_driver+0xe4/0x1d0
Oct 21 20:07:16 darkstar kernel: driver_register+0x6e/0xc0
Oct 21 20:07:16 darkstar kernel: usb_register_driver+0x88/0x130
Oct 21 20:07:16 darkstar kernel: ? __pfx_mt7921u_driver_init+0x10/0x10
[mt7921u]
Oct 21 20:07:16 darkstar kernel: do_one_initcall+0x57/0x300
Oct 21 20:07:16 darkstar kernel: do_init_module+0x60/0x220
Oct 21 20:07:16 darkstar kernel: init_module_from_file+0x86/0xc0
Oct 21 20:07:16 darkstar kernel: idempotent_init_module+0x121/0x320
Oct 21 20:07:16 darkstar kernel: __x64_sys_finit_module+0x58/0x90
Oct 21 20:07:16 darkstar kernel: do_syscall_64+0x47/0x110
Oct 21 20:07:16 darkstar kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Oct 21 20:07:16 darkstar kernel: RIP: 0033:0x7f9f6f320229
Oct 21 20:07:16 darkstar kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 =
0f
1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d af db 0d 00 f7 d8 64 89 01 48
Oct 21 20:07:16 darkstar kernel: RSP: 002b:00007ffe8a2a2218 EFLAGS: 00000246
ORIG_RAX: 0000000000000139
Oct 21 20:07:16 darkstar kernel: RAX: ffffffffffffffda RBX: 000000000d049d20
RCX: 00007f9f6f320229
Oct 21 20:07:16 darkstar kernel: RDX: 0000000000000000 RSI: 00007f9f6f545379
RDI: 0000000000000012
Oct 21 20:07:16 darkstar kernel: RBP: 0000000000000000 R08: 0000000000000002
R09: 0000000000000000
Oct 21 20:07:16 darkstar kernel: R10: 0000000000000040 R11: 0000000000000246
R12: 00007f9f6f545379
Oct 21 20:07:16 darkstar kernel: R13: 0000000000020000 R14: 000000000d042290
R15: 0000000000000000
Oct 21 20:07:16 darkstar kernel: </TASK>
Oct 21 20:07:16 darkstar kernel: Modules linked in: st joydev mt7921u(+)
mt792x_usb mt7921_common mt792x_lib mt76_connac_lib mt76_usb mt76 mac80211
btusb btrtl btintel btbcm btmtk hid_generic cfg80211 bluetooth usbhid rfkill
hid dell_pc dell_smbios dell_wmi_descriptor platform_profile dcdbas
dell_smm_hwmon gpio_ich wmi snd_hda_codec_idt snd_hda_codec_generic
snd_hda_codec_hdmi coretemp snd_hda_intel snd_intel_dspcfg snd_intel_sdw_ac=
pi
snd_hda_codec kvm_intel snd_hda_core snd_hwdep kvm snd_pcm sha512_ssse3
i2c_i801 snd_timer mptsas mptspi uhci_hcd sha256_ssse3 i2c_mux sha1_ssse3 t=
g3
lpc_ich xhci_pci mptscsih snd xhci_pci_renesas i2c_smbus ehci_pci mfd_core
soundcore mptbase libphy tpm_tis xhci_hcd i2c_core i5k_amb ehci_hcd serio_r=
aw
tpm_tis_core intel_rng evdev loop
Oct 21 20:07:16 darkstar kernel: ---[ end trace 0000000000000000 ]---
Oct 21 20:07:16 darkstar kernel: RIP: 0010:hci_unregister_dev+0x43/0x190
[bluetooth]
Oct 21 20:07:16 darkstar kernel: Code: f0 80 8b e1 0e 00 00 08 48 89 ef e8 =
c7
80 8d d0 48 c7 c7 a8 f6 b4 c0 e8 3b e2 8d d0 48 8b 13 48 8b 43 08 48 c7 c7 =
a8
f6 b4 c0 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 03 48 83
Oct 21 20:07:16 darkstar kernel: RSP: 0018:ffff9bcf81503a60 EFLAGS: 00010246
Oct 21 20:07:16 darkstar kernel: RAX: dead000000000122 RBX: ffff8d1c02c52000
RCX: 0000000000000000
Oct 21 20:07:16 darkstar kernel: RDX: dead000000000100 RSI: ffff8d1c0869c890
RDI: ffffffffc0b4f6a8
Oct 21 20:07:16 darkstar kernel: RBP: ffff8d1c02c524d0 R08: 0000000000000001
R09: 0000000000000000
Oct 21 20:07:16 darkstar kernel: R10: 000000008015000c R11: 0000000000000000
R12: ffff8d1c02c52000
Oct 21 20:07:16 darkstar kernel: R13: ffffffffc0bbc278 R14: ffffffffc0bbc278
R15: ffff8d1c06291c50
Oct 21 20:07:16 darkstar kernel: FS: 00007f9f6f416740(0000)
GS:ffff8d233fd40000(0000) knlGS:0000000000000000
Oct 21 20:07:16 darkstar kernel: CS: 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 21 20:07:16 darkstar kernel: CR2: 00007ffe8a296658 CR3: 000000010277e000
CR4: 00000000000006f0
Oct 21 20:07:16 darkstar udevd[577]: worker [599] failed while handling
'/devices/pci0000:00/0000:00:02.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/us=
b4/4-3/4-3:1.3'
Oct 21 20:07:21 darkstar kernel: xfs filesystem being remounted at / suppor=
ts
timestamps until 2038-01-19 (0x7fffffff)
Oct 21 20:07:22 darkstar kernel: ip_local_port_range: prefer different pari=
ty
for start/end values.
Oct 21 20:07:23 darkstar kernel: xfs filesystem being mounted at /home supp=
orts
timestamps until 2038-01-19 (0x7fffffff)
Oct 21 20:07:24 darkstar kernel: xfs filesystem being mounted at /mnt/DADOS
supports timestamps until 2038-01-19 (0x7fffffff)
Oct 21 20:07:25 darkstar kernel: xfs filesystem being mounted at /mnt/OUTROS
supports timestamps until 2038-01-19 (0x7fffffff)
Oct 21 20:07:25 darkstar kernel: xfs filesystem being mounted at /mnt/MATIL=
DE
supports timestamps until 2038-01-19 (0x7fffffff)
Oct 21 20:09:31 darkstar bluetoothd[1326]: src/plugin.c:init_plugin() System
does not support bap plugin
Oct 21 20:09:31 darkstar bluetoothd[1326]: src/plugin.c:init_plugin() System
does not support bass plugin
Oct 21 20:09:31 darkstar bluetoothd[1326]: src/plugin.c:init_plugin() System
does not support mcp plugin
Oct 21 20:09:31 darkstar bluetoothd[1326]: src/plugin.c:init_plugin() System
does not support vcp plugin
Oct 21 20:09:31 darkstar bluetoothd[1326]: profiles/audio/micp.c:micp_init()
D-Bus experimental not enabled
Oct 21 20:09:31 darkstar bluetoothd[1326]: src/plugin.c:init_plugin() System
does not support micp plugin
Oct 21 20:09:31 darkstar bluetoothd[1326]: src/plugin.c:init_plugin() System
does not support ccp plugin
Oct 21 20:09:31 darkstar bluetoothd[1326]: src/plugin.c:init_plugin() System
does not support csip plugin
Oct 21 20:09:31 darkstar bluetoothd[1326]: src/plugin.c:init_plugin() System
does not support asha plugin
Oct 21 20:10:31 darkstar kernel: rcu: INFO: rcu_preempt self-detected stall=
 on
CPU
Oct 21 20:10:31 darkstar kernel: rcu: \x095-....: (59999 ticks this GP)
idle=3D8ecc/1/0x4000000000000000 softirq=3D1583/1583 fqs=3D14999
Oct 21 20:10:31 darkstar kernel: rcu: \x09(t=3D60000 jiffies g=3D2725 q=3D2=
98
ncpus=3D8)
Oct 21 20:10:31 darkstar kernel: CPU: 5 UID: 0 PID: 1327 Comm: hciconfig
Tainted: G D I 6.11.4 #1
Oct 21 20:10:31 darkstar kernel: Tainted: [D]=3DDIE, [I]=3DFIRMWARE_WORKARO=
UND
Oct 21 20:10:31 darkstar kernel: Hardware name: Dell Inc. Precision WorkSta=
tion
690 /0MY171, BIOS A08 04/25/2008
Oct 21 20:10:31 darkstar kernel: RIP: 0010:queued_read_lock_slowpath+0x46/0=
x110
Oct 21 20:10:31 darkstar kernel: Code: 0f 1f 44 00 00 48 8d 7b 04 31 c0 ba =
01
00 00 00 f0 0f b1 53 04 0f 85 c5 00 00 00 f0 81 03 00 02 00 00 8b 03 84 c0 =
74
08 f3 90 <8b> 03 84 c0 75 f8 c6 43 04 00 66 90 5b c3 cc cc cc cc f3 90 8b 03
Oct 21 20:10:31 darkstar kernel: RSP: 0018:ffff9bcf814c3de0 EFLAGS: 00000286
Oct 21 20:10:31 darkstar kernel: RAX: 00000000000002ff RBX: ffffffffc0b4f6a8
RCX: 0000000000000000
Oct 21 20:10:31 darkstar kernel: RDX: 0000000000000001 RSI: 000000000042327c
RDI: ffffffffc0b4f6ac
Oct 21 20:10:31 darkstar kernel: RBP: 0000000000423220 R08: ffff9bcf814c3df4
R09: ffffffff910b6573
Oct 21 20:10:31 darkstar kernel: R10: ffff8d1c0b3d7b66 R11: 000000000000000a
R12: ffff9bcf814c3df4
Oct 21 20:10:31 darkstar kernel: R13: 0000000000000000 R14: ffff8d1c026a4000
R15: 0000000000000000
Oct 21 20:10:31 darkstar kernel: FS: 00007f1ccb30a740(0000)
GS:ffff8d233fd40000(0000) knlGS:0000000000000000
Oct 21 20:10:31 darkstar kernel: CS: 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 21 20:10:31 darkstar kernel: CR2: 00007f1ccb1a6921 CR3: 00000001199de000
CR4: 00000000000006f0
Oct 21 20:10:31 darkstar kernel: Call Trace:
Oct 21 20:10:31 darkstar kernel: <IRQ>
Oct 21 20:10:31 darkstar kernel: ? rcu_dump_cpu_stacks+0xcf/0x100
Oct 21 20:10:31 darkstar kernel: ? rcu_sched_clock_irq.cold+0x6d/0x2eb
Oct 21 20:10:31 darkstar kernel: ? update_load_avg+0x7e/0x7b0
Oct 21 20:10:31 darkstar kernel: ? __pfx_pvclock_gtod_notify+0x10/0x10 [kvm]
Oct 21 20:10:31 darkstar kernel: ? notifier_call_chain+0x59/0xc0
Oct 21 20:10:31 darkstar kernel: ? timekeeping_update+0xe0/0x130
Oct 21 20:10:31 darkstar kernel: ? account_process_tick+0x2f/0x150
Oct 21 20:10:31 darkstar kernel: ? update_process_times+0x7d/0xc0
Oct 21 20:10:31 darkstar kernel: ? tick_nohz_handler+0x93/0x130
Oct 21 20:10:31 darkstar kernel: ? __pfx_tick_nohz_handler+0x10/0x10
Oct 21 20:10:31 darkstar kernel: ? __hrtimer_run_queues+0x132/0x2a0
Oct 21 20:10:31 darkstar kernel: ? hrtimer_interrupt+0xfe/0x220
Oct 21 20:10:31 darkstar kernel: ? __sysvec_apic_timer_interrupt+0x6b/0x160
Oct 21 20:10:31 darkstar kernel: ? sysvec_apic_timer_interrupt+0x98/0xc0
Oct 21 20:10:31 darkstar kernel: </IRQ>
Oct 21 20:10:31 darkstar kernel: <TASK>
Oct 21 20:10:31 darkstar kernel: ? asm_sysvec_apic_timer_interrupt+0x16/0x20
Oct 21 20:10:31 darkstar kernel: ? kmalloc_reserve+0x93/0x100
Oct 21 20:10:31 darkstar kernel: ? queued_read_lock_slowpath+0x46/0x110
Oct 21 20:10:31 darkstar kernel: hci_get_dev_info+0x7c/0x290 [bluetooth]
Oct 21 20:10:31 darkstar kernel: sock_do_ioctl+0x7e/0x130
Oct 21 20:10:31 darkstar kernel: __x64_sys_ioctl+0x93/0xd0
Oct 21 20:10:31 darkstar kernel: do_syscall_64+0x47/0x110
Oct 21 20:10:31 darkstar kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Oct 21 20:10:31 darkstar kernel: RIP: 0033:0x7f1ccb11e098
Oct 21 20:10:31 darkstar kernel: Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 =
48
89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 =
00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 39 fd 0d
Oct 21 20:10:31 darkstar kernel: RSP: 002b:00007fffaa1540b8 EFLAGS: 00000206
ORIG_RAX: 0000000000000010
Oct 21 20:10:31 darkstar kernel: RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 00007f1ccb11e098
Oct 21 20:10:31 darkstar kernel: RDX: 0000000000423220 RSI: 00000000800448d3
RDI: 0000000000000003
Oct 21 20:10:31 darkstar kernel: RBP: 00007fffaa154228 R08: 1999999999999999
R09: 0000000000000000
Oct 21 20:10:31 darkstar kernel: R10: 0000000000000000 R11: 0000000000000206
R12: 00007fffaa154238
Oct 21 20:10:31 darkstar kernel: R13: 0000000000000003 R14: 0000000000421018
R15: 00007f1ccb3a5000
Oct 21 20:10:31 darkstar kernel: </TASK>
Oct 21 20:13:31 darkstar kernel: rcu: INFO: rcu_preempt self-detected stall=
 on
CPU
Oct 21 20:13:31 darkstar kernel: rcu: \x095-....: (240002 ticks this GP)
idle=3D8ecc/1/0x4000000000000000 softirq=3D1583/1583 fqs=3D60000
Oct 21 20:13:31 darkstar kernel: rcu: \x09(t=3D240003 jiffies g=3D2725 q=3D=
697
ncpus=3D8)
Oct 21 20:13:31 darkstar kernel: CPU: 5 UID: 0 PID: 1327 Comm: hciconfig
Tainted: G D I 6.11.4 #1
Oct 21 20:13:31 darkstar kernel: Tainted: [D]=3DDIE, [I]=3DFIRMWARE_WORKARO=
UND
Oct 21 20:13:31 darkstar kernel: Hardware name: Dell Inc. Precision WorkSta=
tion
690 /0MY171, BIOS A08 04/25/2008
Oct 21 20:13:31 darkstar kernel: RIP: 0010:queued_read_lock_slowpath+0x48/0=
x110
Oct 21 20:13:31 darkstar kernel: Code: 44 00 00 48 8d 7b 04 31 c0 ba 01 00 =
00
00 f0 0f b1 53 04 0f 85 c5 00 00 00 f0 81 03 00 02 00 00 8b 03 84 c0 74 08 =
f3
90 8b 03 <84> c0 75 f8 c6 43 04 00 66 90 5b c3 cc cc cc cc f3 90 8b 03 84 c0
Oct 21 20:13:31 darkstar kernel: RSP: 0018:ffff9bcf814c3de0 EFLAGS: 00000286
Oct 21 20:13:31 darkstar kernel: RAX: 00000000000002ff RBX: ffffffffc0b4f6a8
RCX: 0000000000000000
Oct 21 20:13:31 darkstar kernel: RDX: 0000000000000001 RSI: 000000000042327c
RDI: ffffffffc0b4f6ac
Oct 21 20:13:31 darkstar kernel: RBP: 0000000000423220 R08: ffff9bcf814c3df4
R09: ffffffff910b6573
Oct 21 20:13:31 darkstar kernel: R10: ffff8d1c0b3d7b66 R11: 000000000000000a
R12: ffff9bcf814c3df4
Oct 21 20:13:31 darkstar kernel: R13: 0000000000000000 R14: ffff8d1c026a4000
R15: 0000000000000000
Oct 21 20:13:31 darkstar kernel: FS: 00007f1ccb30a740(0000)
GS:ffff8d233fd40000(0000) knlGS:0000000000000000
Oct 21 20:13:31 darkstar kernel: CS: 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 21 20:13:31 darkstar kernel: CR2: 00007f1ccb1a6921 CR3: 00000001199de000
CR4: 00000000000006f0
Oct 21 20:13:31 darkstar kernel: Call Trace:
Oct 21 20:13:31 darkstar kernel: <IRQ>
Oct 21 20:13:31 darkstar kernel: ? rcu_dump_cpu_stacks+0xcf/0x100
Oct 21 20:13:31 darkstar kernel: ? rcu_sched_clock_irq.cold+0x6d/0x2eb
Oct 21 20:13:31 darkstar kernel: ? update_load_avg+0x7e/0x7b0
Oct 21 20:13:31 darkstar kernel: ? __pfx_pvclock_gtod_notify+0x10/0x10 [kvm]
Oct 21 20:13:31 darkstar kernel: ? notifier_call_chain+0x59/0xc0
Oct 21 20:13:31 darkstar kernel: ? timekeeping_update+0xe0/0x130
Oct 21 20:13:31 darkstar kernel: ? account_process_tick+0x2f/0x150
Oct 21 20:13:31 darkstar kernel: ? update_process_times+0x7d/0xc0
Oct 21 20:13:31 darkstar kernel: ? tick_nohz_handler+0x93/0x130
Oct 21 20:13:31 darkstar kernel: ? __pfx_tick_nohz_handler+0x10/0x10
Oct 21 20:13:31 darkstar kernel: ? __hrtimer_run_queues+0x132/0x2a0
Oct 21 20:13:31 darkstar kernel: ? hrtimer_interrupt+0xfe/0x220
Oct 21 20:13:31 darkstar kernel: ? __sysvec_apic_timer_interrupt+0x6b/0x160
Oct 21 20:13:31 darkstar kernel: ? sysvec_apic_timer_interrupt+0x98/0xc0
Oct 21 20:13:31 darkstar kernel: </IRQ>
Oct 21 20:13:31 darkstar kernel: <TASK>
Oct 21 20:13:31 darkstar kernel: ? asm_sysvec_apic_timer_interrupt+0x16/0x20
Oct 21 20:13:31 darkstar kernel: ? kmalloc_reserve+0x93/0x100
Oct 21 20:13:31 darkstar kernel: ? queued_read_lock_slowpath+0x48/0x110
Oct 21 20:13:31 darkstar kernel: hci_get_dev_info+0x7c/0x290 [bluetooth]
Oct 21 20:13:31 darkstar kernel: sock_do_ioctl+0x7e/0x130
Oct 21 20:13:31 darkstar kernel: __x64_sys_ioctl+0x93/0xd0
Oct 21 20:13:31 darkstar kernel: do_syscall_64+0x47/0x110
Oct 21 20:13:31 darkstar kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Oct 21 20:13:31 darkstar kernel: RIP: 0033:0x7f1ccb11e098
Oct 21 20:13:31 darkstar kernel: Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 =
48
89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 =
00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 39 fd 0d
Oct 21 20:13:31 darkstar kernel: RSP: 002b:00007fffaa1540b8 EFLAGS: 00000206
ORIG_RAX: 0000000000000010
Oct 21 20:13:31 darkstar kernel: RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 00007f1ccb11e098
Oct 21 20:13:31 darkstar kernel: RDX: 0000000000423220 RSI: 00000000800448d3
RDI: 0000000000000003
Oct 21 20:13:31 darkstar kernel: RBP: 00007fffaa154228 R08: 1999999999999999
R09: 0000000000000000
Oct 21 20:13:31 darkstar kernel: R10: 0000000000000000 R11: 0000000000000206
R12: 00007fffaa154238
Oct 21 20:13:31 darkstar kernel: R13: 0000000000000003 R14: 0000000000421018
R15: 00007f1ccb3a5000
Oct 21 20:13:31 darkstar kernel: </TASK>
Oct 21 21:10:19 darkstar syslogd[1179]: Failed creating socket for *:514:
Address family not supported by protocol

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
