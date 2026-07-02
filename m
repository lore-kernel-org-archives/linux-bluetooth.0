Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CF35C19B
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974763; cv=none; b=KYBQbx+N4JJ+9ZqeP/GKs0A+PHNSdvo3nUCWYnWZFbGaGkfs+RysqU07HIRPNfST455bFfK/FK/Ku5glPUoPThXZdSu6w0XP3tehnj9j0add1pzeyESnAPql+V/6FKHaMNrWgnCc9SzK190GhPzDJKBu6nA4InQbK4M5tNFan9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974763; c=relaxed/simple;
	bh=o5LUTC7HkBqyqutwo0blbJYGiiPGDaVjfL+re+WZbXw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGtWV1330kI2GfHg0fP0HP1ngmEhfAaUG6bGF3hy3KFdqjx9Dd+eTn4oLVEvis2Nvdyvh9auvR9oFRa2EWUQvU9WuGZDTzBbfxS4CjTi744WpugnjjUcIiBcrsLus8M6XOFxEvVQstXfbvBbCzDxFDKwbGcRwXrGsO9zrJEAh7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5fIrSHp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5fIrSHp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C3D3C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 06:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782974763;
	bh=o5LUTC7HkBqyqutwo0blbJYGiiPGDaVjfL+re+WZbXw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N5fIrSHpFLjpPTSSOhDmZMnpGdKY/1J5j+uXEit5E24HGNU2eplqKqlQIzCSKQjjP
	 nNjlsG8ix6aA+skvl1cbY1jc10mogAX8C0+MVCbd3VuS0phLO38kNcyuGVY4gViCgW
	 OCr7RpCJ+86KUueFRcaGT1x7Ltg4YTHZcXDa5fVsvy17WUR2vG8AW3s31ipWVKX1dc
	 FOejJ3YQ9DA0cQ5VozAg3cris0eFpM7vRragUcPuwRb6MTh8tXbH76ZNQhxrBthYtM
	 Eq3GOwZK7yol8SS71/tGgE5AvgY3kd5grgrUzv0rXRL5/w2SwEZZZJVo/9lfXyXsKD
	 KGlQddborL2hA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0A672C4160E; Thu,  2 Jul 2026 06:46:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Thu, 02 Jul 2026 06:46:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@mattwhitlock.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221696-62941-ifTay80NLC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221696-62941@https.bugzilla.kernel.org/>
References: <bug-221696-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221696

--- Comment #2 from Matt Whitlock (kernel@mattwhitlock.name) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #1)
> Not my area of expertise, but sounds a bit like your problem will hopeful=
ly
> soon be fixed by
> https://lore.kernel.org/all/20260626104604.3465124-1-sivakumar.bs@gmail.c=
om/

Thanks for the tip. I applied those two patches atop 6.6.143, then rebuilt =
and
rebooted, but the BUG trace still appears in the kernel log. I agree that t=
he
patches did look promising, but they do not solve my issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
