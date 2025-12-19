Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F021CFE0
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766182962; cv=none; b=C696hv0E0Z/fpqHJaBZVh7ODChRFs0EACThcXiaMvLpnY7YibG0fGKzXkrRFBfon7HesavHqbfLp/tU4X4dqFxQc0Ppb0Egr8yBdqBIKa69553oZMHGi16l3TXtgQR1LyO86pAmW36MWOKqTWVszUsandIa4+4jyXYl6RhgRpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766182962; c=relaxed/simple;
	bh=q48ttk2WT+8lFRLYMsXFiJpQxMfPW0iJvxu1Pcs6Tyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WaCMHlkZR5D2Nwx+zwqF/rzyYWIu5gb+59kizPyN1WIU3OVNoDOixNFNLEvTOQTP/zqtBZy34d8HoW0zR5K4CHv4cvezPoQYuPpn49IttaIZSfQwvH+NpufVn3qjEZ9jlO1mHFYazdEZovri9kC5r/Q1Xy3YsoAMQe3VmJ4dTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNDmPlrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNDmPlrR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6EEDC116D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 22:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766182961;
	bh=q48ttk2WT+8lFRLYMsXFiJpQxMfPW0iJvxu1Pcs6Tyw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZNDmPlrRhx+6ZM0ksb2B7hHJtSA/Sm/qh2R+dhe2I+tchpSLDNmoZIwItxSiKRuM6
	 lqlPmLBaYEn1OcOUteTxu8YxXGOn6nCuqF5GDbaUsW/OmgxRCSkV8TZ3SE1BfvXCmK
	 yjjEfCz2UXCDI8hV3jLemAqvVmxzIwrMS8iR0g2S32OIklbrNF7N93vKrCR57lPe3T
	 ojmktVsioupvFvQY6+I6LVjorRkB+LFcto6gd92aIDF0jMh7WtTl+3WxnRGA4Zw3aj
	 sZUkCXTgC8vIoNl9PrlVNhh2AzXJvYqq3deEVE22r8Kph+L9+XRGim2ptcJ0bcLhGc
	 izowtTiTI1Svw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CCB9BC41612; Fri, 19 Dec 2025 22:22:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Fri, 19 Dec 2025 22:22:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-nbEjYvuFmW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #27 from cheako+kernel_org@mikemestnik.net ---
Here is my take on setting up dyndbg for this issue.

P.S. Add log_buf_len=3D4M, to grub cmdline for reboot after the other steps.

Create a file=20
```
=3D=3D> /etc/modprobe.d/wifi.conf <=3D=3D
options iwlwifi dyndbg=3D"+pmfl"
options iwlmvm dyndbg=3D"+pmfl"=20
options btusb dyndbg=3D"+pmfl"
options btmtk dyndbg=3D"+pmfl"
options btrtl dyndbg=3D"+pmfl"
options btintel dyndbg=3D"+pmfl"=20
options bluetooth dyndbg=3D"+pmfl"=20
```

On Debian run `update-initramfs -k all -u` to include these settings on-boo=
t.

Many of these do not dymdbg on my system.

I'm guessing this line `iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x1=
0a100`
happening early causes the btusb module to be locked out of accessing the
device.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
