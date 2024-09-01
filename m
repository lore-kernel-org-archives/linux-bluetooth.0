Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434375381E
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Sep 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725183573; cv=none; b=QwU7C8NnkW2h5oSFgHsq5MPmX79y4wG5LS87dyO+NYK5+vhdWN2spJsK42E5nTlr1h5WG8PTKN9E0FHdoYwHjsCN8wXlv0a0piChtl9LEacimQSxkPlzDGWPNxJwLmge0ZtRrOAc5yyYFzdoC2U9JPlHDfG1xtRmBD3LaYTRM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725183573; c=relaxed/simple;
	bh=n1ZDuPq9SbkIB/Wt0/f8bahZciHgWnIaCN/kAsrsb8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iX20c03tohDXYU0NFQIsDcwy/tDSrKsfknRNl1VK5VQxlfzeRpNe5bjjxLAipkPoMOSwfjGPkX1e0WKJmtMyQAJl11ADEeq1W3wuysqNxoo0Rclx1kurV2x7riX6tc69lU1d9PmspaeW6vjlZk3BqML7SZhg2+DAgzR/A/ZgFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNe2JmIA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNe2JmIA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC51DC4CEC8
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Sep 2024 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725183572;
	bh=n1ZDuPq9SbkIB/Wt0/f8bahZciHgWnIaCN/kAsrsb8U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VNe2JmIAYuUHdNRNXOQFBHFugia9RFqTQoNtlhnB6wsQ+s39/XftrskzmXf6JLpGJ
	 NdNvHfgRmJbkkL3mMYcV2GgDt4Uq8cK1xTrb6707OvTkQ93r20JVhUVOmL5lffvM0/
	 Kt9G+RrZy3BKmOFYBsALQ04JYSQbydJO5Qx8sj+kUy4iX16UHr5skx+lvstWco808u
	 J135EUmZoKIeemficnUeLjJLCZMN3h4Af2Xp8od1GxSF60lt70TlMYvm1PkDyjxWiw
	 GIXz8gvv8Rrqx/kJt+gXStJky4n/ntGhgPstC3I3ocrs9bW7Ie2vTqGqCU7U00i0Sf
	 n6sR9kZFqLh5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B7077C53BA7; Sun,  1 Sep 2024 09:39:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219211] Bluetooth not working. Bluetooth: hci0: Opcode 0x0c03
 failed: -110
Date: Sun, 01 Sep 2024 09:39:32 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219211-62941-N1P6A4cRmr@https.bugzilla.kernel.org/>
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

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #6 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Did BT work in earlier kernels?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
