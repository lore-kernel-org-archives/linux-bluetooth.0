Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319541D224
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530011; cv=none; b=OfNHT94S4fza4dO1ahbMa7flgSTf32VX3GNmY/4f4/iYK7Ty360cCzQTOUzROsdlHSZeOLVkgEd5eXB+39sDieNhzKUJspzkMWTUOiJ9mEHc5k7NZ7Trncz93H3io2WcyJDbqhuhwBqwvjCJbwBrXKe8PK7dmN+CbwvHUlnNQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530011; c=relaxed/simple;
	bh=tcq90IQWdjYeQwTCuqTNceXh1/niKD2AO7rIzhdbY7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EaaUb+f2AjHTpSLhzgKBMaaK4fV5pv9CwDa6ZmB+m2d9GFUSrRxaj/vPxbdLgKfUh1foEr3wY5dd9zFurkohWaVFtcOoqCUsnMD75gWfI1g0AhcJjpFfiK/+Fz2JC5UCgyJ/JOBpRCAf7hlyDuNL27iKzyUQGx5QzByWsizGIdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3ONZLJc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3ONZLJc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DED2DC2BCB9
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786530010;
	bh=tcq90IQWdjYeQwTCuqTNceXh1/niKD2AO7rIzhdbY7o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M3ONZLJcEd6jgVQo4r92VLRE4ksqr4X7rgj2rcNhv3/KSHRUihC2pZkFnb+ds07JV
	 RI/pTWyUxGthlrIYrsA33/LzF3GmmzBkmw4fCEvBAIyIRDxSO2PEh3ZZPVW5UZ7KB1
	 EhhA8aNUyXBDtHjjd0pjB2GB3FmNzWMGuMCjQXh5BYbWY3QBv5OLo3LU8wLHdoT6ME
	 QP16HR5hO5MsdzCOpqv8UEypbO/1viY5O7Z1iEjfbGRLW24sulyOeaJp4l0GPK2IYq
	 PCVdm8vc1RQq2diiKySD0ocn/UHdayeIottWO6T60DMz4LLTxbjm+B43LhD/fDqVEm
	 IAptSG4jPunEQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C36EDC41612; Wed, 12 Aug 2026 10:20:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Wed, 12 Aug 2026 10:20:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: rohanasrani3@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221837-62941-c0RmvExZZC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

--- Comment #10 from Rohan (rohanasrani3@gmail.com) ---
I'm sorry I'm not that familiar with Kernel lingo but from what I understoo=
d, I
think the issue may be related as our Laptop model/specifications and the
controller reports are identical. I even checked out other forums in the
meantime and it seems like its an actual unsolved problem. Could you please
tell if the patch is around the corner?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
