Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECD18A95E
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838783; cv=none; b=CaaDpBnysDmFDAA9Td/tk5Tr3xYbtnFMec0kjS84+5TYCHsyGcR0rWJ2ua9Mp7Byq3KsZoFYbF54HQAlGflbDpMzupMgSpM/W4EAUNC5gclCknxwhVmUBgCX1Y6c4+spitBC9Ob4CJYUZzHLb4AbnQxiXApTMSu4E1GUapmXjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838783; c=relaxed/simple;
	bh=ZlFpXOZZdHzXC/8PV1RfmH8S3erLOjfvh7D/KilPmNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m669F+Y6RzE1u5EdYy7T0JMkgT05Cgz9jNE91RJw751nTu0j3eHQaMg4hbuVUa/AABUZ1bDJbBR8o+AM1tw5T3gcY+nfe3GTSmWX9AWqlgsce6WKbgE3tVjsP3tyIYTRLXzpp2KSoGgr3z07sxKB1yrKilV56PZIJBun7mbmJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtYbincX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtYbincX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 015C6C4CEE8
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 06:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729838783;
	bh=ZlFpXOZZdHzXC/8PV1RfmH8S3erLOjfvh7D/KilPmNQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JtYbincX4hInB54gzIIuTK9bwvSp25byonbm5oTHkeqVkljbMxnBzhvKAp8CDaR7O
	 DhlSwkRtFZsYPReLpaMOPjUaS7Tf0ZevxsAWPRsonJKJsh+3aVbLwvnIhERHQWsNMz
	 TziHz6RgwhZWwXi+eljU7/CmQY5gNMbgCs0Bi9i8jI4hYyJ93aR1NT4XROlEnT38dK
	 +vLix5xFDnixAzCTXDxswJgQGZXq/1XqoFrY6IavZeJJ59UAOzIudgDGU0beWK+uRt
	 rbQr5TDbVMmuKdbFvVJCIrp5qP/oPvpCgpgIjW7LvjUzhkfCQC4gOv7Wzg+PpxCnJJ
	 WV33C/Y02qNCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EF7EFC53BCA; Fri, 25 Oct 2024 06:46:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date: Fri, 25 Oct 2024 06:46:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: anhollander516@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217023-62941-HjInAfQxNx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

Avraham Hollander (anhollander516@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |anhollander516@gmail.com

--- Comment #12 from Avraham Hollander (anhollander516@gmail.com) ---
I'm also seeing this on an 8087:0026 Intel Corp. AX201 Bluetooth:

[    1.992294] Bluetooth: Core ver 2.22
[    1.992314] NET: Registered PF_BLUETOOTH protocol family
[    1.992315] Bluetooth: HCI device and connection manager initialized
[    1.992319] Bluetooth: HCI socket layer initialized
[    1.992321] Bluetooth: L2CAP socket layer initialized
[    1.992322] Bluetooth: SCO socket layer initialized
[    1.995616] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[    1.996616] Bluetooth: hci0: Device revision is 2
[    1.996618] Bluetooth: hci0: Secure boot is enabled
[    1.996619] Bluetooth: hci0: OTP lock is enabled
[    1.996620] Bluetooth: hci0: API lock is enabled
[    1.996621] Bluetooth: hci0: Debug lock is disabled
[    1.996622] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    1.997639] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
[    1.997756] Bluetooth: hci0: Boot Address: 0x24800
[    1.997758] Bluetooth: hci0: Firmware Version: 132-3.24
[    2.031013] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    2.031016] Bluetooth: BNEP filters: protocol multicast
[    2.031019] Bluetooth: BNEP socket layer initialized
[    3.645752] Bluetooth: hci0: Waiting for firmware download to complete
[    3.646590] Bluetooth: hci0: Firmware loaded in 1610318 usecs
[    3.646617] Bluetooth: hci0: Waiting for device to boot
[    3.661799] Bluetooth: hci0: Device booted in 14842 usecs
[    3.661800] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    3.662091] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-19-0-4.ddc
[    3.663689] Bluetooth: hci0: Applying Intel DDC parameters completed
[    3.664765] Bluetooth: hci0: Firmware revision 0.4 build 132 week 3 2024
[    3.666790] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its
usage is not supported.
[    3.743089] Bluetooth: MGMT ver 1.23
[    6.806362] Bluetooth: RFCOMM TTY layer initialized
[    6.806368] Bluetooth: RFCOMM socket layer initialized
[    6.806368] Bluetooth: RFCOMM ver 1.11

This is on (albeit a custom configuration + patches) Linux 6.11.5.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
