Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F2280035
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957779; cv=none; b=VYjBTuWhyc2fqNc1cD83HAFiB/EMjxdf5rpQTf1h7F/mrwYNWMqB+PIv7Z7hqwjhtyFVaAAewPkPz6XSt0ix5cYAFFCzfRgcIuMxRHM4loKu5ixn2gjVs/RUmH7qSK5u90sYpXrXOAP/SX5PlJkTDddF3efwFBO75Q52+1Zx1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957779; c=relaxed/simple;
	bh=VlFfd0NxOVNFTgUhIda6YOyZ/Bug3l/XzPURktdYu0s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DV9qlJMm1sSlXYD4dlGgYTwCqo5aA0PO0uBhVD7V8vqY1JN0OmJhFTUaxdXEuE9hyLXw+/WzFbwS/zRjj8cBvBSYZe/h64BAmmkxDioGYQe2cDX++lwoT4WbEkJEgbo3hxie2es+NgX8DwBUKsNM8m4b19KLkuAIMeBidyKfmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZErYP0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZErYP0R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1026DC2BCB4
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 05:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777957779;
	bh=VlFfd0NxOVNFTgUhIda6YOyZ/Bug3l/XzPURktdYu0s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KZErYP0R4Etxf+I07UBeO7jf7CQHxtT3GGpV5S1BeaVDmIKugo35C+IdcWRtG7H9g
	 S8XXrf2oj6BaIzVNMsNnUoTbXgbHnh104qEd27q0dU/zIuhETGuSjnJ7sBRRGCsE3e
	 uOQCmYDng5smY/TnkDwWQgHeI6+xCICqqQJcdTDOwPqQAz8wcCH7KtUU0ag+U2Yhdb
	 hbdtGUiR5oycC38bASkVG/0SFLyubN1iY+NnxZ3gOv6yqmVZnhsSmKNQDqsnO5HMGJ
	 TsFdrYEMc96cLgyKXhmzu5+0ss2XgYdeHjzXjjaWm9oWqdhWKY2HJn0o+jjYQN67P6
	 /vZoEhaP7a4fg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 02A99C41612; Tue,  5 May 2026 05:09:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221449] Wireless gamepad stopped working through Bluetooth
Date: Tue, 05 May 2026 05:09:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221449-62941-F4yIqU2apR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221449-62941@https.bugzilla.kernel.org/>
References: <bug-221449-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221449

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #2 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
6.19.y is EOL. Does 7.0 work? Testing 7.1-rc2 would be good, too. And can y=
ou
please verify is it's really the kernel that broke things?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
