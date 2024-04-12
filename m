Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7E39FD5
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958001; cv=none; b=rnPGn/5PaCOSUbsO/GyfjeE/6yWSOape3q7CiVzUlJooGf1bZoRnNsusDWCcMeR0ArU+mdH9Lb6X5og26I5P1BuHMxkPOmK2Z3OJwHwXs8uBHlS08QqD51W7GnKTq3nDmxfP5iIpAyxBb7onQG/HaH6Gdp7E5SxUWS8AtkzFJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958001; c=relaxed/simple;
	bh=HTekrIiq6VPgIE3sbbp8kziLwTpn7AIeI5s3DsAwT88=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYxDZly0oj1prpCPwIGKrUXFo841vuvhGCh0A2RYRrzIPP6YioutELsqhLkQXRJsNempaoCyfd9Eher+9dsMpgtJ+tNZzfogdhWdh5bpueIFcsaVaN8mQJ2RzH3FgNE+6NQaRGMDLgFTijEbYruz/xh8H8m+MjlfU75Fu+19U+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQvfVmyr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQvfVmyr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60CD8C3277B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 21:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712958001;
	bh=HTekrIiq6VPgIE3sbbp8kziLwTpn7AIeI5s3DsAwT88=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PQvfVmyrCFCrulyp99WWTK1hTvzVVhLnlgk48W6NbBytCRQCK8NcvYlp/tUE1ukwm
	 pznlfVx3/wWMB3aEd3IdqzCJgk7BvfX9UDAXXXbcyqs+79+fbdmlXFRtINRLcHd/up
	 rc2MnDPWJZWgy+YuOdrqrJvIclbXTmXc/tOwLD3AXTo7RdqqqiBPTWbghdsOgg4ZJO
	 C3rTXhXvdrrGuKaO5Giv6eU7r7/MSOmENcAXtx5th2zk9QtGxnNqhrr+LEVYKfKbB3
	 T7htwXEqEAPPWzNmAYBpZzj+/jscnxECTBBm5RU/QSUNPfRIbrLLTnl9spg9aiK33K
	 H5v8YyghTGMFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5159FC433E5; Fri, 12 Apr 2024 21:40:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Fri, 12 Apr 2024 21:40:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-gH9GI3Gkdr@https.bugzilla.kernel.org/>
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

--- Comment #23 from Warren Turkal (wt@penguintechs.org) ---
AFAIK, no OS uses a cold reboot for the reboot option. Cold reboot implies
turning the machine off. Every arch I know of requires a button presses to =
turn
it back on. Very different then just resetting the computer without powering
down.

Is there no way to reset the hardware such that it is in the state it is be=
fore
the power button is pressed?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
