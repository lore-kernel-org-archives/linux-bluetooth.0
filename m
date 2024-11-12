Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5191E884
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374322; cv=none; b=VvVaDpGizIbKf+Whe3u0nYeTujVlwspUmVBzdPW3AnkCrSdrZnVTKSwz0ODz1F5mi3eQ4u4VvhOapVr1btYU0RyACvZrk6AL2JwccYStwGcS4Ce5zWo6VAOitAdybH/5BqHOmaBJJdymDzZTMWvfBlH0YuTzBa9HBmOXU5rpAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374322; c=relaxed/simple;
	bh=whY8Tuw8KhRoQk+ZEABjH16i/nqz1SESnVJBZ/hEbjI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJij6pF45XQPdnpYlPGite224sIGWte7NiM8F3UYsoXJHthW3WkYS+ZbmOR1nfM9RxDZnhGeOeDYF+a+kB4FRP4wKUeYfPCp/ePv0aZfiITMemF3Su/ByOtc4R9Zt/g18hFdsaqu27FajCW8kg/jFcK73p673MFbqPUTDM7vDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCnxcRzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCnxcRzB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CB02C4CED0
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 01:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731374322;
	bh=whY8Tuw8KhRoQk+ZEABjH16i/nqz1SESnVJBZ/hEbjI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oCnxcRzBONRyZtu44bDPw0wDz/mpNFz0c5eoNqmiaXtP06UW/+c3ie7Xwao782f3L
	 kDjO632DtLrLL/UyBgMv1J5AY5ZUfMAEiXKsMUCqO6IFDElufGr6HJ+SK/CIP2EJGc
	 rxjEdk95beDTE0yphAxNhyVGPkBvzzlUWXVMUgnm5AToNrqZCvd51zcJLSuEPpP9Sj
	 Ga+tH+pJcMPD3OBjr0+da3wvgJY4UPx4+gs7fKzYT1cb5/CFZUX+JuZJ9Y2IAvMx2L
	 0cJVHiI7FavdIZzrCLLAG1zdOupB31+ygdQq5v9etNqdsEZNDfzjOeKTUnN6RUcwQ9
	 UUci9pZ2o500A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4DFABC53BC5; Tue, 12 Nov 2024 01:18:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Tue, 12 Nov 2024 01:18:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ghibo@mageia.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219458-62941-p0FcsC5BZ0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

--- Comment #8 from Giuseppe Ghib=C3=B2 (ghibo@mageia.org) ---
(In reply to Luiz Von Dentz from comment #6)
> (In reply to Giuseppe Ghib=C3=B2 from comment #4)
> > btmon output added. As you can see in the working case the behaviour
> > diverges from packet #16 (in the first case, working) and after packet =
#94
> > in the "not working" case, both calls ACL Data RX with L2CAP: Informati=
on
> > Request:, but in the working case it's followed by HCI Event: Read
> Remote...
> > and other commands, while in the not working case it's immediately foll=
owed
> > by "MGMT Event: Device Connected", like if something was truncated.
> >=20
> > [working]
> > > ACL Data RX: Handle 256 flags 0x02 dlen 10              #16 [hci0]
> > 413.700565
> >       L2CAP: Information Request (0x0a) ident 1 len 2
> >         Type: Extended features supported (0x0002)
> > > HCI Event: Read Remote Extended Featu.. (0x23) plen 13  #17 [hci0]
> > 413.700588
> >=20
> >=20
> > [not working]
> > > ACL Data RX: Handle 256 flags 0x02 dlen 10               #94 [hci0]
> > 20.205711
> >       L2CAP: Information Request (0x0a) ident 7 len 2
> >         Type: Extended features supported (0x0002)
> > @ MGMT Event: Device Connected (0x000b) plen 13       {0x0001} [hci0]
> > 20.205764
> >         BR/EDR Address: AA:BB:CC:DD:EE:FF (Company)
>=20
> Any chance to check with the patch above?

Yes, just finished applying the patch (and not reverting the previous) to
current 6.6.60+stable-queue as of today, and it didn't show the previous
problem anymore.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
