Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BB15466B
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215423; cv=none; b=scY9z1VHRk5nPshC0np2NF+0hPa7v/TxwHE3K4iAMWqjJMol0DC1aR/iAZebszwURAPBuIVwdX6C+jdtppXPwuWXXTe0p4uWEdUeyR0+cpRk8kXmRgflL8eSRvFRnncUDnEuu2UdqoMkuDMf2QLo/YDczQJ5fQ5h5uDbU7dt88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215423; c=relaxed/simple;
	bh=Gre5pbq9AK+Vm16pw+Otmann7CTqX+KqvbdsJIkaNOY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLMPxyftZWxNEC1AiBFFJvTO+Eppgs9A5Hq2BF9iq4PlY6iF8ej2J1UobftZRTJqCfsm5aVSH9n+eoSAP4VKXXa1UJvhdOSirSotT9J+HMmJ7fytYnF07BR40SiIGA3eIGlL9k+4S44CzyGVZxwZl5RZBHheb9agPJtgYkgllpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X53cVUHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X53cVUHz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73185C4CED1
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 01:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729215422;
	bh=Gre5pbq9AK+Vm16pw+Otmann7CTqX+KqvbdsJIkaNOY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X53cVUHzPt+tKz5rgTfMwli3VHoAhXrx8V44Y2UkbNwE8BiDm33vdtnbhHSvzjg/u
	 nBRRP27rt0mIpMxAL9yDdpbaCp0HEWlVx1djVjlM7CvQxktyXKfaxpK3H60jggzDcC
	 aK1m8m5TUkMZhvkVo9qMN2MIZ+VZcXWJe7P/XFXS+EBSTQCc4Ib6AE54Sck6vhmH0l
	 aiEXq7pqO7iIB8MrfsspCndH7PBSzFFVODqK9FzZVd5/SJi2K62MrfQU9gxWzLAtZy
	 4SIJ0rFzBerM4/VjMelBvOBPsWjkVAT4ys/x0QlPBTSADuErdpB6dOwdLWrAMKF04C
	 lXDmE/TV6fYSw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 66134C53BC4; Fri, 18 Oct 2024 01:37:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219385] BT mouse can not be found and/or connected in 6.12-rc3
Date: Fri, 18 Oct 2024 01:37:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjgolo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219385-62941-cJqmgBO0w5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219385-62941@https.bugzilla.kernel.org/>
References: <bug-219385-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219385

--- Comment #4 from Raymond Jay Golo (rjgolo@gmail.com) ---
(In reply to Luiz Von Dentz from comment #2)
> https://patchwork.kernel.org/project/bluetooth/patch/20241014202326.38155=
9-1-
> luiz.dentz@gmail.com/

I can confirm that the mentioned patch restored typical connection behaviour
for my BT keyboard and earbuds.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
