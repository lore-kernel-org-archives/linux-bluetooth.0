Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15FE4848AC
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407744; cv=none; b=hlfVaofkTGyYGfqHgNCNiEBS+SqbUVwvtQeYETKakzB+ZznWFUJfTADK2fC3a2muq2A/KegmjByXW2rWRaRwR8Q3EI28ovgI2M0z/f6eJjRJ0gS84+KO7NtWFIVjxwahRBvDoHyRHKWnArjaZV7Hq9t1qvXZpV2ZnKNJdjEZchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407744; c=relaxed/simple;
	bh=teYHeU2DA9iqHKGxiyGfvYz+25SY1Awd6t8ImdYKqaQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ezaEG0pwFCd7d3zWRxaTyvp9JWqzCjXKbxm06Zh8cvziYLJI5W4BJgtoxHqbVS1rjVxyn8WBRntXwEOK5T7su3XppTEn7LlQ4sUG/p+k184ZtmvbZ0sVcTBjemMgRYYUtJZPkTGMQdJD1Ic5zg4rB2HPrDk2T4eWzFaSZnmh5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddYhUdlZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddYhUdlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7388EC2BCFD
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 11:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792407743;
	bh=teYHeU2DA9iqHKGxiyGfvYz+25SY1Awd6t8ImdYKqaQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ddYhUdlZEJQqSqCOgzFlgGnxJZXHeZPK3e3DlUEm6ZoalEczCXGmP7TfsIrH3OvZ5
	 hClfcHlaH58aNKlHlEybUju4pViSJHFRF1/7jKpy1AQCZTmNZ6Byl+G7QuErPBarpz
	 gMnJmSYce1j1BNHK5BLklLvrgocrshuLTA7n3EIIWgUObxWs8MHltW0pfZ217tMAHi
	 SNg5xh5wknqzh39hm1fSs69E9PxtsoyKflr6GfwrBy6UQjjuLQYMnDI57lwnYdXnbv
	 YV7pEuBHZ+fJqAGrgASXfCKVgMsPZbrteThVVT+Oknl/BBIkwNk39gjmCG7N1yMrwo
	 9u1riZt48mRKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5094BC4160E; Mon, 19 Oct 2026 11:02:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222151] MT7925 (0489:e111): BT firmware 20260813113236
 (linux-firmware 50e034a2) breaks HFP calls and fails WMT init; 20260605184935
 works
Date: Mon, 19 Oct 2026 11:02:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: purpleritza@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cc cf_kernel_version
 cf_regression
Message-ID: <bug-222151-62941-xLPyRdsRZx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222151-62941@https.bugzilla.kernel.org/>
References: <bug-222151-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222151

purpleritza@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |50e034a2c2141c902089c09aa5f
                   |                            |e9363c1be6e56
                 CC|                            |purpleritza@gmail.com
     Kernel Version|                            |7.2.10
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
