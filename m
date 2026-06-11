Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A22DCBE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188190; cv=none; b=s5fCMNLvleMAu8JuLdxwARNKfLavWAqsgQpTSDQq+wU4ddgtBBtVDNNJcZCOXiUtoc42fkF9Pe6LfANm1uhfik5eitEbpTKFbrMQIf30tNGXwAxMmySg5y7/QtjEHlyh5SBbVoZzNfergAIHOrlkHvVSWifKGcO41oEl19muIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188190; c=relaxed/simple;
	bh=rVkD4Ex/RUEEvXGKN/m9jjpz3+le1i8Rgjc1RnafSlc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=seByExjvy7fsCVxIdBBAdqqzS+Wp/t/nlBjbO16+ED8eJWGUdN61NRT9RStH54SBFuAwLvEmlYFVWsJagcfV3xGjjcL5sb8nCF1CGsE/p6Wok3ZD22YyYABVAKuTx+5NjGHjzYT7CBy+8pBltoRi3wQ0eluuxnK+XqgleJXPNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNGSYo0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNGSYo0y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0768C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781188189;
	bh=rVkD4Ex/RUEEvXGKN/m9jjpz3+le1i8Rgjc1RnafSlc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CNGSYo0yMliRom9Nz6JDyni2JgDywaGL4g2KEsIRP/i1DZNXA+IV/AJTnnV1VHeQz
	 HEpfUf2b65mR4LO+rWjcwKLPILJq8VU729LDQ7YYx/msRbiSPC1g0G0633XjvUhySC
	 KidAhw0HoEGkw4gxuUNHTKBElLslIX/ddMcauDL7isQgLD2+e3Hss+xARCPU8YVVB4
	 NHZUh0n03PpK7SmctJmtDRyIXqHHPuBFaPn1+NvyNe2B8tYAgPHBsgVGhxFRgMhNTy
	 U+QEJxuKkG+GF3rY9MldKLqVjGJ3p6CMJEuGcyGRyA43rXY5v6E8gMDUCoa4Iv7dGM
	 rBwqsl15Nm0Vw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A5169C41612; Thu, 11 Jun 2026 14:29:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Thu, 11 Jun 2026 14:29:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nibheis@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221637-62941-xWNo0w0JHI@https.bugzilla.kernel.org/>
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

Pierre-Olivier Vall=C3=A8s (nibheis@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nibheis@gmail.com

--- Comment #1 from Pierre-Olivier Vall=C3=A8s (nibheis@gmail.com) ---
FYI, same bug on same hardware was also reported downstream here:

https://gitlab.archlinux.org/archlinux/packaging/packages/linux-firmware/-/=
work_items/45

From https://gitlab.com/kernel-firmware/linux-firmware.git:
commit 99a2479f94e13da021288b016ec55243ac31fae5 (2026-01-16): works
commit ed10eae8facb3b4bf2da7104cec95afdf0209114 (2026-03-13): fails
commit 7df47664dd1d94111858b3224c15908517c73e73 (2026-04-23): fails

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
