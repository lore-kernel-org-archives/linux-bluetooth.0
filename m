Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A122C6BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583275; cv=none; b=dE4ILdTANwr2OILLZFHV1a6+BJSYSmBxMl2FwQxrcVUgD8Owa3Xa/lzwqonoNN0/mf4QV3VISfCYPlGpr0C7nDVyFu4ekBSj+Qh2fsm1x6Gde8sdK+UCQQ6Zw2EnqVSb5/tphIoRfo42mcKbX4AN6T5r+ijvtRlqa5sMYFPtLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583275; c=relaxed/simple;
	bh=Oudv07xyRxoqP6G9Bxo5k57Ubkl2biHF0F+hC6wpZ48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BV+JNywoxyhL2ZUj/bJU6xJeZutO7sxL0aqSqYDj4Q7klMvjJZsJ9n+bKcDkrRx8LKuwO2QUXeyLsMYPlgIFPJ1C5WJ6MfpIw+7oYzxhEg8LEk2uWJ+JVUnrOUBPX1HYA5mcwjtiLhcF+f0CxRMJG4vRbU1gZasHA92USJ5CAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/iyriqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/iyriqH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96B32C4AF08
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 20:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716583274;
	bh=Oudv07xyRxoqP6G9Bxo5k57Ubkl2biHF0F+hC6wpZ48=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P/iyriqHmFMrX2i8oFD6HywiClM6OZ91cKD03meymKwIcYYlleJC3p3H4STHFKB53
	 hyza2ofp187wty/i5pG5j6DDDb39zqhEAz5wf8x9sbS0C8g7ilahRJzBAZy/mFyj6n
	 wLVI7k7rQG1kW7gAeGE8A5ZolQPf8wI3aRd4ftMwXfpCk3B8Msz2yWnLrN9eStOLB1
	 AWHWIYEK86CiFKwNWh+L2fHJkBARTfHI0hYErOZjTMnpm1rbkqpREp109pqJb0vVtD
	 GNG9J8ULfFUVZrL33fRDmgiWQEP5KhztHwdrSBKy9NG7K69vxZ/XaRpwsPwmZN4d0E
	 7a7SOHRzRqYRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8FEEEC53B50; Fri, 24 May 2024 20:41:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 24 May 2024 20:41:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-fJSkTidR4V@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #28 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
@dustin, thank you, but please *attach* the full log next time.

    [90310.622241] Bluetooth: hci0: Retrieving Intel exception info failed
(-16)

is different from this issue title. Please create a new issue, and attach a=
ll
the information there.

> This is a regression. It has been broken since 6.5. It worked fine in pri=
or
> kernel versions.

That is actually a good thing. It=E2=80=99d be great if you bisected the co=
mmit
introducing the regression [1].

[1]:
https://www.kernel.org/doc/html/latest/admin-guide/verify-bugs-and-bisect-r=
egressions.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
