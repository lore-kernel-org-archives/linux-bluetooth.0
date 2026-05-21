Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4A345CA1
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350007; cv=none; b=r/m/7o7w5+lOXPmOtS+x/5lEiwH1Nz0dmS5lPdcV1Lan+QJ19SY7Ybx9TV8T9AwMRKgp+rsQ0Iw4OMF8lBOBEupqQJwL/FDEpwLtO+FTaqepRrh5FNShWizvnrOibKLMK+lqoFgrT9E6/NLfJFLcEjrYZ/Xd4XI1L4YODRdHxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350007; c=relaxed/simple;
	bh=H31Lrev3UrjxWitjP29vGhi4X4t1uq8u/uAvv0bBECU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3kTEjGHxpaajhroxYDvqizI2Xp+ydejQxvtzsIHAYgCC8L3+8FY0wYGe8iqvT6IYsw/Tp9z+RtesHEXmT5pw9/lpX5lVsbN9yfhutShwijAbkG0IHqpi3J2A6zHmmCiH3UlQzNjtdFiGTZDJdw8+3ppWO4m/s1QiXUdE5mMxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4wse+NB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4wse+NB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41AC9C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779350007;
	bh=H31Lrev3UrjxWitjP29vGhi4X4t1uq8u/uAvv0bBECU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=a4wse+NBSU3AO0MS+vg8ZueYXYdpaGdO4iw+Zdsb2YGwBMgWVORGs6nQbi10R2OVm
	 YIMp2lqXbcGzEdZhxpsvzARsIKVuZ7s6shBZAjnIWHPWij/nKDmpZlQG0HhLBrowWo
	 6paf3jCTzDs/r1wg4xWtCDLDX3nX/GEcKz4kVDm1BASJfIkemksCcUw+e/WsPiZnV0
	 4TcYSoGMmPLmHXo3qc2C2/abWeUvPvuUUDo1GMt6Cs0yopZ0pQ/+corz2RxMpfkEKX
	 nQnn5WpLtxTuIYwGHn6ZyTMbiQLMSIBdzpICV9oGlH9zFYb7Hnt7yAD1mcnNtzGk+g
	 p+c17tsXP3sKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3A64FC4160E; Thu, 21 May 2026 07:53:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221552] btmtk: MT7921 (USB 0e8d:e020 / PCI 14c3:7920) Bluetooth
 broken since 7.0.7 - fix for 0489:e0e2 does not cover this PID
Date: Thu, 21 May 2026 07:53:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221552-62941-CpZRwT1wHk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221552-62941@https.bugzilla.kernel.org/>
References: <bug-221552-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221552

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #2 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
That might be a side-effect from the security fixes that might or might not=
 be
being fixed. Best to try bisect while applying the fix Artem mentioned to f=
ind
the root case -- ideally on mainline (and definitely with a vanilla kernel!)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
