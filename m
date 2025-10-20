Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE825394B
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990061; cv=none; b=j+eGP/yuihgjK8zA4ahgPuIVYVAeMHwxLcXhn2OzbCK/DBuiKoCloq2ro0SvVygs42qkTjOEWEBZPhFPmJ9ti9txd4AAXthoryoVk6DPHNXQ+K5GFilqgUrI2zDRwzd8UxysAuxzzWzs4+aK8gi7PYIOwG0SB9aXT1BRWF7ug64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990061; c=relaxed/simple;
	bh=cobBo5cjQRgyIVqI1dkUa70ixWjCR9aTZg8QoilfI7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFVUAFe2E6+c0xLqP4JuvItuvNb7eQjfCYBGcsV5deAW/DQW5O4FBW0JgRpfOhInJj7/cv3EroQn6APXKsGZGSK2hh+qA4ycOqZJ4hPuN5vUx00ENSc107x0NO6IRA8dcYQ8RmK/FsDqT/ZgJ42e15sxu9NibCFd2iTMmMCycsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqst0Jzx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqst0Jzx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A15D4C113D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990061;
	bh=cobBo5cjQRgyIVqI1dkUa70ixWjCR9aTZg8QoilfI7o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eqst0Jzx4Xv6j0bRXMqjipRpPBVchpcTBmPeBt9MIHzYNa0cSyi90+G7CQjQFVFpd
	 j3kVUYjkdb9TRBcb0YhHEwN46F+B7VF1s7XwY8+CATmYErTjPwNeMX5uiRo2kn37F/
	 M0Ah4hNmC86TeF6JlfnRP1UnQnljgWc5f+8Gbzw2PxTj0/7IK8qPSWEHg41240wjib
	 JrlYK5GSSVC1XRtz2aEjUcaxBa0tF57x85Wpb5DoHbzoMDNajXs2zfdjWLrkJoyh8+
	 LvTuxcQrWl2UUp0r+qoUoPM/cv+Pnqq34K3mv1++b2Oq6hxGHrDB4JzbECr5R814LZ
	 Kdsq25rQ6r3fA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 98B74C3279F; Mon, 20 Oct 2025 19:54:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] Wrong indentification of Bluetooth in Lenovo Legion Pro
 5 16IAX10 and 0489:e111 Foxconn / Hon Hai Wireless_Device
Date: Mon, 20 Oct 2025 19:54:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-wfX2UGSXAv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #4 from Jakub Jankiewicz (jcubic@onet.pl) ---
Running:

udevadm info --query=3Dall --name=3D/dev/bus/usb/*/$(lsusb | grep 0489:e111=
 | awk
'{print $4}' | sed 's/://') 2>/dev/null | grep -E "GPHOTO2|MTP|MEDIA_PLAYER"

gives no output in my case. But will test the udev config anyway. Even that=
 I
already tested different things with udev. I've created this report after I=
've
found about udev system and was asking Grok how to disable the MTP device.

I also tried to edit:

/usr/lib/udev/rules.d/69-libmtp.rules

file, to ignore my device, with no effect.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
