Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA826ACD
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189329; cv=none; b=W6qKkBygSJ6lchAJxsG/O76sl0uDfROCu9aTHx1FhADZMZP+smFxtM3LYexVcxDTOM1KKuczrGCzOw7ObLkpiBxQLMgLPmTdRQ5c/986Y8FPLQ0EHh1ypNazdgq6pdVfZShl1eAC2Bi6bXXin0+1k7Va5SF/vlu3CkFKuTP8rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189329; c=relaxed/simple;
	bh=Waz/42Xtqx9y9l47oTym2yUHAidLrydkUWKMYzW5HOI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fzNNnkrPjCKYQaNE2J5eIpwYQz5Js7MCmb74R8MFt9nvZxD7BtFQUwtQ9SlrY0WYUdJ5SxNDoBLGu5dtIvU/ui6uqD3sV06KbuTgFDxR9Acr2pne9LRzengygbW0WS3FH6Vu6qLYfbc5MdoZA+z89YbEcM9gPnMHi6rmo1GB5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muZ+hdMi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muZ+hdMi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39B9DC4CEE7
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744189329;
	bh=Waz/42Xtqx9y9l47oTym2yUHAidLrydkUWKMYzW5HOI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=muZ+hdMiUgh9fAfpeJbpuMqwI6cqI9bqskK9n6+yJIZ+Hy22SewFHlPaWoZma8ihp
	 o/QuCXMDwjiQKHMk0A4ehGasYkT6rm03ljY2DaPMNrtJlht8o9N5fqJ+QGeSnNTpEf
	 NvwtBsh502nyvwg9CHWU3SQFqZJP6IZ4dwT7NpGPHghbpuFGg8sGJe1xTv7IBPWCtU
	 vxUmflL9rDhip0Hg1QbvqOSsWOM62UgLc0ZqP6HZPMm0mNIIGRcvEDFu1+sZgdSHVY
	 2sR8YGCCY/0sq4SSf1g1VDKzlfXyCSoU/HnaRdbv2/wGgiFUt6tW1RaXfBCokaH1eK
	 GTaY8JoqbgnMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2E03CC53BC5; Wed,  9 Apr 2025 09:02:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219997] [rtw89] Headset unusable because of delays and stutter
Date: Wed, 09 Apr 2025 09:02:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219997-62941-cz6CeBDwDt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219997-62941@https.bugzilla.kernel.org/>
References: <bug-219997-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219997

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Kernel version?
bluez version?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
