Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0236081
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1v91v7q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1A53C433C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 14:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703167979;
	bh=K/FJXkTjIedUDrOAfPpQwlxJ5X8+k4aM2lLsNu+lhpc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z1v91v7qai9gmgVxUgMpQZjMH+v8ArJUfPAEhr2Lryea3uuUPrCeMFgKKkK3jsG80
	 lyod4GUzWdcPWBjQHCgkQJ5lsQvp7tYW8iU9/wLpVxGzDU04IfJe7/OhQh5iBSa4H8
	 9dbZUavSB9iNqvcI/6LJuzynRcbDhbBBrdlajUF3uccNmMsjzTzjpRORqES+1UznrM
	 MaXjQDK0c3bcDabnq7Uu24jGenEdFAM2SfdD1+f/ZWlc/FC+uVywLwFGZRX8bkL2Q1
	 iTjQ6RJqqND3/ggq974yJRY792mu8yzxCwTg9CxtTY5Qxq93Awbien8WieSsYsTvwH
	 lrT1dr3uoDvmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D1918C53BC6; Thu, 21 Dec 2023 14:12:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218264] Potential kernel regression with bluetooth pairing on
 specific radios
Date: Thu, 21 Dec 2023 14:12:59 +0000
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
Message-ID: <bug-218264-62941-x7wDDMcxWB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218264-62941@https.bugzilla.kernel.org/>
References: <bug-218264-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218264

--- Comment #6 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Marco from comment #5)

> Bluetooth regression AND hid regression or this can be caused only by
> bluetooth driver shenanigans?

Hard to tell. But I fear that no developer will look into this unless you
perform a bisection. But before you do so you likely want to test mainline =
and
a working kernel on the same installation (e.g. not with live linux or anyt=
hing
where more than the kernel changed)

Side note, FWIW: I have no idea if the bluetooth devs are even listening he=
re.
To udnerstand why, search for "bugzilla" in
https://docs.kernel.org/admin-guide/reporting-issues.html and
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-ker=
nel-bug-reports-are-ignored/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
