Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0675302742
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321663; cv=none; b=Iw6rYDo449xPdisVYJwpuYVH39Hf/XHxFJmuwIoS1hYgQVFB8+6iTnLXJcv3DkmfQE1R9/8JYTXbExjdRpLPd2KivY/R6oDAOuOCLswpaaqa+1A7VwOpULB1Inx4joNjfq0ewQMueAAtjeekMG0BMqMxOg0WcnMvw99OFibIs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321663; c=relaxed/simple;
	bh=ml9i4YkbExth+Ru34emF14UkkrG6VMvEy+2dNhcoMII=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=drieUR+YRX3axn8m7L4Z4UlhNWuCS0SGfyFma9zaXQJO3CrfFcgV/0uYspTcNXUpEz6jWXDZMr0r3615AKQnl5y+FAd2au9wc4EAZ+G+lr4MQWIGFDdokzVS/8UjfDEg1KPbSC+EuLQugYf1TH2McRmoOqdQYPEAArxzJPfEHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1Hu3w74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1Hu3w74"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70C2BC2BCB6
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777321663;
	bh=ml9i4YkbExth+Ru34emF14UkkrG6VMvEy+2dNhcoMII=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i1Hu3w745DMjF7KuPoZ8AOqPruszTBfD/cQRNXutuIirbEavciHdqQ6bgaop4sGj+
	 K7nqEMoNISup1KwmJUl8pGvTFDRXbPXeWk5AvxWI62GAD9KDGPRU/Nv4+s7Xj2N5PD
	 oxUsGUTz06+YulPQ6IhtPZXJObLJlT7X+u7DVEgCW1cbWtmDP82mW3JnNvFacQHAnP
	 TBMKTME87MpFldOP0nPiOmOEzS1aZtaX0HJkus1jgObvJIjIE/U0Jx8HSHJAndlK2P
	 ww+JMI4O0TD04mfv6Zk/XLCJU28xy3qPz/2Tun7vBuPPudRXZp4WT2ZDuIyLsHfGrJ
	 UIBLhsPpEaMJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 68086C53BBF; Mon, 27 Apr 2026 20:27:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221426] Intel AX211 Bluetooth hci0 hardware error 0x0c with
 HID/HOG failures on 6.19.14-zen
Date: Mon, 27 Apr 2026 20:27:43 +0000
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
Message-ID: <bug-221426-62941-AOZwpMGOud@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221426-62941@https.bugzilla.kernel.org/>
References: <bug-221426-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221426

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #7 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
(In reply to Cristian Cocos from comment #5)
> (In reply to Paul Menzel from comment #4)
> > (In reply to Cristian Cocos from comment #3)
> > > I do not recall this issue's happening with the previous Linux kernel
> > > (6.19.13), hence very likely no regression.
> >=20
> > Sorry, that is a contradiction, if I am not mistaken. Which not/no is
> wrong?
> > ;-)
>=20
> This phenomenon did NOT happen with the previous kernel version (6.19.13)=
. I
> am not familiar with the "regression" jargon: I take it this counts as a =
...
> "regression"? If so, please excuse my ignorance, and feel free to ignore =
my
> previous post.

No problem, I should have been more clear. Yes, a regression is that a new
problem was introduced. And actually that is a good thing, as you can find =
the
commit introducing the problem. The Linux kernel has a guide how to find th=
at
commit via bisection [1]. It=E2=80=99s also something the user, that means =
you, could
do to help fixing the issue.


[1]:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-regressions.ht=
ml

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
