Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3E16FF4E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575475; cv=none; b=VZ2dCSTw05q9updX9wG9BtzvG3xqpB4RZcaMMF2i/5LiMKp0nS39v0w1ihysF31nxziHaM3vu0QhsuWSrOxTN5yM/tH6GkK323mr4FC5Pl4EENRA4O5L2CkwaqY4+tiEl7O9G8nU77kj9/FStljsw82l416LGdHSSlMq1fR9fhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575475; c=relaxed/simple;
	bh=WnczQDLsmAz3wiYR1JfZPMGy2BA/Qtx2CPG2hCdaTnw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6M7YpcRJeHAXCtywD4aY+C0q7aTtpEylnq4IcpcbsGUdnUdEkkDlcBmJXR1ccMDHSe8c1/yin/STLededlab+rWDNPcQs6mGzUd6bUwISHFOk2U5y+jrCiOL1GFymmRtVnC+g8kwcsp4XhnilC5lkCWxLKZcQT0qXWGaD3y67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBDRW6YJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBDRW6YJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEB6DC4CED4
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 09:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731575474;
	bh=WnczQDLsmAz3wiYR1JfZPMGy2BA/Qtx2CPG2hCdaTnw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MBDRW6YJX1CyPZmvNK0Zqkbdut3DV7VjIMMnnbw5Z4geVZLxSAKf9Ceh1eavz6gtG
	 4PSOH15RWPqX4XRMQeswwI0sSKTyL5HuSrgow1yXWqYhBKCW3J75G8+OeGk47ArvCR
	 l7ztNw+4DDMPwj4rQs6JebWG/GJXGzRjhMOQhE5Y4rMlBNIXumGIvBER/XZ4DJkzJb
	 UQfiI7Drm5JAFzJ5KKO8CkeHAP1DwOAOBaKppBS79hiWVDK1v4dYU28NhV9+IfeBRh
	 lpiVR2cOlisRj+vulDg1lPImHB/PWvTLMdIbhNpoHlF2td70VmWOjbrlJr48xb59tS
	 sLewgXVa3izPg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C3E97C53BC2; Thu, 14 Nov 2024 09:11:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219494] Mediatek MT7921U WIFI + bluetooth USB Dongle - System
 Crash - Cold Boot
Date: Thu, 14 Nov 2024 09:11:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219494-62941-kVtxDy7o2e@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219494-62941@https.bugzilla.kernel.org/>
References: <bug-219494-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219494

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
I wonder if this is the issue among others discussed here:

https://lore.kernel.org/all/20240822052310.25220-1-hao.qin@mediatek.com/t/#u
https://bugzilla.suse.com/show_bug.cgi?id=3D1231599

Does reverting ccfc8948d7e4 and/or applying
https://lore.kernel.org/all/20240822052310.25220-1-hao.qin@mediatek.com/ fix
the problem?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
