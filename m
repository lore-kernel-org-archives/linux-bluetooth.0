Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DBC2773F9
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114935; cv=none; b=Y2ZhTcltB9eZMm4nK2Yep7d7QaL9LXvVLvA85Xwr/gvZMbOBx0Bw9OdiAkJz5d8X91pgXNJNpOm8U+3VbCGIbxssy1k5a5Q9trVosoY7GyNInEh+G0ZnnkI6yHIxcr77JPViRUlOvZDAYvLpPy3yVGOkp2IoPRKScS6vS/rx4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114935; c=relaxed/simple;
	bh=t95kIsP1G83TPLOvPmrdBGzZk3P4t2Rs0Tr/nY8RzJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JYS7xgmYv3slSD9rFtbdAPRVago7prBTCU6cXPARd5ktlktQm/Dhe5Kn7w8kRw0yb7r0OYFg3w+d2nslqUuhI64MnfE6ameNWNN2vl+CtRPQ5buO8MV7U6u0X93v0YVTZ7E40qX/rgQvHnN9HRG1QPBCs0AakjgSDVZtUc7P2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNPmGVS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNPmGVS1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8C66C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779114934;
	bh=t95kIsP1G83TPLOvPmrdBGzZk3P4t2Rs0Tr/nY8RzJ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tNPmGVS1c+N8csqGNRs5TKz5rBgcRAQeL0qOQoJyTSqPfdd60pz3UO6Kpou55/UKO
	 Ni7tFWu550EBH9tkRnB5VK3jSvXKRerKAzUjqDlp1bkp4QkvhYrPXCijShqaP9vd44
	 MCgrv/7JCHtESRY3yUynAP1us/c9GkecjS7Q6j482GWAf8M0Cmv7dcTHM96oV6nPNk
	 EJkUwcX5KrdOxfFRvZIYAZUxoR8b5OZVRFnN40qfiokgc5cAZzxzFNPBQCAYB3Lm3c
	 3zife2jX44Ks897/B551NoGW+xR9EmQhQrbd+IK0ToroZNSg7rjFlcCgaJXb/D6E7p
	 Nblq9H6FZzLUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A1794C53BC5; Mon, 18 May 2026 14:35:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE1MzldIE1UNzkyNSBCbHVldG9vdGggZmFpbHMgdG8g?=
 =?UTF-8?B?aW5pdGlhbGl6ZSBzaW5jZSBrZXJuZWwgNy4wLjgg4oCUIHJlZ3Jlc3Npb24g?=
 =?UTF-8?B?ZnJvbSA3LjAuNQ==?=
Date: Mon, 18 May 2026 14:35:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221539-62941-sfSp3z8gJp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221539-62941@https.bugzilla.kernel.org/>
References: <bug-221539-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221539

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 221521 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
