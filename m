Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7888336B0C
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Dec 2023 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/3AOzD3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1EC8C433CD
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Dec 2023 23:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702768845;
	bh=7Q76JZ4wHTpCzlSzC9vNh3YcHLWpkmbdvu4zztGyGKo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X/3AOzD3N52PIfSIYyxUpgDvJ7mM0aybgpWyo5GLrO7dg3yzxYlqPXRh5/Kx2ZrFR
	 2SqUBYGbWbFgRx71vSfJnDxmq8SrLtDNw/FNZe7enuC1l5t2V8bOpsqnLyCmNo+7Tr
	 4JkCJk8Hw98e9/mj22cgMElH8v+h/J66OV+sgOBJnkAqObwIezl7Si2SjvTPNX2hmQ
	 ph5UOez5pnr/+rIAT5xrv47NqwGbdbbw2lt8mXfFrwIWmziEQKHGilkgOp2yd2+syD
	 KE3KwxOh5t9xv+VNCjDA5UyBOhNLXG/aL+po9ag4pIYTYOnmHLaiVFJrgV2ERCv1+I
	 8F+KK9l991kiw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DA8ADC53BD1; Sat, 16 Dec 2023 23:20:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date: Sat, 16 Dec 2023 23:20:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: scherbakov.al@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-7rXwwX4ewE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

--- Comment #18 from scherbakov_al (scherbakov.al@gmail.com) ---
I tested it. The trackpad worked for more than an hour without the same
disconnections every 10 minutes that we had before. But an hour later it
disconnected and could not restore the connection. Only restarting bluetooth
helped. This happened several times. The problem has not yet been resolved.
Fedora 39.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
