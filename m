Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5F346E7E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120785; cv=none; b=m8FZJwZGyUETcb7wsrukeAhaF6r5fyGg2Npn+oXiuwsIhNhzHZAq4oY8cwiN2pY+Ne+j5l5vigYrh44bEtU75EypPlYpbFbxwahplLA85T2RjNeHAfhNV7hzkzw7+YhhrDQ4Wu40q06g4KOo4Bs0Y6xiQ/g8SO6dQu6+lSMkWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120785; c=relaxed/simple;
	bh=k4a6XCrtFbXReq1KhVN74DEu6cu+lYkY/IJSe2Uq0Mo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PvU21bFhMtu/yuGGiz/pqIxJvaIlTUNTFC2GVr/AmE685RWIlasgX8X1lg7rbXXfWutDNdYogPKHqDSqmVucfzT8VwQFtO0RDtTH9Lcm8Na5COmoIMEeaBr6ZJVZPn1YXROoSkLN8BAJ3CT6l5v3rMhuwJ6/Sz+BAgAri7lorgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9NG7GrK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9NG7GrK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF6ECC2BCC7
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781120784;
	bh=k4a6XCrtFbXReq1KhVN74DEu6cu+lYkY/IJSe2Uq0Mo=;
	h=From:To:Subject:Date:From;
	b=Z9NG7GrKvfNtz7llIOLOdQKDN38/8CadegM/vzx19gRsoLYVK0SGfwlzm5otIohjI
	 eTczsm+Xb1X1AsXIpJueKKZYEHMTkDmNDJZnRrLS5fCc4pcOniaUEoYpAvhjqAZjRX
	 hAWw27S5/nJmgvvzMI/QnL5TufU+yV3sgCDJiEbssXDSP8tK5vGoxw+oX2LPS0PZ0N
	 xbKkLoK297Ryh9hdAmZTZ0YXLIuCdDFKSjCrBNuUgXIOGrJd4D9Tw5i+DTg9We0Vc1
	 ECMpxa6yCvYLJ145dILFNorcGA/qD4MnSqnplSTBsQYeghyBUdYmcbgTTCDTpbkCkO
	 mefPTOp5eYXCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B21DDC41612; Wed, 10 Jun 2026 19:46:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] New: Regression for Intel Corporation Device a876 (rev
 10)
Date: Wed, 10 Jun 2026 19:46:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: furstenau+kernelbugWGvWw1PW1l@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

            Bug ID: 221637
           Summary: Regression for Intel Corporation Device a876 (rev 10)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: furstenau+kernelbugWGvWw1PW1l@posteo.net
        Regression: No

On my Dell Pro 14 Premium PA14250, the Bluetooth works with the firmware
version 20260309, but it regressed to not-working in 20260410 and it has not
been fixed as of 20260519. (Speculation: The firmware is crashing.) Via lsp=
ci,
the Bluetooth device is:

00:14.7 Bluetooth: Intel Corporation Device a876 (rev 10)

Two sample outputs of dmesg (first working, second not-working, both on Nix=
OS
with the only configuration difference being the firmware override):

Kernel 7.0.11, Firmware 20260309 $ sudo dmesg | grep -i bluetooth
[   13.782762] Bluetooth: Core ver 2.22
[   13.782883] NET: Registered PF_BLUETOOTH protocol family
[   13.782884] Bluetooth: HCI device and connection manager initialized
[   13.782886] Bluetooth: HCI socket layer initialized
[   13.782888] Bluetooth: L2CAP socket layer initialized
[   13.782892] Bluetooth: SCO socket layer initialized
[   13.805444] Bluetooth: hci0: Device revision is 0
[   13.805449] Bluetooth: hci0: Secure boot is enabled
[   13.805450] Bluetooth: hci0: OTP lock is disabled
[   13.805450] Bluetooth: hci0: API lock is enabled
[   13.805451] Bluetooth: hci0: Debug lock is disabled
[   13.805452] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   13.805453] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 bu=
ild
45995
[   13.806042] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-iml.sfi
[   13.806046] Bluetooth: hci0: Boot Address: 0x30098800
[   13.806046] Bluetooth: hci0: Firmware Version: 15-3.26
[   13.860697] Bluetooth: hci0: Waiting for firmware download to complete
[   13.860704] Bluetooth: hci0: Firmware loaded in 53377 usecs
[   13.863006] Bluetooth: hci0: Waiting for device to boot
[   13.863023] Bluetooth: hci0: Device booted in 2254 usecs
[   13.863024] Bluetooth: hci0: Waiting for device transition to d0
[   13.863025] Bluetooth: hci0: Device moved to D0 in 0 usecs
[   13.863191] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
[   13.866100] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-pci.sfi
[   13.866112] Bluetooth: hci0: Boot Address: 0x10000800
[   13.866113] Bluetooth: hci0: Firmware Version: 15-3.26
[   14.395735] Bluetooth: hci0: Waiting for firmware download to complete
[   14.395763] Bluetooth: hci0: Firmware loaded in 517244 usecs
[   14.433393] Bluetooth: hci0: Received gp1 mailbox interrupt
[   14.433452] Bluetooth: hci0: Waiting for device to boot
[   14.433861] Bluetooth: hci0: Device booted in 37190 usecs
[   14.433862] Bluetooth: hci0: Waiting for device transition to d0
[   14.433980] Bluetooth: hci0: Device moved to D0 in 115 usecs
[   14.437701] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0190-0291-pci.ddc
[   14.437877] Bluetooth: hci0: Applying Intel DDC parameters completed
[   14.438188] Bluetooth: hci0: Firmware timestamp 2026.3 buildtype 1 build
9743
[   14.438190] Bluetooth: hci0: Firmware SHA1: 0xd68504ef
[   14.438460] Bluetooth: hci0: Fseq status: Success (0x00)
[   14.438463] Bluetooth: hci0: Fseq executed: 00.00.04.202
[   14.438464] Bluetooth: hci0: Fseq BT Top: 00.00.04.202
[   15.814470] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   15.814476] Bluetooth: BNEP socket layer initialized
[   15.815604] Bluetooth: MGMT ver 1.23
[   28.005710] Bluetooth: RFCOMM TTY layer initialized
[   28.005717] Bluetooth: RFCOMM socket layer initialized
[   28.005719] Bluetooth: RFCOMM ver 1.11

Kernel 7.0.11, Firmware 20260519 $ sudo dmesg | grep -i bluetooth
[   11.552083] Bluetooth: Core ver 2.22
[   11.552591] NET: Registered PF_BLUETOOTH protocol family
[   11.552593] Bluetooth: HCI device and connection manager initialized
[   11.552596] Bluetooth: HCI socket layer initialized
[   11.552598] Bluetooth: L2CAP socket layer initialized
[   11.552600] Bluetooth: SCO socket layer initialized
[   11.586234] Bluetooth: hci0: Device revision is 0
[   11.586239] Bluetooth: hci0: Secure boot is enabled
[   11.586239] Bluetooth: hci0: OTP lock is disabled
[   11.586240] Bluetooth: hci0: API lock is enabled
[   11.586240] Bluetooth: hci0: Debug lock is disabled
[   11.586241] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   11.586242] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 bu=
ild
45995
[   11.587640] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-iml.sfi
[   11.587646] Bluetooth: hci0: Boot Address: 0x30098800
[   11.587646] Bluetooth: hci0: Firmware Version: 99-13.26
[   11.647652] Bluetooth: hci0: Waiting for firmware download to complete
[   11.647659] Bluetooth: hci0: Firmware loaded in 58608 usecs
[   11.649893] Bluetooth: hci0: Waiting for device to boot
[   11.649927] Bluetooth: hci0: Device booted in 2205 usecs
[   11.649927] Bluetooth: hci0: Waiting for device transition to d0
[   11.649928] Bluetooth: hci0: Device moved to D0 in 0 usecs
[   11.650058] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
[   11.653394] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-pci.sfi
[   11.653410] Bluetooth: hci0: Boot Address: 0x10000800
[   11.653411] Bluetooth: hci0: Firmware Version: 99-13.26
[   11.890541] Bluetooth: hci0: Received gp1 mailbox interrupt
[   11.891227] Bluetooth: hci0: Received gp1 mailbox interrupt
[   11.909517] Bluetooth: hci0: Received gp1 mailbox interrupt
[   11.932472] Bluetooth: hci0: Received gp1 mailbox interrupt
[   11.932823] Bluetooth: hci0: Received gp1 mailbox interrupt
[   11.937740] Bluetooth: hci0: Received gp1 mailbox interrupt
[   11.938063] Bluetooth: hci0: Received gp1 mailbox interrupt
[   12.229448] Bluetooth: hci0: Waiting for firmware download to complete
[   12.229468] Bluetooth: hci0: Firmware loaded in 562566 usecs
[   12.264949] Bluetooth: hci0: Received gp1 mailbox interrupt
[   12.264978] Bluetooth: hci0: Controller in error state
[   13.444947] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   13.444957] Bluetooth: BNEP socket layer initialized
[   15.238165] Bluetooth: hci0: Timeout (3000 ms)  on alive interrupt, alive
context: intel_reset1
[   15.238170] Bluetooth: hci0: Failed to send frame (-62)
[   15.238171] Bluetooth: hci0: sending frame failed (-62)
[   15.238199] Bluetooth: hci0: Failed to send Intel Reset command
[   15.238208] Bluetooth: hci0: Intel Soft Reset failed (-62)
[   15.238211] Bluetooth: hci0: Firmware download retry count: 1
[   15.277649] Bluetooth: hci0: Device revision is 0
[   15.277650] Bluetooth: hci0: Secure boot is enabled
[   15.277651] Bluetooth: hci0: OTP lock is disabled
[   15.277651] Bluetooth: hci0: API lock is enabled
[   15.277652] Bluetooth: hci0: Debug lock is disabled
[   15.277652] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   15.277653] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 bu=
ild
45995
[   15.277855] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-iml.sfi
[   15.277856] Bluetooth: hci0: Boot Address: 0x30098800
[   15.277857] Bluetooth: hci0: Firmware Version: 99-13.26
[   15.331235] Bluetooth: hci0: Waiting for firmware download to complete
[   15.331248] Bluetooth: hci0: Firmware loaded in 52141 usecs
[   15.333516] Bluetooth: hci0: Waiting for device to boot
[   15.333518] Bluetooth: hci0: Device booted in 2200 usecs
[   15.333519] Bluetooth: hci0: Waiting for device transition to d0
[   15.333519] Bluetooth: hci0: Device moved to D0 in 0 usecs
[   15.333705] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
[   15.336014] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-pci.sfi
[   15.336025] Bluetooth: hci0: Boot Address: 0x10000800
[   15.336026] Bluetooth: hci0: Firmware Version: 99-13.26
[   15.354944] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.381773] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.436473] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.437607] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.478120] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.479335] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.483759] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.487062] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.490408] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.500570] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.506638] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.506756] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.515964] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.517688] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.517933] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.532163] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.532282] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.635134] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.636578] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.636707] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.638224] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.638413] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.642802] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.643026] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.704576] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.704711] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.710823] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.734369] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.734563] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.753238] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.756902] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.757166] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.779988] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.780134] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.782630] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.782757] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.792866] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.952898] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.953061] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.956667] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.957829] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.957963] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.960131] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.960433] Bluetooth: hci0: Received gp1 mailbox interrupt
[   15.986218] Bluetooth: hci0: Waiting for firmware download to complete
[   15.986223] Bluetooth: hci0: Firmware loaded in 634965 usecs
[   16.021756] Bluetooth: hci0: Received gp1 mailbox interrupt
[   16.021778] Bluetooth: hci0: Controller in error state
[   19.013291] Bluetooth: hci0: Timeout (3000 ms)  on alive interrupt, alive
context: intel_reset1
[   19.013304] Bluetooth: hci0: Failed to send frame (-62)
[   19.013307] Bluetooth: hci0: sending frame failed (-62)
[   19.013333] Bluetooth: hci0: Failed to send Intel Reset command
[   19.013359] Bluetooth: hci0: Intel Soft Reset failed (-62)

Regression originally reported downstream:
https://github.com/NixOS/nixpkgs/issues/530344

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
