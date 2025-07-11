Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D12D3A68
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246071; cv=none; b=SHzwNanlE/H8VXRhCATYVHgqyBcKK3SaTgg0WpxUseQ/kIQNlVABysouEKSuOef3HzhTl5K19+eBmBD1eIKWYlbHP/S9o4B5v8SDC6Yh11boPA0zdr+SemFQTDU97xJX77AiN8gfL0TfT4pHwKn5eLZc41dNCscvXJaDyvUHqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246071; c=relaxed/simple;
	bh=1nIEW3MYHhyt8fws0OhGHq7FiYbtrVnvdWNh2wgjYiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPRtJo4WISb54LuRS1IsAcmJdADZfczr7bbSWQGqyVOYkaEER9wr6+SiTQehcGTh3mN0k/u0f4AvPesEGXuEmHny50xU9yfdTaN353IzdJr8UIdrk7T6GnvLIutsxzLoSQViMV2Qkcg+fsS/lqDOxuo553mcR3XXpPVO+YECNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJJmeM74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJJmeM74"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B97FEC4CEF0
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752246070;
	bh=1nIEW3MYHhyt8fws0OhGHq7FiYbtrVnvdWNh2wgjYiI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gJJmeM74A7GevwnPtzC3TlaLFCJTSLVtULW1NSniDbS7I9ex4tB1SJYkVIrjUflZ/
	 bi+Ra8lxqIA4RgnYK7lP2K7jHTXc+b3hgxTCwbTeXceziPCrscNcbYFnzL1OHT24Fw
	 Jn31TIfu2+zIlQfW+qh1WjAzAIRQuThw0Wh+aY7sAJDCG8GHyC1H2KgHnYm9/n2cwF
	 FzMZhYReDgD4SggdVUy/MpVg3pL+fc/M5AWwS991y+Y8wnM10grS9kolh5O5vBYM9L
	 adk3CLUz+3CzkAs99fplCOF5qr5fTehs2Q34VWukX8Gs82SlYPETYvKynAk7PQG7V7
	 ZQrw3UdrRLX+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9EE3DC433E1; Fri, 11 Jul 2025 15:01:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] bluetooth and wireplumber stop working after some time
 - dmesg report BUG
Date: Fri, 11 Jul 2025 15:01:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218952-62941-pjFU5CuEWZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218952-62941@https.bugzilla.kernel.org/>
References: <bug-218952-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218952

--- Comment #6 from Martin Hignett (martin@hignett.net) ---
I forgot to add: I'm running OpenSuSE Tumbleweed.

martin@localhost:~> uname -a
Linux localhost.localdomain 6.15.5-1-default #1 SMP PREEMPT_DYNAMIC Sun Jul=
  6
18:09:53 UTC 2025 (478c062) x86_64 x86_64 x86_64 GNU/Linux

Desktop is KDE 6.4.2 with Qt 6.9.1. I'm using systemd-boot instead of grub.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
