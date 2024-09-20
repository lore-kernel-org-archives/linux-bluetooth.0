Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1E4AEF7
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Sep 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726864789; cv=none; b=rRIa2T1ckhggA91/DLNzForK76bUMuw7BGANXMRjL8oIB2lC8+HQ077hJhvx+RseCn8rLLpiQUHTPB2usJWBq4aj8Irm1VsliQyPJIU6fsBYT9WWxqRhng28tUeaKEr3Tl4yE1jvWZ4Q1wu2ftgFKOonLT9NrPaPYQRHGebfR+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726864789; c=relaxed/simple;
	bh=ILcUKTAsS+GAzxNiBRStkELNpwJrTzSGdjCP0ZgOJjw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nxVg2q/BA31bY2/b6Rwtbid7C3XnNvIxNYrDt0B8CECNhmzlKn5B0grARAILhehNbtAinW0YQSLOi8pe27UaGaEvfHYMfe1dboAk2lvp+AfIihZ2QbPqzbh3FNg02bOotmHwwuYah04r5ADctxOpQKBaYISeCxQNliI+g5Ry8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPf6USbP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPf6USbP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12393C4CECD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Sep 2024 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726864789;
	bh=ILcUKTAsS+GAzxNiBRStkELNpwJrTzSGdjCP0ZgOJjw=;
	h=From:To:Subject:Date:From;
	b=WPf6USbPwmG3HGGfOnmBCbuzep1UMEhXPVH6AXQwvKUy/ic8AlWOHowKYfbvwWJNa
	 6purDuKbSyTgFJmX5mHB6FW4Ud/ObH7WqNemSniNoS6t9gg3VRIEmqFXcqxmQSAFaT
	 7Bw12ELXQJyT0hfsvqafBc49mE5Hvkjv4LcwmJ4m6gDhe2dkFDhyyW+08aa40Jv7Ya
	 sXMBajZFHxTSF+cyEInXVeUnrE6hzQ+p/7sxWkpDrIjjdSlv0puMJ6kmcCOMIUUywW
	 LjoKT17A1qkzWqgggBFWJYiOa1pwx4y7Ba+zbOgVBqxryxd7I91tzc5exmdYalDXRf
	 eRszgAfOvU4uA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 04353C53BC4; Fri, 20 Sep 2024 20:39:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] New: NULL dereference pointer in Bluetooth at boot
Date: Fri, 20 Sep 2024 20:39:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: casteyde.christian@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219294-62941@https.bugzilla.kernel.org/>
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

            Bug ID: 219294
           Summary: NULL dereference pointer in Bluetooth at boot
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: casteyde.christian@free.fr
        Regression: No

Created attachment 306904
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306904&action=3Dedit
lsusb output

Since Kernel 6.11 compiled from vanilla source, I get occasionnaly an Oops =
at
boot on my Lenovo Slim 5.
This is a regression.

Kernel 6.11 / Slackware 64 (Slackware 15 + recent Mesa).
AMD 7840HS 16Go
When the problem occurs, the boot doesn't finish, but I got the following in
syslog:
Sep 19 19:57:15 latile dnsmasq[924]: no servers found in
/etc/dnsmasq.d/dnsmasq-resolv.conf, will retry
Sep 20 22:22:29 latile kernel: ACPI BIOS Error (bug): Could not resolve sym=
bol
[\_SB.PCI0.GP18.SATA], AE_NOT_FOUND (20240322/dswload2-162)
Sep 20 22:22:29 latile kernel: ACPI Error: AE_NOT_FOUND, During name
lookup/catalog (20240322/psobject-220)
Sep 20 22:22:29 latile kernel: ACPI BIOS Error (bug): Failure creating named
object [\_SB.PCI0.GPP6.WLAN._S0W], AE_ALREADY_EXISTS (20240322/dswload2-32
6)
Sep 20 22:22:29 latile kernel: ACPI Error: AE_ALREADY_EXISTS, During name
lookup/catalog (20240322/psobject-220)
Sep 20 22:22:31 latile kernel: i8042: PNP: PS/2 appears to have AUX port
disabled, if this is incorrect please boot with i8042.nopnp
Sep 20 22:22:34 latile kernel: Bluetooth: hci0: HCI Enhanced Setup Synchron=
ous
Connection command is advertised, but not supported.
Sep 20 22:22:37 latile kernel: BUG: kernel NULL pointer dereference, addres=
s:
0000000000000000
Sep 20 22:22:37 latile kernel: #PF: supervisor read access in kernel mode
Sep 20 22:22:37 latile kernel: #PF: error_code(0x0000) - not-present page
Sep 20 22:22:37 latile kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
Sep 20 22:22:37 latile kernel: CPU: 2 UID: 0 PID: 153 Comm: kworker/2:1 Not
tainted 6.11.0 #1
Sep 20 22:22:37 latile kernel: Hardware name: LENOVO 82Y9/LNVNB161216, BIOS
M3CN42WW 01/11/2024
Sep 20 22:22:37 latile kernel: Workqueue: pm pm_runtime_work
Sep 20 22:22:37 latile kernel: RIP: 0010:btusb_suspend+0x14/0x1b0
Sep 20 22:22:37 latile kernel: Code: e4 10 00 83 80 d4 0a 00 00 01 eb db 66=
 2e
0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44 00 00 41 54 55 53 48 8b 9f=20
c8 00 00 00 <48> 8b 13 8b 82 bc 09 00 00 03 82 b8 09 00 00 03 82 c4 09 00 0=
0 03
Sep 20 22:22:37 latile kernel: RSP: 0018:ffffbf1280b67ca0 EFLAGS: 00010206
Sep 20 22:22:37 latile kernel: RAX: ffffffffa62de3b0 RBX: 0000000000000000 =
RCX:
0000000000000002
Sep 20 22:22:37 latile kernel: RDX: 0000000000000003 RSI: 0000000000000402 =
RDI:
ffff9bcc85e17000
Sep 20 22:22:37 latile kernel: RBP: ffff9bcc85e17000 R08: ffff9bcc8930e800 =
R09:
ffff9bcc85e174b0
Sep 20 22:22:37 latile kernel: R10: 0000000000000003 R11: 0000000000000063 =
R12:
0000000000000402
Sep 20 22:22:37 latile kernel: R13: 0000000000000003 R14: 0000000000000000 =
R15:
ffff9bcc8930e800
Sep 20 22:22:37 latile kernel: FS:  0000000000000000(0000)
GS:ffff9bcfae480000(0000) knlGS:0000000000000000
Sep 20 22:22:37 latile kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep 20 22:22:37 latile kernel: CR2: 0000000000000000 CR3: 000000035f82a000 =
CR4:
0000000000750ef0
Sep 20 22:22:37 latile kernel: PKRU: 55555554
Sep 20 22:22:37 latile kernel: Call Trace:
Sep 20 22:22:37 latile kernel:  <TASK>
Sep 20 22:22:37 latile kernel:  ? __die+0x23/0x70
Sep 20 22:22:37 latile kernel:  ? page_fault_oops+0x159/0x520
Sep 20 22:22:37 latile kernel:  ? exc_page_fault+0x404/0x740
Sep 20 22:22:37 latile kernel:  ? asm_exc_page_fault+0x26/0x30
Sep 20 22:22:37 latile kernel:  ? btusb_isoc_tx_complete+0x60/0x60
Sep 20 22:22:37 latile kernel:  ? btusb_suspend+0x14/0x1b0
Sep 20 22:22:37 latile kernel:  usb_suspend_both+0x94/0x280
Sep 20 22:22:37 latile kernel:  usb_runtime_suspend+0x2e/0x70
Sep 20 22:22:37 latile kernel:  ? usb_autoresume_device+0x50/0x50
Sep 20 22:22:37 latile kernel:  __rpm_callback+0x41/0x170
Sep 20 22:22:37 latile kernel:  ? usb_autoresume_device+0x50/0x50
Sep 20 22:22:37 latile kernel:  rpm_callback+0x55/0x60
Sep 20 22:22:37 latile kernel:  ? usb_autoresume_device+0x50/0x50
Sep 20 22:22:37 latile kernel:  rpm_suspend+0xe8/0x5e0
Sep 20 22:22:37 latile kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Sep 20 22:22:37 latile last message buffered 1 times
Sep 20 22:22:37 latile kernel:  ? finish_task_switch.isra.0+0x96/0x2a0
Sep 20 22:22:37 latile kernel:  __pm_runtime_suspend+0x3c/0xd0
Sep 20 22:22:37 latile kernel:  ? usb_runtime_resume+0x20/0x20
Sep 20 22:22:37 latile kernel:  usb_runtime_idle+0x35/0x40
Sep 20 22:22:37 latile kernel:  rpm_idle+0xbd/0x270
Sep 20 22:22:37 latile kernel:  pm_runtime_work+0x84/0xb0
Sep 20 22:22:37 latile kernel:  process_one_work+0x16d/0x380
Sep 20 22:22:37 latile kernel:  worker_thread+0x2cb/0x3e0
Sep 20 22:22:37 latile kernel:  ? _raw_spin_lock_irqsave+0x1b/0x50
Sep 20 22:22:37 latile kernel:  ? cancel_delayed_work_sync+0x80/0x80
Sep 20 22:22:37 latile kernel:  kthread+0xde/0x110
Sep 20 22:22:37 latile kernel:  ? kthread_park+0x90/0x90
Sep 20 22:22:37 latile kernel:  ret_from_fork+0x31/0x50
Sep 20 22:22:37 latile kernel:  ? kthread_park+0x90/0x90
Sep 20 22:22:37 latile kernel:  ret_from_fork_asm+0x11/0x20
Sep 20 22:22:37 latile kernel:  </TASK>
Sep 20 22:22:37 latile kernel: Modules linked in:
Sep 20 22:22:37 latile kernel: CR2: 0000000000000000
Sep 20 22:22:37 latile kernel: ---[ end trace 0000000000000000 ]---
Sep 20 22:22:37 latile kernel: RIP: 0010:btusb_suspend+0x14/0x1b0
Sep 20 22:22:37 latile kernel: Code: e4 10 00 83 80 d4 0a 00 00 01 eb db 66=
 2e
0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44 00 00 41 54 55 53 48 8b 9f c8 =
00
00 00 <48> 8b 13 8b 82 bc 09 00 00 03 82 b8 09 00 00 03 82 c4 09 00 00 03
Sep 20 22:22:37 latile kernel: RSP: 0018:ffffbf1280b67ca0 EFLAGS: 00010206
Sep 20 22:22:37 latile kernel: RAX: ffffffffa62de3b0 RBX: 0000000000000000 =
RCX:
0000000000000002
Sep 20 22:22:37 latile kernel: RDX: 0000000000000003 RSI: 0000000000000402 =
RDI:
ffff9bcc85e17000
Sep 20 22:22:37 latile kernel: RBP: ffff9bcc85e17000 R08: ffff9bcc8930e800 =
R09:
ffff9bcc85e174b0
Sep 20 22:22:37 latile kernel: R10: 0000000000000003 R11: 0000000000000063 =
R12:
0000000000000402
Sep 20 22:22:37 latile kernel: R13: 0000000000000003 R14: 0000000000000000 =
R15:
ffff9bcc8930e800
Sep 20 22:22:37 latile kernel: FS:  0000000000000000(0000)
GS:ffff9bcfae480000(0000) knlGS:0000000000000000
Sep 20 22:22:37 latile kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep 20 22:22:37 latile kernel: CR2: 0000000000000000 CR3: 000000035f82a000 =
CR4:
0000000000750ef0
Sep 20 22:22:37 latile kernel: PKRU: 55555554
Sep 20 22:22:42 latile kernel: warning: `iwconfig' uses wireless extensions
which will stop working for Wi-Fi 7 hardware; use nl80211
Sep 20 22:22:49 latile bluetoothd[810]: src/plugin.c:plugin_init() System d=
oes
not support csip plugin
Sep 20 22:22:49 latile bluetoothd[810]: profiles/audio/micp.c:micp_init() D=
-Bus
experimental not enabled
Sep 20 22:22:49 latile bluetoothd[810]: src/plugin.c:plugin_init() System d=
oes
not support micp plugin
Sep 20 22:22:49 latile bluetoothd[810]: src/plugin.c:plugin_init() System d=
oes
not support vcp plugin
Sep 20 22:22:49 latile bluetoothd[810]: src/plugin.c:plugin_init() System d=
oes
not support mcp plugin
Sep 20 22:22:49 latile bluetoothd[810]: src/plugin.c:plugin_init() System d=
oes
not support bass plugin
Sep 20 22:22:49 latile bluetoothd[810]: src/plugin.c:plugin_init() System d=
oes
not support bap plugin
Sep 20 22:24:10 latile kernel: ACPI BIOS Error (bug): Could not resolve sym=
bol
[\_SB.PCI0.GP18.SATA], AE_NOT_FOUND (20240322/dswload2-162)
Sep 20 22:24:10 latile kernel: ACPI Error: AE_NOT_FOUND, During name
lookup/catalog (20240322/psobject-220)
Sep 20 22:24:10 latile kernel: ACPI BIOS Error (bug): Failure creating named
object [\_SB.PCI0.GPP6.WLAN._S0W], AE_ALREADY_EXISTS (20240322/dswload2-326)
Sep 20 22:24:10 latile kernel: ACPI Error: AE_ALREADY_EXISTS, During name
lookup/catalog (20240322/psobject-220)
Sep 20 22:24:12 latile kernel: i8042: PNP: PS/2 appears to have AUX port
disabled, if this is incorrect please boot with i8042.nopnp
Sep 20 22:24:16 latile kernel: Bluetooth: hci0: HCI Enhanced Setup Synchron=
ous
Connection command is advertised, but not supported.
Sep 20 22:24:19 latile kernel: warning: `iwconfig' uses wireless extensions
which will stop working for Wi-Fi 7 hardware; use nl80211
Sep 20 22:24:25 latile bluetoothd[807]: src/plugin.c:plugin_init() System d=
oes
not support csip plugin
Sep 20 22:24:25 latile bluetoothd[807]: profiles/audio/micp.c:micp_init() D=
-Bus
experimental not enabled
Sep 20 22:24:25 latile bluetoothd[807]: src/plugin.c:plugin_init() System d=
oes
not support micp plugin
Sep 20 22:24:25 latile bluetoothd[807]: src/plugin.c:plugin_init() System d=
oes
not support vcp plugin
Sep 20 22:24:25 latile bluetoothd[807]: src/plugin.c:plugin_init() System d=
oes
not support mcp plugin
Sep 20 22:24:25 latile bluetoothd[807]: src/plugin.c:plugin_init() System d=
oes
not support bass plugin
Sep 20 22:24:25 latile bluetoothd[807]: src/plugin.c:plugin_init() System d=
oes
not support bap plugin
Sep 20 22:24:25 latile kernel: Bluetooth: hci0: HCI Enhanced Setup Synchron=
ous
Connection command is advertised, but not supported.
Sep 20 22:24:26 latile bluetoothd[807]: Failed to set privacy: Rejected (0x=
0b)


Previously, I also got this Oops:

Sep 17 21:53:06 latile kernel: i8042: PNP: PS/2 appears to have AUX port
disabled, if this is incorrect please boot with i8042.nopnp
Sep 17 21:53:10 latile kernel: Bluetooth: hci0: HCI Enhanced Setup Synchron=
ous
Connection command is advertised, but not supported.
Sep 17 21:53:14 latile kernel: warning: `iwconfig' uses wireless extensions
which will stop working for Wi-Fi 7 hardware; use nl80211
Sep 17 21:53:22 latile bluetoothd[828]: src/plugin.c:plugin_init() System d=
oes
not support csip plugin
Sep 17 21:53:22 latile bluetoothd[828]: profiles/audio/micp.c:micp_init() D=
-Bus
experimental not enabled
Sep 17 21:53:22 latile bluetoothd[828]: src/plugin.c:plugin_init() System d=
oes
not support micp plugin
Sep 17 21:53:22 latile bluetoothd[828]: src/plugin.c:plugin_init() System d=
oes
not support vcp plugin
Sep 17 21:53:22 latile bluetoothd[828]: src/plugin.c:plugin_init() System d=
oes
not support mcp plugin
Sep 17 21:53:22 latile bluetoothd[828]: src/plugin.c:plugin_init() System d=
oes
not support bass plugin
Sep 17 21:53:22 latile bluetoothd[828]: src/plugin.c:plugin_init() System d=
oes
not support bap plugin
Sep 17 21:53:23 latile bluetoothd[828]:
src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv Monitors: N=
ot
Powered (0x0f)
Sep 17 21:53:23 latile kernel: Bluetooth: hci0: Execution of wmt command ti=
med
out
Sep 17 21:53:23 latile kernel: Bluetooth: hci0: Failed to send wmt func ctrl
(-110)
Sep 17 21:53:23 latile kernel: Oops: general protection fault, probably for
non-canonical address 0xdead000000000108: 0000 [#1] PREEMPT SMP NOPTI
Sep 17 21:53:23 latile kernel: CPU: 6 UID: 0 PID: 151 Comm: kworker/u65:0 N=
ot
tainted 6.11.0 #1
Sep 17 21:53:23 latile kernel: Hardware name: LENOVO 82Y9/LNVNB161216, BIOS
M3CN42WW 01/11/2024
Sep 17 21:53:23 latile kernel: Workqueue: hci0 hci_cmd_sync_work
Sep 17 21:53:23 latile kernel: RIP: 0010:mgmt_pending_remove+0x10/0x40
Sep 17 21:53:23 latile kernel: Code: 00 be 03 00 00 00 48 89 d7 e8 cc 2b 26=
 ff
eb d1 66 2e 0f 1f 84 00 00 00 00 00 66 0f 1f 00 0f 1f 44 00 00 48 8b 47=20
08 48 8b 17 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 07 4=
8 83
Sep 17 21:53:23 latile kernel: RSP: 0018:ffffad1700b07df0 EFLAGS: 00010286
Sep 17 21:53:23 latile kernel: RAX: dead000000000122 RBX: ffff95410d16b780 =
RCX:
000000000000d816
Sep 17 21:53:23 latile kernel: RDX: dead000000000100 RSI: 0000000000035630 =
RDI:
ffff95410d16b780
Sep 17 21:53:23 latile kernel: RBP: 00000000ffffffea R08: 0000000000280d00 =
R09:
ffffffffae3e4ee3
Sep 17 21:53:23 latile kernel: R10: 0000000000000000 R11: 0000000000000000 =
R12:
ffff95410b628000
Sep 17 21:53:23 latile kernel: R13: ffff95410b628010 R14: ffff954100f20820 =
R15:
dead000000000100
Sep 17 21:53:23 latile kernel: FS:  0000000000000000(0000)
GS:ffff95442e580000(0000) knlGS:0000000000000000
Sep 17 21:53:23 latile kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep 17 21:53:23 latile kernel: CR2: 000000000c82ef90 CR3: 000000026a82a000 =
CR4:
0000000000750ef0
Sep 17 21:53:23 latile kernel: PKRU: 55555554
Sep 17 21:53:23 latile kernel: Call Trace:
Sep 17 21:53:23 latile kernel:  <TASK>
Sep 17 21:53:23 latile kernel:  ? die_addr+0x36/0x90
Sep 17 21:53:23 latile kernel:  ? exc_general_protection+0x217/0x420
Sep 17 21:53:23 latile kernel:  ? asm_exc_general_protection+0x26/0x30
Sep 17 21:53:23 latile kernel:  ? kmalloc_reserve+0x93/0x100
Sep 17 21:53:23 latile kernel:  ? mgmt_pending_remove+0x10/0x40
Sep 17 21:53:23 latile kernel:  mgmt_remove_adv_monitor_complete+0x78/0xb0
Sep 17 21:53:23 latile kernel:  hci_cmd_sync_work+0xaf/0xf0
Sep 17 21:53:23 latile kernel:  process_one_work+0x16d/0x380
Sep 17 21:53:23 latile kernel:  worker_thread+0x2cb/0x3e0
Sep 17 21:53:23 latile kernel:  ? cancel_delayed_work_sync+0x80/0x80
Sep 17 21:53:23 latile kernel:  kthread+0xde/0x110
Sep 17 21:53:23 latile kernel:  ? kthread_park+0x90/0x90
Sep 17 21:53:23 latile kernel:  ret_from_fork+0x31/0x50
Sep 17 21:53:23 latile kernel:  ? kthread_park+0x90/0x90
Sep 17 21:53:23 latile kernel:  ret_from_fork_asm+0x11/0x20
Sep 17 21:53:23 latile kernel:  </TASK>
Sep 17 21:53:23 latile kernel: Modules linked in:
Sep 17 21:53:23 latile kernel: ---[ end trace 0000000000000000 ]---
Sep 17 21:53:23 latile kernel: RIP: 0010:mgmt_pending_remove+0x10/0x40
Sep 17 21:53:23 latile kernel: Code: 00 be 03 00 00 00 48 89 d7 e8 cc 2b 26=
 ff
eb d1 66 2e 0f 1f 84 00 00 00 00 00 66 0f 1f 00 0f 1f 44 00 00 48 8b 47 08 =
48
8b 17 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 07 48 83
Sep 17 21:53:23 latile kernel: RSP: 0018:ffffad1700b07df0 EFLAGS: 00010286
Sep 17 21:53:23 latile kernel: RAX: dead000000000122 RBX: ffff95410d16b780 =
RCX:
000000000000d816
Sep 17 21:53:23 latile kernel: RDX: dead000000000100 RSI: 0000000000035630 =
RDI:
ffff95410d16b780
Sep 17 21:53:23 latile kernel: RBP: 00000000ffffffea R08: 0000000000280d00 =
R09:
ffffffffae3e4ee3
Sep 17 21:53:23 latile kernel: R10: 0000000000000000 R11: 0000000000000000 =
R12:
ffff95410b628000
Sep 17 21:53:23 latile kernel: R13: ffff95410b628010 R14: ffff954100f20820 =
R15:
dead000000000100
Sep 17 21:53:23 latile kernel: FS:  0000000000000000(0000)
GS:ffff95442e5c0000(0000) knlGS:0000000000000000
Sep 17 21:53:23 latile kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep 17 21:53:23 latile kernel: CR2: 00007f253beef5f0 CR3: 000000026a82a000 =
CR4:
0000000000750ef0
Sep 17 21:53:23 latile kernel: PKRU: 55555554
Sep 17 21:54:26 latile kernel: ACPI BIOS Error (bug): Could not resolve sym=
bol
[\_SB.PCI0.GP18.SATA], AE_NOT_FOUND (20240322/dswload2-162)
Sep 17 21:54:26 latile kernel: ACPI Error: AE_NOT_FOUND, During name
lookup/catalog (20240322/psobject-220)
Sep 17 21:54:26 latile kernel: ACPI BIOS Error (bug): Failure creating named
object [\_SB.PCI0.GPP6.WLAN._S0W], AE_ALREADY_EXISTS (20240322/dswload2-326)
Sep 17 21:54:26 latile kernel: ACPI Error: AE_ALREADY_EXISTS, During name
lookup/catalog (20240322/psobject-220)
Sep 17 21:54:28 latile kernel: i8042: PNP: PS/2 appears to have AUX port
disabled, if this is incorrect please boot with i8042.nopnp
Sep 17 21:54:32 latile kernel: Bluetooth: hci0: HCI Enhanced Setup Synchron=
ous
Connection command is advertised, but not supported.
Sep 17 21:54:40 latile kernel: warning: `iwconfig' uses wireless extensions
which will stop working for Wi-Fi 7 hardware; use nl80211
Sep 17 21:54:50 latile bluetoothd[838]: src/plugin.c:plugin_init() System d=
oes
not support csip plugin
Sep 17 21:54:50 latile bluetoothd[838]: profiles/audio/micp.c:micp_init() D=
-Bus
experimental not enabled
Sep 17 21:54:50 latile bluetoothd[838]: src/plugin.c:plugin_init() System d=
oes
not support micp plugin
Sep 17 21:54:50 latile bluetoothd[838]: src/plugin.c:plugin_init() System d=
oes
not support vcp plugin
Sep 17 21:54:50 latile bluetoothd[838]: src/plugin.c:plugin_init() System d=
oes
not support mcp plugin
Sep 17 21:54:50 latile bluetoothd[838]: src/plugin.c:plugin_init() System d=
oes
not support bass plugin
Sep 17 21:54:50 latile bluetoothd[838]: src/plugin.c:plugin_init() System d=
oes
not support bap plugin
Sep 17 21:54:51 latile kernel: Bluetooth: hci0: HCI Enhanced Setup Synchron=
ous
Connection command is advertised, but not supported.
Sep 17 21:54:51 latile bluetoothd[838]: Failed to set privacy: Rejected (0x=
0b)
Sep 17 21:54:51 latile dnsmasq[941]: no servers found in
/etc/dnsmasq.d/dnsmasq-resolv.conf, will retry
Sep 17 21:54:51 latile acpid: input device has been disconnected, fd 22

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
