Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC58C172BD8
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896199; cv=none; b=NvARa32hWIt+wRV0K2gUHwGp+3+vy8MvFOmPNWInPplDEnM0nRp5/Hmt9SnTykueZ2Ug7Jc0ZReHTDW7mIOELNyS/HCv3pceVNI3ww6PJZPQQ3PijOXU7iei1O/2nAsFVo1ot3gnE2s8ky/HCtncw0yF/LJI6WjJhiTqbgcyTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896199; c=relaxed/simple;
	bh=saNRmJTew0YxrHAOxftPV6mbMbGB9gdPmBsPURqCVYU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nzmz76F+dwJ4cj1rrfH6YNxGkYxU2K6YYPnY+qYQseSlwAisy0yVeThq5ve1LrouCRpSoShOiGzpx5JqFrJVpp6x2KlpCHrQGTS0t1vmX8SBHh4N1j0Jmmck1RULn+kqVHdH4Rb6Gh6Y8ao3XtjQHr7hWSC/uQBk0lloCL/K+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx/FhgAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx/FhgAT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AD31C4AF0B
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721896199;
	bh=saNRmJTew0YxrHAOxftPV6mbMbGB9gdPmBsPURqCVYU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jx/FhgATXQdqIRb0qD4i0gt6slZlo5xjEZ4FdkoF8FgWP6NMceoGI4cwm62T+ufF8
	 UM8w2mDRky3D1kyDuc63GqvMElB8skyUBklJ7xmD9VK1MZDxx5bmWhH0LKIs5jeHqp
	 edbMxEyM17uz/peQbr0X7J5+IkcTs9EdB9xVLbmMZ8kb2F3nfb9CHRrAu5dZVUnbpM
	 Pek933c8j4tpIMF2as8gDjjl5NGaSktlBljLxZsBGdLQb6cE3Yhza5yPQd1/sVynrP
	 WfzJnoeRV6ckLT9mq9I2TL0r5a4ykUQHtTbAAWRLsu+8EK+ljIRryPGlTNjN6aV2XN
	 vEg0VjIefjEhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 78F80C53B7E; Thu, 25 Jul 2024 08:29:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 08:29:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219088-62941-LB2SAqve7Q@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #4 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Eugene Shalygin from comment #3)
> Converges to 2e2515c1ba384ae44f6bf13dd64b9a0a950798c4

thx; I would like to forward this report by mail; can I CC you? this would
expose name and email address to the public

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
