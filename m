Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD922339
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735590294; cv=none; b=mQbmBV7/z3q9f5k3Mv12NnbZtpVSddia7Na4j7k6BDkvSTFCp0pxPEpz6B9l3C16UCpkz3+2RF3x+tAJgg/clwxQdhOen+yT/P0mVI/QGd7vHHpLlZrlDWru3h3i2bH8UElM/DXoqOvpKNEDkYVXkNPIbBxuKwt1OuV31UayLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735590294; c=relaxed/simple;
	bh=cmN9iYHK8cfE4vW0LUeslnVHaEr2hSJskrO41hwptMA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZExguhZONWH5cB6l31nS+3paNkVQ2a8X0QRFUzUBn9Y6o9oZjef2xvydbIjeU1LEXuutdAg/FWalrPUtasX9jsPuhUlMpajMmrxwQAKLavTFSHdnm/DJFQ7jWDh+6zJmknwVcrIWCb4/z6Cy3wuXD9fnXyA8tipeVmQUqIwWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syGvSSar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syGvSSar"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BF20C4CEDC
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 20:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735590293;
	bh=cmN9iYHK8cfE4vW0LUeslnVHaEr2hSJskrO41hwptMA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=syGvSSarq69MaY+qkNT1aNsIXrL+d7237zVQN4QJZbRh7llKsqYj33hzH67k1EG4v
	 5hZmLaGPqFMYUF1NJDZvcTC4PF/Ma0teyInZLaoHPc8sJMOuMut+D63Bo9WqMtlmHv
	 1ItFjzFpqApn7e2Y7P802I8n8mlM1uP/2/XLtY2t7EKtc7jzQ9Qq2KG2zKW+wqXz27
	 oYAc5/CXI5/4u9HTkDTqrgayhC3XpBHv7ul7tTsS6SJIVTOqerHJnbBy4kgJwQmcto
	 qf1LmO5mKUwcLFyovsXOyHohuNqDKYtABDi4WXeV++mJnTClRbhcs6epxLIPMrxg2n
	 IEE2L+l3fTHaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 92A4FC41612; Mon, 30 Dec 2024 20:24:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219642] graph xrun not-triggered
Date: Mon, 30 Dec 2024 20:24:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219642-62941-N6FWz91chu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219642-62941@https.bugzilla.kernel.org/>
References: <bug-219642-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219642

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Or maybe just maybe even create a bug report in the PW's bug tracker.

The messages you're seeing are not coming from the kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
