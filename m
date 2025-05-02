Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F711474DA
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193714; cv=none; b=IOLDhFZ9K4X9y9y8Ie5fek34LW7Ve7C5jCosyWjZwNQy3WBugcPoDAMDYI8EZNH5p3leutIqoHXpd0ZDApnOLEQ5W99h3DjdtVy3iDFoqxTbYkQH8/wBt1GZn4bKyBfTMa8UTn8ZmIerrdQPF4e4qRpO7JeTwrmY9/8n1AqE848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193714; c=relaxed/simple;
	bh=/m0hICS998PAmTb9eTJQ4z8YUK7AfYur+cjVHI7+Rd0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fAQ+o11KF1lxjKl+gFhbHwsVFRDl5HpG+EN/Z8gVFTerd6hYIdvWslkO6WBLZMkDi8/EaGP0UYEu4VVpHZI2byfm9i8Ls+I9wVcKN9TkRBb0/rh4LFSvvZSV2v8Knce5nuZloiPIRS05BmpbJw7qbXERMsn0q1mUXDsHbBfb5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El0pZIQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El0pZIQL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71718C4CEEE
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746193713;
	bh=/m0hICS998PAmTb9eTJQ4z8YUK7AfYur+cjVHI7+Rd0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=El0pZIQLW+5I4ShzXp+nI8TbYPh2tvQvmIY5McHBXsXtf27dxN5EKrMJTAGLOTYm5
	 88RpDSOQgzgJrBSsQAqYPvJhBgED8HhyaVgBl+u65i8KXvl7d4pFeUE8G44oAOIusO
	 KvXWX1n4a7fZlj4s+B5TxisaL0zCiTNOVxyAEF2vgR9vYvhzcwIB1+Nvv9nHKnn1gT
	 gbD8f6IbZsucrl/3BxJItn/XZX0j2YrrzqohFL+BoXWIi8LDl9rTIcDtcF673GwcE2
	 ff4zqjV2ZPiWO9RMYHtF0vPvo8fLlJQYjMDnOdvLh5t5p1c0HtMUxqzy8TlFRsgdYi
	 iJY93Gn9dsmGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 691C9C53BC5; Fri,  2 May 2025 13:48:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Fri, 02 May 2025 13:48:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220061-62941-MiNl38rAdR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #8 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
v2:
https://patchwork.kernel.org/project/bluetooth/patch/20250501141222.2498357=
-1-luiz.dentz@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
