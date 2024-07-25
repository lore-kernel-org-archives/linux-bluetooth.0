Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC9D299
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944382; cv=none; b=gbjzrvj/3w/5PETBDZEpFaRdoXG4S+0hspo4IYzXvW1rNfwYTAIyv/tWmoz1aP6ZjYzLp2c0ffEJW5M2yeYMu+10aP/8HHNBBur9ak/bmBsI1rJcZ7KJvGEgl+akfNHPwEr2QXRMKUmiTCm3fOxiMMSRp8pMmdQ3PZUAtdrDp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944382; c=relaxed/simple;
	bh=SpK4Nx80SrWIXTSx9KZHEvqXDONAuN8wlaskV0sqCco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OaE77ahb5+xp+dIUp86r6SZhBy7LckUmGye5oI0EtEnMwavi5hQDT424Kl2pb4BK8TN1i3OSFZqZQ5K5JE8vMIci8lnQdiR4rSCFXgKesBbhY/cUVmwvdIZXk/DKWq+24Ue3p+orC9kq+ChdmyYZYI/sjL+N/u4XCeSpnsabH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNV7eySC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNV7eySC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0321FC116B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721944382;
	bh=SpK4Nx80SrWIXTSx9KZHEvqXDONAuN8wlaskV0sqCco=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pNV7eySChyYmpJjCChiyKPgHPWE8qADNr34qUK9+xHhlBaUV6TKRf7cN6yBMdSXuV
	 f+SLSCaxC5J8ZVl7XrPI0fSDGHjltfKuGb7m4OAA+qNjcR438cfgKgg9fzkaD6B7Ll
	 CvkrzJtQVUnspCz6SzyXkUR9jrVCAQXIkyTeqlay5npISRI/et9jSdx1kKGbAoShH5
	 3ecDXllQ4Kz1kNzGDJQZ2ncMp4l4W6oVbfS/g1aGDCu5Fm//Fj8hUkDq0yjOZKju4W
	 UHXUxcILPvgP4PoEKUtO7NxR1s+3hUgdYLhmdKL41fs1T+MMvLcjzGCNUjeMVfYPuw
	 bzw6O+rGD+Zsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EB2A3C433E5; Thu, 25 Jul 2024 21:53:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 21:53:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219088-62941-jwiWEH9krk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #15 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Eugene Shalygin from comment #14)
> Yes, I'm sure. Nothing new appears in the btmon log after issuing scan on=
 in
> bluetoothctl, scan off results in:
>=20
> @ MGMT Event: Command Complete (0x0001) plen 4=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> {0x0001} [hci0] 89.970607
>       Stop Discovery (0x0024) plen 1
>         Status: Rejected (0x0b)
>         Address type: 0x00

Hmm, this sounds like the states are no in sync then, bluetoothd thinks Sta=
rt
Discovery has been triggered but when it tries to stop the kernel don't thi=
nk
it is discovering. Do you see anything like Discovering events when starting
bluetoothd or have Discovering: yes when you do bluetoothctl> show?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
