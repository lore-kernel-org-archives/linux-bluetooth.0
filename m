Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B381A4F1B
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568524; cv=none; b=q1hU/VyiDgcPX+yqtsiinbcOtVyMbliVjJSIUgoVvLSbbv6fmqbOHY95/v79gmPK3fcPgUKbwOwigwz49rxpxsD1zhzW1PmZTZXmkxg88ezADfzVzEDG/IxmngXNwvfmWonx8ZKNsw5nPObQdz3U5dxvKAwchds6ORjD8uWd+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568524; c=relaxed/simple;
	bh=13D8viO1F38rzgmgb48BDKGG4err4JT4I46+hL7afkE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJtB7gbqmQWs4kG3SFaXpQhalTD+ZzM6HScTbsE0gSgTXMaCrCeOb6lsJJo/yqCGR8UlKwK2F9Xz8Ux4tY0Hg9cwXSRcna0zsnH/CNlwKAu7oXphOtcaQmnP9I6QEDegbBs1/UCzSJdDiVkNQ+93sds2oCTQwh9yrhuA3yPJbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN6v6hUm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN6v6hUm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D145BC4CED0
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735568523;
	bh=13D8viO1F38rzgmgb48BDKGG4err4JT4I46+hL7afkE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jN6v6hUmESxJxyhLdF23DvTkowAZio5bGekiyWnqxtLnkkoVEFHL0aJSRb4qZ0TT1
	 yFM55FSP1MG4O2KrSObLd6mIsyQ5TGregMdRUAcA2JLp3d0mc7CSjiJV1X15RSWOmf
	 vsrcyVA+YDetAlRQJ9qGIQmVyorLTgbRrsBwU7GoP1xmZ0QNKvkOL+zcJytma21gWn
	 rkWN14oOxdWlvV7WOF2IYLD1ivOvN0TFXhwYU+22P6cTZnVeEziIwa3JFvinf85Uer
	 1AkD8+OIIV/886QkfUQrp7M1SMgESuPfsIf9cx98JFDtUEfUh729blzQyxaVOkYNJy
	 p+9qxt5ANkJbA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C81B3C4160E; Mon, 30 Dec 2024 14:22:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219642] graph xrun not-triggered
Date: Mon, 30 Dec 2024 14:22:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: francois5537@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219642-62941-rZ6enJuKIE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219642-62941@https.bugzilla.kernel.org/>
References: <bug-219642-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219642

Francois (francois5537@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |Linux fedora
                   |                            |6.12.6-200.fc41.x86_64 #1
                   |                            |SMP PREEMPT_DYNAMIC Thu Dec
                   |                            |19 21:06:34 UTC 2024 x86_64
                   |                            |GNU/Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
