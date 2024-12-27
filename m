Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2513C807
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Dec 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735336534; cv=none; b=qLkG/R5PnJE8F5z8pEnnsveqK8VnKJxHoBjXncki43CicygjXvQ+fuGOTUP3yxzBlmf5InIzFEIwpcdodl/3KAZDQkFAoO/iJN/O9fn4PdDtZk8/kDmH7l32xhVLzeSV7FROLbd0/Q5Z+SI5Lwp49e91kwbSlasMxSS+9v3m5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735336534; c=relaxed/simple;
	bh=eaoMe/NTIYP/E2vt5vnz50P1oKMd9/tkw394HhNXDEA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bckjT3KbUTBh06hV9lLh8iol3f87vnQQSVxfuulGmX+pwimW0iLn/IXCYailysIU/ZkuUrbJoOwG48ue7I+N7UKwTv2KK5X7Ix+tKmIaA29He0wXcALIcJ5ABQmntAkiIP0wttwaQ6PEXWS3+V4us7SWwR4qV5FA2vjCiotHOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrfzGGgJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrfzGGgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA966C4CED7
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Dec 2024 21:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735336533;
	bh=eaoMe/NTIYP/E2vt5vnz50P1oKMd9/tkw394HhNXDEA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HrfzGGgJJ9M/LfxSE+FSEVJYMiuuFeUBIVkKfbucS6REu97YZuuTHVr90cJwtIlf/
	 olXIE2lIELpleMMbtwp16vHXIUfJ0RAsivsVnjnEfgkBymqVfN6wcUnoKk5LA2XFB2
	 WaFXCzC6z0ZfTTnZ8ygNJJJnPkU7RWK1LPMkHytRT//x2g+SIFedKM7NMgUJmeQHFQ
	 H+GvIZDdxdaqksyOKny1mKoihWDWxyFegmx1oDvZdVloWcM/4uvodJ3hcfbJzqaeUu
	 H//apS9u4d8F+Te5vKAygPB50jEOEHjHuk/PQ4ll4H3pM2A3MadZxrt2X0wBSwMENf
	 BQSyYdmymL4Qg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 96807C41614; Fri, 27 Dec 2024 21:55:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] NULL dereference pointer in Bluetooth at boot
Date: Fri, 27 Dec 2024 21:55:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: me@0upti.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219294-62941-nRSgb7b0ij@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219294-62941@https.bugzilla.kernel.org/>
References: <bug-219294-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219294

K900 (me@0upti.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |me@0upti.me

--- Comment #8 from K900 (me@0upti.me) ---
FWIW, `btusb.enable_autosuspend=3D0` seems like an acceptable workaround fo=
r now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
