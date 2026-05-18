Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2F28688C
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114935; cv=none; b=jUo5MD7xhskMYfRnhDCIHoY7wPDozi6aTk0ddrHf2/4rC5ZoR03t2iu8d2ifD/g2Isytd1Ttid/iupUsrE2nNr9ZrgORd2thVANb7jO5bo+NaplF+MNqnor5fSplOukRj5FpGOb971AtOnmsFg0bscvC592F2D7pZUeDR8flsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114935; c=relaxed/simple;
	bh=Qh26anXJxJ7R6UmVZK1Wpf3dJB5Imv13hLjZM2Q6xI4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2zytqAUpPyYyRrZyNDlwrrMF/LvAUb5WxdjyqTplrxcC38/Za15R3OMMIiRTVHmVivEIGbjtIVHq/jv7hKWECRkm7Pv2kxfb1wirYWYvXz692VjCmkG3Mos6Mo/Yas5TFsalPeDOxzRAcHN6Y5havSJw9n/WTzhJuC7XAHKNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ6E7AbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ6E7AbE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2B9DC2BCC6
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779114934;
	bh=Qh26anXJxJ7R6UmVZK1Wpf3dJB5Imv13hLjZM2Q6xI4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kZ6E7AbE8MTMFhGVpoZfkrvAYRrLkMc1IMREFtIAcmUJl1PgBXr02FW8yx8ivtQXC
	 FsCgMT9ygl1ddcZsA0IwyqP4oICej1RDTQg3wE5YZ5tpZ4IM1fHJgXCxAdiCbkarnl
	 d94+KEXurQ+iU9XBdQPTXNXCoaNuf8qoKgybD7j8tH/6I7kNAAIUeSgVaLFI+S9OhS
	 giVfP6W4DwC/tec3N4PV6fTJQGe1ONFGvSX0oOXD3QMp90E3d777r4UQBf8fWtGN1+
	 m66tpiRNmONwojCmYEwRUPLOV+4K0ZKfJdPhbiFdQy4y/icsNlzd+q6i22kOAOEdGl
	 VZo/j0k8kbeqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CB14AC53BC5; Mon, 18 May 2026 14:35:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Mon, 18 May 2026 14:35:34 +0000
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
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-xtq4wklOlk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sphinx-rift-sector@duck.com

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 221539 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
