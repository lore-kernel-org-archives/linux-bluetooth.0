Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE5433CB
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168928; cv=none; b=l5WDYEC1llYyQtj8LtJ/+7vDmJpz4ju6S+TwQ9mn5V7z2ENKPf+EP5hVqICdbhpGVFkDU1wrM+CyLLNRKdiAoOabs5QT4McZvm0Hlsb3dLq0IVRlbfYgD+qxDY7Ok5jSFrkRGvySs9DTZ8uthpUy3ZacIkAi6xMWqa1XfWkxYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168928; c=relaxed/simple;
	bh=qoGk70YIfVGKvJqT4VzTtqMjijJcG1PI/B6pEy3M2lQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SQCDZgskQIVUVuyJNzfvS1rLj3+F0XWPy7dq4UPvoUbNsDvPnzR27B9RYJfL3tkCvAqXHZ4pXa1kUq6z4n2P2zmBI+MgwLEd0cTdLTJA8Gf/+xuvEfBspPSEOhTLdivRKzlslr36V3GlPorKIkUZneZEqO5sItg3BnvYpgDFpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWV2WV/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWV2WV/M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EDB0C433B1
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712168928;
	bh=qoGk70YIfVGKvJqT4VzTtqMjijJcG1PI/B6pEy3M2lQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NWV2WV/Mx7KxlFuvArJ+eJCU7r7zaDQSKTvtNRDK/DS5/OPRie/U8ZACji2nZ7j4h
	 iLOmWK9+IxB/9bJq50RWGu5hn4phlmK0Tqu9jvXc+nGbwmTIGEJS0ta2U6dLr8R88t
	 GhkOVmO8NlfG0RdO7pGPQTwlfLlU0HNNN12BMODkk89VbrQjuS74aFix40rnXl1KOr
	 +Gld9xEWVajvC8JD0qr5AoT2nXcbzR6sev9gSFXxA3n02aatDkWpO7OlfCNPBxPj/i
	 z3qi1jx1C9qKHhQ3hh6Jypnc324djKBcrfv/26K8Phns+VzrA1nEARy92UCeJu7Nqm
	 jCw60naONE+lg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 18E48C53BD7; Wed,  3 Apr 2024 18:28:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Wed, 03 Apr 2024 18:28:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218416-62941-7OVNzhkLLu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #16 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Can you guys try with the following change:

https://patchwork.kernel.org/project/bluetooth/patch/20240401193515.2525201=
-1-luiz.dentz@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
