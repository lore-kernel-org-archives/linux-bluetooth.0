Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB331E507
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jan 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736004474; cv=none; b=jt52J+gFcj+ytAw3wY3AOdEi+lI1QqfbIA1F5SpyrgrwN6ZY5YwJ9+Ld7LvHh5DM/FbvmNRJfpSIwzDinjUuQtFHIbvAu9IWKc83acfJfS1Numbc4PeVGebor9nYDJH3IQd9i1A9oXOVrv9dqvlonGuuSub0fWpneb6Qf7rEEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736004474; c=relaxed/simple;
	bh=UfGLavy0j8zcVr42HO067q+GppIP9rCbGtbk28PYq3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFwrY8SehGpmUhG6wv2v9ed9gPfuQT2v0fRG5woqZlydkzSXws17VmTXLxzkkDHtM/BiHtBE4ILjzTqqPe3GW1Ra8gH4ogEuvY5RcwxjoeXOcKBmHJRM5jAp01IMGX7893x3KUwL+dybhQSvfpeY+T5qSk+kq5rjkuGO8N2EdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2Gi1E4H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2Gi1E4H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31A71C4CEE1
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jan 2025 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736004474;
	bh=UfGLavy0j8zcVr42HO067q+GppIP9rCbGtbk28PYq3c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G2Gi1E4HsYcoLlQyRY2OXhgiX1vHP5m9t34wCjJ902Gxp3CWGgAyBBvLl7RyG+5gI
	 dV7ddf/0rW8h3D6Lp8150nEQ0bBJ2LjRmbY7dkQOUuTXPHqRZ7ltohGXzRFuYRGQFT
	 2MoF90zqYlsGRDNOZ9u6kELnQPypBrEKXmigtt+lj9SNw/gE+7Y2cLmNIIceAX2tBJ
	 qAROZdoBbLPeHkLG10vc+DpnzJePLZj+uX7eI/5KbWWaSDpTUhWNciGTL9tnQLuSqU
	 +Z5KaS8h5ip1LXfvwPFGpYNVd6X/zOjAVPxw8dQJNKvbOYxAP0Elsgg0ag4JCDqTvX
	 4gIHNvqP4GBXg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 25E9FC41616; Sat,  4 Jan 2025 15:27:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Sat, 04 Jan 2025 15:27:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel-7xes@p.kunnen.tech
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219514-62941-XwkGgzT20U@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

kernel-7xes@p.kunnen.tech changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel-7xes@p.kunnen.tech

--- Comment #7 from kernel-7xes@p.kunnen.tech ---
Since Bug 219290 is marked as duplicate of this bug, I would like to mention
that I needed to rkfill block wifi too, to fix resume from hibernate as rfk=
ill
block bluetooth only fixed resume from suspend.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
