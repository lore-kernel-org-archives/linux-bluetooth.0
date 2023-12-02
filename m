Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7379474
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Dec 2023 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHi0VJys"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFD16C433CA
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Dec 2023 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701542840;
	bh=hDzrgpGnkXcU3pgmy8Rvz5EdOkBiAskP1qHK4LBRzDg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HHi0VJyspvpLlehoLT3h6nBbVVGxbXmZUuY9BrQmyFcrU86AjTQtnJciwrkfLmo/r
	 mZL5wLxhLavIAP9+0msAfCMa8v7qy9dT1JuJLYsfZVCzWB31aX1/Zn5y5Ejcy8vCsH
	 gb1AvVqUrrhp37sF9exJTdHQvJSInsVoUtidUqprDUhC+JYlUCi9hMkBagMSuEWDlB
	 0aDOVGRWEopKS6Wr7xJkb2M/eht+lJzxTxcNEtf1U3FjgO/n2I3hFFFBHaBEju+FXo
	 tQZFzV4Qe8xsgT4+m9d4mmU+z2rdhCtc5ztx/wCsr+Au7D2lT1EThWlEJ/r5sIkCJQ
	 Bb2nnemWbOosg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9A386C53BD3; Sat,  2 Dec 2023 18:47:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218142] Bluetooth adapter fails to recognize on kernel
 5.15.0-88-generic
Date: Sat, 02 Dec 2023 18:47:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugs-a21@moonlit-rail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218142-62941-xhYwWHr0Th@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218142-62941@https.bugzilla.kernel.org/>
References: <bug-218142-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218142

--- Comment #5 from Kris Karas (bugs-a21@moonlit-rail.com) ---
Created attachment 305529
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305529&action=3Dedit
Output of "lspci -nn" on the Asrock x470 Taichi motherboard.

Happy to bisect - it was only 8 steps to get to the problem commit.  :-)

I'm adding the output of "lspci -nn" and "lspci -tvnn" requested by Paul in
comment 4.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
