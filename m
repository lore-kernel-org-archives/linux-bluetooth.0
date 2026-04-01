Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF23DEAD8
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 23:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087844; cv=none; b=WBTVcwovaU+2d43k5HOsJBURJi/9F+D7WadbWZPj6DVmglTYdglf2Y9FS/MI/oOdEWRx/mii1cbfvCUCWN+dgo6b8n91IQg1Plu0owO50tqjpX+8XA69MjFmqDZCFfijpOtKWzkVlcR+VtPyBwctnMASdrHTMsoCwdS5lrle4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087844; c=relaxed/simple;
	bh=Opv0mZkBOpyBn6m7s/zaIH+oifYiJDKX+ez5LoFABaw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JHzyhXRDtIJ7ezJ2lw7E9z0xT16iKRr5QgFSdpFKZDTe94+LlcV4sTKlIZ3WngIzIAsBEInl1Jx74IRkcRETgWhjEUkfoDSMksEGWSHLL8R8VsukrwGx3Veqcj6raOndgbtmbybwdaT9v5mCOKMnlFFdXKcl08Cch48QOIa2dbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVk/m+xO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVk/m+xO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B3B8C116C6
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 23:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775087844;
	bh=Opv0mZkBOpyBn6m7s/zaIH+oifYiJDKX+ez5LoFABaw=;
	h=From:To:Subject:Date:From;
	b=IVk/m+xOpiUBOTMG+YamiWFsZaeybSOp27yJ9BRm8X1J6tjDUWlMw26hyKHPnsufb
	 StdGj7sYRRUOmK/BD/+j30DkW56//QJoqBwlJRXxMWEk/D33gkFkOnxZL0gdCvcR+w
	 P0dDt80FSifStR00EQPFcelwidltJa3Ol4xWLuOIuPv3LgwAS2GQuKYyrTD4KdbH3y
	 IK2LIU2Sgp11++bcdLIygNUDbO2XVlsJiI7HHIxU4oukMaa7a0fWsZMnnO2UkUkyQj
	 bCYBsto7czBaOhYdyYz6ehna1fK8z4/76F4z2Ao55A0iXwH3eyYTRaE9+sjT+eXWO0
	 BEUO2aut7IClw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4BD9AC433E1; Wed,  1 Apr 2026 23:57:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221309] New: rtl8822cu: BLE disconnects with firmware
 0x0673_0EDC regression
Date: Wed, 01 Apr 2026 23:57:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: i+kernel.org@schimpf.link
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221309-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221309

            Bug ID: 221309
           Summary: rtl8822cu: BLE disconnects with firmware 0x0673_0EDC
                    regression
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: i+kernel.org@schimpf.link
        Regression: No

Created attachment 309794
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309794&action=3Dedit
stability log after downgrade

Overview

After updating linux-firmware-realtek to 20260221-1 (which includes commit
fbf93476,
"update rtl8822c bt usb and uart firmware to 0x0673"), the RTL8822CU USB
Bluetooth adapter
(0bda:b00c) begins dropping BLE connections every few minutes. Each disconn=
ect
lasts several seconds before the device reconnects. The adapter itself never
resets and
the USB device remains active throughout. Only the BLE link is lost.

Steps to Reproduce

1. Use a system with an RTL8822CU USB Bluetooth adapter (0bda:b00c).
2. Pair and connect a BLE HID device (tested: Logitech M585/M590 mouse).
3. Optionally connect a second BLE HID device simultaneously (tested:
HHKB-Hybrid_2 keyboard).
4. Use the BLE device normally. No special interaction required, disconnects
occur at idle and
   during active use.

Actual Results

The BLE mouse disconnects often (observed 13+ times over 60 minutes).
bluetoothd reports
Connected: false on the device D-Bus object, the kernel destroys and recrea=
tes
the UHID device
on reconnect, and the mouse is unresponsive for the duration. Downtime can =
be
multiple seconds.
No kernel messages are produced during the disconnect. The second BLE device
(HHKB keyboard)
is unaffected.

dbus-monitor confirms the disconnect is hardware-initiated.

Expected Results

The BLE connection should remain stable during normal use, as it did with t=
he
previous firmware.

Build Date & Hardware

  Offending firmware: rtl_bt/rtl8822cu_fw.bin, version 0x0673_0EDC, introdu=
ced
in commit
    fbf93476b78933a87073d3bf116a84f2599b37b5 (2026-02-02)
  Adapter: Realtek RTL8822CU, USB ID 0bda:b00c
  Kernel: 6.19.10-arch1-1
  bluetoothd: 5.86
  OS: Arch Linux

Additional Builds and Platforms

Does not occur with rtl_bt/rtl8822cu_fw.bin from tag 20260110 (the commit
immediately
preceding fbf93476). Downgrading to that firmware eliminates all disconnect=
s.

Additional Information

USB autosuspend was ruled out by polling
/sys/bus/usb/devices/1-3/power/runtime_status and
runtime_suspended_time during a live disconnect. The adapter remained active
throughout.
The disconnect also happens while actively moving the mouse.=20
Everything tested with default Bluetooth settings.

I'm currently downgrading linux-firmware-realtek to 20260110-1 as a workaro=
und.

I'm running two linux user accounts in parallel, one at tty1 and one at tty=
2.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
