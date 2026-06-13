Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437B13C9C4
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781369803; cv=none; b=JQ1teleOdZJi9ct4R156WJfPCaTrtc0hVyRrTORN41T/gBdMVbSILoywgK2POhKvIL8jbpWQIAwPT/ak/hjDrhQDue3FJ2yQh4lwtg6ULEwsMR1lp5cLs93eQwMQX8da+bn72Sg+5bWSwSewmHfdS2aB54crYxCwW5igZJQJpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781369803; c=relaxed/simple;
	bh=UFPW1dZtOhzJK08VBOJb+isy/OdBbLNECK9Yw9UkEdQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WglSNViodEiyGrrQdgcpgHl0URhGg9cdXQxgKLNiHeCy+ALbHHsNIpYpNIYsWWMPNKHyi1F9PD1CWpjS7Lnmelz7JFdvTr7QcDp3084pWlpMJ6gCES7QQKhzbB/qy2jye5ThphdvL3zMfrMClsrTl8gXoRlUZwxsPme+A0pKHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbHfmx6h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbHfmx6h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF11BC4AF0E
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781369802;
	bh=UFPW1dZtOhzJK08VBOJb+isy/OdBbLNECK9Yw9UkEdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SbHfmx6h//ZWjeeS2vKsUV3hdtRFIQOEzCL4aHZ/HWQgdIkiHwqTeG8IIjiQRYe4z
	 KApVIbiqCHgzoIhbas1f+jn7/Dkw62oYwW2HNoPTLqFX/YtjNkk9ark26iIepyyyPf
	 jf/C7WL/RyJb59/ID+xsPkWAF5MdM7c5EumJYlYp3mQJdaP1dTdQdFdUpsyMEUEoo3
	 PMi6ndbbg4OTFJgbFMH2JQb/OmNhcDjxbqtLaDbYtAOpfAAdDeGrkjqCxfc86g1XQY
	 5Q2kRFHxvFJCOl3qg1s1QA1zrbQXZXWt5ykuX6K/ToclrQfnyV9oToieJRjqzn1BBd
	 Ly08iv/IHRJ1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B492BC3279F; Sat, 13 Jun 2026 16:56:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Sat, 13 Jun 2026 16:56:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-73081-62941-klAS9UHQUG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D73081

--- Comment #13 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
Yes, as @Hytham is about the Dell Venue 8 Pro 5830/0RK4PK anyway, and this
Kernel Bugzilla issue is about the Dell Venue 11 Pro, let=E2=80=99s continu=
e in the
GitHub issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
