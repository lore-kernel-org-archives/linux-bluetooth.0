Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB559145357
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955128; cv=none; b=Fj/scNTUg7SgOLDfZ1pf/PHVX5i29nExPEmvX/X9DmIyaps2EOE7CiuD/baSjFFOxP4mgbpTWtehOSAQ2sBJm5Dfj8F1Gpyt74YZLB04HRvNwSjds9X0SrNY9wbeZlgLj1sjSVO25OM/w8daBkDjBftBXNauIqkRAdlEz3kChY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955128; c=relaxed/simple;
	bh=DI64NzA2yPjvJQE6g+4ecWAqBDWXsenGYMUesEd2F58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNhwdQf16s6jQ0mMZANnP1kTwHB2pa2OcdYS8+taV/3q4j45hukV/lNzDj/YTPlNXHpDSF9z6HUBITuTVVujPEvjauQCKAuPVNEJdohYsz8/2j6VGz77xA6PBcy5WnbaKWFw/6mqvum4/ct5hL23qNzL7GwWWJdtZoVWTaGvveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/73nbQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/73nbQn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C357C433F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707955127;
	bh=DI64NzA2yPjvJQE6g+4ecWAqBDWXsenGYMUesEd2F58=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I/73nbQnOcKtP5tZoWd91mVvgDquVhwIjkMK2818x+fo9IW+HH76QFiiqUDpsgbZa
	 GyB7i7abbTwFNJanr77/DbhEWiNr0iq43tN0uFJ6o4rT9xeJxUKfXE6cHLy7VRj1G1
	 Qdy7sCdDVXIW9HdGbRH3uMZPRYEKr5Ia/Xh7tFYakivEjuIFYtUwqevAMxSBwgNFE0
	 57XOsC3T+hhp05OtZqGGpDIcZbhpRCW7qCow8RziXFVHvPWrAy8zWuuBelRdHyYhwy
	 Vu5/dFNQ39JFjnDXXwMIpyTd7d6kFlCXgWszKY1f9GhqaxpwjiKj5RrVgo7Vmxgk+l
	 9EZHVk2iFvQ+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 58638C53BC6; Wed, 14 Feb 2024 23:58:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218472] mt7921e bluetooth not working
Date: Wed, 14 Feb 2024 23:58:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218472-62941-xkJS8UdQ0m@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218472-62941@https.bugzilla.kernel.org/>
References: <bug-218472-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218472

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
> Which Linux + version are you using?=20

Your problem is solely with the kernel. It doesn't matter which distro I use
(that's Fedora but I have/use my own kernel config).

> Do you get ...

Nope, nothing.



Using git log find the person(s) who contribute to/write this driver and se=
nd
them all this info.

The way kernel bugzilla is set up, many respective developers never get a w=
ind
of what's being discussed here, so they are simply not aware.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
