Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB25366060
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846208; cv=none; b=hwexO9zwR351otwlmdW+7rqD7T3kIAYxboqR+ccWLnfCBOISBjBBuFyjw8nVQDKcmMm74DIkEcvj0hG046TwT+qJWMUbldoU/Er0+zSUcnKsua+f+Tv+zTuAHYB4cg77y2xxJgSuAzOEHYuvD1oMEVcLDyX4cc4uF+BoZIKrlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846208; c=relaxed/simple;
	bh=9vpZ/e1gRgOBRkJwr21Il/dS4iEOYWZZRkIJk5T+T/I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fBazjgvmpRTU+GaqDSB7agSS7XkiESL+w5kHFQv+pQHxDYOSmUy9deOD7SgJMqpdGyK1DLShjlrHui07OT/1mUMJRJ4aTJFkDpnuUPaKNtQi8pDZjMnFUkUob3nzfwccQw0At1TN4ProSCgNsFRlP1F49OWLQC7eQMGx3CyHWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZHU7ErO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZHU7ErO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B394C2BCF6
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 12:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785846207;
	bh=9vpZ/e1gRgOBRkJwr21Il/dS4iEOYWZZRkIJk5T+T/I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BZHU7ErOiHIR4MNpFOlInUfbPgN0tZQmWoZdaXarjOLpDBtylVPjTZ2Q5BkNIXmEJ
	 5k+s1o44BkgsZyjtApdc19/ElQyD5cx7iUoIchhAtCeNWLKStmc6o5OZ47E95u4NY2
	 MO+sfOHfBgmYaXxxHRF1mWv50l7rhNSsr3UYn47HMvzfN5iUsLDQKAZAr20jsCS13S
	 eb+QLlPcZK3lNB5GKdUJC43KGxXCs4+eIr96gLduwbTda7H0MMszOMcfmU16rE2knu
	 3ip57a6Dp+I1BrpgZWkIHeogPCKUblTY8GV+V30LA2OHi0LoryJUeOD44vPvy0MX+5
	 koXACl/B+jgXA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7AAFAC3279F; Tue,  4 Aug 2026 12:23:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Tue, 04 Aug 2026 12:23:27 +0000
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
Message-ID: <bug-221832-62941-M4pUZmFRFL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221832-62941@https.bugzilla.kernel.org/>
References: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This is a really old kernel.

Please install the latest firmware and try either 7.1.6 or 7.2-rc6.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
