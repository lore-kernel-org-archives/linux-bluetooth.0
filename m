Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97141380FC3
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781335009; cv=none; b=OW3st7D06SdxZbjPZla9zz5IGT7nwuJRB+eGyVCxHLFCdniyKCosJEeMNkr7RSNNc61SpHK2x+Di2G8HCaeKYqeHZS40yYMvwahdQN38QmUE9vcbqaOG1r959LOgPF/TQOoXCPZHzdgsA0blTgmmyJvec48aHbLrFOmN5nTgCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781335009; c=relaxed/simple;
	bh=rj3m6ELh4KBw5U2BmNE1857+10fzsfwfEVVjcaDSNTw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P7Lg1qNDPkZqOHYeNIAsI5gHIsZ0KrEnzkjA6+FqqzBG7oy1gkGBOk+vI9ZDOUA6EQwoRJ6PAc/2RJ4FvYjhuL4QVIyKnNN1/4iKy+gkXzotVQUSXNAZQHUzJfPDwgnDLVk6Zi2+bw+BcSefvFQTllOq6XH4DL/d0gzPBmK2M8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn2bhH67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn2bhH67"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDAB6C4AF0D
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 07:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781335009;
	bh=rj3m6ELh4KBw5U2BmNE1857+10fzsfwfEVVjcaDSNTw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bn2bhH67qmbnYCBg5tLmRxhOy5GrYWOtyJsydcKj0vV051qyGFPaAUWIROQKkrIYz
	 MTNocqiInSCQQb3IaKTsJYL/w1ENrQ3BVsM6PMM1/Pcy2L2sGsLgPwivlOM2AEg39g
	 rVZu6Sp3XGuOSjDY+9Ki7PGEPYq5FKhOBVAu54FKgX7hajrNR4gZzktyCRmqATTW/N
	 zq0PRdH0KkwC+Vom2RDDCwUUnYhMbM7e84iMcVUmgqQBBUgPcyVFwK439ppC74s7mm
	 vQO1I9b/E+Lm99HHXiiFXCfXxTDjVcrHYmwOYEK2QZQsR7MRZCUzqGTAWuQnzGGv2l
	 2XxvlXmBw427A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E3215C3279F; Sat, 13 Jun 2026 07:16:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Sat, 13 Jun 2026 07:16:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: icechrome@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-73081-62941-fbwi8LtDDu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D73081

--- Comment #10 from Dmitry Khromov (icechrome@gmail.com) ---
My apologies for misleading, that was a hunch from back then.

From your dmesg log I notice the kernel fails to find the WiFi/Bluetooth ch=
ip
firmware. You should grab it from

https://github.com/qca/ath6kl-firmware/tree/master/ath6k/AR6004/hw3.0

which is where I got it the last time and put into
`/lib/firmware/ath6k/AR6004/hw3.0` if you haven't done so already.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
