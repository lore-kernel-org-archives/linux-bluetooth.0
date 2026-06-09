Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494E348C46
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028591; cv=none; b=Q4NNPkoSmKnPMhQpm2d0ayJfibtJX67mapeoaWnZgtZRW5ulFUDpKOukHV2luCUnNIsb+GFp2ne1QRZSSV0HXYUUwcv6SYroxf4A0tKJHZXY2hsy3k9k5nBvqm2UuFmowbKTh5ZYEFCD1mKLOSt4hVqURrR8Iy6va7NziaY6xjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028591; c=relaxed/simple;
	bh=Yhddt18X+nMkov0MHxVGyWIFOVPcINyNA4zIW8o9/Ns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRpVxNljw/wvI4zfbo8XqqYlbN2ye6j8dRJ6ihxOypHWEZj524zCwJ0wuyVwM2pC+OAWK8hBkT0t0amtRztYPIMpQS4UXr6QC3WJwdDDdSYbbn/0yhSPw/udwbWLxok/LkhzyUh2iX5jpKC/JzkXDhVHv/ggB5iPMHfSzcJ4Ajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLpzhgqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLpzhgqU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A262C2BCB4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781028591;
	bh=Yhddt18X+nMkov0MHxVGyWIFOVPcINyNA4zIW8o9/Ns=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HLpzhgqUAWeGf8UqIPEgd8goF+R4lDhFA+1O2ehSNNECI5Kxk230sfAr1tRdCXQJd
	 jejotJvs1FaHEmqVZ6i6W/yo0FYgaJnvo0ZL85mCnY05TfgtFL+hKCPszNOdyTGe7d
	 tHN3Yn42NXHHM5MJzyn+mqJbFLGU37iXHjzI7Atqm7nyh2H7FFRH862RzqNaewirH7
	 8QLk3a7bBF7rlolDpDzBsrPkfMJbLewJ7w+k9eFCDPf11bPG8s/DJ/Ad6y+W9anamn
	 3ov8girP5GWhArzxybkuRg8r0DFsShNn3mWWyG7PRCsHRqa8PISdHnxvh7YBau1w4v
	 Zc0iOtBn51b1w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 14A16C53BC5; Tue,  9 Jun 2026 18:09:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221629] Bluetooth l2cap: ident leak in
 l2cap_chan_le_send_credits() stalls BLE CoC
Date: Tue, 09 Jun 2026 18:09:50 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221629-62941-zgMO1I97ld@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221629-62941@https.bugzilla.kernel.org/>
References: <bug-221629-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221629

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #1 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Looks good, any chance to sent a proper patch to linux-bluetooth mailing li=
st?
Or I should fix it myself?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
