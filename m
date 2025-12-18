Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52BD2741A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094541; cv=none; b=HfmlrXUqu2SQlhStOyXJzkIE43+Sxn2jLy1PM99MabwjePYwyMb4+iUOXVOxrBaSLGwsmNpia0EwMioo7WxUNt05TvUQOVQia4s4/ZEw7+WBGsf/ojzUGKhKpyNP24G2VWks47R09oys6goaZjHYuw5OD3tQ7k8hA6LaTTjWkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094541; c=relaxed/simple;
	bh=299cF6gIKZBxzVul6zqM9/1Izx0dwOBr8fuQgT7bhyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UOX6Y6ZecyAVSU7tXvIPqtSVuyKLCdhu4BTWAl+/7rrg93pG693kmOPWkjtYiCRidbQCYJJ3AORtB3ZSooN+XIfdQp8AmJbk92x6kBq3U8RHb1kwihfO0qEnrUCgMo7LZn5Ecw+ZuLa4olrK3YuLvM4vLyo43mifuxBJqJUwDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ky/180df; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ky/180df"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D3A0C19421
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 21:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766094541;
	bh=299cF6gIKZBxzVul6zqM9/1Izx0dwOBr8fuQgT7bhyw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ky/180dfr02axQUfhBRRIvOIjXRSbJjehiJpj2CpWLC7jgyXGgqv5Bc1uN179kjO2
	 gcok9ULKG/aMjQmmWIjE6QQDtgW3JhzHnQXXAEN7SaU5c81xhUww/SArqLEZCP7lZf
	 dOtn6l/rJoc6rwlo+Ncgkxlo5jj0UY8D8YNjHLoAaNmwW0uxRw6lSsx54LvRE212Zj
	 TnCkFjHZDtq6pEoDliOLYQireRQ2NO5+dGuBFzy80Cdd9poR7wnPSjMbJCFuLThhYy
	 CKchu65Y4xjB56SgX1UJ6ReW4G6v2XXN8c9hgs29gP6MBhfvzUJM2y+se+tva1+Ld3
	 FnANE1aVd0r6g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 55AAAC3279F; Thu, 18 Dec 2025 21:49:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 86931] hid-generic 0005:099A:0500.0001: unknown main item tag
 0x0
Date: Thu, 18 Dec 2025 21:49:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rdunlap@infradead.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-86931-62941-XQXSMEs9vl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86931-62941@https.bugzilla.kernel.org/>
References: <bug-86931-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D86931

Randy Dunlap (rdunlap@infradead.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rdunlap@infradead.org

--- Comment #12 from Randy Dunlap (rdunlap@infradead.org) ---
This message is now (as of June-2025) rate-limited, so there should not be =
so
much flooding of the log. AFAIK the underlying cause still has not been
determined.

Patch:
commit 4051ead99888
Author: Li Chen <chenl311@chinatelecom.cn>
Date:   Fri Jun 20 20:02:31 2025 +0800
    HID: rate-limit hid_warn to prevent log flooding

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
