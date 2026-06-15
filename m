Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B0CA52
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781502526; cv=none; b=XVxN8no96lEZkBX5yMydmQ0QQgccaGye1t9Ff7ucuwimxRZYdKsZDHtH78xNvMICnTOpE10dNeWxOwaGOx4wn19Tfi3Y3QuCbw5Zrck/6qDSpvQ1PTC64gfA3PvsO30dqWKQoBiQFxFfA7rqtRhsdaVh+qU96AMgO34SCg38JFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781502526; c=relaxed/simple;
	bh=WGTJU2Zhcwv6q7vczuLPIJcFE9STLxNFB1FLtpDdpdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qK8pQGh29WD3767LoBEGtE55So38NIjqXiP6jMn2OOCHroQQGoRpJyCfqrq4lYXr2jE2bhJGYWza2rqhL0/96AhoKq+XaSfn/8Huh4Gir9SiLBlwTKWGgIbRX392ZKOTjmpvbz0oJe4/NKBN94epuVCf7IJ1j+aG2HUibeAk2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkqNBfvi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkqNBfvi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6B69C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 05:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781502525;
	bh=WGTJU2Zhcwv6q7vczuLPIJcFE9STLxNFB1FLtpDdpdM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LkqNBfviM5cCb2I5fjNO96NMkwcXb/RjazAS4ugI/nh8lODDvYglWohbk8VmyC9Vw
	 +TR/lVaqfq5391kpCR3dDlnM1O76G6J8jlcN4jOPlwfp/In2Z3ZVRxUHiwp7GWpDUw
	 J8nSYxDn5fV+kB0A1ARO0KQ7lhMSf24eOBLBjIfOyoteeOqNe6+l4IjK3w5R/dqytG
	 Ti6As/h/vhQ3XorAVGMcNqFMuSl+OfUH8DtwrF+X6eXtbVxlyhfx3+bXHYoxL45vFT
	 OAr7L29/C04nq/OkHAz7VONOvOP3d3XpUH3/OTfpyfJKVE8rYqtu+8Y5WprwSWJHAd
	 ZQEYPNs1+Ylkg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D2DB5C53BC5; Mon, 15 Jun 2026 05:48:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Mon, 15 Jun 2026 05:48:45 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221637-62941-LXCj5w3KNy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221637-62941@https.bugzilla.kernel.org/>
References: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

--- Comment #8 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Krian:

> the below patch.

FWIW a quick reminder, "[=E2=80=A6] updated firmware files must not cause a=
ny
regressions for users of older kernel releases." -- that is a quote from
https://docs.kernel.org/driver-api/firmware/firmware-usage-guidelines.html

So fixing this with a kernel patch is nice, but by kernel standards this fr=
om
what I see still qualifies as a regression where the firmware change needs =
to
be reverted to avoid the problem.

That being said: if we assume that this is a corner case that only Bianca a=
nd
maybe one or two others hits, then using a patch is fine if it's fine for t=
he
affected people. Is that the case?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
