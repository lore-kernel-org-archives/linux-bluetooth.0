Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFC1AF0BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082198; cv=none; b=UTl/rvGLOD3RTQREiYPfpJJOAnZCfg75AeIRR6kbmSdgpi31tfIaywrv3uobdY/eDvVewrU7l3TCE34bkhp9DqE8L0Edor+eF+ep3CXwdqXGcARuj+jiebQ2dQLCYb9k+KSbkiIRFZJKAiqUYmrATy/r2NUvxviYzLUAZYUfTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082198; c=relaxed/simple;
	bh=3F3gAFbQpqJSQNtX0cR4tAdli/l1pgYY5zDxP7C/U3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTfi6XBopB9Ql3ZOwWcddn7E/4bFUvnQ3/BANY9838RsOYZ0BIapK5ruorxvnLqbeGC2BdhgKA9OodF9EWq2qUeJmYBnXhP4EYAOYP7zKxwcOHRv0ZcHhOolRpIcAs/vy29T0uH1Chi0GAxZH+08K81pANcOJB1beN8BOdItaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEXOdlY3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEXOdlY3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FE7CC4CED1
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 09:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734082197;
	bh=3F3gAFbQpqJSQNtX0cR4tAdli/l1pgYY5zDxP7C/U3E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lEXOdlY38Slzq25+YTZTORGY4zM8kS+h8IY9Zjwz3t8Ep8F8e0MpfMMCEIqmUHWgG
	 xklawKcOKzkZLAgDSJPx0st/Gm3bgdJ8P33o0ICZ/lSwiMcLy/KSUS2dyK7Ea61rSB
	 rwehHyQlDgUBnd6DK96I/pYJp5trYhVNqEhkO0ORxeWklC9R4CL7+WVxryui/0ZoVm
	 O7pucuxTvOkwqDxUrwAZdQ6zPOzoHk/NTMKv0tZGNz9bnFR4HgtxxwQ/Uv+doEFUOX
	 b160HR/PIYmkroc8Wd8Ftqa2klgcUgywqBOzTi0sKqryNzyKzFILgT6zigrvAkPPzP
	 2JLrzsfBvPB4g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6E39FC41614; Fri, 13 Dec 2024 09:29:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] NULL dereference pointer in Bluetooth at boot
Date: Fri, 13 Dec 2024 09:29:57 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219294-62941-wpTkRmWIRU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219294-62941@https.bugzilla.kernel.org/>
References: <bug-219294-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219294

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #6 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Luiz responded [1]:

> I suspect this has been fixed recently:
>=20
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/commit/?id=3D6f3f7e9414834fc4210a2d11ff6172031e98d9ff

Does this commit fix the issue for you?

[1]:
https://lore.kernel.org/all/CABBYNZJJ+28EvyEvDsVzZv6ZbZLhSkZ-tuDckAvNfR_=3D=
qCKVMw@mail.gmail.com/#t

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
