Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905ED2EA481
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763505; cv=none; b=u5zRgJijEyy+q9fUAHIbYqJXb43ZOh8dZ1clQI+Ue1GE/0WoIwMZWI96frIzemPdGKNrqRWAjI+SEY4KBsxK1qBicq8FKx1BzOaw5RlVFXuaOAAJOQ3VbgwGgmKvVrY1UvvuQr15qVOEYzwZP8ZwUO9hrxQjbgs/iLbpv/80d5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763505; c=relaxed/simple;
	bh=IhGD27irx0v114kF6cBIA7uX3GBQve+2i//1L/YrmSA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rnvalk0V6Yvg6PB5qo6aRN6JKFsSffsnszSWEFdyWSSeT4Re3cgKqkv68h8sxIcMYSAEljCl3ENw2BRfE5F17aMUM9J5bbXeJV+i1pHWYfKo05PS4W/MhMqBEkfZBQwV1oNGJMB94+X07MN+7YahUgaMg3oKSsOzvSW5w8YDAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFxxhYQ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFxxhYQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F985C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 06:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781763505;
	bh=IhGD27irx0v114kF6cBIA7uX3GBQve+2i//1L/YrmSA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tFxxhYQ5/j8Bpe+/Q5hRI7AbiYh6IKOIpVVClV/Z9laYV20nFPwuIKmUmdFZ4ulJu
	 XIvv5MhEorSOCTu6OPqemPN7PT8nW0v5p2R0m43M9ZCFUMkennV6+dfcvsz+qx6xJI
	 EH5FY3WE9lr8l6h4I6T7GJvwPHkt77XPwwL6qWBdKJDmh0I7rgcmwquO8ZRhuGgA8c
	 g4HJgCInNClSpC6IuPQFy5oRP799SkJRx9Zwe7JzKkl5H8AJhK/rngFsspcwyxS1cT
	 u0Gsrg+185gVMUCEtWNQW/xhbuuwGRootZRnYIml56AfWrM4tuWC3ukQybhYsgIV6L
	 OnlYOUh/wvIQQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 04F79C433E1; Thu, 18 Jun 2026 06:18:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221660] btmtk (MT7921K / RZ608): BR/EDR outgoing connection
 always fails with Page Timeout (0x04); scan/receive works, same device pairs
 fine on Windows
Date: Thu, 18 Jun 2026 06:18:24 +0000
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
Message-ID: <bug-221660-62941-bQr3zPnPfg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221660-62941@https.bugzilla.kernel.org/>
References: <bug-221660-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221660

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Did this work with earlier kernel versions? Is 7.1 affected (7.0 is likely =
EOL
in week anyway).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
