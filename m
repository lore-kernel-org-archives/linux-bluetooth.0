Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BD20B1E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAk+0uLF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB00CC433C8
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703069751;
	bh=UJjj6u8SyuFsTrLdvwqjeSb+C7px3TLJdm0j5SvF77E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RAk+0uLFuxy7RFEDEeobsvgYdk+s5D3W27nQvNo1YP2r+uQ9HmUgpQaMvtnoXCkmS
	 Z/wgQz01m5fz9NLOBihQSM7u8p1GKE3jYeLGHKDedhtKtNzvCEwlfhwMs1iyN235EF
	 Nc4Wm0BDijJKNJVhc1Su9h0Xb0d6WKSn4ZuW78ryG+46c32ZuLAN7OIhqP5oGh/0M+
	 pzohKQ0phRiHFJKziCR/aUZvMKltP5vzPJK+8EhMo7sCx/VOmnTqUyfFXf0jxNZlJx
	 MQrXdy4Yh/z+NzivZxkNcp4QaFGG7W/vs0YuV4k/ukF2HTi8qwcP7PKYBBPz/uPO0S
	 5hSxhYbnZNYsQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8F7B6C53BD0; Wed, 20 Dec 2023 10:55:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217256] Bluetooth disappears after suspend
Date: Wed, 20 Dec 2023 10:55:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: franzferdinand1999@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217256-62941-deMnqQUD7T@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217256-62941@https.bugzilla.kernel.org/>
References: <bug-217256-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217256

Franz (franzferdinand1999@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |franzferdinand1999@gmail.co
                   |                            |m

--- Comment #5 from Franz (franzferdinand1999@gmail.com) ---
Did you send an error report to the mailing list? I am facing the same prob=
lems
with a Realtek RTL8852BE chipset.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
