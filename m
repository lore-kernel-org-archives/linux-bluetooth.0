Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB111849
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZGGgLk7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89898C433C8
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702798328;
	bh=l8s9+RcsXup36sWRr05td8Nqdqt9iO8ooXyJb+9/Yj8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AZGGgLk7whJMXmWDJZdLGzdxM+Nq1uPcfunqLVhLFRexP+nLEE2baT7H7CPkdyS4f
	 qxNlJQ83H5emQKWKOIgV8pNIQKV9I1VXsBwl6xt6vRApzQ8diqs9afxGEUZxkhJsl5
	 peLNwbJB+MSMwUTIpg2tn7IjgTpveRKdt24tyqIM8IS2NZ1P4McyPsx/X/cffKrsa2
	 CsQ6uYZgNCjWENrlNPvjyMnY0fxBCgiBcnQSWHKL7vW3wLvho+IgizcihZMj+MzeTF
	 b6Gm/sj6Bt9PPczLRZ2+1O99TMWHlFNB3pY0VQ9y6jBo5nOZb60YDcaOqUKxJOoHyL
	 qCVl8aOlBa3lw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 671E1C53BD0; Sun, 17 Dec 2023 07:32:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218264] Potential kernel regression with bluetooth pairing on
 specific radios
Date: Sun, 17 Dec 2023 07:32:08 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218264-62941-xJKK9aMpav@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218264-62941@https.bugzilla.kernel.org/>
References: <bug-218264-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218264

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Marco from comment #0)

> I'm still not sure if it's the kernel driver fault or bluez fault.

To check that I suggest you install a 6.5.y Fedora kernel again and check i=
f it
works there; if it does boot a 6.6.y kernel again and recheck if things sti=
ll
are broken there.

Old kernels can be found here:
https://koji.fedoraproject.org/koji/packageinfo?packageID=3D8 , like these =
ones
for f38 (https://koji.fedoraproject.org/koji/buildinfo?buildID=3D2322803 ) =
and
f39 (https://koji.fedoraproject.org/koji/buildinfo?buildID=3D2322801 )

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
