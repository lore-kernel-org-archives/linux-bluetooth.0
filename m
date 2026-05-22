Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC63A7829
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438151; cv=none; b=nX8dlF1SFkLggyeBSHUbqVKhH7E/LS8Wa3uNSDq3rMn5vrdpOt+Bs2w1CnnHM8vnkkpHEW33R+cepMq+EwlPF4XAqLg/qJ6vujk11D4Bn1FlUPua+i7Opq64raxkWNmMdsWtwVMCf461j5Z5XlXiPb47OsZllukoEl6zoorfABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438151; c=relaxed/simple;
	bh=fawV1IElSYq9TH6Gy4JD7y6EJuWmuo+4ARIL4d896l4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0uq23uqRUHbc3WF7jCRPF63skV4qbngl3lQM4QvQq/y9vmOX1ttWD5Z1fmNHDJ4qlSPQD4V6YrBKjIEs9lehvXuYraF+WxAtw18gOphbwExUlAnD+4HZbavRkaC/QgDA7+RPNQEgIRQc7b2uPxd9+pon4Fs9fAv6U2Es44yQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIhSncin; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIhSncin"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 500AFC2BCB9
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779438150;
	bh=fawV1IElSYq9TH6Gy4JD7y6EJuWmuo+4ARIL4d896l4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bIhSncinUwt0lln3h1GaJBe1LmNu2LTACxqKkr9I5aWRreQniDgZh4EQ9I0UbcbSx
	 UtgRMSDWc2Lg1CtIqo406Vgyix3pvVQMrfsx7fKipEO8+EGyFBsSJt8Zv2QrJCCXbD
	 2d+3uQ5bt5cLNOgZY1TvyNBIDWxdVZhZ/B3ufad+CwPlMAKSH3rVpDhYMTRlDwoWCt
	 tL2pFGto6562yXe/YXHiIlczarQfHO5dcH81MpSXVUhVtnh6Q1X1jLJTb/VuICcKRY
	 lTL0cuQiDx83BH/e6tkXz7k66UNaMiHouD+z5ppom/fku9RpJFQvUMYavGEEXy5Ddd
	 G7Lms5vnNycVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4742EC41613; Fri, 22 May 2026 08:22:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221552] btmtk: MT7921 (USB 0e8d:e020 / PCI 14c3:7920) Bluetooth
 broken since 7.0.7 - fix for 0489:e0e2 does not cover this PID
Date: Fri, 22 May 2026 08:22:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221552-62941-6jAkVvjyb8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221552-62941@https.bugzilla.kernel.org/>
References: <bug-221552-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221552

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |RESOLVED
         Resolution|---                         |INSUFFICIENT_DATA

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
