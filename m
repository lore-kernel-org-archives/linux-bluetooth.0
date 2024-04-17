Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394902746B
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335591; cv=none; b=V10O4VkN2lejzSxWUnjjT6cWRZoNjowcWBkHW1JBH27xppLPcxjTerofGLdtJDU4rj6Y3JSTAKqSdtCBEHtFMWTjY9rdIuqnjTqG5DCnWQYcKNOpp5ZgHCWKFuKDP8wNd5tng8k8HA7+EvaLYkTAhLLlXAnQCtsORWg9QbaIFU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335591; c=relaxed/simple;
	bh=d9FyG9t/QYiBse/klP7rfKBqa625eICH7OpHk1qyvrQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4lsKpNenFl2nsUoK7IgxXeR2TgHWuer+QyZg/WGXiokqqyfxomdOCkXwJ+uUduNVQHDnejEInPtL1oURS71jvHvJu1IOh03xlxHsduRHkB8/ZobpK5u5hYdjtzcoaf+WoW4uOGeY4YCnDIrbl8bggc5P13MGIG2/IneQcTraYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juXjvpKx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juXjvpKx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6A3EC072AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 06:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713335590;
	bh=d9FyG9t/QYiBse/klP7rfKBqa625eICH7OpHk1qyvrQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=juXjvpKx7WK313rjplnB0ZwmSTUiC3osv8kQdnJfGEGzn8VYxMk/MXtZkGDO8EyD/
	 hBY1sVas3O9dXlbMtFrHTuI0ozoTXojiuBdVSaUJHqPlBogXSYCA7tZ122rdiQWooW
	 oLXX6dacIczv9ofRp02BgoUW0rZndd9sZSOuXsAs3EqMJqRQQauGQx0w66lOMbUjtL
	 4uSuTOkToem9ftdXvxtBDai7NHqiWaKopPsClSwsY9Rq8fYHtVzR5Ah2w8XqrAqVT5
	 Z2V0q2uXc6VzTIiPwoj7bayud05S2u7TfVLYhXtxz3oeBeySu87xP+j0rAKdL3zMh3
	 RRItxdiZhlKkA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BEFC7C433E2; Wed, 17 Apr 2024 06:33:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 06:33:10 +0000
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
Message-ID: <bug-218726-62941-mgWzNgX2lg@https.bugzilla.kernel.org/>
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

--- Comment #24 from Wren Turkal (wt@penguintechs.org) ---
Okay, I think what I am actually seeing is that the timestamps on early ker=
nel
logs in systemd's journal have the wrong timestamp. I am not sure why or ho=
w to
fix.

Anyway, let me try applying your patches and getting a full log from boot to
shutdown.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
