Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EE3890FB
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224790; cv=none; b=C4ckDyPCUpG9W46ywabnpr7EMJd8mIhXebn8sQHnbWkuXwuWKzW4krA8TwvSsQKZBRFD/b4MjO7wZ3y5stMZ+CvOy0fsWtCjGMfVb/Ma4yXTxBdh0yHohu3DmDCqnoTtQG6+nBc7+Z4WRTQ0Gw2ZyfzduYkd0d8n6afmKRHnXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224790; c=relaxed/simple;
	bh=wOTQ8VkOOxTdWKQR3akiA+TYVFTDR2u7N3en+3omiJo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iwD3fWzWHAZl3cpW1yproomjP0Pd7lWsyywQfwCZ0JqRw4a9nN+dwsR1Be8dlsC96VT1fB68ZFC04/uMwazWnw8Vn13iWHKzm5+yZX74fB9kjJyVdD1KJTIjLX7BIM00wry7gAP/zXrn5da/2GxzIyFlGeoXkz/o37nqDBbmSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgtzBsuz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgtzBsuz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DF2EC2BCC9
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 07:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785224790;
	bh=wOTQ8VkOOxTdWKQR3akiA+TYVFTDR2u7N3en+3omiJo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qgtzBsuz+VQ/Fui53tUpyh6G1+pmMwpPKzUWTPrs200N6zM4h6kTlOvJ0fqvFT7nJ
	 85tyvwAhzN/Iaan+/+UaIZ0A7ddoUNNKo1WrStuSdR6E55MfbVK0W4M4xmoK4qL6+Q
	 aW8UTwfRNH0ghTlImtVW0kJNjWqNZ5DOmR/3eUia3egmRSZQcbVDNXJonEjulqufHT
	 D7RVNsi2rplzAFzypRy28V0z7BNHPXtnYlMyXBbL7C9ypv3ByItdWo/600oYaHM7VI
	 u74OOfWXqb+d1wdHJ3RSxaM31hJbXz5Y1XR2E1//hT7bjmVg/ZurE0QF6dZyGQX0oC
	 ctEZdAU3NLwdw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1D514C41612; Tue, 28 Jul 2026 07:46:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221783] Bluetooth: new-device pairing consistently fails on
 Intel AX211 due to ~20s delay between connect and Authentication Requested
 (WiFi/BT coexistence?)
Date: Tue, 28 Jul 2026 07:46:29 +0000
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
Message-ID: <bug-221783-62941-Olt2uhbA26@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221783-62941@https.bugzilla.kernel.org/>
References: <bug-221783-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221783

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Is this hardware new for you, or did this work with earlier kernel versions?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
