Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BC2119
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 May 2024 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716614569; cv=none; b=Rwy0wYUy7keuaK95hKp8nxvtPS8nR2SiMO/x3Amtt6voDsDudFqhz9nbubNM9bMcLY28tEkbTI9xwIuR1xzfE/ZWEhbnMfW8FvKbULakaiKTgrwHdLe4rku1tF5d/H0fK6TAGLq1W6mt4rznUdm1SPVFatPm+uaAYrdztYf4ZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716614569; c=relaxed/simple;
	bh=J19D27H8jD4ASCnkX6TWHUD3juZIv3tA/VP97S9bl8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYM+YM4mzbiRuSdHtYfDLSzBDnm12uni99AZr3eYg+qnor7O/OUeEteJp5sWYNTpDibMiVQzN9/XfRGXX8vAbw0sayEHAEi5k45bkcuFQ4VQc/C3mcGMmqZSXIeMy19hQfZv21lr9OisTHiAQSHnmBDKe3fwglwiCrGZ9Bn388g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9Zo8JwW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9Zo8JwW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E20B9C4AF09
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 May 2024 05:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716614568;
	bh=J19D27H8jD4ASCnkX6TWHUD3juZIv3tA/VP97S9bl8U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V9Zo8JwWIFuregkUfeyZu//LiZ1kMrbmht+G3liIJTnfb+YjmeWP/MphzP/phLbOJ
	 mKqRYtZzsfIB7JKu0CWEesgyLgStqXkJbkOdX0rcMWOmKpqLWDkYGMghuyCQ4Ab0BQ
	 X4VHNnQhcY/wLBNJwsf0UEIqwuBeKKh8b4F/vlseTG/O50dFoS5EfRco3k1yiTA2Im
	 ezJXjGtzC/yP+g6l9/QirX3uQFJ/rp8gcYgfzy1LwHxmLEirWji+b6BAXiCt31HyTe
	 0lNBPyfGsfcFABi5mGcuUMrND1mN+4/vZ7M7AS6qM0jhN3RUUb72SzXMBpvnl2h8Fq
	 l8aRm+SH76XVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D912EC53B73; Sat, 25 May 2024 05:22:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Sat, 25 May 2024 05:22:48 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-a0e2bSajdN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #33 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
(In reply to Nickolas Gupton from comment #32)

> this issue has been reported starting in 5.16 on the original bug linked =
that
> they closed and asked for someone to make a new issue if it was still
> present.

Bug 215167 [1] reports a regression in Linux 5.14, and the referenced openS=
USE
report says at the end it should be fixed in 5.16.1.

Nickolas, thank you for attaching the full Linux logs. As the error from the
bug title is not present in the log, I recommend to close this issue, and
create a new one for your problem with a descriptive title like *Bluetooth =
only
starts working after reloading btusb and btintel*, attaching all the files
there. If you could bisect [3] the commit, that would even get you there
faster. The Bluetooth device can even be passed to a virtual machine, and if
the problem is reproducible there, bisection is quite fast [4][5].

I am sorry about this, but unfortunately, the comments by others on probably
different issues, make it very hard and time consuming to understanding the
actual issue. It looks like the maintainers are overworked and the subsystem
has not enough resources. Still if you buy a device with Intel hardware (and
even better a device with official GNU/Linux support), it=E2=80=99s valid t=
o expect
that Intel hardware works also on GNU/Linux.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D215167
[2]: https://bugzilla.opensuse.org/show_bug.cgi?id=3D1193124
[3]:
https://www.kernel.org/doc/html/latest/admin-guide/verify-bugs-and-bisect-r=
egressions.html
[4]:
https://lore.kernel.org/linux-bluetooth/5891f0d5-8d51-9da5-7663-718f301490b=
1@molgen.mpg.de/
[5]:
https://lore.kernel.org/lkml/d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mp=
g.de/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
