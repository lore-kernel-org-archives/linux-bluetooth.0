Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B9340DB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037399; cv=none; b=gtYHnbcJxgKtRMxdhAeEntRfitze0fHrQU+SetiEP8HHDyX/GSOj/EXPSqtmVSJ/kiuwEPyAjEErFHY39A+mtmryxSsymwDkKryCX4GamzH57/VvZbPFgmE2Hs+xhWzsVMRpjrfDx9h6psa8afkfw/SWfyYN3vWY4HptFGNm//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037399; c=relaxed/simple;
	bh=n4O5F6DucmN8PU70OQGfjaLDYUsLe8wnCXf4lNOAY8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3YeXyVOVeHSW6NOq0HiCiDNtnxpeBdZXzhUuX+JNG1v/La6s53YgSGsNy6mkpqx3b2HeNSZAcZFAgqWf3DNPtTe5MrY9Q4gzJhkFL+BL9sXDe1fFVQFgi3cZ2Fp9xUPp/21WQl9rza9MPBECwUCR6VDOSxje3i3I6kcspxEyIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrkHbKDc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrkHbKDc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14282C2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 07:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787037399;
	bh=n4O5F6DucmN8PU70OQGfjaLDYUsLe8wnCXf4lNOAY8g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DrkHbKDcCSd/9TtWRAikNSWM2Xn7GfCO6ZuIVmZUKmVJsKESRuSP45yb9otDTz3kD
	 MyreY9ZTlMHPpewGQUTOBVpXQVveTC+oPknaaP/j8NsHxKbreOgQ8df2YzKYRDZykU
	 uTBKAsm3jQqrYE/XgH1JzVvZhxUPRJjd6d7MUlWSee7AB9cO7xiWEzOX6BkhXG0xxJ
	 zimEwx7dXngXPPOvOgAHTOjvSzOA1vIU8yyuPA9QZOuAkIcv2QeSN1VE8c9fCcq+ph
	 Mu9ISH9T4tmEp/1/co7+GZslneowJbeFUSwXCj2M4WvD/0Wf5PDwPCpY6e/0uIU7hX
	 Q6lUzhzi8pvOA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E07CAC3279F; Tue, 18 Aug 2026 07:16:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221878] MT7902 Bluetooth USB 0e8d:1ede firmware crashes during
 use; reset fails and controller becomes unresponsive
Date: Tue, 18 Aug 2026 07:16:38 +0000
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
Message-ID: <bug-221878-62941-fOwa8syXCT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221878-62941@https.bugzilla.kernel.org/>
References: <bug-221878-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221878

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
> The same failure was previously reproduced on Linux 7.1.6

So did this ever work? e.g. with earlier versions from the same or an older
kernel series Or an older firmware?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
