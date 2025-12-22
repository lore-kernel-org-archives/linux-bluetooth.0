Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD822A7E4
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766418108; cv=none; b=fwabGNCi/scIFwyTiwaMsHWpWE6tKl16KLeXsiGqNPhy2kpdRByl5yH05fAQTFxfMFv8l43CiGeIrUBdYWT3lsiSYckkK1WiqPiFSbstvRjGbFo6go7jm6Krd2uf1KGG+Hv77DpyYZa+BOG4Zu0jE0e5je3ec38YPooEGRmtSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766418108; c=relaxed/simple;
	bh=54t+taeL7ILeq9sXnL4T3gGEPXU/X44tLs68GDPqiAc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=icrp3qnLEmQShT6XOzoNt1h05AJXOVWaXecobbhlptG4WYTwg/CK5bnsnWxGfPuQ137io3jS1+bv/w1oydoIMXeCu6dWY/b19+bNQ+lTQ9wTGC8dcbfyIJZEUa0lL7+zLzVgOTWgRBStOpDB/9L4gMnSh5opkiOnr4QZTTVGfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQuoUk/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQuoUk/8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E6E4C113D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766418107;
	bh=54t+taeL7ILeq9sXnL4T3gGEPXU/X44tLs68GDPqiAc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AQuoUk/8eJBcPtluI+H7NE02AfcNDxSh/hLhwGe5DRe/Us7VE9+CWvFP/IkiaXmeB
	 D7xdkKB8u0puPWaVupLsu6LTb/IbzOxYyejDowphb6tvvVu/3nmV+2slc4aQKMsKW2
	 K+f48Rrn1Jin1gPympKAWS06RDCIRCDgsW1x+uQcRMk83mHr5fYDU79qW0V5SP7VrW
	 NTLlSaId01x/3QKhhWsXyx7iznYB0w+cC0+Wq7QMzctAVoTux0E7yBleUlRZe5Tlal
	 NkSZWRwO0+Fc8vxqCLvC8W6anQbgR3sba2yRMyjyGbNnfexWZajkAcN4LzyfEWj3iJ
	 krDDk6d4fWDGg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2266BC4160E; Mon, 22 Dec 2025 15:41:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Mon, 22 Dec 2025 15:41:46 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216936-62941-s4tHaViBoE@https.bugzilla.kernel.org/>
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

--- Comment #33 from cheako+kernel_org@mikemestnik.net ---
Created attachment 309060
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309060&action=3Dedit
A simple patch, adds my device ID as I suggested.

Sorry for this I know it's etiquette, but I didn't run a linter.  So this c=
ould
be missing a comma or something.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
