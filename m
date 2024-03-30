Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991828DC1
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711807165; cv=none; b=ibuSTcYanMI0bKx52Q932vnuAi0SUBUkuIoq+3p2doLBnu9mFipUE+Q9r/DcL8D3UkeC1olr9njceukDTLZoAJjPVetbFk8jtxeUgCXB+C3E2cO8aIxGNJxCT3zAyDomhFc4oZls1lLmOlavOpxQNsA/LEcYkoxw18xrAFVqb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711807165; c=relaxed/simple;
	bh=8YS2p+N775XcpfhnZf5v2Wn2ew+U9xIj1nnrK8tgwQ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUb0SKMHJWFr73mqHoQVg6T2VqL2IqgyLm+qfJDqPG4V0WDtVShefRIn+jJ8OwP9t068nH4EzQjE15ggvUfw7DCxqApFGWhhfF/klBBUs+5b9cMuxoFW79palxhU27mGtb/FCWpjpKWq0y5BGPVkoDttdikbvX3HNTHokj75Mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTO6p4+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTO6p4+i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26B3AC433C7
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711807165;
	bh=8YS2p+N775XcpfhnZf5v2Wn2ew+U9xIj1nnrK8tgwQ0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TTO6p4+ifJPgD7pSt23VFMuqLid5RMvS/uPE2wxa+JaTdQbaG4x4jhZSgggwSuv5N
	 26+YPPEkrgQdYqm3fuuRa8VzcbRnGlkQ8RX72dTMXlz7k+bl/iG/N7vnmB09aiGP3A
	 PVh+2lIIhoUGzkbBakcJJUnVuomQ9GShq3cY6s3UNGqqwotDhAcFI49F3jxyHkl637
	 x4ebFNW6DstMjBFOcqzw86DMimjJ3/ZKVNUngSvPEK2T7S0c9aRqyEU2qW2uTeCOD7
	 8cIoWmMPX0mssZy5d4DjhqTgHphQUO9JYSBRl/iuQj0TpT8lIEezGQszuoit/Fy7Xb
	 G0t39XBcwqfaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F281C53BD6; Sat, 30 Mar 2024 13:59:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sat, 30 Mar 2024 13:59:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-vvV9gO1cEv@https.bugzilla.kernel.org/>
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

--- Comment #12 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
From the bisection and the oops it's pretty like a duplicate of
https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.i=
nfo/

Then this patch should help (which might only get to Linus next Thursday):
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D1c3366abdbe884

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
