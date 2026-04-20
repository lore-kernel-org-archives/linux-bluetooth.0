Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4867C298CA5
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684970; cv=none; b=YKrlca5qrgaFHlx8x4pRI9HBb3YWFa0MKOPdWtrkMD86+kadkPsvP7SzDCSfZTEV/itX/IL/MpiDilQpBtTGM8b6WN0SzdZzGVbhE1Xkv/uYkgtGtkuOLBtYfzMZYlR6l6bGoDbX23u8gSxkAmiAyXYdZy5c5ijhY+ll5Umf1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684970; c=relaxed/simple;
	bh=nSd2MDZmSpLdGdpCXFCx0fAwUbiFBzpX7Qm5mqIwbf0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FeLzIzE/zM/F6e+VySMiYHiAJSp3ixgKFc9dbm4GAXtk8Rrl5Jsl3SM66fmamFBCOVeg/iVAMWKWI6UEUeSL2o5x5OHQJXdKCYf6UfVojsowUAF3UkwQ6G/0O4yAPPgUIdHY7dwnEekPguQGK4CztEfEAF/KibzPeFJwrSGr+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKjmbIC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKjmbIC3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E10E4C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776684969;
	bh=nSd2MDZmSpLdGdpCXFCx0fAwUbiFBzpX7Qm5mqIwbf0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EKjmbIC3eHTM2RXawhMj+HnX8lLBfkFQKIT1+XcTfuhna9lC3eHK0+b5G8saWB9WN
	 dqPPMxun7dAEGRLtGWyWaANrbCVzULQfHI1siWrD8GFblawfmzTaonk6PuMLGMPvUN
	 tTc/6Nt5bt+X4c7x7pLEAsI28t+6I0V2AHxAzVBBOvvGHR8+Zd0BG5rYvhrLAg4vPJ
	 7P6ytQnEGGJbRjZDLbb4GeMnNG1ZszJw6BrxUsJF42NFWoOJmJI1eHO0WKEC8yEvUV
	 CnrmOschtb+m2bGoJDToTUHdJCz+ECo7TXG9AXF4wjg8t2h0rKkXYOIHa/r25wKIvN
	 sXrhh4AWZMKDQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D6936C53BC5; Mon, 20 Apr 2026 11:36:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Mon, 20 Apr 2026 11:36:09 +0000
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
Message-ID: <bug-221339-62941-uqGvLJGk2F@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221339-62941@https.bugzilla.kernel.org/>
References: <bug-221339-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221339

--- Comment #9 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to pallaswept from comment #8)
> That sounds like I might get spammed a lot (more).

No problem.

> Is there some other action I could take as a normie end-user here?

Yes, confirm that is was the commit Paul identified by reverting to the old
file -- as then I can ask for a revert. Could you do that please?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
