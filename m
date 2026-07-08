Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D02BD02
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499596; cv=none; b=nyD7GsZuuVeQzWxWMGyoGAxCM6afFlMcGe7CCUg9ClJ8XcTM+Bo7uWPhvOTmw6vx78rIIVPje6Rx9gXXYqmVeqHzK3Pg1PEUeQkCRp0XW5Dk9LVrZoQHPEBJjLNlg9iFntx7rvL55rBGzYADlX4X0Q3+IgIr4jNMG07WyI3eHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499596; c=relaxed/simple;
	bh=ZY+UDqxy/6+1rPWdDA7sI7g24cMxoiy/CmyNLoXl+ew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DyvPrBBYN5IwKkIYSGhmI1Boh9buRv8Qu1Wqs1ICYA+gOrrCOrwfc1nfAvnd5IPeqVdzSQwMzToB5+7Uu4axinhybqqnoFfImtboscKC703D8nOXgtPp5p76SFnOojMNyw6WGjm7KauMgxjnmWUuTmf0Uc1l5sGQrIiiwXXF05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELztvilf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELztvilf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44400C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783499596;
	bh=ZY+UDqxy/6+1rPWdDA7sI7g24cMxoiy/CmyNLoXl+ew=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ELztvilfb5mLOJREB/sdX1lD79VXLP+bJBWZZoBHlppqoK1Dy9f76jZrfF9VGrLwg
	 M6jQuHmVLjxzsI40oJ18A4qgDlygMpCDQNkMEq2Pzad9kUp4Qkq0uNxPW5VTPb3XAf
	 s0hA9f7ZdU3WMHxe/+rxAijlwW6FSwvYZXzQPwx1f1EvaQjY0bnT2i2Wj6bYrauirk
	 JwGJ4EIvtpAeaJYkw470V8Vk92gvPZ6MEBwVbL/PFkprucAHVYkyWJqEWC6kwebsrM
	 Uln6JUuQYxDJD6I3ZPm8q0WfNqz4UKKWEQux/eZcbqx5qzU90+zoXm2FmlQ0lZa/lm
	 1Fe9gDi7tM7jA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 34EFEC41616; Wed,  8 Jul 2026 08:33:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] bluetooth and wireplumber stop working after some time
 - dmesg report BUG
Date: Wed, 08 Jul 2026 08:33:15 +0000
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
Message-ID: <bug-218952-62941-sORKfCUn7m@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218952-62941@https.bugzilla.kernel.org/>
References: <bug-218952-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218952

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #7 from Artem S. Tashkinov (aros@gmx.com) ---
Is this still an issue in 7.1.3?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
