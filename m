Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B231E859
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641347; cv=none; b=ZZEfUX4U0C6GkAphZpeHps6zEMn0wxOjZZhqJa+9EAErm+lEgdrEYuomdVQ3I5Qy600IZEvoGKJg9fOyT3xnycJ91ko/+WvV2v0Qfyb7tX5ZIR12Wy/62T7sEonB3kyYWyDlNZg3XSmLhwUwmLbjeIVPX050ec42PNu0xeFipLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641347; c=relaxed/simple;
	bh=EYrZ8tQXnqvsgrnxVfj6gSBdtex7o42g4yNdDkbMivA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9fxt7ggJ4K8PwsKC4aptjd0kGK9FUrUcvEVTYyt82GTAHqrbFEgTXUnq4Q4RxutlyxuhDhSaTRAIhfquPnyivRJvicFnW83BeZ9YYIRa1YbBaA/h3XE0057Lil8s5I5toqHaT3LujjdoD3Vy3Oml/onsMmUvbFTMmHzJQ3zRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjkCz+vz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjkCz+vz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4D36C2BCF6
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 07:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787641346;
	bh=EYrZ8tQXnqvsgrnxVfj6gSBdtex7o42g4yNdDkbMivA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PjkCz+vzWXJxLx8b+KCqD/ygzVFoEIrqhTK28lixQmDGgnhxocDAvHTvVxT1Ijdvp
	 Mo2LIhlDmBNiFoC28LwZ5bSCVuVREPSvglxskTEGoq6B+Zv2OL+9hsXvEP6eIhwPQe
	 VE9k4Z16s6ne2+oT1FMNvFPXcYwvjSnilfotIXdtKlC9Z1C6sJPLM7RXN3v7tztytI
	 f9zQfGtMbtn7W4EyPzVK0AgQKm7MGPSAATZwhH+xMBEaLPcb8wfQCFXF8ccfg5yu7I
	 efO2uk6eXmUQyYXZ3ayy62sYWwZyUJ7b8bS0FsfKUMxUa8PqZNkVRqazYIVe4844+p
	 Uq3SvJuLxW/oA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A650BC41613; Tue, 25 Aug 2026 07:02:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221878] MT7902 Bluetooth USB 0e8d:1ede firmware crashes during
 use; reset fails and controller becomes unresponsive
Date: Tue, 25 Aug 2026 07:02:26 +0000
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
Message-ID: <bug-221878-62941-1GDvCwuJAN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221878-62941@https.bugzilla.kernel.org/>
References: <bug-221878-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221878

--- Comment #4 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Then this bug tracker is unlikely to help. You want to report this to media=
tek.
You could try reaching out to the their Linux developers; better report thi=
s my
mail to Sean Wang <sean.wang@mediatek.com>, CCed to
linux-mediatek@lists.infradead.org ; if this turns out to be a kernel
regressions, please bring me in the loop again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
