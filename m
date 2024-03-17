Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733F2032A
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2024 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710589; cv=none; b=j1HO05hpaUq5YkTMW0PQEltlioRjZXegTfe4pNvCwWghDJEf2c7W4fPzw3O9CQPiY1VxISNS7ef69kjvH1vL8jekeJM/OUCSLORJET+dwKVde1KBoJA9kjDhY8iXP2EE3DzKztX3gnytK5BxmR24coQjnotULoWUGpNOqmpy5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710589; c=relaxed/simple;
	bh=DU9PJ1ocVGxHD4XSG20XEi9Fwa+ra6c/4+BFxI8Y804=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LijG+9Iv9wixSMAf2sBDtsrqtufQ2x3lCDKJUMeO/f6Midgr3yWuaU65PWguXhtfYoTcQwy1nL01PknicgesTYCigPtB+wFspndf/jWmTIc9NUSms8KfIoJViHzaB89gZZ9Qcdi9UwHramd82hNyIX9nDzmmVVv6o3j3raBTI+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYPZED+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYPZED+6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AE91C433F1
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2024 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710710588;
	bh=DU9PJ1ocVGxHD4XSG20XEi9Fwa+ra6c/4+BFxI8Y804=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JYPZED+6ca5lgibv4QF40klOO2OyFSTqr5tpy/QaKCOYjbbMyCTr3cf60oL89qAGE
	 atZcgBI674k46KO//gN9MC1PzBzV510Dhmys8bMLJlpW8ppVExPQ7KPJRlO8QKFQI+
	 V5Ps4/iv1Q2PV9R4pdLHnkmRtK8028v1+FQ9IyGUq0d+Yc8iL0gxoBQhfvCmFMRHUS
	 SVo0xmwAmOGiEemvzeikZNDXI3FDUsCpfLLlRrRcABa6TEjhx5jhlrg7M0cAoXkAay
	 ebyDm48ZcAJwneME1/b6naOvIJAX3c5SbLRFOSc4yPqCQGVqojabJzjmyxNaHypElK
	 ppG+X1w7bcH6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 886D9C53BD3; Sun, 17 Mar 2024 21:23:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 110901] Macbook8,1 12-inch (Early 2015) Bluetooth not working
Date: Sun, 17 Mar 2024 21:23:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: j@ovvvo.co
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-110901-62941-nlJZMMrmgj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-110901-62941@https.bugzilla.kernel.org/>
References: <bug-110901-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D110901

Jonas (j@ovvvo.co) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |j@ovvvo.co

--- Comment #49 from Jonas (j@ovvvo.co) ---
(In reply to Leif Liddy from comment #46)
> Cool, thanks for the update.
>=20
> I managed to get bluetooth working on a 4.14-rc1 kernel after applying=20
>=20
> l1k's hci_bcm.c patch
> https://github.com/torvalds/linux/compare/master...l1k:hci_bcm
>=20
> and roadrunner2's hci_bcm.c and hci_ldisc.c patches
> https://github.com/l1k/linux/pull/1/files/
> 61c59e8b2a7f129a339608610069a26f4181c82a..
> 7dd4a90a92b97b017d9210899afcfbe985b10509
>=20
> There's a pull request to include roadrunner's patches in l1k's repo. Work
> is also being done to port the patches to 4.14 (I just did it manually)
> So, this all be cleaned up in the near future.=20
>=20
> You can read more about the current status on the link Christoph posted:
> https://github.com/Dunedan/mbp-2016-linux/issues/29

Are these patches still required or have they eventually been merged into t=
he
kernel eventually?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
