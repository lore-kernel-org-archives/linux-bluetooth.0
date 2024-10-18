Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899F18C0C
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253703; cv=none; b=htXNeDv1GF99+Ip10VHCAPpu03TYJxDrVNCQUr4rK9t6AwKnX8+OMk8XtlmBNB7/HRSdYAkvFZ2mk2b8+QmIwoIzKXoTWXOwEQvzW5EEY+i2/dLYzmemKtTxfa1RPblneANR0Ef41n4jPHgbW+hzJM9G3P4d8CVMx4DBMmk9VPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253703; c=relaxed/simple;
	bh=5nRpj8oj7OGKpp5+b2Ay/AbcaZ63YGrMxhgRgfwi2kg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJbXJtPwp+Ha8jREhEzor//Gwi4E9otvlF7Kj7ZPWF0VhVwojFAgVnf9B3j40X3yk5xova6D+Wz3rThZYf/VTSf5NYN1RpHAGMScqH484SHvnwfbR8YaSjYqAp8t3uBOHWtWTC8Xdsh3tCibRb+OjDRVE6O7eUnqkCBSP7kvAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hs62O4jj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs62O4jj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB03EC4CEC6
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729253703;
	bh=5nRpj8oj7OGKpp5+b2Ay/AbcaZ63YGrMxhgRgfwi2kg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hs62O4jjKMsWnZYOKortSpcNaLRY9tSqAIBu8jjX+XH2Dkem083ufygUVHKrTu+3L
	 EzO5S/lM+b7O+UhOUDmffkBaiO/ZgWzhKo1Ubkkdpf+aHDB146jI3+wMN50dTDTXle
	 fmEnCNDE8LRBd5vhOaO+ERTzyA0hIGBhOxkd+EqYeDe6TCI1f5dGPflnPzyx4PaKKp
	 P7+mzvfGFn9NoC5CKAGV8ROiWPMkkOnYC+c9uZ/ZFgnVmxCDcj2+nh85/jJPrUGW+A
	 4a5z5lA+55axpkHDZt9UTv9pMrmKuvgICBhJqvVj7KVaDOoJEHJ/BZrF1lAE8fozww
	 Puio4I4HOX6dg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DE35DC53BCA; Fri, 18 Oct 2024 12:15:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219333] Bluetooth: hci0: Failed to claim iso interface
Date: Fri, 18 Oct 2024 12:15:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sunabouzu.desert@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219333-62941-xq3aAsjww4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219333-62941@https.bugzilla.kernel.org/>
References: <bug-219333-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219333

--- Comment #5 from Denis Shkuratov (sunabouzu.desert@gmail.com) ---
user@fedora ~ [1|1]> sudo dmesg | grep 7921
[    0.279215] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[   11.024762] mt7921e 0000:08:00.0: enabling device (0000 -> 0002)
[   11.043381] mt7921e 0000:08:00.0: ASIC revision: 79610010
[   11.121955] mt7921e 0000:08:00.0: HW/SW Version: 0x8a108a10, Build Time:
20240826150948a
[   11.145034] mt7921e 0000:08:00.0: WM Firmware Version: ____010000, Build
Time: 20240826151030
[   11.977583] mt7921e 0000:08:00.0 wlp8s0: renamed from wlan0

Be glad to provide any info to fix suspend issue, because it's kinda annoyi=
ng
to live with

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
