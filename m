Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794B22A1C5
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 May 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710001; cv=none; b=qFd7IKILtT/d66I4gFJqTOFHybvgQIQlbuMt4XXOVI/s5rpchboh+RCMHHOPa6picLduYsqCFARUtGf0kXHHc1NwVH2uXFC9TqJK44bjA4kSq0y9oeGpg3jqemNS1TaXnXSSUBgt2sIW3gReYSDMIjQkfhV9X7HwDuaAs80+BGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710001; c=relaxed/simple;
	bh=bFxPa4or5M/pCd+k4SSE4aj087sX+T8fi1IcECu6IM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJc8Q15rZMXB8CvUWwYpwXLX3kD3mDCqhMaK2rR9rtv4H9aW8FZlGNue/iFKELkCaIFIy3Yv+BEm91U9zum523kXY8YNX0G11D6CagDx17QpxJcZ0fcWyiDWgZTiVXO6rLJI9mtZTpPlUYgTyLxkVTSyIurktYz8vO2zeahIz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2QGFih9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2QGFih9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 448B6C4CEF1
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 May 2025 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746710001;
	bh=bFxPa4or5M/pCd+k4SSE4aj087sX+T8fi1IcECu6IM8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B2QGFih9Ycsi6c+t6KXkEFg1AyXxyqJrZ/lu4yiT7a6pm2yN32x2n09DovhNvnQFA
	 CdZsR8Zo3xoIR7TxtZocasUEtkho9e3WuT1b0jFYbXOScN+tvUHU9LpYhe8nFLBuA9
	 bNSKNHOpIDmlkfmpEjpjP6l0KSBVN9OYMBwYbRsOjTw4dUqQD3CFUcb4/0zmT/2iY3
	 6PwAnZyD2JWk1sSog16UfEw3R6QMfq00phwjTe3BUpasVxXPigitAUto6UymBu6bEz
	 dBUT9Jwa9hdh82ww8dtnXIjB2SqGsxsgwzZZfn/IHIpwJzcy1pgAskVoVWdbo/7joL
	 TUSAKtdwbnDfg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3B383C53BC9; Thu,  8 May 2025 13:13:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Thu, 08 May 2025 13:13:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220061-62941-JE4RGYOYPt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

--- Comment #16 from Artem S. Tashkinov (aros@gmx.com) ---
Strangely I don't see anything relevant queued for the stable.(In reply to =
Luiz
Von Dentz from comment #12)
> (In reply to Sandro Forster from comment #11)
> > I've tested v2 of the fix with a DualShock 4 v1 and v2 (the firmware is
> > probably the same, but just to be sure). Both had the same behavior.
> > Connecting failed on the first attempt, but every following connection
> > succeeded. When bluetooth is restarted, the first connection fails agai=
n.
> > Here is the output of btmon for a unsuccessful and successful connection
> > attempt. I've attached to logs above.
>=20
> I think that is because when you restart the daemon the link keys are
> reloaded and then their key size is lost in the process (for Classic, for=
 LE
> the key size seem to be stored by the daemon), anyway I just spin a v3 to
> address this so if we don't know the key encryption size we use
> hdev->min_enc_key_size to satisfy l2cap_check_enc_key_size:
>=20
> https://patchwork.kernel.org/project/bluetooth/patch/20250502202052.28024=
41-
> 1-luiz.dentz@gmail.com/

Strangely I don't see anything relevant queued for the stable.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
