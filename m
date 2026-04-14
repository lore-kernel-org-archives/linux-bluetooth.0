Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9377635FF57
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151004; cv=none; b=kicC6Hw/UeZpwnebbaEkEnT4uyAV8Cs8IFiDZQZISw7bB5F7Xzt2dCrLnpGywLhQs4kOosWERokRTJlJd2gle9pS9932h43HS9YoKYu0Phfw4fCz/2yBRdBNXFfTSNvCxpFy906tz5ISaKacZmqtvi5q+a5ZhqPAPE7r9EGXwJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151004; c=relaxed/simple;
	bh=dhmsgek8qUSYU+mwfAMsSDngASHmvdyN5932etAEX7A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BsZFgB1EY74exTgxsNrYkyCO6juDh02DA3dDGhQogz87IYdSCmHHuwRIh0sRfB0H/PT28rYEDG4oUARW4/PejZET3GZGqm22wGmOC4QZjq4/y4w9fylesQNzCdgMdMcVx6mLQOZd5MzXTo+Nq1Ku7fI86NDn73BX3njaC66uIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDN+rBZU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDN+rBZU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EE2AC2BCB6
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776151004;
	bh=dhmsgek8qUSYU+mwfAMsSDngASHmvdyN5932etAEX7A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YDN+rBZUiNNI/9mayUzebh5jGp27vMmXC6PSskLbTie4HtqXrO8sVNS37RSwrdLTs
	 vuXF0rXn8e8sSEBU4u20d69eJNHO7XwEQPWcnME9tKMp8PGMbv4WjUntIFwaqc5Wly
	 7ibBrZ9sBEdK9Pqcz+qc4MpLHaX23q000qKXPB6KtsgJPIluViEelpTwI4nKYBxqDq
	 4YU6FEQ7QKY8lCX0oU8W0LRZmulBXNaesgsaqEyZQOgPApa0T0zkSUd6pp78xDBcOr
	 1znwuS2QFELZBW6IXkuD6mtVqAsK4TApV3EIA251kAJzaf/XYyavbjRGMQRStQZ4WQ
	 a6RXOjv905W7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 377B2C53BC5; Tue, 14 Apr 2026 07:16:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Tue, 14 Apr 2026 07:16:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221339-62941-YuPuzcCG4e@https.bugzilla.kernel.org/>
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

--- Comment #6 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
@Thorsten, only if you didn=E2=80=99t know, but for the Bluetooth subsystem=
 the
Bugzilla issues are sent to the list [1], so the maintainers should be awar=
e.
(And I added Kiron to the GitLab issue.)

[1]:
https://lore.kernel.org/linux-bluetooth/bug-221339-62941@https.bugzilla.ker=
nel.org%2F/T/#t

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
