Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF915E7FE
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439776; cv=none; b=jWw5R3wTy/B2tHJwHz5ombYs7pvAKjfd8H7j/Jg5h+WhGLuDZBzrUejA9eM0/FSn7XBVglmhp4T67GPVHocYLnz9+F4QmW8fFH9/K/VcJH0WMd4K7JVd4hCxcSMi3rjTkPEHHgTl+O4Qgco28jo9FOHt9QOhz2YKxa1nC5acM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439776; c=relaxed/simple;
	bh=JNUNqgQ/kRBfMijV40P7Laiw69ULEFMGZ0tpP1bfCm0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=klxvLbolU81NKD3hcQJZ2k2BP3dl8sgUG1Ryp02ZgkyX7lfP+NX0Vd7K06E1EkY13Hxv2jJg1AoQXNW7JJdn59eVeYSiMpBF5EX2Y1wil2Vr9QXLMWEk72pwep+8Q+MuKqlBmolJlR5SlFPc40Qd0nirZSVqdL37hG0j7wHfNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG74MAg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG74MAg5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E51D0C2BD11
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713439775;
	bh=JNUNqgQ/kRBfMijV40P7Laiw69ULEFMGZ0tpP1bfCm0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pG74MAg5AAqWqPU6KaJzsoLssmq8Bta3gt4diOwzsE6IGGrwtElBtTd1qxwWpMTx5
	 ya071gOV+BfxiiaGX4NFrYzgNHsfwMf7HJ8f6vAsut0ea9vPQF0l2Kv+9NhPTYml22
	 ctVrpJhqc23ZigrSMKOVQ+jpHwsETr1Qnw3kVYFEXQvk7ODdF8aO8sR7mWlpH2MyYU
	 vaR7/6FKxJP/L4q0XZcuWNGyGXUzJn3idvkwIoGrv1oUBZQwgseUc87Y/T+b4OrSJI
	 w4K90RIU10Gh/HBPMZ33niBQhE1D0Zvy81Rm9F3XOdVDA9S5hgND++gt9vMc58ammH
	 8pfLbdL1s8DPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DBCCFC43230; Thu, 18 Apr 2024 11:29:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217870] ATS2851 chipset for Baseus BA07 Bluetooth does not
 connect, no bluetooth device connects, adapter does not turn on
Date: Thu, 18 Apr 2024 11:29:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: painterrer@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217870-62941-4muSAId4we@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217870-62941@https.bugzilla.kernel.org/>
References: <bug-217870-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217870

painterrer@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |painterrer@gmail.com

--- Comment #3 from painterrer@gmail.com ---
Fedora 39 6.8.6-200.fc39.x86_64
It is finally fixed and works flawlessly!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
