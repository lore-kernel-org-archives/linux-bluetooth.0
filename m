Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555592AF11
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388057; cv=none; b=kXA7Q5NAconJlhS4okdOPXGFjeSIQwTZR8KbVNW9dcAzMtIBOphLvm0pTWnq8PwchckaG3Wa+M6cSPx5x0pyeOiCJVEyDG6/maATha0y2RkC35njwfHGXAA6qJTl1LGeP14zjk4rLRMJmqDleMYn047z6nvxyTsrSRCtBbLhohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388057; c=relaxed/simple;
	bh=hM9OBnv3B5LdY3gL+pPi0fjjh0aRZpkuHf+MI5F9nIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a2clPPjQwZ2JS2pG7lJYlsCz7TMKNGFyfEqMzpDQhsovDRObhA5AOMCK5/RE8nHIdTCwFX9erESQj1dmC+8vgQtdMOzqJoaLESJh3MFbHYI5CN9KBW1glio41K4mcT+FAeT5MEQR5tBWHMamoveOoR1pYNCn7eCCwwMk9O+geW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK9n+l4Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK9n+l4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB353C32782
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 11:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721388056;
	bh=hM9OBnv3B5LdY3gL+pPi0fjjh0aRZpkuHf+MI5F9nIw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hK9n+l4YHxJN6/UXeI/JHyFkAnMi4oDVwVG4WyrN/rNnGzuI7RjA+tjKrzayD3NWG
	 lk4xvSRmTzvlJ0wD7A6oPDfcznNBOAAZJ7JzgpZomfSt79IikE2jiDfpVLhkKr9jod
	 2d0h8muKDbCd4RUbPfrrboKT5pyINWhpn4UW31wET/48cfoGzt+BPbeqIjxI/8XHE1
	 5d1PX2posC7t/KCZ3pE+vo4R8SLxvW6JN2v65qnRcQNwNvQacga5BufJDPG98u2jvP
	 a1+3I8aaTgJGYYq8YMZYgAF2B29FRqiMcyjmxPtRE6+LaSaU1tKLccrvAZooSnB7/t
	 UigE6uxjKDfhw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CF869C53B73; Fri, 19 Jul 2024 11:20:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Fri, 19 Jul 2024 11:20:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219057-62941-EyETBp0tg5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
And please attach `lsusb` output as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
