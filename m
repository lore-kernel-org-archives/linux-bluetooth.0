Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD216EC19
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276737; cv=none; b=sjs9v5/biHXWiF7wihn7V/ZFuOGcPPw3B7hSFnBdaUmPQXpMPi5DR0ytrF+gPQTfVFbw68q6cloKLOM9xMlbfoQn224HdNj2ptBiGHc0v1v6Pd0CkbQPrutEQQByw6bMIS+H6F5qXJw+xGLO2oqoGihWDPHIm9TXBjNK8N0vKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276737; c=relaxed/simple;
	bh=LrNkEdWh9WehbsDOvFaxM2TzqCpsXITARCikPaI/1wo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+PKJiy70+j2gX1JicxJ/qoGxy/0FuEGs129oNaJSXgihuGV4sNKTxseLJI8X5S0hTG1yKr6KLxbjIxKkmT7kBYEbKHC6gSQIjcN17TLaKEjkQdwZE9bYDcFeBMpoFeUsJdT6uKKdDJBmFjs25Yha/ZuaUNINpwLR8kxhKShzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzWQWL2X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzWQWL2X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B251BC4CEC6
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727276736;
	bh=LrNkEdWh9WehbsDOvFaxM2TzqCpsXITARCikPaI/1wo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TzWQWL2XN4OYLlc5H4qdRd/Jrf4kmr+gHpXDVDXc1ULnFbMH8vJekHVagB8za3IFj
	 Zll0yoKgMfyJhk3hLeKy/w3lmiDKs2JjpwXG2HXHx5BfX8Vn1OY0JWnwH7GNqwzVWt
	 SzyWAjhcL626RhjcC3KftEFEQOJF2g663om1qcS57Y5joSS0MxST7Bv2o6w/UaN7Xd
	 +mf21LEj+qC3Efo6Nyo4duo89qyuH7GIvmbaf+duI2fz5QKyS9hkdC+P++z+0i4zyc
	 aRx9HKEWXIBkqjePGNnN7Xdf4x6SUfsClIdHeNki5mOJ0htUcbQZEtp8bLg0sWyiIQ
	 BGfKMr0gVtfJw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A558CC53BC8; Wed, 25 Sep 2024 15:05:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] NULL dereference pointer in Bluetooth at boot
Date: Wed, 25 Sep 2024 15:05:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: casteyde.christian@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219294-62941-JxvvGkurVH@https.bugzilla.kernel.org/>
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

--- Comment #3 from Christian Casteyde (casteyde.christian@free.fr) ---
Hello
Yes you can forward and Cc me.
The problem is effectively rare (got it twice only for now).
Best regards

=E2=81=A3T=C3=A9l=C3=A9charger BlueMail pour Android =E2=80=8B

Le 25 sept. 2024 =C3=A0 15:54, =C3=A0 15:54, bugzilla-daemon@kernel.org a =
=C3=A9crit:
>https://bugzilla.kernel.org/show_bug.cgi?id=3D219294
>
>The Linux kernel's regression tracker (Thorsten Leemhuis)
>(regressions@leemhuis.info) changed:
>
>           What    |Removed                     |Added
>--------------------------------------------------------------------------=
--
>              CC|                            |regressions@leemhuis.info
>
>--- Comment #2 from The Linux kernel's regression tracker (Thorsten
>Leemhuis) (regressions@leemhuis.info) ---
>Christian, I consider forwarding this by mail to the developers. Can I
>CC you
>when doing so? This would expose your email address to the public.
>
>Also: I guess bisecting
>(https://docs.kernel.org/next/admin-guide/bug-bisect.html ) is not an
>option
>given the "occasionally" aspect?
>
>--
>You may reply to this email to add a comment.
>
>You are receiving this mail because:
>You reported the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
