Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4118DB1A
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778917721; cv=none; b=VsuxTLocLOCZKwTz44qlRPePRg27Gc8HdYHpWHe2G9QDJHsjntLIaJik7gRDeA02lUQG8GkMPJfc3jKdz3GyFi5I3NI+NCpx/IkMbt0QT6Q5wBRq890Y1aZVlzS68pWm1bRwcnOM7D4Dk2NGoCgVpqSfF1AdvNua49PJ+mFcWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778917721; c=relaxed/simple;
	bh=vs8H/T/dI+BeavP7Pb2PHeaKi0ZxbCH2trxL1NkXLiM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=exmHl1AX1KRDO7pl2ex/V5vvUj+PrPjveyYyIw2NBEyH8BedL5nEA622rl7zQGIz/zsH0O8wjaIRv4NyamQ0mL88fiqzENMHt2exdVYYITcL+2Q8mLL/pNn9IoFXttCDt7fvYqEVYTBnIVw848z6i8IOci5+8l4oXKdFGGCJzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3K3ozwA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3K3ozwA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D59AC2BCB7
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778917721;
	bh=vs8H/T/dI+BeavP7Pb2PHeaKi0ZxbCH2trxL1NkXLiM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o3K3ozwAk4ngMpzxm7n8Zz2GGNyDyNRcS4LKUnT7k7C53HCUeUO990swvaaQRiDQq
	 UlH3ryz0Vnp54qiUSb8xO0Te9MTVCw28BAwj4xWOTCli9q9dNmaO+xtDLywUGRB32b
	 02XDdqAMi2ZFVuWZcMZDa0d2DLL0gzTtOAufO0/bQoZkMfN/L6Akgh/OEKIKXjqJRp
	 e1JRq+RHzUgObTLY/N3GGBL+KJvIUB6JqD0evKHxBhXZuG1aiHfdVXUgLc9/4Gjh2v
	 XX+xrSJTV09L91tGYMplEHE8lnbIJmg55Aw0dsq/uZzGAA9A0P9MhYJbRfXuV+Enfy
	 HWn3gEtbZWCKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 34F6EC41616; Sat, 16 May 2026 07:48:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221529] mt7922: Kernel 7.0.7 breaks Bluetooth
Date: Sat, 16 May 2026 07:48:41 +0000
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
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221529-62941-FlCVGJINHs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221529-62941@https.bugzilla.kernel.org/>
References: <bug-221529-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221529

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 221521 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
