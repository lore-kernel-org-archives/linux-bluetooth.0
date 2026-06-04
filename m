Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819763D45FA
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609516; cv=none; b=GpgMmRdScrNusfXG6vcYJ64vrjevgoOeySN8dk3KDVYZuSJOi3FR8pYTpHJ9CsVYwUVQQYcQdssyFl2Kktd1fhSE6pPeK8JAtq+9tR3wjL7LV7HISytJyPk0vBUM9hbS9hhbxJ7c5vo50oER2AzgwE2Sh6uyt5Nhkk+e6Z0hkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609516; c=relaxed/simple;
	bh=ptU8MGa8ABPtUHukfRxeCQ9hoajVi4wLkN3SUWTI8p8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWrzl4p/ZOwbDdXpDlCauQW9bQ+xQ7z0QwStGgcNB1ReSvfZRyjdWfFE3MHI+U90i8n5Mb/pT0Pk8KxbdQwpRH5PKwylFjMMikER36O56/2Jm906Q52GdzALqkoFatCS6EQb4A6MovPUaeNFP++5CCKfM+aGRUgF1ZUJ8NhmKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz+YLm7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz+YLm7h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31C17C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 21:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780609516;
	bh=ptU8MGa8ABPtUHukfRxeCQ9hoajVi4wLkN3SUWTI8p8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tz+YLm7hVvH0BSMY8+TNWGuUcO9gjfjl/ZBtIeMgOl4hZiH3TfsNbubwYGtG2yIFD
	 NfaTlkk+vI12Is3L9VJnXPJEL4WIAhjE0CpN2J4Daqq56EKgqITk3CTg4AfuNga/Zf
	 IWFpJCwmpsePl2iqfRWvza4Rf8LZw1zI0EfVEw+bKKwdO/uKwAM5JgepnLNhNGF3Gn
	 aFArl/Yj1KHddr92Swp+GgVa8pgVZaYMEjzqNDl6oZhWtmhBXljwoJYOU7Zxuy0alw
	 e5hi/fcfBJDuY9+x+1ph4MUH+IfukinBD83+o9U9bIiT5wffxsolqJ8SLivYbnmKmp
	 v8i4WwG1T1VaA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F335C41614; Thu,  4 Jun 2026 21:45:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220703] Bluetooth connection is sporadic, quality is poor -
 halts and stammers with linux-firmware-network-20250917_1
Date: Thu, 04 Jun 2026 21:45:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bob.hepple@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220703-62941-rrckhPy3VA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220703-62941@https.bugzilla.kernel.org/>
References: <bug-220703-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220703

Bob Hepple (bob.hepple@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #2 from Bob Hepple (bob.hepple@gmail.com) ---
This appears to be resolved as of linux-6.18.32_1 and Firmware Version: 83-=
7.26

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
