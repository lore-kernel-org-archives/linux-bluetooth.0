Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15225338F
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345529; cv=none; b=W0AVWnqDnIIq1tNAXriWQpBYmBylVm4lRAiqANOWKlQCaW20BPLpi5ewsk7DRxNvuoqG7NfT8SXdBx/65JSwjwUQaoI+Np39xAzr+M6vZtABoVGBP009oN+hh2PcnderZqYQPHAq8bw22s2/6RNd6WdaLnkY0p0KBiQWmrCI1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345529; c=relaxed/simple;
	bh=Ap5xjOPFNOmTZx9+LMY9m99EcpUrBTohKFvBid1wu+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ti5L20r4knK/QV139I27idaTWYnthFtZByRT5wjlSW52C0XEB0V3nJEKQFQTxgwPhtI1nvXMXGQzQaLLeANquJFeCk3iD26L/8B2tVrCnQZ9G+iSps63Fd+erQq+ZxU+14MppXIraiQ7WuWV8j017Lf38L3qvCejBc7HpN8J0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE7h5UxN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE7h5UxN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80ACDC072AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713345528;
	bh=Ap5xjOPFNOmTZx9+LMY9m99EcpUrBTohKFvBid1wu+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UE7h5UxNrfg/kufUQMrCG+B9CPHY5Zc9jpXyMcU1rBqcZTfZXDBgiQNnk2DX5fReE
	 UUKf2ih4xEANIFFgs0e5ptQJc+spbnlcvsEJsQJt8n+yf6dMo3txznZrvNcg758uIn
	 MRG3KjkgJyrA5FsT7NYrBQ5PKWHkTmmSA6/NmoKLz7cWzFDAG5++UmRkQ1LPJUrzgb
	 YGv9zNu79PhabNMmak6ib/mWUwjYuHkt5osNatFz52RNfUNwcjGcUyDPSwI9J3tJZL
	 lKNXz3l0Ty1IV5VBgfOYXkFBTTqsi7mGC1oWuibb9zhHozq6XxecQCreAHhxEz9lA7
	 oVhnF0xF9cYtw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 77C57C433DE; Wed, 17 Apr 2024 09:18:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 09:18:48 +0000
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
Message-ID: <bug-218726-62941-tEXKcpMvfY@https.bugzilla.kernel.org/>
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

--- Comment #31 from Wren Turkal (wt@penguintechs.org) ---
(In reply to Zijun Hu from comment #29)
> thank you, Wren, for help verification and capturing logs.
> will check logs today later.

Okay, cool. Thx.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
