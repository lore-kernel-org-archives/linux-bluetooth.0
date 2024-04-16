Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298912A172
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270378; cv=none; b=AGE+nHImDuoi11B9KmhE0anRT6rGjJ8Kxe8K4w0w6NVXY/+W+P+leu3GoO+1BbFjZSo+aeTH9I6WXOAn5vYFrAoSffpuq/XVaF9Bg1dI/a3vGnbh7E3DqUR2TQbVU6fO+bPPmrPR5FteMBkplAQD8i2NQj3Fe0PTtoVqd5jjo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270378; c=relaxed/simple;
	bh=UWFuerOdlQQ7Qy980RQ5z4YhhJrkCpuGFFLFATc3SoU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=shNc20diM8etLmAnlRdoGOGuriDqwXRs9d1RE8zHxuah+uRhpEepRr5WFmvbWfODwafqyGMH8gVMi30Qb/PPK34iOQXBkGiqv7IZ0G1C3BK5DIdYclQC6TwfM1dwdk4WICIvH3IgZx1q0nO3AP+1LYIIMJVB0cXWxSpP32CkwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvO3YIuG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvO3YIuG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42814C2BD10
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713270378;
	bh=UWFuerOdlQQ7Qy980RQ5z4YhhJrkCpuGFFLFATc3SoU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BvO3YIuG1dXdAeSoa7AAIEvFzDO7lKJnzYJhz/ILD65wkuKVpJH5Lq+Qtf48n0EAJ
	 Y7JGd7DxfKtvtPLhLdl8ZC4/Lr+EPWthnqdgiKHFkFqG0pNQ0StN7kydA9RqSbV6+e
	 eRewUQqLuKgSJhJxZ/hJLtKFQAWYJCWdLbspdbPEBJy7XbrdIt8rogi+WhzPWc8lXB
	 m0xkJui15ejQpOjVJ3I0LamOqTS+d0bHfOC2MB5Y8rHICFEXGhUUOtGl8pM358FWaj
	 Jf8V0UcGxalHU9mjmaFYTw/yuB1PQ6ZGlMCH5QaP83KOko341HA9DQ+c2HszJ0YXZO
	 Csf0jkMVj3EUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2EA5CC433DE; Tue, 16 Apr 2024 12:26:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 12:26:18 +0000
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
Message-ID: <bug-218726-62941-GdAvSWolwf@https.bugzilla.kernel.org/>
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

--- Comment #23 from Wren Turkal (wt@penguintechs.org) ---
Apparently getting that log is not going to be as easy as I thought. I trie=
d to
capture it from systemd journal on the next boot, but for some reason the l=
og
appears to be incomplete.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
