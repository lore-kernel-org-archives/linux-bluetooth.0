Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14F8472
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Mar 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902071; cv=none; b=j1T/LL7x+yFRrqJSucMk7fI/4zz3JQrFcoql/ezXcWnweFMmPFFU4N98JIWGTx7nfxMqo++Ny74FBOsg4g5iPt+g/IbdwAe2dl6qLANNk6JCPZkz5LLzptrtKtWuvPQkFpTTsHrIi6vTIYUuiL60VujnhiRxg20ehcbW1xDQCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902071; c=relaxed/simple;
	bh=UY44S2Ig6P+fTrBZQovIvykn9+eyISqMuuJCagueX6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+sMEpc+gzJGUYJh8PkTR2HTuB2/Fd0ZlIZmuaPUeFAD6YpM5BxxNKZlbZwtKGRq0X8c2sDysExUIzm0N4XthzRFDWC7bOWUCK1rWhJPZWkwPMqm0dIDogft+fhp4An6O3y8w0B4NeGpQ+tisODjIJo62eMG1gez4SMAcl96wx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqRvJFeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqRvJFeR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FF5DC433C7
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Mar 2024 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711902071;
	bh=UY44S2Ig6P+fTrBZQovIvykn9+eyISqMuuJCagueX6c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NqRvJFeRPhm7Uw37bqj+dArTstbRO+AO3aublUDDY8ABIdXJa+lHLhi3av50TGohi
	 a0PZwaIgPQFFFuM84XnZIayKi86nfbaqCqzMZx8o4+e9TsTpRIfV70fTT/Dz+esrzN
	 H6u72hlupvSGDnAYAhLXo7Ehzswi7Cd0CLjbaauPMAXBzWg+6xmx0p6I/gUPjUELFO
	 HDckS2DW7aDcEvYgRnzcp+glLQHDMvpECS2QLqMnlxQNXCtrgdZEQ5U6+0mF6BcVNo
	 FtvDVmAXgLe7xbSYgBbnTZzi5n4jLpWE6Ru60sVi6LUE6z0JNrPur8SujWr++cPmot
	 HaTD3tMd1kq3Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 53872C53BD7; Sun, 31 Mar 2024 16:21:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sun, 31 Mar 2024 16:21:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-z22zWuu6sO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #18 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
If the kernel without the patch (In reply to wolf.seifert from comment #17)
>
> Although the git bisect gave the same git commit, the problem is probably
> different and the suggested fix did not work.
>=20
> See
> https://bbs.archlinux.org/viewtopic.php?pid=3D2161135#p2161135
> for details.

Spreading feedback over multiple places makes things hard.

And journalctl -k / dmesg would be helpful.=20

Did your kernel threw that "kernel: BUG: kernel NULL pointer dereference"
before the fix? If it did not, it was a different problem to begin with and
worth its own ticket, as things otherwise get confusing.=20

Or did the kernel throw that error and it's gone now, but things are not
working? Then the patch helped -- but there might be another problem or the=
 fix
is not enough. Building a 6.8.2 kernel with the culprit removed could help =
to
narrow things down.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
