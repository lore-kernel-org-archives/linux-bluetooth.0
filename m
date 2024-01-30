Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE886DD10
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624472; cv=none; b=ojxAUAN5/AewEBH2f2JTtOdyk4WiAwike5gfKqFk8bAhMEHgb7nBHT5bi+q0y/vMVzLJ7PFi9ar6IR+aRlXCM0yOEY5F29Cu73XpsYrj22RbPRuy5I3UL3uoze0v184OON9Svx2s8Q73BP4YGi5Oi96dNT9cp+y+Msoe+u44vvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624472; c=relaxed/simple;
	bh=l5nWMCLRoMXwx/yTD9XhcU0gLTAZUJfIG1DXKIC0wvY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CIoiWR3O/6nev2F4RHyudzf5xyLhsOyo5UyuFdPdnWR/kazv3U9e0vBf561/EdgWmONpc/js8TLVHrIf+XLdSdIbV7rs5U2I5giP/nGF5xOm7gtN1aO0tuZXf43fj4OxTSEfStkrGvgjx0FbVZ+DARKfXDUIBq+8+XjM+PkzZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFY4JIAG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFY4JIAG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBF71C43399
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706624471;
	bh=l5nWMCLRoMXwx/yTD9XhcU0gLTAZUJfIG1DXKIC0wvY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bFY4JIAGnLckDpexzmzga9jaaP2oYnLYm8MSkh8O1n7GTzlPL9APECimGaReEsKaD
	 p1U+tRTp1NmJkwRrijGJSQ/ExTJZT4nz6YcEuR4JoslqOuDOIIXWzIQ/ZQEj+p+mcL
	 Eq8Fglh0OZgEcb2Yip0T0/9HVBJ3dQoZYgZkTy5k9nigo/P9Krn+o1fPbB00hOBR1K
	 XEgf++FblmL4g/sMeB+KHXGWq/lqLNnvgU1xxCyFACC0ULQiwwJmBYj1pt9r20E4cV
	 QUqpVJD4O1iwQpF+JAClQ/eW/0C4Ssw/P1vdLg5EMoJRR5u6i24mjRCkbtS9MY2G6U
	 RwQkqUsjWVkjA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C0A7DC53BCD; Tue, 30 Jan 2024 14:21:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Tue, 30 Jan 2024 14:21:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickolas@gupton.xyz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-Cigi6NZsKB@https.bugzilla.kernel.org/>
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

--- Comment #1 from Nickolas Gupton (nickolas@gupton.xyz) ---
This issue is still present in kernel 6.7.2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
