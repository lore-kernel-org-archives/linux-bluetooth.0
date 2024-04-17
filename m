Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAB7D07E
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342536; cv=none; b=Hr5wwPT9/l+pC9/uuiUkcVwYhbci7KjI6WQl0162uNTrb4OfOigNfBDp7Y7hcmCXj6y/aJWDI6qxL7p2zLnB4AtOjvXs+200uZrjL0v0SEMwhI2gVVPrpNx5Wk9KOaOcxOygyju3D3G06ZYdY69uystFsnirmWNxvQ5XRxvoAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342536; c=relaxed/simple;
	bh=Q2Pu09lHoG4kZlU4auF90uNZtpLOuvrwxkZjwKAgqCc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWhMSdJi5CcpGYbQ5Bn9PJO0NT7QaRv/cCVXXBmXnXaVDtGCByugAAqgEp/CGWDLT8x15gLARVOOJEKRAYNtTwDcnOVmpTaD8t5Peb8J89scwXTEiVeimFO/hHKxqanvqKH2trMQZB4TZg7uAnhun8wLZEJKlNfDBR4EIrPSxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coNHuSjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coNHuSjy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4162EC072AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342536;
	bh=Q2Pu09lHoG4kZlU4auF90uNZtpLOuvrwxkZjwKAgqCc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=coNHuSjyDJhKCvlbAhYR+3wThkuuRREB6WlF8OQ8T2hbqK2AakKTrZmEACki8fpHW
	 pxAl+WmSSqwvPhte7ybeumMKkS3nz6UPi33nReBaCyh1zT8bnK3Hc6U0vWhfMdhg8O
	 AHQ1qTVUIZQN2TzgtaiEVFUvyk665hhcwm1C9fpKOOfez3zHTMsnG01DwAUMOt8KCw
	 WI8g+bu/Cl7mCN3zVjoSarAMky1W9JkGAQ9r3EtJRoA1AKUBVdb4oib2dxPb5Clogy
	 w9leHUC9Y6phBnHTGbZb57MBjgkLwWkPJdLC0xFNRkAfhT6WtRa55o4x/xuRQKaI5N
	 gU5vsazR+7nkw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3AD1BC433E3; Wed, 17 Apr 2024 08:28:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 08:28:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-reqfwd8BGh@https.bugzilla.kernel.org/>
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

--- Comment #29 from Zijun Hu (quic_zijuhu@quicinc.com) ---
thank you, Wren, for help verification and capturing logs.
will check logs today later.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
