Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEA1AF4E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029851; cv=none; b=WTOGvm/xKG4nFv7NturGM2ap9M8H/zDr/fVGhEDVGYRG2DnNNoVYzxy4o2SsgH8DUpjDgWcKYR7uinEZ/4rTwZN2xsLnes6bFIcqcbGhNcAHLKAMCne+52gKIprGSZ5MvpQ6oRmiA5/+mRvIW2ftozVrc9OYc3rHSG9pPf35Fpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029851; c=relaxed/simple;
	bh=nl4bpduFSv47j1HTQveZOTyEdef8TVxVtrD86/BH8L4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHy6YeOLXZRQ7PSLGYFIPjjpWWVW4YU3ADF0SjnXl49FevoliooVcAabSyaPtpk2NXPEGcJNBNqFC6a43qIJ+LEaIHXr0e+XnNBysWHm0KZnqY+7aMKLL/4j0wcOLzf5zXzEQbPzgwM15yASGMr4FYNbu2OYMwN0V2D3LbxRMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK5Mpykr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK5Mpykr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59D9AC4CEC2
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725029851;
	bh=nl4bpduFSv47j1HTQveZOTyEdef8TVxVtrD86/BH8L4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rK5Mpykr5Kf0D9rRqOXqZ7dZEwu/xl0+W9OqjbkjaG7NoMqKxIxQt6UQL5qHVk3/9
	 c2L+VSDpLfNTBFIul9Iyjl2XkV6on2BGWQg0zix4+reRbdscKo2oeIx2KqBL67yLqE
	 vBd5+xsUD1QdkSj662JaF5Ncqvix9tcpaQj6hFKNW7AcoPWpgPXVdl6fT/ngxK0sNt
	 cFaCRHGSK51A5v91lHRENdBV1ChuA77rdbV2A6e150VqpaCCUuhZ5l1DiIbyiga+Kl
	 VOyBgteTZuKas9KLXCcxZqD2M44NvemPLohMgqgj/3XO7uV+6zIi6fQJhSJni+TInd
	 Pq1dBXeRXgJlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 49C7BC53BB9; Fri, 30 Aug 2024 14:57:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219211] Bluetooth not working. Bluetooth: hci0: Opcode 0x0c03
 failed: -110
Date: Fri, 30 Aug 2024 14:57:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aprilgrimoire@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219211-62941-4fRmEJqlim@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219211-62941@https.bugzilla.kernel.org/>
References: <bug-219211-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219211

--- Comment #4 from aprilgrimoire@gmail.com ---
(In reply to Artem S. Tashkinov from comment #1)
> Kernel version?
>=20
> lsusb output?

Sorry the correct kernel version is

(base) april@AprilGrimoire-Mechrevo ~ $ uname -a
Linux AprilGrimoire-Mechrevo 6.10.4-gentoo #7 SMP PREEMPT_DYNAMIC Fri Aug 30
00:01:45 CST 2024 x86_64 AMD Ryzen 7 8845H w/ Radeon 780M Graphics Authenti=
cAMD
GNU/Linux

I tried this on multiple kernel versions, and all of them didn't work.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
