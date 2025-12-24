Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7313148C8
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766588678; cv=none; b=L2tV9Z8bVi49XOTK2D3oS3I7ucQvRtUltVzLD8pWnvm+llnAhQ81hpb91pKbCBYeo7q3omQWFM59dIFk+QIvCPRqP2IZHky9S+hXgr0KIdy06OeY3UhUHj8daWbMGR6ZsLGOEQ3TbQiaAbSXnK9LWJRsh5fbSC124eHS6f9o9qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766588678; c=relaxed/simple;
	bh=+Dv+RDAUe8nCah9093O3NQ6Ihut9uYjdrje5QCMSpy4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YxcIRA7hXE9o3fN5euHASumv9jw/HpwaBVceDSPx+tzaGX6VBVdyImMi3eNLq/hqXUbZZGdrb/J1Q95DtXgIdAN2eyx0JDie6s07ZuuPpb1I3Xuxn7kZk0SVfKPYLdZNb9PL8VXS/1Og172+VxisL8T4jhFizi3EIPCkjgxq4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/p1Slzr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/p1Slzr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F2E3C16AAE
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766588678;
	bh=+Dv+RDAUe8nCah9093O3NQ6Ihut9uYjdrje5QCMSpy4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r/p1SlzrLjy6HUHX1c80n2d1ocmtRSIKUEZlCoGMxVf7DmABeZ0/PkYlGmh+ot+6v
	 QRNeAOSbuuk1idJE+8QO32EnaFcDJgcUj9aqotouNSeAUZftrJJM6/fuvo255Av00J
	 2Q8KTwi9702hdoqVK5OOPFHNc9mYWwC3zDYLpHWMK07jX/+zYfDU0Z9GgvhUWlrnYG
	 fNS7Pp4f+4QBtuOaBd9vfHWtZDV1QbKd8vbOF5akvRJIusLYWsD10MVgfpVGAgxcuL
	 Mdv1Yv1OuJFGzrezXf8jFyavmqx+S5Vjk5LI8xk0tb4wvEoiRYlK3Uytc7URzpItoa
	 cNqIAHQ6PFARQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2277CC4160E; Wed, 24 Dec 2025 15:04:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Wed, 24 Dec 2025 15:04:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tobias.diendorfer@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219387-62941-YQd3ENijxx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

popy (tobias.diendorfer@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tobias.diendorfer@gmail.com

--- Comment #13 from popy (tobias.diendorfer@gmail.com) ---
Exact same issue here on EndavourOS (Arch) on kernel 6.18.2 with newest
linux-firmware-intel (currently 20251125-2).

here is the log:
[ 5239.185443] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[ 5239.190333] Bluetooth: hci0: Device revision is 5
[ 5239.190352] Bluetooth: hci0: Secure boot is enabled
[ 5239.190360] Bluetooth: hci0: OTP lock is enabled
[ 5239.190366] Bluetooth: hci0: API lock is enabled
[ 5239.190371] Bluetooth: hci0: Debug lock is disabled
[ 5239.190378] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 5239.203072] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[ 5240.922007] Bluetooth: hci0: Waiting for firmware download to complete
[ 5240.923091] Bluetooth: hci0: Firmware loaded in 1679687 usecs
[ 5240.923135] Bluetooth: hci0: Waiting for device to boot
[ 5240.934911] Bluetooth: hci0: Device booted in 11535 usecs
[ 5240.934930] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.=
ddc
[ 5240.938914] Bluetooth: hci0: Applying Intel DDC parameters completed
[ 5240.940018] Bluetooth: hci0: Firmware revision 0.0 build 14 week 44 2021
[ 5240.941912] Bluetooth: hci0: Reading supported features failed (-16)
[ 5240.941917] Bluetooth: hci0: Error reading debug features
[ 5240.941925] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its
usage is not supported.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
