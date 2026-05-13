Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B613A3E7F
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702597; cv=none; b=VmVIIyF+MBs0dBzWnVXpnxwxCIWFApx9r+NNoE4/sMSFzdsUJ4WgqbvaXJ4CCbEMzAQJ9B8UFLsa+EyOnWTYhir7LTWG62NeoZohhGPoKgbvs/P76PmZr6DBtzC3nJjFuuJUWWr8lsBso+rLL2nbOClaftbOEN/sn+KdD+PXZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702597; c=relaxed/simple;
	bh=Ic08bwYerAtSKMUcbm2AGpz8zN74wEK2CHGKCprbHVQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WOD9VVoVekyp5KamP0JMjQ0CPEoaLO0NcPo/1gp2zVvArUsJ32drho4OhiNe8Ix7KZhaEaKll8HSz+GOeDi3CF0aA1iUBnjgruLhkJA4zxVcynmv4fWE8hVxUT80hrM43qeDCpGFgRfZQ379zRKKQ9WGJOivWxZl7IPjU9Nf4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQZOI0KL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQZOI0KL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05076C19425
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778702597;
	bh=Ic08bwYerAtSKMUcbm2AGpz8zN74wEK2CHGKCprbHVQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FQZOI0KLULKmyWEhM2/sAHL/0DenADK9/gS/otE8jqLgG0XDEYuEo7j4WxWyU0EaP
	 bj1z467lhgQWEBl7BHZaV1aBunGxkXlbGK+5aXDus7Wm7n40949g5h/tzMjMi6Y4tz
	 933eTUYLJavpgKAjSC6drdWpuFW1+9rFyNKVXzTD6Pe/rgRgj/QQBj8XmLUZDY79LW
	 nyb7Xr+3AG29dKK4wox5/lU2hyoG0O7tGFeSYHhfEVpV1pX1HYPj1SH2l9+EyGPNkw
	 UkxmChoGS8qZStRn1zXH1FD187PyvypMnYnOJNRQQvsCPfBIl2kaGKC6HYEKH6p6YC
	 8Ht1oyZtVFbJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E706EC433E1; Wed, 13 May 2026 20:03:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221511] MT7925  7.1 rc does not work, but it works in kernel
 7.0
Date: Wed, 13 May 2026 20:03:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: erpumper@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221511-62941-Q4jiBaiP2m@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221511-62941@https.bugzilla.kernel.org/>
References: <bug-221511-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221511

--- Comment #1 from erpumper@gmail.com ---
Created attachment 310115
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310115&action=3Dedit
MT7925  7.1 rc does not work, but it works in kernel 7.0

MT7925  7.1 rc does not work, but it works in kernel 7.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
