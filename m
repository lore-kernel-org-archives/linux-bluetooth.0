Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13C1922F9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101310; cv=none; b=U0VEqORWtSov99fAQkdj2r/aPf5roZlSPMxOtPBuDyPesmprOQ2DzHuB6SANvXjxgIA9fyffZGTVBIXsU7chTCGbcYSucPI+FSJFLmxayNF1HmNx/S6nKwzFHIi9dwIkDAN83Kspx6OfFAv4ggx/TC7/r2qgme/LaGqO/pGhyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101310; c=relaxed/simple;
	bh=xRCgtjvoHc5HY5IAMHWzfaT2xT//3+To1QGxNF3fYKA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qR/FOHCaqrep+hvZC2F/j4VBWRrGFCSdncZghyr9txFVgfYYsuD1zv01Cj7nduWry/qXSRyyU7WqaX/iO5zoX+AXxDMhyj6eUDl0FwSiqPFjvSrCycwvpY2N4SM/aDeixQqsYIPf6u/avFIMOPr+cSVSY2iXhaxFkQkMAZunSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX8WJ8jC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX8WJ8jC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12F6BC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730101310;
	bh=xRCgtjvoHc5HY5IAMHWzfaT2xT//3+To1QGxNF3fYKA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oX8WJ8jCM8Z23VT2uQBquml7/EgZ2myDpXeL22f36i3BkO17EWEzdYI2KWKTSgErY
	 dCIw0i9dfhsV/bK/MGrp2WX+LzRwYxnQ+KcLLPBQS4ss+o3VSxcDF4TUqLtWrCDqU4
	 ViAx31p9A9XqWHqC2X3gIwTe/cLdzciWpc/8llck7zLfKBURbSVO41aWm+W+Et0hto
	 b8+OkNBnyzSKu0U3kJKw5i0nirveLFeSrRV0dW309fm5+hwwforX9N8Yr7VZ0s6Iyn
	 nK4EBM6qOaYSzdPIjiFljHsMNUtzAaZSD1omn1/x4iaQuT6cjoUyqmEbBanYzu18nK
	 CVZ+/fSCLlRTg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0A518C53BC2; Mon, 28 Oct 2024 07:41:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219433] RIP: 0010:btusb_suspend+0x1b/0x1d0 [btusb]
Date: Mon, 28 Oct 2024 07:41:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219433-62941-Tac8mlchNh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219433-62941@https.bugzilla.kernel.org/>
References: <bug-219433-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219433

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.11.2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
