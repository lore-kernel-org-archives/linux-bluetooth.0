Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00F205502
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394657; cv=none; b=HBW4wYbx8Hlgv7aWHMPWy70rNz9UB0cRQr+fRVUg2YAn01INwC0MSxGxfZogZxATndyZMlzPiKaG6/Te4Y8W3xAvNHtU2ZNXsIZe33XeP3UnsQYloW/5hqwbvqUsqYmcO+VyUGvHp4XA4RL+kpGn9y+CYgDcQvvYr+7QXwLE/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394657; c=relaxed/simple;
	bh=Xj8Flb2jQNYy863prIO1RWb1zArrEW+x4eJ30HFfwYo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XcwDmfRzlBgaeFcdtlXnFIRVXOMFM3TTvB62l47oM2veia/D+hGZot8IIG2UXAqyZEMk6++iUcbISsnrHrFuPgMn2zJ88MUNuU8lyIyMWXEITgPhPuLU+2WznDZhrqF92vyHjmqie+lYdCjDbnBk3scCR2yEc8b4OMsklXu5d0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf7bimWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf7bimWH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02715C4CEED
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747394657;
	bh=Xj8Flb2jQNYy863prIO1RWb1zArrEW+x4eJ30HFfwYo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bf7bimWHGzhRDlUIajFZhmuzeIZfYlP8AXuBX7GDNJ106mBk3lHNMfKsTN3UmR1cw
	 mc+xr08eC2eoufWYCta5p+vTeTQ87k852cc7nMcqRjTuFd/Thj0N/jUcbpvpIviYCX
	 IZLGni0SxNTDYpSutBgdiQ61xOANYgXaPjHIUH50HSVI0MaIrJza5hVKeTrMwcaM0M
	 QtCJA+cGk6r9xULCIM7bSQ3hmIOlM8eFAT8aIU1kjp+I5OIAYOiUKqvBXsWOsBB0wT
	 22LoHXC6NP+Wmo3RcNhuu3WUpNUXyJBdB3WlWRcrME8uCcSUeVlE1j/fEr9EXDfsls
	 8sRtSR40IaNyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EFD82C41613; Fri, 16 May 2025 11:24:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220123] Bluetooth
Date: Fri, 16 May 2025 11:24:16 +0000
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
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status bug_group resolution
Message-ID: <bug-220123-62941-A2pEKG95JM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220123-62941@https.bugzilla.kernel.org/>
References: <bug-220123-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220123

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
              Group|                            |Junk
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
