Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4EF84DFA
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253934; cv=none; b=VDk4GZZwENK5IN5A9j4KNp585lmiMgliPtg603hQfu89JWGm+wjaZzHSPvrUCtR/XYg2By85RK470UPdzetNhBeUndQxNrLUHCxr3xDqDBf8KoRQNC3H0c5UfyVeAOAiejxokU2Be4Ln7oCIzoXUSrTWYimFnmC2uKntgG0l8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253934; c=relaxed/simple;
	bh=kbuDhGSSWkd2DzdsqMr8eUYg6kJMz1pMscRigJdo3dQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OP/W3oKgRamWleLoaPh2U/B/GbROB5tNA/KWaW1rp0mami2zP0U5m5YIQqvj4FgITjGgrym5o42oq85V8qeQlQgpzQ08YiOeO7i8xRo2eFODl7gjaVVswsUk294iztcBRQUHWcIy43Ku0KSLJWEpZYU9cqK8T1bKWWAX0OY6mkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mr2oiMV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr2oiMV4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E28C113CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713253934;
	bh=kbuDhGSSWkd2DzdsqMr8eUYg6kJMz1pMscRigJdo3dQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mr2oiMV4UEA0hn4KJ9UA1VjWyz8pAMGKkFoDMjC9E3bGLbNCRtN9rRDdngo9gR8T+
	 g9k9BDefb4vLaFexQz4bVDo063Nrcq6wIdyVrmNr9w+OCOyCy2T16xHFYpvMKG72Z2
	 rN+farOlLrqSYGo0HwlFGU++w/WgEvrf7UmlKXTYXdd7qCUoy8uKKxYCt/i+s1GYtX
	 KzlsY7crJh2flfXdN3vuUOxhvOkxzrEZHaLRI8bE4QLpfTIK81dhKNBgMkiy8Eo52D
	 xZpbG6ezV6O2lymPUki8I4HZhP1fuFQwJdpMYR9ZvkSa+SjvM2c8DSUouoiyMiyvs5
	 P9mHX6U2tX7ew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 34555C433E2; Tue, 16 Apr 2024 07:52:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 07:52:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-OY0Eycm5bv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #15 from Wren Turkal (wt@penguintechs.org) ---
(In reply to Zijun Hu from comment #13)
> you maybe apply below two changes over the tip of bluetooth-next tree, i
> should have not conflict, then test by following the steps shared

That worked. I am currently building a new kernel to test.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
