Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32AF21ABB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743161094; cv=none; b=M45uZcuW3sSEqhRI3MnsNz8dTRiPXq3hFG9VTS3OJ/jU+tSfXqiXknJOlhOp+iJi8h+9QDo8w9e85nCuk2AIl2IG8MmbzHYVP99wK/6flr4d+rjV07SA2OqKP5O4GHuBRD1T6YXK5UwfexSI5stP8vEbXQJ4vSABLI3TrYv+IU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743161094; c=relaxed/simple;
	bh=V0SYvhZjlk5MS9goQg2O4ZBxbr6i//SffuZffTPMOms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t3bxGnK9dLrA9cFZCHdAs2YDw1wcX0OgKCo68l3yCTGmSFISbYVqjbPgMfzXrDGKONbEq0uOVISQnGT2NxfT7s0xl7BiA3cxikC+MK3+WgQZyDysgRgwlOc+uJwQZiGxlaNGWZXJEpZDF7oIPz4uSEzMVfWypRAwSyP+D1nV+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFO4AOP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFO4AOP4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39BEFC4CEE4
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 11:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743161093;
	bh=V0SYvhZjlk5MS9goQg2O4ZBxbr6i//SffuZffTPMOms=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tFO4AOP4hY7od/nhEfqTd29Gzu3coNOlVEuEfopHMrUb8X/kymSUEVt8a3GsdOUsB
	 BNTUITu4CRqOEQg/hIZTV+ACXoPM7oaps5Q1v+oUM+Cjvi4Osg5oOVsK6/eBiWUDD+
	 XYPu6cLrjzh+a4V+DqCH/cCFxyJyVP0APYN3OntnDVfYZRzy2jZwsbEVuPayeZEJo2
	 44UG0u+2ocagfRSlGeFWVooKDDiRi6tQoY3WMjx19Q+FMivHwF1ApebISP46AiaSJC
	 kLeBvi9yq41eFVr2T7NvPPOBC/yrSJfjWk8/R8GPFXaHvOCiw26NNc26ACjZRJw4RW
	 SFlC2VYXAwEBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 18E7BC3279F; Fri, 28 Mar 2025 11:24:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219894] Bluetooth Qualcomm WCN785x - Input/output error
Date: Fri, 28 Mar 2025 11:24:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version bug_severity
Message-ID: <bug-219894-62941-rOJjIKzdIh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219894-62941@https.bugzilla.kernel.org/>
References: <bug-219894-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219894

Gurenko Alex (agurenko@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.14.0
           Severity|normal                      |high

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
