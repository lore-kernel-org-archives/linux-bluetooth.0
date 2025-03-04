Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3218D
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047537; cv=none; b=hEFTJ27S/ecr37IqLuW8VV2bWdt8t9lPkarhv+YIo8NOfLwLxG8eLUKJvdsVQFwy2mFw/YToz/50Kz5JpjTwhLrmvjZCTml2BLVp9pvQe6IVy46knZiJLzPAHroLrz47vocs3PEWkO5htHCmjVXDyOeMrtIzY0D7aJXLN5dEW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047537; c=relaxed/simple;
	bh=kJKCF/VojUjaZq+CgPETwSMTzJEtA2McaewWrW6iFgo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jpgQmQEBGtRJG3NMxXGDNvve2OWKbY0PFizAw/Nh5XjW2ft0VUlnXTXGewCzx1uSNSh1efLrb+vG7teAQOro3Ogp2JxiIu9pJClIRtK78IOf/0H5+q6fN7nyXRiKFIEmsGuaJie+W+2GCcMFH7FTreLGCJRlGGJh0mlnHCmW5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DojU0u0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DojU0u0u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05F6DC4CEEA
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741047536;
	bh=kJKCF/VojUjaZq+CgPETwSMTzJEtA2McaewWrW6iFgo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DojU0u0utWaKlZnoclboNAp2r3RmOfXW2bdh5GP5LAuZXotA7L8XW4MOPuNrOlFg4
	 fEL9YaW8NMgQPHFRhbrKxDtQjp9c5/ajwYp3g8O6MS5VTK9EZbu/gclCD0Iwyk3N8d
	 KoYfidYabQBPibgnb9KtaXujqmNtzBrKjeSjJeJnp4lFyQ64gZOiw0o1nKVh9+Dzn5
	 Wuf2yBCMXlIi95YHLN8iVnXs3yYjCu3Vr0GdYhhZP8lv1cu9Wr+ZsoL1yBK8ThAf44
	 LCkpB1RB8KRhzHUzABEx9fUD9GYVw438lyINX8CkDlUyvKIbk1Ev2r0PpIDA0VEkh8
	 UGC0ubRaZCflw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F19B8C4160E; Tue,  4 Mar 2025 00:18:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219833] USB bluetooth dongle stop working after upgrade from
 6.8.0-52 to 6.8.0-53 and/or 6.8.0-54
Date: Tue, 04 Mar 2025 00:18:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219833-62941-N10PLwviBJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219833-62941@https.bugzilla.kernel.org/>
References: <bug-219833-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219833

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Vendor kernels are not supported here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
