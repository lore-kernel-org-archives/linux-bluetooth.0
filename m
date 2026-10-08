Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491F84B0495
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473899; cv=none; b=ZaMaA4urXgu/pnjSB3jd265YTD2DV46yotrNKHcEUUcNJUifV1M4EYCGD2fXLMiUROf31cq9rBn5Fy66zpA0v1WomtYPIhufEjETuHhrL35V616NljnwLX4zfQLk2VgBjmL/JC0S+Hhb1g2duKdRO2Y3rScWhkHOHKb4f8L/LCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473899; c=relaxed/simple;
	bh=bLB1AItXcAUQNnq/1+yKP8ZjbJ6fLnh9zNrIjYpLLxk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MZSAFKi5d+i/4PMX9NGdhpk6e5VvmBor0AyDeRwMNqEx16t2ixZyHT5XX2y/RgvJFQ6vIFhf1mA0e2aCO9Xd81cie67Sx3M5BT+0iUGNVvFVZGv21NvYm5jyerW3SQucUHpXmZUyJvZF/Q5jphQLjHsIihw40haWeLc73xZfI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIRYJKB+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIRYJKB+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA686C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791473898;
	bh=bLB1AItXcAUQNnq/1+yKP8ZjbJ6fLnh9zNrIjYpLLxk=;
	h=From:To:Subject:Date:From;
	b=rIRYJKB+qcBnQQEXHBvgBn8hdFsQPjd4Ne3MLOWbc/7ijYHdnS06eIePwTw3rAXg6
	 oBrK7Sq4f7Z4RSvzkkS11Ro7MByDgFtRzmP11csvesflxCxJa2hI2U+xFlVaUVzSS/
	 75ZEc9Nc3akYBFByhhvmYs6mBaslTYXqbNuHIS8Q+kQLdn8v0ftnecLfv80LAc6zNu
	 JtDuLyaBDwOzMcQd6/TpnYLzILJOWcJPHFbDKI4RBX+NjvdW8mY7a+0BG5I4yLhoQR
	 Bv5/G74XF+eewJXTzutlEP6jRyDbw+sGZ/f8F8t211ilIrPV2Zwr65SfC61P0G2Aqk
	 CnuAsVzTDmo8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A6FE6C3279F; Thu,  8 Oct 2026 15:38:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222105] New: btintel_pcie (8086:e476, Panther Lake CNVi): BLE
 device using a Resolvable Private Address fails to reconnect after
 suspend/idle and requires re-pairing
Date: Thu, 08 Oct 2026 15:38:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: przemekm83@interia.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-222105-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222105

            Bug ID: 222105
           Summary: btintel_pcie (8086:e476, Panther Lake CNVi): BLE
                    device using a Resolvable Private Address fails to
                    reconnect after suspend/idle and requires re-pairing
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: przemekm83@interia.pl
        Regression: No

Created attachment 311033
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311033&action=3Dedit
dmesg dump

ENVIRONMENT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Distro:      Fedora 44
Kernel:      7.2.8-200.fc44.x86_64
Driver:      btintel_pcie
Controller:  00:14.7 Bluetooth [0d11]: Intel Corporation Core Ultra Process=
ors
             (Series 3) CNVi Bluetooth [8086:e476] (rev 01)
Firmware:    intel/ibt-00a0-01a1-pci.sfi, firmware version 214-29.26
Peripheral:  Logitech MX Anywhere 3S (BLE mouse), modalias usb:v046DpB037d0=
003

DESCRIPTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
A paired BLE mouse that has been working stops reconnecting after the laptop
suspends (s2idle) or after an idle period. The device does not reappear in
scans, and `bluetoothctl connect <bonded-MAC>` hangs with no result. Re-pai=
ring
fixes it, but the problem recurs. The same mouse reconnects flawlessly on
macOS.

The device uses a Resolvable Private Address (RPA). The stored bond contain=
s an
IdentityResolvingKey:

    AddressType=3Dstatic
    [IdentityResolvingKey]
    Key=3D...

Observed behaviour:
- After suspend/resume, the mouse is invisible to `bluetoothctl scan on`, w=
hile
  other BLE devices in range ARE seen (so the radio receive path works).
- The mouse's rotating RPA is not resolved back to its stable identity, so =
the
  host treats it as a new device and the existing bond is effectively lost.
- On re-pairing, the device identity address is regenerated by the peripher=
al
  (last byte increments: DD:28:F7:5C:A0:49 -> DD:28:F7:5C:A0:4A). This is a
  consequence of the forced re-pair, not the root cause.
- No clean disconnect is logged in the kernel; the link drops silently.

REGRESSION NOTE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The problem started around 2026-10-06/07. The device had been stable for ~a
month. Kernel 7.2.8 was installed on 2026-10-03 and is the most recent rele=
vant
update (the 7.2.8 changelog and recent linux-bluetooth patches touch RPA
resolution and btintel_pcie). Not yet bisected against 7.2.7.

REPRODUCTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Pair a BLE device that uses RPA (e.g. Logitech MX Anywhere 3S).
2. Suspend (s2idle) or leave the device idle until it deep-sleeps.
3. Resume / wake the device.
4. The device does not reconnect; it is absent from `bluetoothctl devices`
   (or a new address appears) and re-pairing is required.

RELEVANT LOG LINES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bluetooth: hci0: Found device firmware: intel/ibt-00a0-01a1-pci.sfi
Bluetooth: hci0: Firmware Version: 214-29.26
Bluetooth: hci0: Failed to send Intel_Write_DDC (-95)

RELATED EXISTING BUGS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- 221346  btintel_pcie (8086:e476) hang in shutdown path
- 221481  btintel_pcie: suspend fails with -EBUSY on Intel Lunar Lake (s2id=
le)
- 220419  Bluetooth stops working on Intel BE201 (btintel_pcie)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
