Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139C39B971
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940392; cv=none; b=HmyLw56J0xVfUmDbKQTC7tmdDQ6mpttfK60Ux1n7RCe5jzONO3IfwmSe5NWinp/A45yNI4lRfH7EhSI0S/bjD8cPY3jwgetQ3lIwViMfRcjBLmJMceJnsiXKZKxMiekr/APYmGVBriAwfFLLXU1ka+mtUAQbZTEoFB6h2kM4dAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940392; c=relaxed/simple;
	bh=FlxawWiXfylrULgTRoCWD4wXXgBWTH0h+yWl6mOpRuY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fii/mPMJraZLczXSXrT8UQRt8yCeyAGeIaNelxwKG2A9ntezN8UPZKfd5z65hZK+nHE2mDnCBN3ggmwzerQTzOGtOf+mMfVCeC2C+75isJl/F4++TM7nDV5eXoUxXsU1U/G2cf5KTR0op0x+NIfAyEGajYQLvbZ5OmwUC0k8os4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnzw8ILj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnzw8ILj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26392C2BCF4
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 21:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782940392;
	bh=FlxawWiXfylrULgTRoCWD4wXXgBWTH0h+yWl6mOpRuY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Rnzw8ILjQIoaX5Wx13nm0rFQOEGhTuZkljaW1AqE3+JCCPNk4tIr8C7ZFrN9+Ij40
	 sq4waolvGJYKDuqOdZsCY59K6kLzbt9EEnHcMXXI+1LK2fmGq3dpyPvb7MFnbpg0NI
	 db4K9NOxD8l6d8Mody9oZpW6TO3b0uAODhMYg0dPz13OzSaQylm/KBSHN2A4lS3NGs
	 5Nphh6c3U6Xvdup8Ghid6faHzY5toVFag3etHD4DirMeQPW1XC8ygnkokQzziQrNLk
	 Y+rGBvq+8qdi7KqIk0ukE4lPoUeUmfZJYootuGPWvjbLPAocLSNE+CCcqatfvY436F
	 bk0NhEILjr2bA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EDC0AC53BC5; Wed,  1 Jul 2026 21:13:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Wed, 01 Jul 2026 21:13:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: robhogan@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-h5Wnyb6NrS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #15 from Rob Hogan (robhogan@gmail.com) ---
Yes, it worked fine until the last few days when the interruptions to sound
became nearly constant - almost every ten or twenty minutes.

Linux mwenge 6.8.0-124-generic #124~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue =
May
26 21:05:19 UTC  x86_64 x86_64 x86_64 GNU/Linux

dmesg output attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
