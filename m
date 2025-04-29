Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436CF1D88A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910481; cv=none; b=Uo/UOH7hZkGIvCln8CYqOc8g7HNCZdO61fYI0ehChgwr+fJTmIDYKYa+CwZUAXVA3YxPaNgzbvlLLxdspmeFwGhGQrvW9gd5ZZoRD+iRaOJkD4YtvUkGy5oGgloLqjGR/zv5Jef+8NKtvZGqadJIJzgKfz9OCU2X5FDkHFlXPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910481; c=relaxed/simple;
	bh=Kr+pcBa1Gzl0s8c89DwTNkGlfqRd0fdCxUpZMgAJ1Po=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CwABIFXmJ61LKTAl4497QLHVZ8LC1nABe0aFlC+uIW4WKfrvfBUcvoj9oCzk4lmU7YqotPMeP5m7dvHuzoW8ePEOxy6kU/1P/Hm3JkIXjh4iDgg+9mgSPkTALVWYyOD0gozZpO6m7KhMq+q7ewSi2ucsUtnf407ReQ5yrXGl0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1okTiQ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1okTiQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADC8BC4CEED
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 07:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745910480;
	bh=Kr+pcBa1Gzl0s8c89DwTNkGlfqRd0fdCxUpZMgAJ1Po=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O1okTiQ6uP4IkerVqlGC+FTHUM4WQV+L24OMG3WNBja86VJPf2t+Phvi26wWe9nBK
	 Oj651VdYEIdQ7lyuFV6agpvTL70nHprinyVjywByMETLO0Q1P2aCl056r5ELUpN5Up
	 mIXnF0Ss4KG2HXKBreOOo44daaxvQGEIHUBXz0+Lxh1J9JVR0GolD5vraFJUJpWCv3
	 uxaPTv6gwFRF0fSbZ1cf8DOj1aT6zkxXgLEfNtRk/VOakBZHeEfQJ0QcaszoZ9ja6H
	 Wc9vV+m2JQX7rEgXmjAJxLjk7RB/jb5C5W1K9hkcKnQnGFvy5HHhxcYCWhSg/DOvTa
	 748/yG7zQ0V2Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A0BEFC41612; Tue, 29 Apr 2025 07:08:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Tue, 29 Apr 2025 07:08:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: frederic.danis@collabora.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220061-62941-1F5kij5UCD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

frederic.danis@collabora.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |frederic.danis@collabora.co
                   |                            |m

--- Comment #2 from frederic.danis@collabora.com ---
Could you please share bluetoothd logs and HCI logs (by running 'btmon -w
/tmp/btsnoop.log')?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
