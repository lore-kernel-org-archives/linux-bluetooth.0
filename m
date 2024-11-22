Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAFC2D638
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294067; cv=none; b=VPo9BK3Wf4GWPCTcJyitR8plN7vg8COVnf3s5+JIETHtbdgOHW3R+10YH8mAoYzorhmk4m1hfhaFAVAqyavhE+TsAiUmxrw78CQhlLkxoE+6tpnOePbLjmg9whoyS2qGNyOS1+gCuMIbpbyb4EbzddMpqFfjxUgGJ8CspIfbvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294067; c=relaxed/simple;
	bh=VUqI3wdnrZDhiCOuyCyxc5MFymyWw3eweRnEIr4xI10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eIdiNJbmmdrclBRIPEWHAVVyKgGCMIxuTAOSAaWPiscKdgNdRLGfa4/GPHtyC52Cm9HLjlhzfRI52NwcRY9YBwwzZMj8xyIinmnk9WASSnj6b3SfgWqo+mms/5+KmrdprhigE6NkKFemYlYHrQhuli4qAAcZMfkXdk+2vS5bUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3HX6yO4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3HX6yO4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D55E9C4CECE
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732294066;
	bh=VUqI3wdnrZDhiCOuyCyxc5MFymyWw3eweRnEIr4xI10=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B3HX6yO4+ZLOx/vjefxg7MCgkLVe9ak9zJZqAbTa4iOtdyshAx3oOvIeIUWXXBMHu
	 6HcVq1XE/pGrLTUYRuwlJxaOgjMvjfqki+1xaYeV4LXYpyPp0ervgnAC5r2cqX9ibT
	 cM2nedA+xFmkrtKb4QpZL/NBnt6M/WDMtZYQZeO2lpWi9xo1qZzNxEmbqi3ZSHZshy
	 C2rCarHqbEju7Fk+6dzsEyJUy7MQGPI7HOe4J1DGhzvMZi2q1fM/EhCl1E0LAptIdA
	 UctYlGBxQHiTH9Q9ZdIVA63t3WbsIb19zn36WYkzjHvAtt3ygFaV6Ux5ppRRtFDBr9
	 QNVSCd/bclsVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C13F8C53BC2; Fri, 22 Nov 2024 16:47:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219519] Hibernation Failure on 6.11+ due to btusb
Date: Fri, 22 Nov 2024 16:47:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lkml@antheas.dev
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_regression
Message-ID: <bug-219519-62941-Hw0I6YNhBv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219519-62941@https.bugzilla.kernel.org/>
References: <bug-219519-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219519

Antheas Kapenekakis (lkml@antheas.dev) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |ceac1cb0259de682d78f5c784ef
                   |                            |8e0b13022e9d9
         Regression|No                          |Yes

--- Comment #1 from Antheas Kapenekakis (lkml@antheas.dev) ---
I think it is commit ceac1cb0259de682d78f5c784ef8e0b13022e9d9. The way i
bisected the kernel was a bit unclean. So I will try to do a clean revert i=
n a
few hours.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
