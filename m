Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C10155300
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283763; cv=none; b=saPfuuVetS/kcJFGpyMcSYKfID64IxfrO3+BYxfO8Ya4YXVmkGqQZko8S5XHhueyaRZrUWk9BCK8dnf+c6XD5bx8NNHCVQejwAAVL7QBQZn9b4BQBZMmbTyPRB8Pwj8dJHewi0ZuTc/yEXE4XFulwmOXI6s6Gr5XycvVZsQ2Akc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283763; c=relaxed/simple;
	bh=dvxU98YE2WzkycHmIwBkpT+afPsb55LXmwBFKID7uRk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WuiUfmzHnfODQZmuhVk/zWYs6z2rpgRvD7Oqb0epfPAm4BFVlEismkPW/myDG3Tm6cz+L4VxPXUxUD91YuSQyJrm56JklND8XOwcPpTXg8seeZfBSguAJr9aQLhoSM6d6k/U8K2Zi283UlXhLfhY0fhot/sHwdRrjklrCtmve0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5adxFJZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5adxFJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACC8BC4CEDD
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 21:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736283762;
	bh=dvxU98YE2WzkycHmIwBkpT+afPsb55LXmwBFKID7uRk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X5adxFJZcAfegp5bxkwI82bnPrHomqsCzWP6I8Sb6z0zkrZZDJbzC6q9OKX9h93+V
	 QbjIw3i7BXajAHOTNjNVqm+no/SdTc6YotFuSg/NXeq/5HJj9vwJ/qhRVL/ylQNrvO
	 6G6P9RNd2avdPhhh2E+Sb2m+kPMusX7dlgXyZCg2jKodT9sqLQk6GziH0Bgi2kzkkI
	 GBshKHrYBaGaaengPvo8iAvvicdPuMVVxRU+D2XfSa4k+JOnGkYkdb4D7zmGO4C3xf
	 ZxNaWPC3xEewupg3j9ZIT+45yM9/O2w8XvAXFvI7rDc2VYX9O+b64jJTrpvaA8yg0b
	 dWIUgnPxIwSfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9FC4EC41616; Tue,  7 Jan 2025 21:02:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Tue, 07 Jan 2025 21:02:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bojan@kseneman.si
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-Bgar14skqg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #13 from Bojan Kseneman (bojan@kseneman.si) ---
Seems to be fixed by this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/drive=
rs/bluetooth/btusb.c?id=3Dv6.12.8&id2=3Dv6.12.7

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
