Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573F3D667D
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008444; cv=none; b=h7pJJOm52WFdR2anL9Y/PvWcWwelfEBmOPO7qeS3jSXtWDcdTp4b9+9oj2ygM4TTfKS6wqub87WnJ6GLazce/wrDqU7XoZoRzscBN3OxjHb2odpeV1vBLDSpZPGXjl0FoPrJ9zGj7bgsjAswZmlEmrpq5ekcWWwBfWjwotz4s7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008444; c=relaxed/simple;
	bh=VdiX37xljZaSZRWFGi4RnEhc33aNzgjsLurHWAm/tG4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQzywMr0JSSVOOs9XvGhkAEoJNZuzEq0+8bMuwJN7HL0zrlOfbZL8hpX2aTpDgG7tQjCSeIIbclYcewlMwtv8QKtTW+a4CCWpPioI/q+BPoREZP3kVvwcFfXGlnb6MabHZZb8WbXhDwy51EwxafVXaa3iYqDbmKUCySmKs6yIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUxy1QAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUxy1QAq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6612DC2BCB9
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786008444;
	bh=VdiX37xljZaSZRWFGi4RnEhc33aNzgjsLurHWAm/tG4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fUxy1QAqWhJzY9IwkM9NASQnubi7OWY42ITuoAgvW2zviUbB/F1ixVA4l5r7HkUb1
	 4cLQWW3cKliZtF5LB4U15pmfdiYILR4ZCcVGAxyZT7vNu438FQSoZjl0ypariz1CSj
	 ZcYOcf9NSi8DX1nntlM4bG2PPBFHTXkJC3xsXJQ07CBWAOU0erAieA4YHjMxtEeqaP
	 +f/OeFkbT+DiDGPs95wToanB9R5GOguCUyIv9xFERZ2amEOtiuUwRJ8jlf4iMb8Nx3
	 Khlocx8HCgtB9JWwycXS+ZTbHvMispZskxA23rKrhaEjkgGgQTveirmp1OfeaQWoi1
	 4n3s1OT5r0vlQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4061CC3279F; Thu,  6 Aug 2026 09:27:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Thu, 06 Aug 2026 09:27:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: rohanasrani3@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221837-62941-Zk2rkAmsJt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

--- Comment #2 from Rohan (rohanasrani3@gmail.com) ---
Sorry, I forgot to mention that I originally faced this issue in kernel
7.0.0-28 with the the latest firmware. I then tried to jump onto different =
old
kernel versions to see if that might fix the issue. No help. I'm not sure if
Mint supports 7.1.6 yet as I cannot see it in Update Manager. I get the same
dmesg on the new updated kernel as well:
```
[    1.457364] usb 1-5: Product: Bluetooth Radio
[    2.820216] Bluetooth: Core ver 2.22
[    2.834484] NET: Registered PF_BLUETOOTH protocol family
[    2.834492] Bluetooth: HCI device and connection manager initialized
[    2.834506] Bluetooth: HCI socket layer initialized
[    2.834511] Bluetooth: L2CAP socket layer initialized
[    2.834525] Bluetooth: SCO socket layer initialized
[    2.943691] Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000b
lmp_ver=3D0b lmp_subver=3D8852
[    2.946667] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
[    2.949812] Bluetooth: hci0: RTL: btrtl_initialize: key id 0
[    2.949823] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[    2.950664] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[    2.959682] Bluetooth: hci0: AOSP extensions version v0.96
[    2.959687] Bluetooth: hci0: AOSP quality report is not supported
[    4.661628] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.661634] Bluetooth: BNEP filters: protocol multicast
[    4.661639] Bluetooth: BNEP socket layer initialized
```
Is there anything else I can do?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
