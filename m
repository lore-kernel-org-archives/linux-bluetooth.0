Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A6186A
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923346; cv=none; b=HyS1fsasHq4N0xH8GS6zqolKpMzuaziL+VEJHWuqq0gL1844SmZcuVlUEH1yKmLx4ezNRoEIQC1pw7WNzeq5+4YPLIItdIc+lSTkqIj5ZWPZgiUVoSogEoNPjH16vtcu0O3vAKTFOC2oexZU2o3HDm7Lt02zN00N8IqW7DqZ4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923346; c=relaxed/simple;
	bh=k++WwtgSZpMaVP9WXXVrABWQMimW8vs0lxm+LNg9b1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tkdkAYS3ggTgokGVJ9pLN2iyjOlIeCpDVA5gMnkDN/ELr8a3gSEfHtFNuaClxoDfNtCYzOBA257XUq+QBhj+owZ08bESPgdLoOHsxon+lYz7pYNdwotoWKG59p0w77i2aJ8czo1Y/tz/uFrXzVBnvw4L9zdO+ect4QIlRCwoULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW3K7gAi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW3K7gAi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DD1AC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752923345;
	bh=k++WwtgSZpMaVP9WXXVrABWQMimW8vs0lxm+LNg9b1g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hW3K7gAiNaA66AQnLXZswu2H0cZcuCmmlUxJtoEXh6LxRYX/MkGhzrReegA0PIKJg
	 keFnOmcrYDHFFCB1ASrx+grukZ/YXdEarlh7hT16vQKpXl+waBbQIYzUynlMPWVDo9
	 +jNI+uOxDD9xOV+wf42rmAc8K6wNv9pLTrRfffU6U0TZfutJSORFGyKNgL5hLXa4CO
	 3srytxw/+QaEUEg/ZpY/3rDDegmL2t/+ijTU77A1JF04DRp8cE0AC3LDnA9rEw7ITf
	 P6rTryN2s0JiqROLjrPq3UNh9mn4yMZhUv+k2YkitHdxvMLFbgYNG+hejIrr3ej0xC
	 tgfqewrTsWURg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 96EEFC41612; Sat, 19 Jul 2025 11:09:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Sat, 19 Jul 2025 11:09:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nicolas.baranger@3xo.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-RNbnUx0dOb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #18 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
I'm sure it will help if you can reproduce on mainline (and developers would
have to work on...)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
