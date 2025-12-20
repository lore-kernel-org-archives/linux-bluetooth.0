Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57586277
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766263301; cv=none; b=Aj0c438/19x25nrbBEcdFhcqZ0C5/5kpfkw7Arg67y4hQdUoWSiOmTPsonpGfma91yIREkKuMvmsQuQamgE25yWQi4201n0bCbrxetq8T3FVA3rtXLwfnzfXl+8zs33MbTzsXwu0EM+DHZdNccZxvA9+neJflPjrXdSZ5wu/BSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766263301; c=relaxed/simple;
	bh=DBgLTRInF2/cLukC/bjBYaVN77QdRKPAfDeER5b7zhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OHCcU0o+N1YjQlhJ9y/CgP9wlr73LX3VBrZli2clqyt0XC0mAdW8NJplybCCi4ck6LPFApecWPsQcEOPnrHrja17fCFEJhGMrt86uGbtNMj48EfNq7VGY2eRB8ZhQtq9WwlY+5HOy0BBfhqRI9yidDr3DAFaypkSSlJPWJ7XFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/9r0SVy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/9r0SVy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DECF0C116C6
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 20:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766263300;
	bh=DBgLTRInF2/cLukC/bjBYaVN77QdRKPAfDeER5b7zhc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Q/9r0SVyZsyG+TTFSiFHX9VxOCemeOECx0/7NoAzki0CbjOqkUfGt90uy2zzwx+Pm
	 a9Z6PIPM0o3Li4DksxJitU/R3AJ6XPwLAY99XH8sd8P5LQNQxr/s/qmcrveJaqYwry
	 qeQi1I5yOT+VU0Zs2/FGWqt43tXPQXQKhNBGCVAWpO+Ml0khbh2DyV7rXcH6w1M1lY
	 jlLWFdtQEw2DQrMSp1tovePRRLSmXLUEXJFtcWbicpP7qv6JIqUjOZL1BKo2UZVw8X
	 UyK6+WjYw54aToujivAWBWeki2zjdsPt5UjrlQg3NbdLb2K6sLGxZKc2FIsgdhehkg
	 yyvyGaiF3TCEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D303CC3279F; Sat, 20 Dec 2025 20:41:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Sat, 20 Dec 2025 20:41:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mpearson-lenovo@squebb.ca
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216936-62941-6jdDhEfMC3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

Mark Pearson (mpearson-lenovo@squebb.ca) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mpearson-lenovo@squebb.ca

--- Comment #31 from Mark Pearson (mpearson-lenovo@squebb.ca) ---
Bit of a long shot - but try removing the SBDC call in thinkpad_acpi

https://github.com/torvalds/linux/blob/fa084c35afa13ab07a860ef0936cd987f9aa=
0460/drivers/platform/x86/lenovo/thinkpad_acpi.c#L4181

(afraid you'll need to edit code and build a kernel)

We've seen a few issues on recent platforms with disabling Wifi, related to
this call. It's not used on Windows, and it can put the Wifi in a disabled
state that it doesn't recover from.

I've been trying to track down what changed and why. We originally thought =
it
was Mediatek modems only, but have seen it on Intel too. On impacted platfo=
rms
we've been turning that SBDC call into a no-op as a fix in the BIOS (I don't
want to break older platforms where this might be needed, so have avoided a
kenrnel fix so far).
I'm a bit worried the problem is more widespread than originally expected.

We see the issue when disabling Wifi from the systray on Gnome, but it's fi=
ne
when done from gnome-control-center. Very weird.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
