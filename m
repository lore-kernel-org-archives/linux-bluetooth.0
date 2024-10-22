Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DB38DF9
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589689; cv=none; b=HCwxzeyTopFaoK71bMtunbT4itpzbevSA8BimkC4Cb/dzmqzF10FIU3W7Y4vJz5un2llRH112wFswSeEiDke/VO03xhg0PhJSfyLDq3NPRo/Y7nc6s/XWBSDB6HsX8prkx5PyZLJJFMm8/CEwFTCZeZi4MSz2eiWPQaeXo0aEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589689; c=relaxed/simple;
	bh=J5hVJNzVANEp0rlDNR+0Ba3OCEQnI9fzZ19Ssq+Fdu0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=th6HEmJr6nNqv+kp7o60FvUbz2Ayjs8QG0aZy+qf+b8BS+HbKG2pSgqUtw7mWo458COgZBuQN+Uphnr/i3EgrE/oJ0XgHBxJ3oLfbDGLDZCR+ApJoSRAfozCzir1JTkoOGYW4+TSfCt8VJJ61l3aGLUARDidEtqpICf8UZ/zAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuJObPSs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuJObPSs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C29C2C4CEE7
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729589688;
	bh=J5hVJNzVANEp0rlDNR+0Ba3OCEQnI9fzZ19Ssq+Fdu0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TuJObPSswc8TrZ2ilKqTxPFEPvQDETktgcMma3nXC1T6kOrvcmpvXiY2Yctp2aSXD
	 7SkI7Z0UFPXiDzWxgTmJvYDlAcVZmhyzW+Ov0vSV0MiUT97mQ+ph+CR9vyosuE40Le
	 slp5fBEVYuCSwzW2oHGlup3X6LRUhy/3WnJX8k5W/W9x4cvTbaUk+XDkQTNJKxvQUL
	 HcX4IRv15u0a69Ss+/RyGe3t1KfiGm0TjV0xvbHfFUTVLB/ZXuLvtlh+kj/gcBr5V+
	 kAebaeJkJXYDmUdm2jBMBe6zwPS9erA7MypCgfoL2om1oZGO6VYRzG8awxGoSaxICG
	 NcQMGX4laOjBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B7295C53BCE; Tue, 22 Oct 2024 09:34:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219405] [regression] mt7922 bluetooth scanning does not work in
 6.11.4
Date: Tue, 22 Oct 2024 09:34:48 +0000
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
Message-ID: <bug-219405-62941-8aXYji9jy1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219405-62941@https.bugzilla.kernel.org/>
References: <bug-219405-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219405

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de,
                   |                            |regressions@leemhuis.info

--- Comment #4 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you for your report and pinpointing the breaking commit. It=E2=80=99s=
 a known
regression, and commit 4084286151 (Bluetooth: btusb: Fix not being able to
reconnect after suspend) [1] should fix it. It was queued as a 6.11-stable
review patch yesterday, and should make it into Linux 6.11.5.


[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D4084286151fc91cd093578f615bfb68f9efbbfcb
[2]:
https://lore.kernel.org/stable/20241021102303.120595342@linuxfoundation.org=
/T/#u

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
