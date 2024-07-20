Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC221B86E6
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721500650; cv=none; b=gDJhlwQf4p0vc+xcNuAuxTXTrpVTblCIgBh5mtLeiw/XaASXMt4JVPcQXGiYxoRciM8k+wXqmcgQ3A9Vu28lE2BIG5c9oe70qyRpDkrx4YG/FfEfU/xcp5uE2t29cYw45/E1HtLvD2HJvvj6r5IAV6/sn8p8jnrxedveKf6wmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721500650; c=relaxed/simple;
	bh=u9J7q8P4/LN+jQ9vHxZEnLiV6VkpaWiuv6CMwx7TpiY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDrC0SebQtKMKRHVu9oyn4zfgcRf7RBQIKlO+Oa9wrrXxAjvEJ5TYu1v4Y7I9zfZmhTR3vdhKizHS/xkVWMjrzE1l84Nt/4QOpAqoTC38ikuAGb03pDew9wvBO3COLWjBV8DBRWmokFICYFOa/BKyt5/X3EIh5SqTozTohW+Wp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSRsF8EK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSRsF8EK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B22DC2BD10
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721500649;
	bh=u9J7q8P4/LN+jQ9vHxZEnLiV6VkpaWiuv6CMwx7TpiY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pSRsF8EK3a0Lc1PSSsbMUTXABIDOdv29a119wxFWcQyacvvkN7MjeUVOBEGLyxA5i
	 jf8SO4u/6Z6SRfKjB8cabra0RldOBE5hID4oAjdc8aGTCylFoOkgMOxpQ06iw6Q/ub
	 hghVNh3g9bsfP/c9FyUMFfPUUHNeeu3X2ZW2omoWPwUU5x3gMzvgCE3HcGgAgj9nKH
	 qD1FBeG2PbDYZ/NL6b2OgGe/UlnQgQJRo5r4EtkFm3BYAouPOmTmzLfijzok/n/9CS
	 fKTqtd5ej/1E3UbtBNNTcGOR741jFzwMRsOwxjAFfuOdf0GTJxBdDxmTL3va2bluzk
	 m36VerF2wbEzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5D203C53BB9; Sat, 20 Jul 2024 18:37:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Sat, 20 Jul 2024 18:37:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ricardo.andres.riquelmerios97@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219057-62941-gDHbc46unm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

--- Comment #7 from ricardo (ricardo.andres.riquelmerios97@gmail.com) ---
the size of the text file it is 85,3=C2=A0kB

1137 line of code

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
