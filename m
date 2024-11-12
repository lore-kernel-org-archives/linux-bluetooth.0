Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF11201012
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372795; cv=none; b=LoNjgKINzZfz9W38fhcL5pE7OhfiG047BBuP3tSnVm+A7gx+Ib9gPE3y4hAuC2N91CUBv1iD9nyK1/kfomrK20nEX2juLALus617C+636HPN4iLYEtzBAHjJB5tH8+JPtfadZIRNS+UF+Ib/T/BhHjA3P2/lMpFN3UGE52zouX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372795; c=relaxed/simple;
	bh=fg9+REHJSkB8W2xlihOxydS2EDNBGSAK08e+WDwWTTU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hrJwAEzJz2xplNKXccaxKQnif8vTLFwy+cjWmkEyd2sqE7uh8SpADlZ2ibcnb10azLrHwFlORxEvHhBLeIjOizLygwlz8VGg0/6Dpgr35gu2jBkLhd0kUkPQogHDNLs1ArMSyhOwUOrk95Ipxc0G2dJklh2OtGJQQ2wWbEoyM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHvUsd4N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHvUsd4N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36FFDC4CED0
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 00:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731372795;
	bh=fg9+REHJSkB8W2xlihOxydS2EDNBGSAK08e+WDwWTTU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UHvUsd4Ny3ZqhvHFKlcXEYU3lTxSrSfV4NIOZ8jy5NREzdMdgQW0aGNr0cIs2GE+7
	 zUKl4UzeS/Ag0sOIGaq4G5CymZiDaQb+pCkFkVJZH7RLPvEjjdrL1Uu3PLSgfgNxsO
	 +Uy3xcvlyluiaUIMOO/UYPpst0KzQLXaDuC9AD/85xCKYHCdZvWXkrWLHxbKe80RBe
	 X6nLkFwItURFHs8J/E+86VcR3r348IZ6y/QwLee+6tQbd5aimfTqhx/ptguS7AQtfn
	 hRnRY9FMh/H83pATXAmMJl+ErrkshrCYZ3JfpiXo5hnGzceTiZe654i3u4C7wKqIla
	 n+JjqzqsHw+eQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 08C66CAB782; Tue, 12 Nov 2024 00:53:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Tue, 12 Nov 2024 00:53:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: shaoran@sakuranohana.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219458-62941-wefoj1OQ2R@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

Pablo Yanez (shaoran@sakuranohana.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |shaoran@sakuranohana.org

--- Comment #7 from Pablo Yanez (shaoran@sakuranohana.org) ---
Hi Luiz

I can check the patch. I ran on the same problem (when Updating from 6.6.52=
 to
6.6.58 on Gentoo) and I submitted a bug report there. They asked me to do a=
 git
bisect of linux-vanilla and my bisect also reported that patch.

I'll try applying the patch and let you know if this solves the problem for=
 me.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
