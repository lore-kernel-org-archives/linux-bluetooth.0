Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC1D268
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721596976; cv=none; b=iXGOap7vpqQLI/AY4DY2uNTTr4aLmueUSFJfNkXysc5zfAT/fetMG1OxStQh6+tywFpo+ydyQ3kpyDw2rlnVHfaSAQlRkvixfys+oHIfArGGp5t+CeovqMGpFmbQpqy4mfK3iKY6NMFFXHv6w41q/B/MAzP105hNyMH+zA0lMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721596976; c=relaxed/simple;
	bh=kA5Pwz+wgk3AOnQ5EK5aNj4r0n/6QB6yT35ltLtGbhE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oB/UmMzAtct2OVDLbsXhLlsU4i61NvLkPVwJ3ELGoevH1U/DNrMBs5aPeG6E2Qu5Ev0kFRFmGbz2YQ2Oki2m9qTKvS9qrtSdDoTti0l/J91epfhftX1o+HE4oLMEbfuyODwAWA92YEacm3QilKhj7H9XIOQpx3p3gotfaZU2Hw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjtyzrpx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjtyzrpx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 736C9C32782
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 21:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721596975;
	bh=kA5Pwz+wgk3AOnQ5EK5aNj4r0n/6QB6yT35ltLtGbhE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cjtyzrpxmz46f/qv66pLLS9JrwT8SZ1S+CmeceA/l6xAs5+MuQpnc1hj3J4Xkzihi
	 pxoVMQtVDFnxz0KG5ktg8FEeEat8GKqnf7pnkJnhjC6Vh3L1fIRvvxXHlPWKljgG3Z
	 iYmlCkg/pRcFmskIBKMTNiYS906Sp1pz8a+muA+A12B2r44t8Ohl+oQOhNuikSLZ4x
	 XjGLwwFMzQcIKMbF4+0ChagpoN189ZCuic/gScmT/gHSlL9klySb7cmV2DzEb1dRqW
	 Qb4jgkwHQa44a19F7YIFHp1gu/4U4v/4UIf+0PSq75M8f84CV+32xrRpNt74UTvG4S
	 uKsoQXfTQEKSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6010AC53BB8; Sun, 21 Jul 2024 21:22:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Sun, 21 Jul 2024 21:22:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219057-62941-dkhd9xvTZC@https.bugzilla.kernel.org/>
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

--- Comment #10 from Artem S. Tashkinov (aros@gmx.com) ---
Your BT dongle could be malfunctioning, that's all I can say:

[    7.641748] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.641750] Bluetooth: BNEP filters: protocol multicast
[    7.641752] Bluetooth: BNEP socket layer initialized
[    7.746321] input input12: unable to receive magic message: -121
[    9.399212] input input12: unable to receive magic message: -121
[    9.449012] input input12: unable to receive magic message: -121
[    9.524765] Bluetooth: hci0: command 0x1005 tx timeout
[    9.524802] Bluetooth: hci0: Opcode 0x1005 failed: -110
[   57.877847] input input12: unable to receive magic message: -121
[   57.944875] input input12: unable to receive magic message: -121
[   65.820223] input input12: unable to receive magic message: -121
[   65.894224] input input12: unable to receive magic message: -121
[   67.979270] input input12: unable to receive magic message: -121

Someone has the exact same issue:
https://bbs.archlinux.org/viewtopic.php?id=3D296195 and they've bought a ne=
w one.

A google search has not revealed any success stories:
https://www.google.com/search?q=3D%22Opcode+0x1005+failed%22

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
