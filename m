Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F414286
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034563; cv=none; b=GBcKCGiPA6Q5zubOkp66kVPTcu0fmHVyKBebU6CUGGaz32KS5c8I92Dba6LgkS9UntxFrV7YvcxwhFZ8JWKBl5s9W54Q+LOAjgDgno6+fbeM8T6fBkeiUdU7fPvEbIWepJI9ryr7jeFKFp6MfMzbDhgV34OcfJRl2IqsezLLg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034563; c=relaxed/simple;
	bh=SgznRHKys9eTMyzgS7UkKu2QOH9dvdgORdCv+cAS7m8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RPxVU+CAYgYiKKhhxsqirHezA2FKAa2jyYxFLMU46mjU9nyntK4y3vujC5pR1qQzBd343iNkVV7jW3d8+pvBQx044UxrvHi4ldsvR0igbDI/ZQdco/J2kwFl1Ri5R4rBFtsYI6bopC41aYKSPPQcKAzI3izvH60YwMM9ODpLVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHDkGxc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHDkGxc0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E042C4AF07
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 02:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034562;
	bh=SgznRHKys9eTMyzgS7UkKu2QOH9dvdgORdCv+cAS7m8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LHDkGxc0ZZl/BdFydayX3tGgZomy1Kf36f6e6xqQkUrPwYFySQMFP0xLDxMuQEUrq
	 VUCP9cw2Mz2AcQiJnqJfocR8Ad0hTwB+rBIfLWPU8btTZkpNohf1J5Z/cVFplJNw+b
	 dobnIW0f5qL3JXux3zxeAZs6LNLyekF9Qr/3GZCgMkjZ7aqpajgFGXEZcPnJTTmv0Q
	 jgAvmQBgdk6z4wdcBfQozUO4HmJsemDvYoB6/ZytoYRigDjjVwxyOo7fY+eNRiMkUh
	 cXkTb/FshKjKfiTrmVaAyVZ13YGtPBtRbvlFGmLoe/5EWbELvRq8k/p+Ciswe6jj4m
	 6Sy/Lg/E6eUVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8692BC53BB0; Thu, 30 May 2024 02:02:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218914] Missing HCI event REMOTE_NAME Causing Subsequent
 Bluetooth Connection Failures
Date: Thu, 30 May 2024 02:02:42 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuxuanhu@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218914-62941-7RK4n97my8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218914-62941@https.bugzilla.kernel.org/>
References: <bug-218914-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218914

--- Comment #2 from Yuxuan Hu (yuxuanhu@buaa.edu.cn) ---
Created attachment 306374
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306374&action=3Dedit
Attachment 2: ftrace records of bluetooth and rfcomm modules.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
