Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74C1925A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967581; cv=none; b=q2tR500pDDayDOzH9iedCw6ct9b2kAzpK+/OEzwlW1cY42UI3XY9vBL4YqduYCw0DNXT3kCd4o2ZGIZIX+9yndhhSaC26aSrTZDvM1MpQVIcfR48H+zZdyXa1r6UiwsCdFoSL8OzrhAedpJZlSU/Ru3HAAKN7FZ/UUj9TrnvNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967581; c=relaxed/simple;
	bh=/WQUkxjJycPBXX5dC3Ynnjkb9Un7m1Q5DXlSkoJh3zI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pnQeYUgf235h20ennGAm/5eG1ttZoemdC4KYKWUaSkRvhU1zrEg5XNgFXfkN1PesX26vtzMSMAq6mzkXC3L9FTNZhGZXzlcIO+60jWMYZVFz/0B4QCLphqZZKrE/ulWO5h9XAs8dtLkrMJZuWMHulYpAjjbuVlkURv5mUyDWhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj18jtrT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj18jtrT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8C72C4CECF
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731967580;
	bh=/WQUkxjJycPBXX5dC3Ynnjkb9Un7m1Q5DXlSkoJh3zI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bj18jtrTeduNM1DtSVqGYStGjlmhjuqVUqlg7R7h3UMMy9Tp5kXI/mtnFEC67iPTY
	 /N2Bgenkqs+yiL/rTzm7wnlKZo2YpGbWm4mNfcnqeXXa+pJKPZB65OJn/Yf86JtQ3y
	 ClWffIiUnjaUS4WHnMyQ9h+Xa/XBqOWo6egTdw3ad+cJ1M0KCUE7WSDpFt/HQ/i8Hz
	 wVWnKuQdt31fUNP1BGssKleasIAQuCU76FKqTQwWPfhUvzISlle4rJ6m3LYhwNHQlJ
	 AbznJcd3O0P0Xu3g0sESVlBrm/K3BREoKNGNBZyWfSLuCvfU13HcpyzrpWGU9sXSrW
	 bKSTNA6yjfFIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 97CD5CAB784; Mon, 18 Nov 2024 22:06:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219433] RIP: 0010:btusb_suspend+0x1b/0x1d0 [btusb]
Date: Mon, 18 Nov 2024 22:06:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tim@tim-richardson.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219433-62941-7Wa9Rn4HjA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219433-62941@https.bugzilla.kernel.org/>
References: <bug-219433-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219433

Tim Richardson (tim@tim-richardson.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tim@tim-richardson.net

--- Comment #3 from Tim Richardson (tim@tim-richardson.net) ---
this is a power-management bug related to MediaTek bluetooth occurring in
recent kernels.=20
I don't know if they are related but what a coincidence

https://bugzilla.kernel.org/show_bug.cgi?id=3D219290

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
