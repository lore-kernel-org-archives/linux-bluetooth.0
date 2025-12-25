Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D93EEC3
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766634659; cv=none; b=Z614QwSr1WDlSGwkRDKAfrGGc7sdHG27BlEVz4x3wYRKEFF2AtCvWPSBYnM41COYef9QUKl2T+PX+I/+dj3ecRbI7RcMylWo6Ur63Nda3OD9XglvCjUC2faCVPnb0ce2XzimbaHiJozeRvLkZio/sSHyC3wvj8+sjAyuEPPxk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766634659; c=relaxed/simple;
	bh=L9/Ka5Lx25+Xe5c/h7n3VIWFDIzTW7/5ejW9WTyBmLk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJg7TjRNqMA7ieADFKTa7nHQp6mScehmqBgejRu3XIBGX982lCu8D+VC8ij6eVBBOTjbuRw8KXT6axply2RpI4ql1t/tFZHm2Iw6Osil2mEkdrVLLcHQDgdatlDb2P4NafQgYMlTCK7R+m52/Egwe41KP6U/o70lqA8sjh8Rspw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn+wdm0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn+wdm0a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D09B4C4CEF7
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 03:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766634657;
	bh=L9/Ka5Lx25+Xe5c/h7n3VIWFDIzTW7/5ejW9WTyBmLk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mn+wdm0aqCgLqhGLUpxWxCZnY5hszN9zUweLgVX4sV+dCiA94NYyUUy3Yif1e/WST
	 vfDSp0NUbrRQktVnIp68uKJaFHu+QKOw2X0E3WZWA585dfhrFkdALgnTVv1Kx1sE7L
	 O4zMbQRKvjsonXmaBEBvbCbj/G98TjS+EyQSnpgfKkDPNiGvorXgG1ZHXmPP1uHVTy
	 u7aAY8lhXtw7PAmhlKArLBqEbbNYcG1l4aBATqcqwggayGr83NiOHhTwrbgQEPebRt
	 yFZrGmODjBEyEYgNY8sMzuhLkzoGYNMfM37pKsm6yPDRVNCPOR0hsw+Zu+MebHRbVy
	 5iOdYKVW7xHag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C629DC41614; Thu, 25 Dec 2025 03:50:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Thu, 25 Dec 2025 03:50:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-xWdB9CkL4W@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #38 from cheako+kernel_org@mikemestnik.net ---
@James If you didn't see this was an issue with `thinkpad_acpi` for me,
blacklisting fixed it.  You could also follow the example in Comment 32 for=
 how
to hexedit the module.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
