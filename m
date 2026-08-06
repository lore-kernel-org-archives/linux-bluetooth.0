Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBB25A2DD
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992490; cv=none; b=M/WAJgzRlFBRUvBKr+IIwTYY7wg8agtO+0SiLDPmc+d62QNCchz0yH9VnpfUg8rrcr67TE0DKv3N1wAQrFd39+Z8hPxekBokKUkdJi+Bz5bVjgGMcENPGTn5A+YndHRixTyv+mlmFGVxYnMASAuDap41njrjYUV61dM3/EW5LrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992490; c=relaxed/simple;
	bh=waSlOeOkrflYZv/ou3f7spCO1hMwIDVwyOk1SNrUqp8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OrtHuB0uERm7PPy8wgvCQzETqG2S/TwuvVw4Jp5cYWeYTQUMHGnLgkXoNpNNTsxgyYLxSlPJaDHD7C8CG4ob2UenIvlE6nHtTBt4011MGHfLYUaMErRYcf2lgjhkH0PJtwsCYJw2By6dmquc/hIWzaIsGaPW4obQj68POv5bx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgBBOJAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgBBOJAK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE79EC2BCF5
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 05:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785992490;
	bh=waSlOeOkrflYZv/ou3f7spCO1hMwIDVwyOk1SNrUqp8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LgBBOJAKileFBMQuyo1PrKTrxn2/NkIsFf7jYIECxp0KylSa1RZa6UX7S25MLV9Fk
	 wdB/0pd0rEuYaT9QmTUx/Jk3Xqdbsld3vP8TPlM3UhHkf+othscIWgFg8P0/Uye9Qm
	 lbFLJFwSKOn2fEhGRwRGc1vBTPLEROou/R3tpZifdVF4JqUeWY8MdW3lErkKUk5VZ0
	 0LC92ChMc4tEuA8qXBXwC2B9zpTbqAvUX6bSFZ60rh0x5Q98F+FJ2eK1dBuFkZcUnY
	 s+BYMPFcK/jHHNEujvvrjuymxcOQrsnxucy4/qpXRkILr+WDz59kHYh+IiUaI4V4kS
	 yUSwFVLMhh5Dg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 90553C3279F; Thu,  6 Aug 2026 05:01:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Thu, 06 Aug 2026 05:01:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: q23456yuiop@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221754-62941-5o9SVnwS8r@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

q234rty (q23456yuiop@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |q23456yuiop@gmail.com

--- Comment #8 from q234rty (q23456yuiop@gmail.com) ---
Please do not close this bug as resolved until a fix lands in the mainline
kernel :)

In fact, support for the new firmware format has already been submitted to =
the
kernel:
https://lore.kernel.org/linux-bluetooth/20260624053334.3151885-1-hildawu@re=
altek.com/

One can verify this by pulling in the patch and simply replacing
rtl8852bu_fw.bin with the rtl8852bd_mp_chip_new.dat file extracted from the
windows driver .exe, without doing any additional processing to the .dat fi=
le.

I assume realtek intends to submit the new firmware to linux-fimware.git af=
ter
the support code has been merged into the kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
