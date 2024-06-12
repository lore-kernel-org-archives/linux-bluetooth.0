Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B9800
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718154364; cv=none; b=V5iU3Gp/waERvgoA4jnzq5GnD2N+DI4I+VjJmjhoG1FSK+uZrCXQPob0Dae359mUNSmgkPfwxsQN20cm8UzgYZGWpsjc90GUQ/3hMUnnlLGza0G0+JertdDuayz27rvOPfmhrH6hjU5C1V7LYordS02MkFgrlB5oE+9IdCc7S+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718154364; c=relaxed/simple;
	bh=VRYUSwN7U3WJvm2AcRElZCGzre7BIb8nqW77ecgJIVc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imp2ETBMa0v5ltCbCJDFlmH9Ye5fNWTzTOB4b3WJzwpBvm/4ANuI58T5ha/GEjCwb82jqXmO0xwE1daOwJ8wvm5rgioaZp5H/1VP3qtNPxEsBmByhVBbmeZ/arjNpBBtZEUJb3YjxnEvYqGNEHW4o8FqlIVJFpSc0+aNX1clS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzFw+k7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzFw+k7D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 432A2C4AF50
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 01:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718154364;
	bh=VRYUSwN7U3WJvm2AcRElZCGzre7BIb8nqW77ecgJIVc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RzFw+k7DmZvHXZVU5QEDUtcCnjd+aiy0vyc7umlKWH3QPK4RnPpCG68xusB8lcYIl
	 Qhl8eCM/fsMOXfNq7Ks+nFZZk6WaKlS/RaMskpFmX8TJOsGAScbko15bkzMz8NvQ4d
	 yr60I2L6l8xyeswF5lSR1HdX3n+0mSc6s3lcKwSV3GClziO4yI+KPBH+Whv1ixzb2O
	 QRl/1ff8o+sf882opyWMUXeQEDQlYmdCPt/3pi5JgR1vmJqTsBhdrVPEPdm4tYi79I
	 Rm9Q5S3PLaWHd22aruNBPGe5HLNcJgTuFGFaRZUJCaRHoGWPeBRw2/x1aKGVLdclCY
	 rzytDKGcqN9lA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3A44FC53B50; Wed, 12 Jun 2024 01:06:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Wed, 12 Jun 2024 01:06:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: priit@ww.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-2Gi28hPuUU@https.bugzilla.kernel.org/>
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

--- Comment #35 from Priit O. (priit@ww.ee) ---
And yes, it is regression. also it does not work with kernel 6.6 (LTS).
However it does work perfectly well with kernel 6.1.92.

Linux Zen 6.1.92-1-MANJARO #1 SMP PREEMPT_DYNAMIC Mon May 27 03:37:00 UTC 2=
024
x86_64 GNU/Linux

$ dmesg | grep -i bluetooth
[    5.621856] Bluetooth: Core ver 2.22
[    5.621877] NET: Registered PF_BLUETOOTH protocol family
[    5.621878] Bluetooth: HCI device and connection manager initialized
[    5.621881] Bluetooth: HCI socket layer initialized
[    5.621883] Bluetooth: L2CAP socket layer initialized
[    5.621887] Bluetooth: SCO socket layer initialized
[    5.659250] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
[    5.661255] Bluetooth: hci0: Device revision is 1
[    5.661259] Bluetooth: hci0: Secure boot is enabled
[    5.661260] Bluetooth: hci0: OTP lock is enabled
[    5.661262] Bluetooth: hci0: API lock is enabled
[    5.661263] Bluetooth: hci0: Debug lock is disabled
[    5.661264] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    5.663789] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[    5.663805] Bluetooth: hci0: Boot Address: 0x24800
[    5.663807] Bluetooth: hci0: Firmware Version: 132-3.24
[    6.464952] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.464954] Bluetooth: BNEP filters: protocol multicast
[    6.464957] Bluetooth: BNEP socket layer initialized
[    7.025995] Bluetooth: hci0: Waiting for firmware download to complete
[    7.026211] Bluetooth: hci0: Firmware loaded in 1330487 usecs
[    7.026245] Bluetooth: hci0: Waiting for device to boot
[    7.041215] Bluetooth: hci0: Device booted in 14630 usecs
[    7.041217] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    7.041527] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-20-1-3.ddc
[    7.047218] Bluetooth: hci0: Applying Intel DDC parameters completed
[    7.050221] Bluetooth: hci0: Firmware revision 0.3 build 132 week 3 2024
[    7.217324] Bluetooth: MGMT ver 1.22
[   18.841731] Bluetooth: RFCOMM TTY layer initialized
[   18.841737] Bluetooth: RFCOMM socket layer initialized
[   18.841740] Bluetooth: RFCOMM ver 1.11

sorry, but I have no time or will to install and test with every non-suppor=
ted
kernel versions inbetween 6.1 and 6.6 to see where the error came back in.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
