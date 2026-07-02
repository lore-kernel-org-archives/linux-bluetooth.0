Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FB133CEA7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027925; cv=none; b=hhsysqWqUxQIxBZLjp0F0TEee+t0T4Y851mrJ2k1ahO2s7q3V5FOpOCTe0r4VJRqTZ9eKjFCWq/2OYvFNAEXelaHQ7Y5IxHtEZIvJpwmr1jFtpo+gzhFLCDdlSl0LkNjxeT5hRb+y9O+2fJG/kj/mZE+OJIm58U0JT7b3iu7XAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027925; c=relaxed/simple;
	bh=aZ5TDTB1Ih7yLbTC7NNKcixwQNurW1p0XP7xPa0OmPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8T689SzUsYi7nCyCLg7ofBHq2sRO4uye9fjswrKG14Kpk1u6zbNa9/0IJetf3TQaCafmNjOn5ssLBhW50fetYWuWaLv7KeKTafAVMhGAguE0D6ZjFvyw0d2yxDaI04IJGe+QivrDRCjVm1sV8qoCrUh9S0XCAbFBeuThAS88h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TctdIZoz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TctdIZoz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC2FCC19425
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783027925;
	bh=aZ5TDTB1Ih7yLbTC7NNKcixwQNurW1p0XP7xPa0OmPA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TctdIZozweKpE+RxHarTcWZGH6ch49vpLqQ326mnlo6atBrePVi53SCA/0GIpVWcB
	 cYfdkYMWH4CtlkbQjqdLaiTp7sqWzvlNS4sDPkI0uilvujPj/qTBP4vIkO7M8BjlJE
	 NqpvuqRrX2gAC3ACSD56gN1X4otaK2dQvEpDsV8wolEYblnx7KL5BP92S+nYqCEp9u
	 noAUELKi1RNlqqMFJHJdXHHx4Ay3bApwjBPrLZfqFpJH2zySbU8JrTIqqMAEzXWRBq
	 XC5SvCgarEHu4v87KjFngEQWktiSURRsq2/SgJveB93+XDyqpG7BArhv5+RNoR+sJh
	 04aF7Tde+6GXA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DC3F1C41613; Thu,  2 Jul 2026 21:32:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Thu, 02 Jul 2026 21:32:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xyukta@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-3JxtLB1Mmn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

xyukta@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |xyukta@gmail.com

--- Comment #18 from xyukta@gmail.com ---
I can reproduce this on another MT7921 system.

Hardware
Lenovo laptop
MT7921 PCIe Wireless Network Adapter
PCI ID: 14c3:7961
Bluetooth USB: 0489:e0cd

Distribution
Void Linux

Working kernel
6.12.74_1

Broken kernel
6.18.32_1

This is a regression.

Bluetooth works normally on Linux 6.12.74.

After booting Linux 6.18.32:
bluetoothctl list returns no controllers.
bluetoothctl show reports No default controller available.
bluetui shows an empty interface because no controller is available.

The Bluetooth USB device is detected and bound to btusb, and
/sys/class/bluetooth/hci0 exists.

Additional kernel messages after the initial error include:

Bluetooth: hci0: Execution of wmt command timed out
Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
Bluetooth: hci0: Failed to set up firmware (-110)

Booting the already-installed 6.12.74 kernel immediately restores Bluetooth
without changing firmware or userspace.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
