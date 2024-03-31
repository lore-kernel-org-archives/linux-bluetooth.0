Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02CA146D40
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Mar 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711904170; cv=none; b=M7hn+i7XBPQwNewnoRpKLwZp7hPYhSO8noAgDV6xHe2OmdGMr0P0VM/O3mUW/PoYhC6a42XrFcSeHm+3LbIGVq8oeB3ElSrRPBQx3UOTwIuweaGEOQWnk6ahP2ZpHZM4Ik4FuwpEu1ORyV2NonssN3XelQS+fb900jYO8ys4d5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711904170; c=relaxed/simple;
	bh=jWSvyXrRhKBkq/L8S6xxkq6T19+HFY+Qqm+53vYrpSo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ItX0BGOKCTYkJUZnFPUsdtcpbA/icK5QxiZkLSskRTh4sNVJ8cdKGxjaSiBk4mr3wXIVGAVPdwo6TwfNRsv738Hb4ky6eLNII4F0eSg1cGBVjZB/sHLPFNRLInpgaMd0J82JuFki8NiLwtq2HpT5v7GQN0/0vTy6JpEU04fcWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgz8jqCY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgz8jqCY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B869C43390
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Mar 2024 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711904170;
	bh=jWSvyXrRhKBkq/L8S6xxkq6T19+HFY+Qqm+53vYrpSo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hgz8jqCY+V4qz7IHSl0cLGMJZX/1r6I+uTWqC+3sMmqr1aUMWzFmWjzJeAhpel/GQ
	 rr8rcioExTO0yk1yCL4XqDOWxwjebBd3w2+G3EHEcLjwFqh0Cze0qnFx8sA88iIgDY
	 oKacWjXHjh7tkKzXzY/O2A2UhvzFj7hlNPFAHdS7H4jGxgrCIKVKGdhRaJMpAKZ/uD
	 ss9QHwxLqpORtDVFVllGzbedQkkvxjv9smGv96yG5GAxLSZo4RDTfLnWzbwx2Qsfs1
	 QFcGRs+8EVpHQvfLzGxsozdXNXkxQlNGMaVe/M4pu7fdOJ6bpB9WHp+Jpg+Cz4UJa5
	 44JnHOL+NECCw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0CFFDC53BD7; Sun, 31 Mar 2024 16:56:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sun, 31 Mar 2024 16:56:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: wolf.seifert@web.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-rBrGRweMD8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #19 from wolf.seifert@web.de ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #18)
> If the kernel without the patch (In reply to wolf.seifert from comment #1=
7)
> >
> > Although the git bisect gave the same git commit, the problem is probab=
ly
> > different and the suggested fix did not work.
> >=20
> > See
> > https://bbs.archlinux.org/viewtopic.php?pid=3D2161135#p2161135
> > for details.
>=20
> Spreading feedback over multiple places makes things hard.
>=20
> And journalctl -k / dmesg would be helpful.=20
>=20
> Did your kernel threw that "kernel: BUG: kernel NULL pointer dereference"
> before the fix? If it did not, it was a different problem to begin with a=
nd
> worth its own ticket, as things otherwise get confusing.=20
>=20
> Or did the kernel throw that error and it's gone now, but things are not
> working? Then the patch helped -- but there might be another problem or t=
he
> fix is not enough. Building a 6.8.2 kernel with the culprit removed could
> help to narrow things down.

Sorry for the confusion! In fact I never had this "kernel: BUG: kernel NULL
pointer dereference", but other people having this commented my original po=
st,
so things got messed up.

Anyway, the git bisection is probably o.k., only the problem is different. I
will try to clarify and open a own ticket.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
