Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A328387
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Sep 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725212596; cv=none; b=CxHWbcpw3AmsCLIOh0QWLvxxgZn8nfe+lTTowZpPrKB8xQCoFRdJVM2XEDCaUW++vbnoFxsOBsStI5ig0vVAhjTaqHbPGAK3pwqJSJiPAf8QQ6LYDByG/Uo62aY8pS0ThtlRnAGPb6y3TGc0epYE2KiqKbLEKmgRjDW0K/DY6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725212596; c=relaxed/simple;
	bh=25l1QxwxTAxzw96eNWGsjtJMPfTaRSOf1pNIwMNZ1kI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pdc9oGdUmLML/vS6L0PUt6DV+PBok3A5T2m2uCuBoueATGc3pjgKpMJjEKRvzmglGGFPI3ykxDAm4zM0LknVDjx0/Bk6/HRFAlfBkC+rqDDtTAw+fgYkqdMhFH6YvcTCRyd7vcgENHBDQx7xveqCIoyqY54QJXPiT+6ZvnVd6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ/f+bnE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ/f+bnE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60FE9C4CEC4
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Sep 2024 17:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725212595;
	bh=25l1QxwxTAxzw96eNWGsjtJMPfTaRSOf1pNIwMNZ1kI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XQ/f+bnE3RQe6zvd7jl57N3EvP5jU0mzcpcB3AO0B/V0+1BJlYRJf7vHhCj7JwLUK
	 LPmuCRb/ZJFH3uJtUy1++Jf4/Z3I6eaq9P0QaLZeZAvNw7dGy/FuNYvGVg0hLBpn7U
	 93DCeZDGWqSTsDsqrY6w3jB7g01Tyv9ENSW4CXLWjITLIQSUX95Ad2M/DTJerTKUhi
	 bKd/TUOru/yl3l66+bEj6iZN7J2xkbycf8tzwoxhLH9KKJJDfxrfshxHkp18RYipJY
	 cYu5P4AiguXP4FtGF+FSnoW9miWHPaO1qf/1rXt4hI9zVCQuJCD+p21hh2ARMO+95e
	 KWouGDH+Z+yLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4BC72C53BB9; Sun,  1 Sep 2024 17:43:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219211] Bluetooth not working. Bluetooth: hci0: Opcode 0x0c03
 failed: -110
Date: Sun, 01 Sep 2024 17:43:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219211-62941-TfXWY2xzKF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219211-62941@https.bugzilla.kernel.org/>
References: <bug-219211-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219211

--- Comment #8 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to aprilgrimoire from comment #7)
> I tried as early as 6.6, and it didn't work. Should I try older ones?

thx. And no, then this is unlikely to be a regression (and thus nothing for
me).

But FWIW: if you do not get any reaction from the maintainers here[1], mail
them (see MAINTAINERS file in the kernel sources) with the bluetooth list in
CC.

[1]
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-ker=
nel-bug-reports-are-ignored/#you-submitted-the-report-to-the-wrong-place-bu=
gzillakernelorg-can-be-one

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
