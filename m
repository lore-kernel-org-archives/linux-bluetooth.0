Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235B2561D4
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Aug 2025 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754163001; cv=none; b=qzmGmALTWzS0pHnELkpjABHIjzlvbeRiwxZQboaFtQ/C8KeZ+8SEPusYR2X6omnYOhjiqDSAlE6YIorAi65utccljVG7lpdyqQpYPNXcB7ceseY/GZ8MdqbisiCL0kiCTr5Duku3Tzpj2iwkgL0GiNLAcwCGkLvR2x5GtW7s1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754163001; c=relaxed/simple;
	bh=hGsIHGAQl3rT02Vc1a0swcBh0/LuLKXQ4jbG0W4JlHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mCQvALhlJXVIcQry9SdGksuMKdpHouLmvJft7O+Y/dkdUscn56J/ojYFYaGtnUAw/Z1W1zBxyyvk18uW8aihD7Zjg/VJA3/zC54H6rb9yko9XM7yC62F7nHxepTps61S0abBbuER8K6ZKpZ6gdYEjI8LIJIAmDUQtD00QqjaRJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX7DTa29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX7DTa29"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09288C4CEEF
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Aug 2025 19:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754163001;
	bh=hGsIHGAQl3rT02Vc1a0swcBh0/LuLKXQ4jbG0W4JlHc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MX7DTa291g5yBkmvMwdhuqbhMsIgK3niv6f+nRnGoWmeFoRgY4hxJaNXVM7Ow8poH
	 fcjz3VYqQodoGPJk5OWcjKEg2a1mDyTnbjbBuMtRajdklw1Qk/t3S4G2n8YfTQgtgu
	 weB7h0F1BcJgiCgeygBCLsldztrUAkHVwe6V2PuBY32vyg2O2RE0ohHV22C+fwMC3C
	 2L6XGLnSfo68t9gwDKygwsBIeGfT9IDAN/XZhPs7BqrDXvZ72IVEWCmiS2L683PgIq
	 3fJLG3DkronZUpv/gr4VApH83fAo1JGnhIi1q0uSzuv2utAApwljgCAPn631nTPRt2
	 B7LUDuUAVyKhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EC0E1C41613; Sat,  2 Aug 2025 19:30:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220391] Headset is disconnected immediately
Date: Sat, 02 Aug 2025 19:30:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220391-62941-Vxsetnkpbt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220391-62941@https.bugzilla.kernel.org/>
References: <bug-220391-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220391

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #2 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
@Antti, thank you for opening the report here. I actually do not know what =
the
rule for the Bluetooth subsystem is. I believe, the Intel folks are interes=
ted
in having their hardware work on all distributions.

On Ubuntu, you can easily use their linux-mainline PPA [1]. Copy the
*linux-image-unsigned-=E2=80=A6* and *linux-modules-=E2=80=A6* packages, an=
d install them with
`dpkg -i =E2=80=A6`.


[1]: https://kernel.ubuntu.com/mainline/v6.16/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
