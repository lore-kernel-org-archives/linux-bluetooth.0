Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225D1F5437
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802860; cv=none; b=BaLyfRqR21WbF49maPoNQ4wcXTIRZUIucEMcOgy1AvkaxWqFAECYWNtf3S/hauRNEEt1b72ymLWVJ2at+X4UkQrNzFzuQ4zjxRlb2nyOFRl1Pw/wOIVtwDdLFdX+DlEvXgHqa+jOoWQsQo5ewr/LX6shOpcPq9MjUTt7n7dEp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802860; c=relaxed/simple;
	bh=5R06YqWdt3+xVuw+Gz9JZBMaefoBnOkfs+qJ1clN9lA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GxqJXsBlTnM8Acee6ZidFP7rDJwZBF1Ex5IQsQ4Fo2xLSwzO102Eg3ft75WTS8jmNwedjL4gnZcrYSuZ7V4jsHwfWhS4iemjt81JCMOu9LJsxHAY63PTCGQ2Oj689eiW0AuilbudmSSYdr76WdUHyEnac9BXE32N8BAgYbNZ3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHKhKe40; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHKhKe40"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDE17C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781802859;
	bh=5R06YqWdt3+xVuw+Gz9JZBMaefoBnOkfs+qJ1clN9lA=;
	h=From:To:Subject:Date:From;
	b=oHKhKe40EaBVpQwnirGA28R6aicr9tsTTkvmemN9GQf6+BLQjI6wWdXkbo9han1hy
	 ftkKQNoZ2u71lupRnDA/j6saL/pvZQR2kakJxL1ktM1sGnykk5Hdk86IallofSi/rg
	 wTqVG/jW/fHPs3UJ14VGS7xLxpqHPtlo3GPANAzZ6xSPUEsRBDKZoxDceK6ceFD312
	 89NJcIcHr9rjqdjSutBlsVxxBbbsYd4fN+NnAGHZHrSX5x4zmSi9VaD6eF2TFFjAx3
	 wBVZnN1JkmhJJrROqizS9MF2ccp7OEVVD1eT5w/jlzo6dz1cDXoaf5qU1sFUXDtMjt
	 tHLgWN54qQRcQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B4A7AC41612; Thu, 18 Jun 2026 17:14:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221666] New: Regression in 7.1: Kernel Oops in
 hidinput_setup_battery (hid_microsoft) causing uhid deadlock when pairing
 Xbox controller
Date: Thu, 18 Jun 2026 17:14:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: intellq@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221666-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221666

            Bug ID: 221666
           Summary: Regression in 7.1: Kernel Oops in
                    hidinput_setup_battery (hid_microsoft) causing uhid
                    deadlock when pairing Xbox controller
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: intellq@gmail.com
        Regression: No

OS: Arch Linux / EndeavourOS
Kernel (Failing): 7.1.0 (TKG and mainline equivalent)
Kernel (Working): 7.0.12 (Arch stable and TKG)
Device: Gulikit KingKong 2 Pro (paired in XInput/Xbox One mode)

Pairing the controller in Xbox One mode via Bluetooth on kernel 7.1 trigger=
s an
immediate Kernel Oops (Page Fault) inside hidinput_setup_battery called by =
the
hid_microsoft driver.

This initial crash leaves the HID subsystem in a locked state. Consequently,
the bluetoothd daemon enters an Uninterruptible Sleep (D state) deadlock in=
side
uhid_dev_destroy when attempting to clean up. The Bluetooth service becomes
completely unresponsive, fails to terminate on SIGKILL, and causes the syst=
em
to hang indefinitely during shutdown/reboot (watchdog did not stop).

Booting into kernel 7.0.12 completely resolves the issue, and the controller
pairs and reports battery normally. The issue only happens in XInput/Xbox m=
ode
(which uses hid_microsoft). D-Input or Switch mode works fine on 7.1.

Steps to Reproduce:

- Boot kernel 7.1.
- Put the controller in XInput/Xbox mode.
- Attempt to pair via Bluetooth (BlueZ).
- Observe the dmesg Oops and subsequent bluetoothd deadlock.

Kernel Oops Log (The Root Cause):

BUG: unable to handle page fault for address: ffffffffffffffe4
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 19 UID: 0 PID: 912691 Comm: (udev-worker)
RIP: 0010:hidinput_setup_battery+0x88/0x3a0
Call Trace:
 <TASK>
 hidinput_configure_usage+0x62e/0x3290
 hidinput_connect+0x6fd/0xb50
 hid_connect+0x147/0x760
 hid_hw_start+0x3c/0x60
 ms_probe+0x80/0x190 [hid_microsoft]
 hid_device_probe+0x1a1/0x250
 really_probe+0x1bc/0x4b0
 __driver_probe_device+0xa1/0x140
 driver_probe_device+0x1e/0x110
 __device_attach_driver+0xc1/0x150
 bus_for_each_drv+0x12a/0x180
 __device_attach+0xd3/0x1c0
 device_reprobe+0x5a/0xa0
 bus_for_each_dev+0x117/0x160
 __hid_bus_driver_added+0x32/0x40
 bus_for_each_drv+0x12a/0x180
 __hid_register_driver+0x73/0x80
 do_one_initcall+0x135/0x330
 do_init_module+0x62/0x330
 __se_sys_finit_module+0x270/0x3e0
 do_syscall_64+0x12c/0x3b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

Secondary Consequence (bluetoothd deadlock):
Because of the worker crash above, bluetoothd gets stuck in D state
permanently:

[<0>] device_del+0x3a/0x3c0
[<0>] hid_destroy_device+0x27/0x90
[<0>] uhid_dev_destroy+0x48/0x70 [uhid]
[<0>] uhid_char_write+0x28f/0x440 [uhid]
[<0>] vfs_writev+0x2c8/0x410
[<0>] do_writev+0x76/0x110
[<0>] do_syscall_64+0x12c/0x3b0
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
