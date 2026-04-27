Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A732E2DF2
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321550; cv=none; b=P55aJK2d/WYMHQdr1r9HKk7GSibCsoQ5lliGpI0fQQpN72/C3xKDO0WxET4fcIy6HzQz1P0ETEKOqQfZdTR5CaU3EtkzPdds7ZOX70j61mMFOkH50wWmQcGjpT0HdEQaYuSw0kXg9EM0fvRrHCVwRFSsf5wDX78lXEybXCMJ/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321550; c=relaxed/simple;
	bh=r3DnMWu9I4U5zzjVhdR7HlQpKT8wFq73JC8bIdXe1Sc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UumPQXeJmhLecvj1mNhSm/a9J4It8FLRNGX56qFUMXEQBXm69SnIYAXWG6lpfixvMpOLhSnD9JSqy3A/u0DEpjXPSY7XLZjgwi2sphQetsGF7tZCLeTPuBVGkKauZeaoJkHglvvtC1/TBy6Y6XqnMP3pY/hGRfCbxIhtlAQX/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dex7T3EV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dex7T3EV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E5B3C2BCB7
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777321550;
	bh=r3DnMWu9I4U5zzjVhdR7HlQpKT8wFq73JC8bIdXe1Sc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Dex7T3EV33ffquL1eSOjuoYCvVzxKXBTTc2uwbKDOLZDZvTXe0oByYt38MhwG1C2P
	 N2ty0wiulyniaSthg8O/2KEfjEpiWbQq7GVo6V6UKqtIVLZ9Xt/mZGaXF37pZ8t5FC
	 8qBr06XPgcu4/Uc88oHGz+eBZX0a+3yPWvvfFeT7zuN3cwYRs0vPt4cBUJ6VKX51qu
	 GFGtfvLnSV9FGk0tn24/C42rzhx2ex2yvjgkt+EE8KHorVwexcqcrztWsw1f/zffD+
	 9GMekzbKmnVwb1So6nA7OoQJAsH7RTq9xzja9dh77/umBzPcgIpRPRo3MZD/ROPFeF
	 I5bLngOppjA1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 26481C41616; Mon, 27 Apr 2026 20:25:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221426] Intel AX211 Bluetooth hci0 hardware error 0x0c with
 HID/HOG failures on 6.19.14-zen
Date: Mon, 27 Apr 2026 20:25:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221426-62941-Ra87UMfHyS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221426-62941@https.bugzilla.kernel.org/>
References: <bug-221426-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221426

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #6 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Paul Menzel from comment #2)
> Thank you for your report. Do you know if it=E2=80=99s a regression, that=
 means, did
> it work with earlier Linux versions?
>=20
> What firmware is used?
>=20
> The BlueZ issue template has some more commands helping to collect things
> aiding in debugging.
>=20
>=20
> [1]: https://github.com/bluez/bluez/tree/master/.github/ISSUE_TEMPLATE

It might be a good idea to file the issue directly in github if there is a
btmon trace then btsnoop-analyzer is used to analyze it, that said I suspect
this is firmware related if it is really generating a hardware error.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
