Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C282156665
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209930; cv=none; b=EJwzKB1JrlhWt8KqQmQkqUAgzKqvZq6BOgZEhXx+HoOP4ncbPKfWuoe0d7N2dzkxdLC6RBCkRqj0Wa/jSyeLrJDvylxeWW0M+IbiudNnvzQN94ZDDr50Yb+V75SUC1Zrcqj2McNGcqMBeGmeAUnre5N85FYKXG9gdQpi8axXmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209930; c=relaxed/simple;
	bh=wuruRGx31+AHvrRlwgzWlZsasGOAgRqqNqv2M5lf4eU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KZgX+mvG4U64AAarYsi1IocmqXfdRh0gmBf3UR26BYRr/bxlPdIUbftGCcAbC8vDAgISqw/S0nawX1Bxoh621ZF1rDgcLnx1tAhn4Ql6jjoe8rYoqiE8Swk6qQGMy7JSu19c4VhaTQ/C0J7JT/9lvj+IBQ9lix4P+gwn0YePXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLQJGgo6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLQJGgo6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AA8CC113CC
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713209930;
	bh=wuruRGx31+AHvrRlwgzWlZsasGOAgRqqNqv2M5lf4eU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PLQJGgo6xlsUAC1iPlIeML1FmMocjgterG0YM8dAj4lrgIgUGo49YcJFAnmoKC5ZF
	 S80YtIJFUro/TJ+fA0IOpdujVC+IoGyPXdEYmcghfpQEsyXixPhHM6DhM/tpfwMYsR
	 O6K1dZ3+p932isWKAwVV5/ydWNY8IvbTKzthUqzc2Nu6AVrD7G0ggCJEwzfoV0FDg6
	 dg4nA7v0mbHTitpWvx3DI4R2HVvfrl9LE0MY9m7iPZ4fw4YvPNMpMEpej0MT/LW5W3
	 qVSutlIGIqCW8XFTsrHPEmQVpS255io/WdYPYbn1Ue0DGRE5MEs3AJKlEUlPL0zyBe
	 4gD29hoFE8yPg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1A1DDC433E2; Mon, 15 Apr 2024 19:38:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 19:38:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-z69RA1RGkC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #8 from Wren Turkal (wt@penguintechs.org) ---
In the first log (after cold boot), I only captures shortly before toggling=
 the
bluetooth. In the second lot (after warm boot), I enabled them with the ker=
nel
args. I definitely see a message from your patch in the second log.

Do you want to capture additional logging?

I am applying and trying your new patchset. I am applying it on to of the
logging patches. I will then use the kernel arg and try to capture as much =
as I
can on a cold boot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
