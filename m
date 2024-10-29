Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C391DE3C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187931; cv=none; b=A8Lzo70vn1DL/gCGI2L6mrTYUIZKMJbeNI7OkrMtplWI+8hwDsiAsp+z1tl/6fD8PugtIdDkHcvC8GuCmt2xgrRRUI0OcKBHb1OyciIvcp/zuVbA7l+smTxLov8SB9PyNUk5li7n/FAXlNCa/3Qhvtng7Lvlnc8XmP1kimLenfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187931; c=relaxed/simple;
	bh=lzGljC/ZHtwwu+8fGFwKsvJGGmaSuUo55Re0rQZx0ss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWZyIz17OpfU8PL+s3kgbcPrlgBsLXbEwHQJc6lESmsoMkQb1oYUKkxlj5xpiFtIx6G1U1pPxvL1woHhAJjoMSNo+q2YZUwit7Lzs64KGHNkrnA6mTJYKQjdZIyPrhlP077Ivh7nsGQaJXVidwfkgLw8VPDmVPwRDlzUNKPiGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTeVbBTa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTeVbBTa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84AECC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730187930;
	bh=lzGljC/ZHtwwu+8fGFwKsvJGGmaSuUo55Re0rQZx0ss=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pTeVbBTa0F5xN+qrgUqGWSpg66QYzqy6IH4NlfMG6Q8blDwXxLIgBARfIi8BjKXmb
	 tafRqjQ05rwI/EKp0eOAWymrEGE3MevTV9cMPU+BYC9jsytbKlLsGFLmMoUmUo2hEy
	 fDRwnCkxnW8pIbDyWPjFZroVHBuQ2YtMWurXCuCbFJHAFlUmZuFIVEnW3vF0/CwDwq
	 /YmWOjl11NRjH0a3Dzh2BI205vLeH2zkI6PP4ROazxhk/kIgFJoqP9XKlcdeDJXZ19
	 BxX3l8t/Ubdq5tt3VKiFzyu+hWDHKRwoU91frKVmgnoonWRhWs8bti+a/uHZMdRX7I
	 iD61xynjXX8QQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6FA07C53BBF; Tue, 29 Oct 2024 07:45:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219404] mt7922: bluetooth can't find any devices
Date: Tue, 29 Oct 2024 07:45:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: g.wenzel@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DISTRO_KERNEL
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219404-62941-gJNuiVVZ8t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219404-62941@https.bugzilla.kernel.org/>
References: <bug-219404-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219404

Georg (g.wenzel@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DISTRO_KERNEL

--- Comment #3 from Georg (g.wenzel@gmail.com) ---
Thanks, fixed in version 6.11.5.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
