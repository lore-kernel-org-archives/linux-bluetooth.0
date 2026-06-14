Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2600175A87
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781420681; cv=none; b=c70K1FeOomdIyqR4KilGxXaMqiZsO6H/a9nTWRwtzSWTEAdd6Cpvw+iK0djh1lUM2JzhHHdkbkOyraMc0gFhP9I2lALu/9mta0LpNmQN6Gw5jFtSCs7tbxipF1QXlfW3kHITz3Ymj/lf0wKA8WwRxppm+0ty3bFbWsQN3xQBrPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781420681; c=relaxed/simple;
	bh=QGl9UhnlWJ26jgW2vRa4NNgL3b+dYC05f1TxsEaYrHg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XqUqgI/27CiLfwHYxihknvS6U20qK89hjtmsNG871JJInsUnh4CWOrG90Jv4w8Lh2Bi0ggq8c3+MW052G30BNfOQDh3gp1qynQCD/MIgZ+ip1wKhqVcujUFWzMlzWbFFVTCtg2cpybW52wLp+TJUPPpCfMVYxs+BAL6I8LT4tZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bg0Fyr05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bg0Fyr05"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51612C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781420681;
	bh=QGl9UhnlWJ26jgW2vRa4NNgL3b+dYC05f1TxsEaYrHg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bg0Fyr058Szr8lXKK7quBdUMwxdEiy3E1eAhbPRinB13oG0vqloBUASCrsedxR0mC
	 8nUrQ2L5byQlDGcNozK68hLk56GYBKi1Iez4+w5eOf8NipZAz/6LWL2+m4kwTe3ZQ2
	 b52OGmpInZMQD5ObZ/N6URGjnqiajbDsuHhE9A/HMGYfXVPkG8Sh9YFb+g0tiSOcxO
	 giJ88LBMGoKnMHXfDMlGUt0k22W6H/UYqHbP810yUB8ZSzYr1AX5VB5xkOXqgrdfva
	 jt5onEBJwQsfacb+zKNVmCDc1/1IH0kb21cSqOyT5fNnPN5C7tMQDO8kd9pUwuYpJf
	 AE2iuaM9+Fhww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4033EC53BBF; Sun, 14 Jun 2026 07:04:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Sun, 14 Jun 2026 07:04:41 +0000
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
Message-ID: <bug-221637-62941-B2IoBuRYFm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221637-62941@https.bugzilla.kernel.org/>
References: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

--- Comment #6 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Bianca sent a message to the mailing list: [REGRESSION] Intel Corporation
Device a876 (rev 10) firmware crashes since ed10eae8 [1].


[1]:
https://lore.kernel.org/all/635e5e63-dc67-4dac-8590-d613582c94c8@posteo.net/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
