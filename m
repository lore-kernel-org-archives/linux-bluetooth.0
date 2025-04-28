Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BC288C82
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859570; cv=none; b=URCOGDTkNFwXxVPejjg7AjCwfFJsiIqXDeCtCiNP8AX/Hjr8GbodDHBjIsGi5vOt48NhBKy0SO88Q9F9nTYYRrJatpKnbaQ7IghPp8aPyamsTe8nYhLR0GBcDlCgTh1/iGhDeYUdDac0qU1+TBhc1mJUTFOepgESEqAQpl8DP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859570; c=relaxed/simple;
	bh=YhHC3rdkdf4lisiIplqJGpZ98BmudRX8E0qsne4LiuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCL2tOzcLOdrZMdZ5+m5tCwP7MRrKFlXuvw0lu+JI4tCFCoEo2kOL1NlDS5gLhG+h8RuDxxGu4ShabAREEw9WukWEPs+Ic5Gz48n64f0DgInQ/Pk5764waXqth+i93Xz1S1aALmzUL+wWM00vNT8ABc2Mt4Mp//I3KfMjEkigWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgUpUHEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgUpUHEc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E024BC4CEE4
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745859569;
	bh=YhHC3rdkdf4lisiIplqJGpZ98BmudRX8E0qsne4LiuI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CgUpUHEc9wN+8aDpmNhQK4pZPLPFGRv23QxW+z1ffqFeYTuBgsBddhDM0s8A3JvYe
	 l9NZWNDZL5XEGov9Q5ulwBhle650VkU215WQm7S6Y4mtOl2F1Nhv9IxlikysaNt2oB
	 /4WbBBZLFryirk39EShhPbqa2eCfHEX1laBPfVDjO5M/muAjR+rpLfGWLyJ4ZkoRbN
	 rhEJDhhgNEbeWKy13hVXIgSX9JCjcqHFU1AQ3A+t40DaNBpgh8uPueQJDknKbdWZBa
	 ye7Kqn0Yj4XjRpF1uOYDOKJGNtQmmalfp8VS1ng2yCRQBlUYmktrCs9eER/U0RcfH4
	 j3q0Hu0+s+N2Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D494CC41614; Mon, 28 Apr 2025 16:59:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220063] DualSense and DualShock 4 controllers fail to connect
 since 6.14.4
Date: Mon, 28 Apr 2025 16:59:29 +0000
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
Message-ID: <bug-220063-62941-PXmkcnxQKH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220063-62941@https.bugzilla.kernel.org/>
References: <bug-220063-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220063

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Could a be the same issue as bug 220061 [1]?

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
