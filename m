Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40B1879
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566310; cv=none; b=aXkBKXDiN1yd7l8OXkzrvWmsI/nUFaFXl1XXeNqn/nlPURECqSa6F8Lq7PNAM0wLCQN9B/7LsjXJuKRqMe3AT7TeSdUSyEzB4OxsVHtiU6i8IAO9kYj1bWNVjYB+XeXG1Di8uc3M4gXDaODf1+TmASLSMTUxE4d5uDtzRB/taJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566310; c=relaxed/simple;
	bh=CUY5UV+uh9BnVgZzpB4hEkQICOfKfW0BKLGiVWr/0Lg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S841ic2Xpn/xZ+IlTTv8fhyVSvN/FXguqbUy9pgLA7Z0jCh2Gvpt/9pHRzOw3PhP4e0/Cgaw7NvAMmAEnr6OtbExx5BfCZiyLQPfrHcXF2++rfz8T/GjyCISRBzaKnBLGI/oCf2cRvNA4P1Tov0iPqY6lgzG8b1IoAwHzz5j/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM9Dc77k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM9Dc77k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BED60C43390
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711566309;
	bh=CUY5UV+uh9BnVgZzpB4hEkQICOfKfW0BKLGiVWr/0Lg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cM9Dc77kxm6klj4Sc/NR3fFb+BLRgUhLwEKgTcf5v1znE3almAi3HBGhPU1sL5OmB
	 RDmr8rH52gDjTYKasFnGRWp9hzmKlpZlMjpPUMZed174R7R340e0TP/VgPPFATmcij
	 wibpsWxShzFV7M0bnFirI1AsC90RYtrByYUkVT2GNNEX4wOpfjoQBRGnDn3LyCZK3P
	 Bl9NESF5zSztkpgiwZduww0nAnm2YGGoLuPRyqiS0reDSjr2ce35GaQYDfKOxLIm2d
	 F7eoaRpVykO9zuPxMO7VY4v2B8zd+1Wb6MnNoenSAeeMFrePB4Jm1HSM6g0Nr9Sfoi
	 ZGCXdpWSiDWJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A387FC53BD0; Wed, 27 Mar 2024 19:05:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 198919] Xbox (One) Wireless Controller won't connect
Date: Wed, 27 Mar 2024 19:05:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alexis.salin@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-198919-62941-gx4w4g5YM4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198919-62941@https.bugzilla.kernel.org/>
References: <bug-198919-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D198919

--- Comment #11 from Reaven (alexis.salin@protonmail.com) ---
I am also affected by this bug, can you fix it? Thank you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
