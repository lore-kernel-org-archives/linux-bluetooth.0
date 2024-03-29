Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A2241EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711702351; cv=none; b=fy4l+P+gJE01HE5OTtzYA4BLNUhFCMQYQmDyYbnFYnxf5YuGa5Ndwmbm5SU0ytm69AZMO/CJXN8MkTL4EclRjZdCh8FT3NaIKlj1Yw3j4M5iN7gfwNOyWmfMJL7tLUDQP+JtQR70Tz6IV1BEURAOxeDib9P5qcJIpA51cBsReZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711702351; c=relaxed/simple;
	bh=2le/Vfo6y1YAgcJbpfDuhzqanNc+hYNpdPlSa+hAhdw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YkU4xvZrF0qcG43YHheQgXEshz/1OZkC7UkDVhR6pOGt9Sc5CYgZSzgshffJRJqMNOPrqkMcOJ7Id+SiBgp0vLajTcdN9KGpZskTLfsHo29Pn7D8/AVoGw3bCdIEJLsI3/1I8Lk5M6tU4+fgggLQHTeaoR2yfKtDNJuCgxlBl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiUPDJBF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiUPDJBF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FFC8C43394
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711702351;
	bh=2le/Vfo6y1YAgcJbpfDuhzqanNc+hYNpdPlSa+hAhdw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OiUPDJBFTnk5SiZKinKNlb/gXe5QjWU5YyY75IkXdU7z2TTtmdyRCdYrxQUxiAkr1
	 2asj0oH7RL8RCBdmoCYNVDoioSNO6UY7Hq9r97dG6hkRt1lU1MgZEWVjlBilVaNl5D
	 U3BAo6gxNtPb9rWblv1CaTDtVe95vLnq8cM/a88fOxuIRDz28MBmsQ43hsLuCpcjMw
	 vTjneF7quuTDuqmxUzxBGr8I1dWVubkfsJGOsSmjJl0g/qHXFedzTYKdfvc3iB1ckJ
	 Tt+Z4UQkXNCIHgDPgMpq3f0CptGmA0TsWXgsS6DEi7t2NAnGny1jWKEvbdPace+y3y
	 Zsbp6sdxX68Xw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 539F8C4332E; Fri, 29 Mar 2024 08:52:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 29 Mar 2024 08:52:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: contact@odelierre.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218416-62941-B38fBvEF8x@https.bugzilla.kernel.org/>
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

Olivier Delierre (contact@odelierre.fr) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |contact@odelierre.fr

--- Comment #9 from Olivier Delierre (contact@odelierre.fr) ---
Had the same issue. Somehow, after a long power-off and turning on again,
Bluetooth managed to show up and the message was gone. Using an AX200 as we=
ll.

Currently using kernel 6.8.2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
