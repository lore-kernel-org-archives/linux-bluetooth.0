Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05865BAD
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630175; cv=none; b=CB262dp07gjsEuGepvlt1InvHDlc8IZCTtexyqqGXlcgL2Zatq7j8PJ9rpo9U4rfp3gcmu/63dh1837MivadxAU3aoLegQHGTc1YZPgP38oZKrQfd0azw6VBbmTAQ0LXbzAgBjmhE7A1zTDxpXvrjbLcxMfHu/dZWXjf9QTDEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630175; c=relaxed/simple;
	bh=QXaylMD/sNcY4IPan5/wWyx8CuslyIWR29ETPtFnoGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQ0m3T+GhevhU84fR/4YVe2feciW6Wng1jYfR/VRV/U7Tqhw69r2h16wOGwDN7YRESZHimDjiYpC8IMiCVTLpFZaMzjL5VWogfXE43q5VnFi5CFRNMZg4iU5h4OeKgoolRA+2cCcqOrF47b632BCDzTYoEatRnPNg11zNA9g1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVJcjY++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVJcjY++"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDD4CC43390
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711630174;
	bh=QXaylMD/sNcY4IPan5/wWyx8CuslyIWR29ETPtFnoGU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EVJcjY++fIWIII9WHQbgW22P+jWX+3FrPCPpBJ7p8UJhR6F9WfSQZY/14guSPAesR
	 7+kIz4/rzShO+qnBWJZI4HwXfgLIvjO8gQwhc7p5hBXoyn/mz6vqAsNmzO6B+rKXzh
	 GavW4cGhds0QBLhZZAviOtbuJisq+vv/3BAXnoRvjR6rCpwGnUHj/tLRh+6NyHczHw
	 EANY3t33wbUxkIpPJ5KMq9sCfn6Yocjyf4Z3CqRtbsPH5POeQKQr+oW0FbBhYk4/kP
	 W+a+dfJQeeBjs983FKPr+YsR7VWqNGT00aMPRU180RedgH1B4+pBB4pqpI8kLxOWef
	 KrR5k17g/bipg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D00AAC53BD2; Thu, 28 Mar 2024 12:49:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 12:49:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: peter.weber@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218651-62941-E455Q5QeD9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

Peter Weber (peter.weber@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |peter.weber@mailbox.org

--- Comment #7 from Peter Weber (peter.weber@mailbox.org) ---
I've cross-checked with a ThinkPad X13 Gen 3 (AMD + Qualcomm WiFi/Bluetooth=
),
and it works properly with Linux "6.8.2". This issue is limited to devices =
with
Intel WiFi/Bluetooth.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
