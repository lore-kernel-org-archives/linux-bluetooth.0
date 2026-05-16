Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641111A3154
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778897701; cv=none; b=e/2eI36C0bVhb1mYQIK74N2u0GIhevreMJoobHVAOQw8doyRYgsv7gIAeTasDI4kFi7kDu5TQbxpm0Zx3IF20taq/7wP/26puzZIz/PiM8ynDtjQGX2nzYsWVKBGtqgkjm1bWt6tVpL6mKuBinHrmUueWIYx8yb9g/+avjdvVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778897701; c=relaxed/simple;
	bh=WgCheAT2MChne1a0f5qyr8iMIM02jIBSHIJ8S0EOZa8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ltfxnyy2TxJuk1RtvqSXbAKCbJ8jAVWmPjdXmucIiik6NqT+b5VqRw9j6pZwQsB+TkcPTlUbz42Cog/G6uwEGzPoVQgYQEbIA9aiNzVzkt2PMRf/TlALwyO2JtPw4fTnq5vaHhhYou2rT7t+q+ywoTVuoQ436N85AEHjb8sKMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA2lM3rj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA2lM3rj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA541C2BCB7
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 02:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778897700;
	bh=WgCheAT2MChne1a0f5qyr8iMIM02jIBSHIJ8S0EOZa8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gA2lM3rjQt4cDLqO4OYLAoSMMi9rBstssnvwU/kVEvtJfl2j0X5Ub5afOh6arhjps
	 X1tPPOHUsijO7bYPO8X7yQDy5bH9cOOrCW7bcPOiZWRUVaaj4lPKkO5DZ/vTmOXHhp
	 WkUUUjprUC+ITbX3Cz56sFX2T3XIhhs7RG1twJi17ngw2uCcB4H9NTCVjgb9oNWod2
	 98hGbDTpFZuuQztCykvDAc6zuQ5F7LWOORXUc51pbhMBocux3SoxIzyWghzKC2mJxX
	 YFmTBoCVjFOgjRVGjbyxGB60+EUWUjC9jckvo7nV0ZlhDp4Jo6jTmUrL2uU7mBPNip
	 gBCx+56ROX5Lw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9FA92C4160E; Sat, 16 May 2026 02:15:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221529] mt7922: Kernel 7.0.7 breaks Bluetooth
Date: Sat, 16 May 2026 02:15:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: donald.labaj@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221529-62941-4hZrvNCvIF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221529-62941@https.bugzilla.kernel.org/>
References: <bug-221529-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221529

Donald Labaj (donald.labaj@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |donald.labaj@gmail.com

--- Comment #1 from Donald Labaj (donald.labaj@gmail.com) ---
Seeing the same thing in 7.0.7. Used GRUB to run the 7.0.6 and the mediatek
bluetooth module works.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
