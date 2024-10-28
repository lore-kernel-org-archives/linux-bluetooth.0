Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B22383BF
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111397; cv=none; b=MzBTh5UZVU3vtEpPW7n2FZ9BEyJDdBjjXaBsnZ7UmXqR13EHuqNXXGGtnU8uQfdvR3WtsvUaj2+AZbOY4kXpVZhEVWdy7DvH7g5D1wCHRvM9CKBhjirSkmjgGKMrXLE4QErHCqBvufkXMUAD0OIFGWegCw+JnKn3DnyH4ASBAN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111397; c=relaxed/simple;
	bh=+9lJ+g0tBH/IcvDf9Ko61Y1eE1EDZBRMuGDkOPXCDN8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EA1fzn5YXwnFE/B4lIvktRwbMcL0VuExmW7g5Cu6FTrZbNf8bCEdxDzAoGuaYvvF0dNADNo86wvbR/0lYdqn/Dl15dyfLuph8rpe+zHCs6Ql9SYgv371pHm2w5r14L74z+2HcLgjbKpEaw8udvNY4f9cLckNUQpJWShtTrRhVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYndJDjc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYndJDjc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43826C4CEE7
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730111397;
	bh=+9lJ+g0tBH/IcvDf9Ko61Y1eE1EDZBRMuGDkOPXCDN8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qYndJDjcAMzr3mHS5272Mfy7ebZSKuZRxOajhfNZOxDg8yMWdKWvUKS6IOwvWkZVW
	 wFah6oZ0r1L9bd3ETzzOkFEBbJkX7CesTwF3kr2/Y6VzlfI7+AnQeu/7n6f1MMGd1C
	 dO1DntDcFcOEN9fOhs7i4IT13Lu5yfYJ3m0slfSRSNQavTqO644nk8mytRGimZ4cGq
	 GR5+SA+QS+xLsenA3OPFIqZcSYgXrPa5fSBOnvR6xopamLrXrSXsacoXR/i4DEr1Q+
	 2diQdaXCttNWYbFczuV6/0uC889HcYn9BB1Aax99HYr+3cGsU+1Sny/rMej1evRhx0
	 lQHEz3mdoQ44A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3CFEAC53BC8; Mon, 28 Oct 2024 10:29:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219433] RIP: 0010:btusb_suspend+0x1b/0x1d0 [btusb]
Date: Mon, 28 Oct 2024 10:29:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-219433-62941-z6MId3tgL8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219433-62941@https.bugzilla.kernel.org/>
References: <bug-219433-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219433

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
There were some btusb related fixes in 6.11.3 or 4.

Please try kernel 6.11.5.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
