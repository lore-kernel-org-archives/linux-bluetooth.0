Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045013A879
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742549; cv=none; b=peHE7mx1JDKtEBTuXJtECMV3k4pRNG4i9FFJUxq8EiVs1KLA+JV3AcxlIkEJubqfhY9r8KguihaSeAABCBcD6D4UOX/oY4gE7NAQL8k6B1RGIWnDY+7Kd9dlRCFSN3rCZ7Irxc2iT0iAiyghKC1SGhSJEH806gCVHpDVbntjqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742549; c=relaxed/simple;
	bh=QLfmFTeMZbk9smZhXBb0K5kPpt0NELywlV5HlytLjwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g/IDhm7w9HkPm+XTrIVKA5iTNlb5OUkbKA4sGEjEU8brAGS4vIC5tayXMvSin5sR1PQxC2gP6K+GR4//0y6XwnPADtMb2KNMF2vlLGWxpu8O9LMgWN3zofS8UfMivR9bPhuBPDcL+TGP/NKmkuq9Fv30PTZGu5RHfhYIyKW80as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF8eCPZI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF8eCPZI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97371C43394
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711742548;
	bh=QLfmFTeMZbk9smZhXBb0K5kPpt0NELywlV5HlytLjwo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eF8eCPZISM8vOr+AJOeyvGw6FPLFsOXp7taNaPdtsgKNCu2KfwYRzWz20Plohr6w8
	 oNBwlkGzcGWLAqzDusslSpsPA2dbHMRpm2RFICHlXK7Wvv1srUHWAIgg7Vf5ykzfJU
	 9G6Y07UxkgVkdCJOTwhytp6i1RdycgSizmxaJLWf1Tx2i55O2PGlpaN1p7J+fqnzV9
	 mOcCnzT4hFKHllCbT0aYUoBawszvVE6XeZ8CCQY7dhmVlltctjPo/5uQb1OwcxmheD
	 SUlid+MXODfYDWrO6lNpMXIsIdGo9ffFGjjQ7VV0y/a/MBJh1+m5jmWZDqNb0OYG8B
	 /N6l5Nqx16ZPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8ACDFC53BD8; Fri, 29 Mar 2024 20:02:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 29 Mar 2024 20:02:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gabrielreisvelloso@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218416-62941-hEUTF5OZ9J@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

Gabriel (gabrielreisvelloso@proton.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |gabrielreisvelloso@proton.m
                   |                            |e

--- Comment #13 from Gabriel (gabrielreisvelloso@proton.me) ---
(In reply to Gurenko Alex from comment #12)
> (In reply to Dustin from comment #11)
> > (In reply to Gurenko Alex from comment #10)
> > > (In reply to Olivier Delierre from comment #9)
> > > > Had the same issue. Somehow, after a long power-off and turning on
> again,
> > > > Bluetooth managed to show up and the message was gone. Using an AX2=
00
> as
> > > > well.
> > > >=20
> > > > Currently using kernel 6.8.2
> > >=20
> > > Wow, indeed, after upgrade powered off my desktop, flipped the PSU sw=
itch
> > > for a few minutes and it worked on boot. This is very weird behavior.
> >=20
> > Sadly, its short lived. Mine stopped working again after the first resu=
me
> > from suspend that occurred after the cold boot.
>=20
> Yes, same here, after normal reboot or shutdown (assuming it happens,
> because it also hangs on shutdown/reboot now), it **only** works after PSU
> power cycle

Can confirm here, did the test and only work with complete PSU power cycle.
Turn of, waited few seconds and then power on again.=20

Have a Intel AX200 chip and Linux archlinux 6.8.2-arch2-1 #1 SMP
PREEMPT_DYNAMIC Thu, 28 Mar 2024 17:06:35 +0000 x86_64 GNU/Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
