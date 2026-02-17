Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD14361656
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335280; cv=none; b=KTyXcixqb3qTgUdzFfvN35f75wTVNaa5we8NO2WQGF/q46ZY3xs5WnGe88ABO4dBIiE8C1b+1pCMpncFCL6M6wnTP0tgSHteBiIZPMFd72tFFzFZvMesMtU7mtYiMX5CTiZuCm+zDD1DxceLrRhlYKcxEPffP9SvNplpYxDWllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335280; c=relaxed/simple;
	bh=5lCWy+iERWA3jjI8di54rNRpHXhOvYT6zBDU8yMLUp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKwuAeWNEXF7tMSb+wA7rOMQ1G23wx5DtjSjsPY9/ykAGYs4UHn9b4msqZk/NJ7KqP4/GQdU7j85l7530tFnU5Sie0t0MtHclNUH7nnO3VRQZfrqfN1bTvlB1XvlzASzgZQk3d9JQU6SFVtwxn2QSpiQyOACxVY5mRnODMVuuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkSH2qIT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkSH2qIT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0613AC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771335280;
	bh=5lCWy+iERWA3jjI8di54rNRpHXhOvYT6zBDU8yMLUp0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HkSH2qITgk+/fkYhDBMVQ4l0IsDyMzy/cpi/mrWMPPmtoUXlJ3Vyqx4XkS1PVai0R
	 8ZgkhXkGqHEff41CwCkm4Sb1vnQw0mLj5zAp/NLuIyvyJgamfVZekbgfjlSjQvBA9g
	 +uX8LUqUevGqt+8i/Y+OJJFPvZKcvQhsfAmY8lCiaY/cbfQKUbuYCqrCBR5spbrdiz
	 qPojUd78+S+sGdF5n/CqHaEPpVkAvSFXxN7+Ymi0gyVDkqzg8tbtY4kZHrldT1qhsE
	 Iif7I1fNL4eu4pJnb40uOzEYcyWHypRdSsKFoLdtrYYyul6HVsjbv+n1QwU/kEOcRp
	 8W31pcdmqxhKQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E66A3C4160E; Tue, 17 Feb 2026 13:34:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221096] [PATCH AVAILABLE]Please add MediaTek MT7927 (MT6639)
 Bluetooth support to mainline
Date: Tue, 17 Feb 2026 13:34:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: javier.tia+bugzilla.kernel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221096-62941-930yRE0TBW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221096-62941@https.bugzilla.kernel.org/>
References: <bug-221096-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221096

javier.tia+bugzilla.kernel@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |javier.tia+bugzilla.kernel@
                   |                            |gmail.com

--- Comment #1 from javier.tia+bugzilla.kernel@gmail.com ---
Thank you for the patch; I have waited some time for this after finding out=
 my
mobo was lacking the proper Bluetooth support.

I wrote about it in
https://jetm.github.io/blog/posts/enabling-mt7927-bluetooth-on-linux/ and
created https://aur.archlinux.org/packages/btusb-mt7927-dkms.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
