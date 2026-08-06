Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8342CAE6
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007707; cv=none; b=BdvfAW+AUwWPz6lQo6Nx5M4UwPN9DpdZ/5wP9p96JHQBzZupHExIGdGgfftSosKR97yG/uLFR1kVUcy55h3ipwlFAPbB6yCMYd1wOrl5mVEu641bi0a1Ob6zgz/QauW03KP/2LP7cGqcW9+/FvGWe8vmLwUnnODu73Sthun7NCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007707; c=relaxed/simple;
	bh=NU8l5RJnRf5H5wXmcpSKFsnU0ObvxGNntlJdjle1cOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l7FDAUV/yp9ZVFPFXgYvkeBDrizgaCi1ia1Xg6T8UT7PVNXuVwIHOE5wxO8xZhlB30MZF7Qy3MLU36TuO3r033iDZfB1ahG1j09j6gB7/ZRAg1sU5ndkzQxjnRJRcAFRWmIp4jLcqFqzpnwEwN0lP7B/ao/CRpbOlTrgoEx0GP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPOPqJCv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPOPqJCv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08121C2BCF6
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786007707;
	bh=NU8l5RJnRf5H5wXmcpSKFsnU0ObvxGNntlJdjle1cOM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lPOPqJCvivn14GoYP5Rgkl6Wgy9KiVWtwr+WewoG/GieDwJ2yIbmWQdJRRb9ioXSD
	 38fkxbPDfuGYyndtG9bawjHNURNR3+9Tj++yJueXuiVfafIWdP8GtG/aBEiJn6zZJZ
	 anGc6aRNP/IKJEDNF+9yZ6dyXHurBIfKYVQqMUh4zM6xR76H4QFqd1kpzAU8JHcAqV
	 +JHTcRWZujkmo+WrRLxI99Mt6r41E3nLWrMjbn1YhlvcWGa6ynrEROoLnduVswCjYJ
	 fZg2rhIxYNcRuVMnAiG8QDAUBElY1om5vtY2F3aLwjiFtaCFmb7Sia8vf27E6KmEHt
	 9KvkKBAt6XL4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EB295C41613; Thu,  6 Aug 2026 09:15:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Thu, 06 Aug 2026 09:15:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-221837-62941-yNLLENLPWW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This kernel release is not supported.

Can you reproduce the issue using 7.1.6 or 7.2-rc6 **with** the latest
firmware?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
