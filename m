Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BF12C532
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139599; cv=none; b=ObktLYPhjEjZOI4PRo2bm1Vi1VVILCfSKd+M23PYdYQ4kIcq0b6ZNA6g8xr2sM8m6PU8079qoh8psrLyIsKu2h46vN4m5mLc35kUxkMBjoaHHlMhVKGU9SYKlJyWoTuKWgQQYG/q5zKP1rwNoyhXPjor2ZOHvKNYgbAjdAeofuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139599; c=relaxed/simple;
	bh=DAmgDE5PIKOssf8DgjLWgDq6mLv+tKO2fCqJ/DfG22M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ha7131bjTDc0o2X1Y1IQgiyUOPUjdm2SaMAd5jRO2HTCp0bclqdotNjj4bjTGz1Ltzd6Cyrz3ufmd3wtiINOijgY7sfU/ArAI4E6DKNrDRJmpdsziG6pjxyLa8/IFzpLroxACIy2bfr68dNDoJCLS3LexKI/+jS0oe8WMGTGxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr2kPac/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr2kPac/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3CACC433F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 23:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706139598;
	bh=DAmgDE5PIKOssf8DgjLWgDq6mLv+tKO2fCqJ/DfG22M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gr2kPac/Ck1wQF/HdGgczOsVB5r1rO3mJpr2hMXgf9hr0vw5HcWUCAgGP/KENJom2
	 lF74gJXfdB77gpJZfNbCmCpSiZTB7t07Gn6x6C1prcvHQQLkAJx+4srKr2oa0k3t7W
	 9YNnLvyV2BdHwaJTd7z4TvijIMiqbS92JZ0+LvKAJ233bNaYvARgYPFGoY+Ur+pHv9
	 MJzb18Co8kxTG66uYUulETmvNBir8/SzfbapUe2raLdg7jRBGus+mv/dnWyK8Z7BSV
	 4YXaMSDab26fEwUIaUw+P9+Yi7bCsr7LIj+zs9y6xMXeRk1YLyzeMuLCJ4o93V2OWt
	 BGO0avNwW0BAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B74E6C4332E; Wed, 24 Jan 2024 23:39:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Wed, 24 Jan 2024 23:39:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickolas@gupton.xyz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: rep_platform
Message-ID: <bug-218416-62941-mcFCqgqlOa@https.bugzilla.kernel.org/>
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

Nickolas Gupton (nickolas@gupton.xyz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|All                         |Intel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
