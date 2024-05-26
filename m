Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2B1E896
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 May 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716750885; cv=none; b=O0wz8vUulFdhBiIercueyf6dhpIA5gm6O5MJhFHidVKpviqtC7WlukwGztdEyjF5+rlfapMdBsLoO3iC3cAdUkV8tnCl6hSeQHkxicRqa7O8pjrdeMsWYr2Fwq6PU3/djxe7QH3p1BQhsbstdAQXZ8dlEQPamRBdnYvyg699oI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716750885; c=relaxed/simple;
	bh=1JOsIjxuCfgHopDFHjCbAx1REKw4NPbmG0D1Ht1BDqM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WuDibJeCKfib5/9sUzaI6GTEZRtjsV7zUL/hNux3SsX7A0rHu+i6HF7F4IeY6a7qJOsUoERB00egTv/8xrNSrj1uoVDolmSEG9bobxpTsQ161wI/wr0meNf7Nsga5wky5SXLIvmIhkbLcsQYc2OYsurCGOGjRvmuuEX2TMNgpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPeOjlvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPeOjlvY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AFD4C4AF52
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 May 2024 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716750885;
	bh=1JOsIjxuCfgHopDFHjCbAx1REKw4NPbmG0D1Ht1BDqM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZPeOjlvY6GUNQGxK0wBbRauia/OzY6qahCLlBJFaozHJxXBQeoalv8NvWsNEjLRma
	 TYrzQot5eRJNBIn/Yncoklr4WFa2NQ0OZPGKwfr9f9byvJeYzpqTyjJrjOKADW0ydW
	 8/89AlgK/gbv1VbgfXzppmHkvwc1CCZAuCZwgXf1+j2h9rUJJ94IGLJWXlnnzTdtf+
	 Ajrhizx+QTLFkb5y16IamSFCS24025mLd5tA8Z11xX3FBdHofkXZo2h/RF3UcUhlcz
	 55hwCzvAsD3z20z8sUlzGIW46V7rw2+UOdV01+cOxah3OAmNdrWFyvcVPCj+DyLUGC
	 wdYk07Rk0YxcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 158C1C53B50; Sun, 26 May 2024 19:14:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date: Sun, 26 May 2024 19:14:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: harmie@opensuse.fi
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-PFzu4dAecy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #59 from Harri Miettinen (harmie@opensuse.fi) ---
Yes the original issue was fixed long time ago. I have changed my computer
since so I can't verify if problem has appeared again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
