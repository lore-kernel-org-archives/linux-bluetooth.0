Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083331E852
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688482; cv=none; b=RlNnq3rlNbDM+RbSzuX1GdODOJ8/6nH+AsUx327xJJFYlKUkP3WM86SQSkQEeHWpika+V+cH/+OD5zXKa58NbbUy8/UdkDBKAq1tmciDEjmx1FXKw00BkzSUSXks1pJMVASj4V914vX9Jc9QUlGaDyJ2bojt5DSJvQnqLZceJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688482; c=relaxed/simple;
	bh=8zEYFjjpsyrL5XxqFdTU0GGKZKkt4DeWDsIrH4qCYeg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eXXVymLkUAjUWoenGL7oFI5JnJUB1kFxU77b6npXwkd3jpt1449Dqj9RgWDRZak8cv8R8vJhUkZ2ck45q1f+nDapQrkg5iasPOmGiltVv0aBoA8wtndsS68gyWItFnSNQJExS+1I5d2FokTQsJVMWcq7Gp6KaNbzrhxfzJoo5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCy5u4hk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCy5u4hk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADF3DC2BCC7
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778688481;
	bh=8zEYFjjpsyrL5XxqFdTU0GGKZKkt4DeWDsIrH4qCYeg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZCy5u4hkEu1SHzNBXUTnsqU0xzWD/gd6Y51RMvRtWfhUMTT6A53HoKpTEspcffCxz
	 IwdWHRvzn1MTYbv48J1lPiakYautqudrU1URh1XPrjprgyCbOCUTNzVqLFxjLQuo0n
	 gNR67Xzz6nJ+X18b2gS1VaRvZzyq7g5pTYrtZnyMKn2MHZskyj8Z/qjJgrqcca09u7
	 eNLpJqDAFZ99ZRDH4691j4yvO0UL9ySR8CKu7AOuFq+1QovOTYHpMHb3OqQuoWauaA
	 nhje6XdiIYGO67v/rfiog0+YyNLNuLuRHrPKFwfpF9s6yY+EPayALN45EJXp4MutWy
	 3hYJ23Fx3YMJw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 99842C433E1; Wed, 13 May 2026 16:08:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 110901] Macbook8,1 12-inch (Early 2015) Bluetooth not working
Date: Wed, 13 May 2026 16:08:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-110901-62941-xT7WuFXkmL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-110901-62941@https.bugzilla.kernel.org/>
References: <bug-110901-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D110901

--- Comment #50 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
(In reply to Jonas from comment #49)
> (In reply to Leif Liddy from comment #46)
> Are these patches still required or have they eventually been merged into
> the kernel eventually?

I just checked the currect driver (as in v7.1-rcX) and I believe the suppor=
t on
MBP machines is in upstream for a long time (the hci_ldisc.c patch was
upstreamed same, 2017 year, the rest was redone by Hans de Goede =E2=80=94 =
it uses
serdev framework now and the PM runtime support is done accordingly).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
