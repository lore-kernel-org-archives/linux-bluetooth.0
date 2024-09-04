Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077661DA2F7
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456386; cv=none; b=meRWr9VsNSXoRCpcyqPsLkmREwMAsUVv/d4NEGtYa5HreRlcj0vHp5RzzpQfWVl+6ugeqBJaRPBMdaaUFd0SMd74EpPLmsImeYC5AZbEy2kZ/nqSL7BOwmemid8CN19K7NixYLFd5UuML6qRNEBndfg7mgKjwi9WUaVZTFzWEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456386; c=relaxed/simple;
	bh=aLAaR4znabY7rOHqMAqot775DxezYoxbc+8CDERzYeY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=szKY754zwhbAyhKhS7NWhbvPj8xM9GVFifP/xrMgE5tx9rMThhxX8AToBMsv07/YBWWJIiSQyk9zxJ3CPZBnXjMledz82mH4XlK18RgChAFjGNNvJesIXkOc093sIO7V1pAmKIAXcUIy9yMlNAxobuyu4CLRb+IBn6CWZNyHDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFOJtuvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFOJtuvn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F808C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725456385;
	bh=aLAaR4znabY7rOHqMAqot775DxezYoxbc+8CDERzYeY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GFOJtuvnS/UY+8+poO/qS2YfX3kBUrEBTVG+L9YiKWb8GNTvn/Islf7lOW/LmUzrR
	 Sg74v/i90JlISQ73VZy//ZVG5ouGiqbIlWT05PrX1gi0OdbNl3WWDtdZuuoer0mP2C
	 YDMzyNh/+UKJk0GCOKA3O8scLbGB5KHr87CJdTBtgegIOWHwheX5YQKjTCg4rvVMVi
	 /jvAw/Ji0CKL11kojn2I97m4m+rfKy7tdgi6OWcBdCP51f2cDeix/Cu+l5qGOUiOIt
	 V/MvTpIIr25nVxwzZhfy3pMHddrWKHc9DIj0XgF71TwzIqhax4O82wPdZhiMV0iez6
	 1UQ18vCzW+ZuQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7F0DEC53B73; Wed,  4 Sep 2024 13:26:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219234] btusb: regression in rtl8761bu firmware
Date: Wed, 04 Sep 2024 13:26:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexander@tsoy.me
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219234-62941-AQQCWzi00T@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219234-62941@https.bugzilla.kernel.org/>
References: <bug-219234-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219234

Alexander Tsoy (alexander@tsoy.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #2 from Alexander Tsoy (alexander@tsoy.me) ---
I'll try to submit updated firmware to linux-firmware

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
