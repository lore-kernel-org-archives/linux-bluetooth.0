Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2D85291
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259991; cv=none; b=VF/87Oy5xhYrArb5EJGmO7ugHO+K5iOjyGvzTN1lK/f15vLO826YQC5iATk2lUMsmQjIkwqROW2e0xFkmIjZVt2N9yIQspFNje9uPn5hRHSBFd8iCiwVz27csvliuJf4jPsDkdREbC2gcW2A77Qb/xY7URfH/0Eldj6RBOpGWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259991; c=relaxed/simple;
	bh=qM0ACuPnHF1iY0txcdvOo9TmmbeMdNVAvCmv08FxqiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOQlfyCSCDEl8vNt+ifIw0aVBvtEs0BaGeEICT44jLMX2CsQHb7bGF1D7wY77M8RaadqsWo1wcn9w7NK2+lIx+bCWhMg++LUgzFb+Fgq9/mwwW37AxFFX+vjuUeoJk6Y907Ik3ejK9UcIFFeOjxiPWAxfQKQfXsCWpxvyI18W7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2fYezLb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2fYezLb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D60AC2BD10
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713259990;
	bh=qM0ACuPnHF1iY0txcdvOo9TmmbeMdNVAvCmv08FxqiI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T2fYezLbHsckiHUb5gkwPqNQq1AwGbryKHJp6bjLA9oakVr4gBKkYj4ih/Wq919Uc
	 A7vdZcInKDZk3zHXFUEHVfCwl61gBqyK7MVeg9dqYf5tpBRggWylm8AIUUe+xJ0oeY
	 EGz43WpLt3nxLMOojPxAy6HWB7xO1lLTpncMuGuQCbTsS+SzS8WUJLFGWPweJwZDCL
	 j6PtQYZRbKfUeBQCZXufCZ96rh6SyrtxHGvarE4LXBGtkMLqvrNgs+IOJfp15oXIe1
	 6tYQ+ABi2T7OmHG9oStX5ALNb2irY8fmptuiYrX+1grZDfEinp3kpaN55gOC79H8eN
	 mtmxxkKg3XYXg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 83C3AC433DE; Tue, 16 Apr 2024 09:33:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 09:33:10 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-C9QdKW2k9I@https.bugzilla.kernel.org/>
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

--- Comment #19 from Wren Turkal (wt@penguintechs.org) ---
I am trying the bare revert on bluetooth-next/master now to see if not
including the quirk hunk allows disable/re-enable like it does on 6.9.0-rc4.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
