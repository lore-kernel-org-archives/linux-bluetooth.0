Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99063DD521
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521873; cv=none; b=UkZfXyBJohTEMjql06FFZD8aNWK/fli5OczAen+y5NrZS0FhpI9GuE2LycK477cA69GKEF3JGpAYiTt6XnCcmMV73YIE+3VkWzbju8x1TauajR48zMKiH0WzMpsPKfYRbMAyTyHWNB1i0BZwpcxRERFE8+6BaKddR5Z5EHVSfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521873; c=relaxed/simple;
	bh=yPwSS4P92n5OJBWZmmkHK3oMJUGq5EAqMCtK498eC0s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bhDloaFITPcAuvs/kOJT/ziQgQG3X5txWdHXfOcsBLGc6Ik6v0FPtAQiweVCUSyw/DFsDOlC7QzWUX48ynTQqTajP9LY3uhiOVp+0elUFJG8LjdJIyM2RaaeauoljsvRrb4+JKX2QEEGljsU/PKYGoehfLcliMVT0oWJe3RAAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWx77hyp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWx77hyp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69991C2BCF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786521873;
	bh=yPwSS4P92n5OJBWZmmkHK3oMJUGq5EAqMCtK498eC0s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iWx77hypUeGe6cZ6yHsjHBhPKwtURaOvhue9ggaQ2D1bjjDMoWtv9Ov4ds+i4EATs
	 UUnJ0KqCOUpK0Wbxa4xfxFkj6Mz7hCYm3FVm8dFe0D+95VG/xctUQS8sf7yXVuxhhJ
	 HG5Ptohv1YvxDt2y4XYDUGtYzJUasrdjcyFqjxwAZHJ88ICVjAO2OB/6ZomxCApRpO
	 +7bUJJUpK0VZgMKbL4osevyQQ71rnF7SjNPS//7qteQiN7Oike9uE0pCmTe0Y0Lov8
	 0G0Prw0Z+3YS576T1iInhb0g3mG0zV/sarZJehANMcnEys+96VZg1Ejw6CGofQxMRP
	 WlCUJPOVy1XBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4AB81C53BC5; Wed, 12 Aug 2026 08:04:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Wed, 12 Aug 2026 08:04:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221837-62941-D8AT5B129K@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #8 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
> Hello, any updates? I'm still unable to use bluetooth. Thanks!

If you have any expectations on support times, then please contact the
company/entity you contracted to give you support. Otherwise be patient for
volunteers to have time to tend to your issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
