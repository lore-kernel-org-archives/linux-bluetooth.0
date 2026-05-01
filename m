Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011F2FFF89
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777613774; cv=none; b=aEDnGvp+OF6Y76nmchoSVC9CqGjx7L2cF7L3iC45lXaA6BAla5iGW015knpZ/Hnfz2y7SCxigkY74RLyX0g8T4Nqz26YCA11BZAeUzX6tfhgfcDvWDs05f1IR2BbceufL7AnVSCUeBZdopYEs98muNHJXcgQCXFJXEkhaqMaYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777613774; c=relaxed/simple;
	bh=ZkuFd7rfouDUrVWfYkAxjfOCxOmk3Q6y1u5SYVSavZY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBaLbSdjCa7yhSNvHStI5rIlrPXAJ2nZUHx6H9Hz0+sRvJ/I0B2KDAsegkUBw08dAgXjhVElUc7O25YND0YZ0JRl8zPFzGSC8O43SxPcrMaDbgPYmMDE5V2XRMfs/vFzREE0tG2Ttn97bKNjWU1J/E4Q/efKt+6/ziTcYopB8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQbSe7by; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQbSe7by"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ADD4C2BCC6
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 05:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777613774;
	bh=ZkuFd7rfouDUrVWfYkAxjfOCxOmk3Q6y1u5SYVSavZY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TQbSe7bygOFH8vvQYVjjhLfRe07dSZd53Ysx3gJDVZeI3aznziAth46vDl5eiPiDU
	 WKJVFEQ9RA3jG+7gxWdeYZlgKobqJQpkOCZ2ZGpbM8bteBFwsFCofU2cKaoDZ0IwsX
	 ivn7YN4FRJ9OqGLqsiZZUEabHYyYqrXqvH6UiZ2TfSY7rTbKFrfK7A/q9fsSXkZjhx
	 QbsyEZWmsPr785fCMu0ETUEQV4LcVvfj2l06lLbSaQg53/AT4i1AnFsd7/qdS+u6rV
	 LgIBh71QXYze+YOnyatuZnosk4brCjKulcHh6cPouqbYYPrw1xunHGKht8Luh5IaaS
	 DeYBUbXPrpELQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 20FD8C53BC5; Fri,  1 May 2026 05:36:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Fri, 01 May 2026 05:36:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pallaswept@proton.me
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221339-62941-YvTDmQ4VQz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221339-62941@https.bugzilla.kernel.org/>
References: <bug-221339-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221339

pallaswept@proton.me changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #14 from pallaswept@proton.me ---
Thank you that's done the trick!

I hope it's correct process to resolve this.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
