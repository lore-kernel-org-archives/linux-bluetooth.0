Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC939FD1
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918746; cv=none; b=U8EYrW+KhKpwGPSJy/jh5izfSPsRTWv696XNhSOazLQ6iydr8eerRzpROglm4LJrtA9/iEIhBYmWSyVKGZB7lVt0mZPNpdxajwBPhADDiMcKhsTsVLZmABKMr1IoLU2ABwmLs8ERGlnYF1fIgcb+4vCWDvhDIN9VC6hSwlKoLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918746; c=relaxed/simple;
	bh=QUjanRZVZc1CRp5LhPpwAAIZe+eAMSSksRySXBprTBs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4uYyDMbO6Bn4R29C4CyL9l8a9twUQPpzVgi5rdcZNDC1sC/8Ym3OzBMyp/9V901ksUGsapIEd3TtzTczihnjzeNHNyMy1fSHADk+et4pl6vVCkRHIN4SYQnKkCu9DBC+ZFsnNO9YUQ3XhcnL2RSVF55r8OENzGOw6YsngNmEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsSUOfvE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsSUOfvE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B786C4160D
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 10:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705918745;
	bh=QUjanRZVZc1CRp5LhPpwAAIZe+eAMSSksRySXBprTBs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qsSUOfvE0/vI2SHFvw0TP8zx2r6s8qR7H0oX+JJzNQ/03i7062D1ZVD+TO2YrlhXY
	 6O1wXARp7pGB2CRnr7fBnWVgqSarHZtWmEFi0CgxGhwyv1Af+0/UyCieRYl1GKDTkB
	 +a+TNhV3pazokGDFXKU2F4iOPbMiwwIxA6brcdxlDcXr3Qwm9p6lRofFvptOSu4Nzc
	 2c/juL/5m82W598Bdj9DmDwIZC6St9y1Qzi2YEqT//HgJlSglzh274PZX2/yCBVLNn
	 KfIZAq4pFvYKdBrAyFpK+3NOqgMsdycG92gEeHa3MhiTI/ZMb0tA4GqCCAkG2OQWDm
	 MIf1QN30HKc0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4F1EEC53BCD; Mon, 22 Jan 2024 10:19:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date: Mon, 22 Jan 2024 10:19:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215167-62941-5gmErGmw6X@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #57 from Artem S. Tashkinov (aros@gmx.com) ---
This bug report has become unintelligible.=20

Please file a new one if you're still affected.

Make sure you have verified kernel 6.6.13 or 6.7.1 with the latest firmware.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
