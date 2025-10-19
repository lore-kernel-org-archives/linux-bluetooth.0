Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29235354AD4
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Oct 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760892363; cv=none; b=jyXsbXoBuPbQlkGWRvRMMDmdiD3+d0LxT/VwqxCdzkovyZYDaiF2hMhzxVq9h91KxJ+ifdGx2KpWVIZGGHOGqZvYeetn4TngR1cecLXbyyFRLTNsA9SKrnegXdVUZj7f0iyayyLAYj1mYZtwGICYYFCKkfPe8Wc5bzqWoE1ZFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760892363; c=relaxed/simple;
	bh=B1Of6Sywi/SIDHNGhe+4STYq+zbvJXipe35pcGBqDzE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQRup8VhKbb1bU33gC2TeuzykZHfJ+ti3DkFFoN7AbapSP9qfg+QLxNyAlvFsdFS+6JKuk5UtDjt7sCh2KRAODTpMfpCIMqVwDHt6wCb+vdi9KKZPkjZvPdLlgwkTc5q8WVpkBoMFbwqRJkFSO8Wst8B4UELKRGLjMw68jKls6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tE/1EKfq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tE/1EKfq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC93C4CEF1
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Oct 2025 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760892359;
	bh=B1Of6Sywi/SIDHNGhe+4STYq+zbvJXipe35pcGBqDzE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tE/1EKfqdG8zcibojRMiKZvWi0cOzFGGhuSx70q7aRgbOpbKjTl/aw8o/cFBiw018
	 8zxByoLhXM5Wqhzhlzsa+FhQu8mChF2UNMos/QpnUu/DeKVFz4y1hPGQeUcI1QZfSx
	 0wLvDdR+teHjuzRQ2TtxsW2179R1rPLK+fq51xL5fMXnE8DTyzWjsLb1tpFOPK7j2U
	 JsHYNAXxN6sDdlOfrhuE0/GMMU5HrRXHIejt4LaTpLgDgGYkdInLUYU/iDMIlWBvB0
	 fJryUzEgzs+26WKZFwWOWtyJhvZCvHwpR0YBTMfRVEtBU7G51LBXgmXPRKYvAKDLKo
	 ebbtPhHV0L0PQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7EF5CC53BC5; Sun, 19 Oct 2025 16:45:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] Wrong indentification of Bluetooth in Lenovo Legion Pro
 5 16IAX10 and 0489:e111 Foxconn / Hon Hai Wireless_Device
Date: Sun, 19 Oct 2025 16:45:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220564-62941-5nerDysePa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

jeremy (jeremy53561@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jeremy53561@gmail.com

--- Comment #3 from jeremy (jeremy53561@gmail.com) ---
https://github.com/LuanAdemi/mediatek7925e-bluetooth-fix/tree/main?tab=3Dre=
adme-ov-file#quick-install
See if that fixes this issue

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
