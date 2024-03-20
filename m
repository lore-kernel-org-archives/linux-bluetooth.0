Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413E3B293
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933653; cv=none; b=Hjdx4h8Fn/u6LpaDUmDheuZpm/bfkYSrQ5LN7wWCtPS8L/oKn583zXzirpQG58YgwrRkDV3ocngeWakS09eAHZCfx/NMlxGSbyi6RfefHvrg4DqPpIuuaNcnxhVltiYkUi7yVduTq1eZ7Z9lE/uQZQQLEHTAZ57v4CwALr5+PNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933653; c=relaxed/simple;
	bh=bySY64psIxMSeI2BQ3DcdAPfvHpOZAsxMl5TNwDOKNA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlMih51vuE+0V22s96mmlSCZiwY3cjv3B86n60ppOhI+DK7qW87X6HnoOvB2tVPatmLQ2CgQCVZu/S2iCV0Yv4KDopPiDcQkeM49psoNBFxPnUi+PgVcj6aQon9UyZnNW9s3kx+rQ6n/4WN976x/iYKEQQBbPaMoB6PEqJV3Hxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLsm6P19; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLsm6P19"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76DDCC43399
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710933652;
	bh=bySY64psIxMSeI2BQ3DcdAPfvHpOZAsxMl5TNwDOKNA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KLsm6P19eZejWziapfRSofqaKL0cPO68iNduNh1RrqgGfF3nuh+42HY9q4w2FzGX/
	 AeyUvXgR2Qw1CzifOXy85xMi20CLc3LAodDHErtbXl5fNNZS8MnPVQwM1UTo7DGNrC
	 uf4OKK7SPmwMj31jrtDuxQSSivYLkSt1iUVY5592OsKtZz492l6ZHTHWmVbRep8U21
	 Qx/kScAMHHRVJAHQ9ov+s/1tp2OyZiVtyjJUB2Lm2mWdPiG2vt2NxdJ+1nTpqtfcSx
	 idlA6qt+jKwFL/zDG6LdLa7dvM3+TyG6HBR28G0YlX5qq7f9cp4A5nVWPimQdPKhyv
	 HteqvNctGdFzA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6FCB2C53BD4; Wed, 20 Mar 2024 11:20:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 198919] Xbox (One) Wireless Controller won't connect
Date: Wed, 20 Mar 2024 11:20:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: delor.vd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-198919-62941-gHQfQfzm8j@https.bugzilla.kernel.org/>
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

Vincent Delor (delor.vd@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |delor.vd@gmail.com

--- Comment #9 from Vincent Delor (delor.vd@gmail.com) ---
I always need to install [Xpadneo](https://github.com/atar-axis/xpadneo) in
2024. Without it, my Xbox One gamepad is not detected. Every distro and DE =
is
affected.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
