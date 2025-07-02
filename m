Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C221323C
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436299; cv=none; b=ryEzXfj7cl4Vej6L6nUyTKKcdnOaXngjoYbGBxcTQLnAcGB7yRoID1T9Xf5fKT8j1PzIivpDInQimzEG2R9mNxcDxJ89vZGQRUkbuESNyd5Ps7ZW/bocWf1D9eGzINdA+BNnwI8Hozxk8FnVsbz+lnbsnT9oDs6mR2aqxkr+t0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436299; c=relaxed/simple;
	bh=wcatZ3fz6h7+jLz/fGRbDDvWt7AqTPaNJKbJQCOoWVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arMhMqHl20Mf/FoeGAHHB5oHWp7lgjKVJQXgBAQgzUeb28e+h4qtxvAmIiJVrGUKgJO0NfnUfKhO0jUbrFTlptRLUgRf7EQz4/8MINXonCot/O2sO7TXYAtQVmLA9Upv8Yqk3DEGXN4IT0uYsf56TtV8vFhf0kyYEKZcQc+UoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHCsJUoq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHCsJUoq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19318C4CEEF
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 06:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751436299;
	bh=wcatZ3fz6h7+jLz/fGRbDDvWt7AqTPaNJKbJQCOoWVg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tHCsJUoq0WiI1s8hF7gcLP9ZmaLB7t3u5dHrwrEpccbQJ6Tkn2+rOZpFUpif3sArM
	 lmxgEAV187vDp0UMIq0qw0YmUTz67BnmNJVDGFg8HtQ8NAVvrjQ8zCU8bPxyv1m1r1
	 2dkoCbocQGZHTzu2neYSUeZ0vrqORN9rr8XWvYpwGp1QVDUR7if4pUy43Wq86zPPH2
	 OKeYnn+lBs4ZVyt0YhOn9imeEkMuWAAx9Xoli8WK6yX5LhlJ5p0qNQzcd7cGTPh7sk
	 MlfGrvAAAV963NBpPbLv+V5GnhvLBS3xoZg06bLw4kYThwVaYZC3NLT0U6VdYluC+M
	 CAxDSme5hOg4A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0E127C433E1; Wed,  2 Jul 2025 06:04:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220306] Updated ibt-18-16-1.sfi is bugged, "Invalid exception
 type 03" kernel spam
Date: Wed, 02 Jul 2025 06:04:58 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220306-62941-NO1Mb0VxHY@https.bugzilla.kernel.org/>
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

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Kiran, could you take a look please?

I'm unable to CC Sai Teja Aluvala

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
