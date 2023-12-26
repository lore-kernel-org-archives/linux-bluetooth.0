Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9284C63B
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu+xE1jC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50210C433CA
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703577797;
	bh=Y/8kmr9dg20OrMRVmxFlx03Zh4TQfnWeu9yqREpU/bQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fu+xE1jC4c42txSa5MHnMopyyxxx96GwKw88jD3/VeoJN7aYuhmNCNTaInFYreOxJ
	 Dni9baxms67JfBdVfti/cdc4nqe54DeTiYWYk1Omt91r0TOkMvOd6+4EqjW627LjLP
	 EtDDqbLxzHDi/8uitja0hn5Y0he09h879CBsAeY92lf1UCmNtovMPTPt+uJCdmjzBK
	 M4julsyZUm7AhGRekrg0PLA4SOTVU9ktVRkIH3ISwGDyOsjlWKkHCgfsjcwwV71rd7
	 ErKEUgZJqJUD7BgVMIfo4WGjkGsnyd4fkM818nTokd+6Atz09hYtZ2irShN5xY1n6e
	 vB0M/d0MwiVbg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2AA98C53BC6; Tue, 26 Dec 2023 08:03:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218323] KASAN: null-ptr-deref in rfcomm_check_security in
 Kernel 6.7-rc2
Date: Tue, 26 Dec 2023 08:03:16 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: 20373622@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218323-62941-q42LS80A9l@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218323-62941@https.bugzilla.kernel.org/>
References: <bug-218323-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218323

--- Comment #3 from Yuxuan Hu (20373622@buaa.edu.cn) ---
Hi there,=20

I've attempted to submit a patch to fix this bug, but I'm not sure if this =
is
the correct approach. Thank you again for any response you may provide.

https://patchwork.kernel.org/project/bluetooth/patch/20231226074355.328940-=
1-20373622@buaa.edu.cn/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
