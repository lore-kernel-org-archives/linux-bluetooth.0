Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE660384CD5
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038149; cv=none; b=fZRmKw/qzxho9QdZmUqNrp9QBPXo9WnhHArT35Cuq0LRQSy/QzTiJVLKDKqSo8adTGZmrZoCaaenu6+hoRoxZ8+28DDwmARxme17odSAho3EXO3sz58J20UKljLJRuX7/pZlRmI02ClSU0ixbCAsjOTyFFVwK4Zpbyg20xzIa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038149; c=relaxed/simple;
	bh=/5v+DYRqlL2vuc7bqBzji2kXGJDrZ01Ru+b3sZnKre0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MsH6cUP23UTWV9UjGWIH9BmPWy0rMTnqPdRbLLweQrNyNNQeDzm1i2JhdazBcAbX2TKFAbMmtetSVS2zlIIdcYJfFtHdCu/tf9NqU6d9aqDKGQAdqtGwT6C+sKKrwCF+ORDQo8mQIgFgDCFFCm7nwUsW5urL8xiXa+z4dGNq9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtHaEfkD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtHaEfkD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 553DCC2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 07:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787038149;
	bh=/5v+DYRqlL2vuc7bqBzji2kXGJDrZ01Ru+b3sZnKre0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZtHaEfkDg79rkkMHiguj7/F6r0VknNFe3wAWRisUsnLMjoVd24VAdjiik06fidU+E
	 1rGhwQFyzD7Um0iQFsi+hTrR/r01hPLqC7Twqy2g5RD95+N+5g8+PAXbAxjnwQrsdG
	 7XiMCxMEZo/Rf2dW9SaQn9r6ubJozIdZukdbWkOnFEjpKMZ10y1dUqBi9o9amzDw6I
	 yyXagqBnvuqRYJWsP9aogOpVv+C/xN2yNfezLYIpzltbRonmUdR1dECgtaHTqlsLcj
	 rQz9rlZ9gLYeUSEmCRHn0MmfsyNswJ1l0dotpzds6ajQqlgVBB2aSs9ab3NBYMOXR2
	 /oS2hcenNfqqQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2A562C433E1; Tue, 18 Aug 2026 07:29:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221878] MT7902 Bluetooth USB 0e8d:1ede firmware crashes during
 use; reset fails and controller becomes unresponsive
Date: Tue, 18 Aug 2026 07:29:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: maksheev777@mail.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221878-62941-mHtNAt9UGe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221878-62941@https.bugzilla.kernel.org/>
References: <bug-221878-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221878

--- Comment #2 from maksheev777@mail.ru (maksheev777@mail.ru) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #1)
> > The same failure was previously reproduced on Linux 7.1.6
>=20
> So did this ever work? e.g. with earlier versions from the same or an old=
er
> kernel series Or an older firmware?

I do not have a kernel/firmware combination. The laptop was installed with a
recent kernel. I did not test prior versions.

I have had issues with Linux 7.1.6 linux-firmware 20260622 and Linux 7.1.8
firmware 20260810. I cannot classify this as a regression.

I will try to test earlier versions of the MT7902 Bluetooth firmware and re=
port
the results

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
