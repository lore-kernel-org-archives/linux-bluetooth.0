Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9C3D544
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626481; cv=none; b=H1pMPhKXVtMX8QbkThxAxBqFLfLARpCQzSFBonu/UCogVHPQw+sTiNkmaLy54qOphq0ZRggucUpmrBWVYNxbFS4N9uB77vL77V3uuUX0YO3JDxJAwkl05YYwAmot2whTpfSVdEnwkl5Z8H5gIEX5fEWHXP+klP0tBnvNCsdjw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626481; c=relaxed/simple;
	bh=pQJ2BabFdfVYmBQRorbtC78fEL4VvfciospE5so97g4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ox1zXZNlI0tGTBKnjEVAYFnonJvq5msjh2zNmaX73WtZQ/kBUp8JyWmz1kuf94spBf7RYi87gvrRNdkc7ToGopaaw33ArQiyIlJL0M3pi2jitADD0dvlvuPw4GMkY+ehdU21ME/iBAySVeJenJ2LmBMnyTZeFZtb+B2/m4ea2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScwnMjk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScwnMjk+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83234C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 00:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752626478;
	bh=pQJ2BabFdfVYmBQRorbtC78fEL4VvfciospE5so97g4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ScwnMjk+ERBtrSDYLVyhQjlDyln/4BRfMQYj8Ef9aRNDfSg+lxT2FgzLU5H6y+seb
	 yXPHuyisezFZ1MWO44eeWp1OJulJREIEkIXAVQ89ROmv7LZ43D4t2R1VoyeMm5ep7H
	 PLRC/TxJ/uL0mi4mjhSDBuqkk6lzoJdwyENQDz38nP0V3+jImF1vLmvQGRCxB1TJ9b
	 1DSNuKK4bYZGBrPxtlGsRXj6e6gnLO6qGOfsFzoY+LkzJoSxLp78w13qvpzCYX+88o
	 laES2ZdFBq6fSICJSMygt9viZ9bHzb0hdvY/o719esnLOpHYG4Z0/jFRj7Xq5vL4nI
	 3LjMtmZQ2WICA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7885EC41613; Wed, 16 Jul 2025 00:41:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Wed, 16 Jul 2025 00:41:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sameeross1994@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220341-62941-Yrtv66oTcW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

sameer (sameeross1994@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sameeross1994@gmail.com

--- Comment #2 from sameer (sameeross1994@gmail.com) ---
In your case, Kernel Module Crash happened, Could you please try
reloading(using modrpobe/insmod) the module without rebooting the system and
let me know here?.

Also After how much time you are observing this behavior?.=20

Is it happening only in call or it happens in all the cases (For example
:Listening to Music etc,)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
