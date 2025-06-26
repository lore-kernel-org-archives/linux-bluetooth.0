Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B35B2EBBBB
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953514; cv=none; b=Re42NZlHsm9mib/FXQOnrL1V4vnBeCdpuw+bpuG8JvoDqPBowcGH0TiWxgfGdeR4mYkdAwxMcwo0v0myzlt7eJ2iV9JRFM1kXG4wovGHG6Kr0N2DClAsOaNlZI/37diudD+pxztx3xeIqRr4snpWcMV2rFwCtvKMYpxBH+Cs+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953514; c=relaxed/simple;
	bh=AtpTJpZictm9k2cmMXI9cKxVRJBOpiDFDxAfgEwzNKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XnxGx5Ky1KelUe2z1qm/altkYTzb03RrCkkHLbt/ChdRipA+tgJH/PEXzT7fBASVDp7kpiLbZEc69ta+fp61SE6XuDby15YboHbGXXUs9dT95VucJHxQrzx0s44VecJ2S25CtlWzNVCTBRPxKlIrAXGTTDTsp22Jj9Z4eeksJQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwtqTMuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwtqTMuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 863CBC4CEF9
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750953513;
	bh=AtpTJpZictm9k2cmMXI9cKxVRJBOpiDFDxAfgEwzNKk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CwtqTMuQBAzQ+A0o3tZNNjIS4VBenwv8SWZvuetSvQGhpY/D6hdOvRJBGLlKgpQsV
	 UFaWG4s6oxMJaCkSKrnXtnKkGQJ1u5gYjhkPWC8JNNKKRGYNzMjGZxIeQtzzULiINq
	 A29/l1YesvAHqZDJo+Ka2JhcL6+RhRh8gHcSnZzdLyDuHVUntHDtCPHPHLP4IqERS2
	 64ogwbSSF9D3yt6PyGdxMwRzVUnU8d2vlbGzFgtvpPkJQ/OyZegxHTtciRpJtK/WoY
	 mdYxN/ajZCD8wTqeR0u3r4iBeWPa+qXQEy7oWuxgPCooMHIfbdqw4QwO80ozgKykOZ
	 T4CZiFcSswz6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7E439C53BC5; Thu, 26 Jun 2025 15:58:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date: Thu, 26 Jun 2025 15:58:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nishiyama.pedro@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-yW99b8VA8l@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

Pedro Nishiyama (nishiyama.pedro@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nishiyama.pedro@gmail.com

--- Comment #280 from Pedro Nishiyama (nishiyama.pedro@gmail.com) ---
Hello,

If anyone is still trying to use one of these devices, try kernel 6.15. A f=
ix
for a subset of these devices has been merged.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
