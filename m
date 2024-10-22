Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C671494CA
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589659; cv=none; b=sHul77CBHzUtwl4CNbaYSalPcZwGuGtUszPbo+Se9Ye4nTX738VvQag3CJk2F6T/FB8z0hublr17PbtF25Lw43aladTKNB65TestQoGOc0e2qdXJN6nCPygD3dCS4XMK3bRMGjEodtz+0OoYfm7Zz1xToj+aWSyoYwhIPyw1UR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589659; c=relaxed/simple;
	bh=iFLMfubmezSCf68pv7FY6ZPbQRoLBMkgXr4Wtarn9ks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ez6lfwtKMmncCoLKIuxZweT51CnXhExoocY7rydPfqWDatBEW48cw5ic6wg/f9ciQRtmE/n6sTwQJl7wrom9xrPOz5JKpOD2LCAxLU7wp1s4Vfs+7bys4HXVU/DbBSDNrm2/wKN8UUbJDZvyhi0/9Ix/5xJZjXuDOd+j/QUfdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPaF31bT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPaF31bT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88C24C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729589658;
	bh=iFLMfubmezSCf68pv7FY6ZPbQRoLBMkgXr4Wtarn9ks=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pPaF31bT2JH6Ca+rfGvQBcXR1IaJdePBSHYxqw6eJ7sov/V6YIU00VYEgKFiEVxsF
	 KaXN5hHgelY0Ry+RYYZh43x6S7YVzoll8xpdrJALoZqY/PgX0MAH4v18wSCUTf0nWd
	 NqTReBxnrEa/SwMMfKiteqv5oA1KxP8meuxSiLXM9HuAsQS7XZIJumRLnTvBbN71X8
	 dK16KfhRlSy1JvCPBNvUbgVFxtKbbeSmGK9ZLRod3+04pXkFV7/sYO+YTmTG1s3L8V
	 gL1MKET4sTPLL5/4R6D1k0xpsPCladSSK9qvo868H9R1u6x090Yg2hUoPFtyJn8LCd
	 bX/YebfsWrcMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8142AC53BCA; Tue, 22 Oct 2024 09:34:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219404] mt7922: bluetooth can't find any devices
Date: Tue, 22 Oct 2024 09:34:17 +0000
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
Message-ID: <bug-219404-62941-FS4dqJMZgM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219404-62941@https.bugzilla.kernel.org/>
References: <bug-219404-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219404

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #2 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Will most likely be fixed with the next set of stable releases, likely out =
in
one or two days.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
