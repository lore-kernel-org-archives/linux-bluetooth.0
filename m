Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7993EBF3D
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771112563; cv=none; b=nAhm1nwGtXA+uLyVJtO6ptxM2AnI/jSM778Q5bylLZld/kYK8gmyINKP4T4zR4oVGHQsswt4MOznbK6hwGiCJJ4lCjfDM3hBfmiwSxr42qC4jizLp0eMvi/jbnC/jCgSsBUw0vOxBCckJ5IJE7xkms8uNOE8pO+GPefj56PfxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771112563; c=relaxed/simple;
	bh=zyF+5yZqG3CupQ09QK6JqKiCsttQRe+s8Fyux95Jl90=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RmAWgtPHi62M2aHj7jQeXV/JMVv8TfnhMyNhPaX/Q/gJi1XTHHQIk3glrTtrVfFoEm2uG1SZ9eE1AQ6woVmp//1p0u8lXLMxm/HZt2BBXBCeM/t2y307WTGf9M4EMQEAFGa17je920Ax55iUkND9wju03FS6Bi2dsoCN+0b1U8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQLm9k7O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQLm9k7O"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84EC0C16AAE
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771112562;
	bh=zyF+5yZqG3CupQ09QK6JqKiCsttQRe+s8Fyux95Jl90=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PQLm9k7OYzuA8Yyl7ipDooeS67NrkQnsrDzNDSm0jP2jjrBXkL72fZrHV+ZtqGhzm
	 uw4gmKGO9wV1fjPwiQh85uU0qcZluH4QV9mqQp1tqz61m91g0lwIjttCPhM7dr32gw
	 VbP0dT5Ge8MPP672cBun6B1I+ZuxdI2Nz3Mkr5cJnG+UOc0dXRtcxgDQin3mhFpjy+
	 WAbY+qXjdNfkjkBT5MViJDZsqTvl7cUc7IPN9kx1Ox7IPz2THJznHgdx6cqWyq7xWq
	 f8NgytgIx0bB1kYxq+YrX5bllw5aXxna2G+5SNlFte8Tig3mZjdQFFTwDZl7AA8BLp
	 NUIF5ivVqn6ng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 79987C3279F; Sat, 14 Feb 2026 23:42:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220815] btusb: Add Realtek RTL8852CE device ID (13d3:3612)
Date: Sat, 14 Feb 2026 23:42:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: danielzgtg.opensource@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220815-62941-TtylIoKjLF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220815-62941@https.bugzilla.kernel.org/>
References: <bug-220815-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220815

--- Comment #5 from Daniel Tang (danielzgtg.opensource@gmail.com) ---
Added in
https://github.com/torvalds/linux/commit/d9f7c39c6b7548bd70519b241b6c2d1bcc=
658d4b

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
