Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE02B64A
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721453102; cv=none; b=gLI8lq9JnHB+3kowQtlxuozE/1e4QEKGiufWNulB3CEy+p1/gc7MLmi+JDXfGG0Mqcs2mGuyN75htMoQgkTxL8T6w4brV2EpfrZ/ObMWMCa0zu+Vp7NdNVGz4SkPUUQppdHCkHih2wMIWc641TKqeIXQfRZvn1GEBCyZufLOfiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721453102; c=relaxed/simple;
	bh=cQE6jOFXjcuMW2Adv0l2fWsfLI2nz2r3gL4PeUZ8Xqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rteAkKgNEWq22pyWT8D6urNOIZOlNqp2jpOdOq0axGuOiaWz83NWquCq8PShEhzWH30DmQWqksmZCHMhu2jimuEAdez7WAtQlAOCz6gML20X6UzCi+S3mws1yRqm+GcOEMj1vfEdi5pXP3KUDJ86/VTV7PdsIKN48QGrOn2quF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUlnSt6M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUlnSt6M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 156DCC4AF0B
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 05:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721453102;
	bh=cQE6jOFXjcuMW2Adv0l2fWsfLI2nz2r3gL4PeUZ8Xqg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CUlnSt6MAaXwMvvEb/kfl8eA7mFDWTX1J2YIZUjxL9ZReyOkDSadywT1fkhSO7mgG
	 DTo+LjgMVYMdFE+omfJML38FSQQKuK7Q1kxMV5eFDFjyZB38B0BGodq6GWE2Ozl3qU
	 sQ+5GL7UeJfzp9J80L0zVmFkIs/CZvwCW0zHcNkmExKGJxAvRd3Hg+GN4QEgg4+DX1
	 jeVTTlSo/yCkqqu0nSrN5fW58dyj7n/fWd7/6gL3EFAZ4S9TyipzA80yOtg0Gjx/9G
	 pJGByamRvFurTsUm8R9gU/xh0grPDQsfe43F9pq/2Kfo7xBR7MuyYUbMKL+faBsC/k
	 oA+0P9fSGyeFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 02220C53BB8; Sat, 20 Jul 2024 05:25:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Sat, 20 Jul 2024 05:25:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219057-62941-ht8gHxjybg@https.bugzilla.kernel.org/>
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

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #6 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
(In reply to ricardo from comment #3)
> (In reply to Artem S. Tashkinov from comment #1)
> > Please try kernel 6.10 and if it still doesn't work, please attach `dme=
sg`
> > output.
>=20
> I cannot send because is too long and I can't send it but it said the same
> error what I am posed here

    $ dmesg > 20240720--linux-6.10--messsages.txt

Did you try to attach this file clicking on *Add an attachment*? If that do=
es
not work, please tell us the size of the text file.

    $ ls -l 20240720--linux-6.10--messsages.txt

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
