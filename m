Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB03221F17
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751608811; cv=none; b=K6wLY1U0jQfXwc/lElubKlBpsCjsWkwoQCVt5btbh2gLRvv1nb1OAvoOeU9EnK0169ZC0Ecld+bvqlUN+pbyGJclnO29GIwmOXzgdtWpqPmvqCVTjSBhKZGsFep9MGL6Ku06Dml5472rnX7l1VtDcK//sFJrqGAMPMAHtXLxiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751608811; c=relaxed/simple;
	bh=jKEMWcO4crhMe1B3wan5TV6BnL0kJexZ8dbWHNXxjT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OTta1zQR7qWB4VRabVMEobZZBxuxpeu+M6ncsULxZAQEzSUlGOrL7ZmX3JiOi1ptnUHBGFSzCnDm0MYtusl+68reV6fNMfCI7CW5ZsS09FN6BzeHFcDFlc+gyGvkhVG8rmMcfI/BD3loE9Zfdo2G5VHWXsnnrwXkn6HJOIvXzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBVkkX8E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBVkkX8E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F6B0C4CEEF
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 06:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751608810;
	bh=jKEMWcO4crhMe1B3wan5TV6BnL0kJexZ8dbWHNXxjT0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jBVkkX8EsYNcBXMphJSwTUTugzfr0YK7n2sdtfO5P/wCXuFy7LuhlbEUicU7ec2jR
	 4uubs3XEVOJnyoiaR1/Co92oxtEo5dlpja8179x97kI0v+n+8e5oTuMfWCMJwkp7gP
	 +uGs89tVz8x1TBq1t61YLHuR4gPuWGXj2rgWz5b+QMxKKMvE6Li6iIPrx5YYcGetOc
	 QpczL5pF1NjTsF36LX2fQNLQeKAacT/5NVIqqk04wNd8mL/0K9WsINx9t2FCboGSlm
	 aNNyrbCpBvQScDvzF83ARmK6mwKtYSbeDMgjk8LoT+kKatnqJAS1D/RBT2nYamZYge
	 5WU38cPQYJriA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 702DEC3279F; Fri,  4 Jul 2025 06:00:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220306] Updated ibt-18-16-1.sfi is bugged, "Invalid exception
 type 03" kernel spam
Date: Fri, 04 Jul 2025 06:00:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_regression
Message-ID: <bug-220306-62941-VgzYY1xtXU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220306-62941@https.bugzilla.kernel.org/>
References: <bug-220306-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220306

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Regression|No                          |Yes

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
I've downgraded the firmware and the errors are gone.

It's a clear regression caused by the firmware.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
