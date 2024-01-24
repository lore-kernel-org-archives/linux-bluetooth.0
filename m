Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0432131E4E
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125271; cv=none; b=lg9zVE9+3S+f/CEYn2UmJTgnPMxdyi4nsqY8bXoWPyzDOUfyQY75Pr6JxloBlPflmkX7rq9gfgsvdAv0k8hGMybLwY3epRy68ZcCekMNKHhH24CzFiSSkUl9C4XSzLy6pXme9Zv+AO2hN/SNXD4/FxL0VDH25ygGeldCmsV3+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125271; c=relaxed/simple;
	bh=KyqWoD7yP50nCQZVfowl/teFVB4266Z5pv85IWnKgq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YD7PlfrL6+tVLMQMf/CiUT2udyHg0zNRF4cothC0DecFWTZ1M2mQ2V+IZQ+7Vjj3xmgGGSLsRu1w76NXgcNXBxpwGrA9eCBc2nXFwgqsp9IpVcz6Ooj/U3ZG9098yu4T0KWQw8TQn+reBmH8le8d95ExlbwfkTucf13GF4rr7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJTnqNOX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJTnqNOX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D718C43399
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 19:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706125270;
	bh=KyqWoD7yP50nCQZVfowl/teFVB4266Z5pv85IWnKgq8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MJTnqNOX3qDaEwRB5TR23vtQ/rB1OoUztoK6wN/Xcznx9aanD8JRv+Q8BSWIgaKtx
	 9ZrZG+ggFEzhayuq5Iqb6VUfS5yarewMLX/mYB0Ub8Ra4iZ6tHU3kiauPk/eYA5Ak/
	 3hnlYb9WWLrycReWEfeL63+VVOUegEJRRlzrsa+++MoMzUi278CKezlWB+YVVQrGUp
	 Dln3idKXr39/J63nm92srMqP/bXS2mde5VOl2/M6qovtXoRHmqr+5JDyXmCmZlMNBG
	 N/ns7RHg+VqaK0aEEwg+8ucF+zABW/IspuVHCgKyr3z+CCkbbexyXyMhSd0fr8aX30
	 E02auz86J7x2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5E77EC53BD0; Wed, 24 Jan 2024 19:41:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date: Wed, 24 Jan 2024 19:41:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: LeeFlemingster@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-ZdtazmupqA@https.bugzilla.kernel.org/>
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

--- Comment #21 from Lee Fleming (LeeFlemingster@protonmail.com) ---
I did some more testing. It doesn't matter if the speaker is attached to US=
B A
or USB C. The problem is seen when the speaker is attached to USB 3.2 and n=
ot
seen when attached to USB 4 (see diagram in last post).

I did the following testing.
Speaker connected to port 2 USB A. Trackpad disconnects.
Speaker connected to port 2 USB C. Trackpad disconnects.
Speaker connected to port 1 USB C. No disconnect.
Speaker connected to port 3 USB C. No disconnect.
Speaker connected to port 4 USB C. Trackpad disconnects.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
