Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFA39FCDC
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263893; cv=none; b=XNaer4RQOfG+CYXZbYXzBbkCXA6rYwJvuXicX4iQ96SqNORTcQwlEdEoMxWtzVgPjmamTPg7XZqrEBtC+3fhEpVpYDEm2A1zcErIYooVqBApP69QsHhXKGweEvGOZq7gGI9Jbbvflb7A4lZpYBmFA2KYs0eCQMYFfHFQb/u3f28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263893; c=relaxed/simple;
	bh=hidVVDfZa+RUwXMHBf21wRFgK/h+CYEFKmIyGkpdVgo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gPMrodp2AuRl6xdny5uDg3HToXgukXxlNr7GhNZARqPV+MA+WyFZ7lejWIbh66BeUnytHEYPYWbti8r83SEXS3lx2C/k8rCciOPkqQes9McUFZH+Tnu2Uz5c/7e4JofDisM7cJ962kyu52uq9dwqHBWA94J2kj8Myq04o8ZKryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsP2lu6s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsP2lu6s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33009C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779263892;
	bh=hidVVDfZa+RUwXMHBf21wRFgK/h+CYEFKmIyGkpdVgo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lsP2lu6s7O/Puta7NtTR6HC4toImTZH+T4O3pV1TveJMlMmDaLhRafNs66NR2rOdQ
	 AxPFsUKAFfoi41oIu2ezZpEPnlmW/fYnzcUHV0J50QL9pXZJb8FVNuz3njFCN9WFAl
	 QEnsXavT+1c7p+NWejLwYeiNLenCcOU+5l8jADBEy3NaXifPkpag+9QGwSxH+U1Kaq
	 eqVzbhZAMEkKCS+eelMvMYX209+c4ksRohcnnI4ipTCWZ8ZwHjblmf9irzIq6T7ERQ
	 BbM0H+hZLXDafaKY3PRXpzdHL0687ZrwavW/fpMhYS2byEmBF5axb1UbBdIuFYwGkE
	 pvUqfyda+iU4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1A97DC3279F; Wed, 20 May 2026 07:58:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221552] btmtk: MT7921 (USB 0e8d:e020 / PCI 14c3:7920) Bluetooth
 broken since 7.0.7 - fix for 0489:e0e2 does not cover this PID
Date: Wed, 20 May 2026 07:58:11 +0000
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
Message-ID: <bug-221552-62941-ZSNr72N7lr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221552-62941@https.bugzilla.kernel.org/>
References: <bug-221552-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221552

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Are you sure this patch doesn't fix it for you?

https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.177705=
8551.git.pav@iki.fi/

Upcoming Linux 7.0.10 includes it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
