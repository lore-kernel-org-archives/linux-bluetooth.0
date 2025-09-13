Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FF1C1F13
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Sep 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757781595; cv=none; b=KHYMsNj/Sjky0AulqCgP8QJ8Vpyv2dW4phsdN/hm2ND0KX4qSLR8YltTXYe59XN3JXhjgVEDNfZmdR+bPvEZKyPgcuLHUn67Czha4sqrhh/9ufNSw18bisuVw+KKLagLJ88qEgua21VdmBKwyuAJtiF4x3ecnbYc7Vf0/EGUh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757781595; c=relaxed/simple;
	bh=dCpD4epEwYTCtkgVASuxB/3ib3jhv4lacW1lhpkzyQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a8E+bgYVaKwGU2qRTbkHgeHAtvaSjCd5XDjPvl845Y+zKJsmf39VJsQszLi4f/6Kgvv0BJAwIyqLll001JCs+nlfahF/atO/mtL7klOBwZttxu3ev7TJtUxSlwGiM4BsBJhVkHk5nQnOnRl+L7uFKnee2QO46G7lbll8R1uzqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3zU2JDN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3zU2JDN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3A97C4CEF5
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Sep 2025 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757781594;
	bh=dCpD4epEwYTCtkgVASuxB/3ib3jhv4lacW1lhpkzyQQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B3zU2JDNzcvuUzNgxrnjh3RrRQ+KFTqbPwuKXWNfc+dCkuMvnnEkJ9XycAdjalLY1
	 rg84ctadxp0/tip3M+FG8vsVqgjIgakAVdU5aapdGeM9lfCOk0yz1JiwnkYolM+1Sp
	 fFMGFV/X7K+nBvYtqUG3kt3cC+hgFk+okOydR4LPKWP/i9g2wWLXHAhxW8iWF3lmBX
	 3EJA7kztddktCi8LOpk4eaJzsldFnUtI0u743Ho2OmEZt+3iBqkHcz5iUeOhDUP4NH
	 dQFk6MUlHLZACPE9GcTkWibs0bOE76v7w57yYK6Xr/f6eUfM8thUfYW5I4sd6eMUvn
	 8Cxdkz3AsUgwg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A35FDC41612; Sat, 13 Sep 2025 16:39:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] Wrong indentification of Bluetooth in Lenovo Legion Pro
 5 16IAX10 and 0489:e111 Foxconn / Hon Hai Wireless_Device
Date: Sat, 13 Sep 2025 16:39:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-2zMalvUE2G@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #2 from Jakub Jankiewicz (jcubic@onet.pl) ---
I was mistaken it's still happening but less often. The logs are not flooded
anymore.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
