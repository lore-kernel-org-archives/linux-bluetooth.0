Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10364523D
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713232913; cv=none; b=F19O2z6P64jtkaa5OhZ7mzfJvGHPKVJDhh89p6x9kf0XT8uUbs3JHrWWi4Xx9mmBX3ZcNt7VT6t/2/caDdxeQ5MR7AzwvxGZ2hbO1nE8HhLsbHE3aO/1XPbRosG4jJt+6JaBaUcEQFMMOCDByRdhymwxrOhL2K+d2OvyIiJmz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713232913; c=relaxed/simple;
	bh=qZ296bH+h/cQVQT3j+BRRQWWNEvS7dBBJZ2ylk11ojE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3j2Xg3XGabTk58+Q9wAcIppp2EuBMyRcEthLurwpbsL+Plec2Y21hlUxRRRr/4ktSfUMlLVEJTXUMijM2EH3PowFJfW6Jst/9NGgE3nZbDlh6VXUXDHbtlfJZHSLIsf0ootlggXKc4Lj1djVwIDPBaohWySWgjzC8NdTv7YVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9wG7bv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9wG7bv+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C042C3277B
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 02:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713232912;
	bh=qZ296bH+h/cQVQT3j+BRRQWWNEvS7dBBJZ2ylk11ojE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y9wG7bv+9LDdcnvo3FWEKwD63A3IvE+JXI4YiSJIPmHaL9mJKWuOtPpp1vW7l/dOo
	 XeryebmFYlTSj/tIIc5aeOoS88QhLKi3BeT964bemIJXn4PGSDjJESD1VEXYhWlTIi
	 5qpLic3M7a5jYy3WpQFVwh6jhqTBnmYou9BQmzyZYOatOGNGn+oozV05IeK/0Blkn3
	 UvMOG38i2W1pO4oE7Yy7PTqvMG1LMXDdzefzuNPXdalhra+ofelR/mL/mKWWPn7cbc
	 TEZTzAsTPPtsWzyj/KCAoH2tiznChDfOTqTMpSb1vyeCnoK8olSOVaLudWLPwd5h4b
	 CHGu/CpyYuV7Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5F430C433E2; Tue, 16 Apr 2024 02:01:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 02:01:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218726-62941-hh1pYtwWx0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #12 from Wren Turkal (wt@penguintechs.org) ---
Created attachment 306160
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306160&action=3Dedit
commit cef27048e5 + revert 56d074d26c5828773 after warm boot

Bluetooth does not work after a warm boot.

This log is after a warm boot. Unfortunately, the following kernel arg didn=
't
seem to enable the logs for the hci_uart and btqca args like I thought it
would:
dyndbg=3D"module hci_uart +pft; module btqca +pft"

I am trying to figure out how to turn the debug logs on as soon as the modu=
les
are loaded.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
