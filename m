Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB81C5D50
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Apr 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744452943; cv=none; b=a3oFfbqee+rk3g4SJ4zt5YgTK25BxsZe7EkKyZ0RJpCLY80ZIp8nZoEdDuRov3ZXdAjlghGoZt2dfScUE/FeoQUp47XX60NexskV/67utdlrZBWya3RVH7Pwca3V+wyqiOto2sp23FmqCofel1w/hdwhzr+eb+T70Kx/3TeNa+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744452943; c=relaxed/simple;
	bh=PRIWM0rK2GnqGqe6aWy4e2OMaUCt9w3PuXvMh4yh5Ho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ps5+P1HwwnMhfOVwpvd6V4F5zbFyrjJ7vbs3COB+p7gd0P5FjL5vqjPWHSO+eQQ7MCVa30fteXRJGbXK/qxzVxiMQoP1JwjwqIpf54rsaqiM/NYH/x2P4NURPUF+rwDQyXQbcRsSgsYf0wAglMVQPhm1Qqmo1rb+TLaB9B3hYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFDRafhz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFDRafhz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 101ADC4CEEA
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Apr 2025 10:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744452943;
	bh=PRIWM0rK2GnqGqe6aWy4e2OMaUCt9w3PuXvMh4yh5Ho=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fFDRafhztH0RnyZGirUEoGzLlXP8TELYEsdnx/GAmBCq5sbkWfZWGlsw3+zq42lO7
	 jWhhv0VtV6xOSWrZG9UqmYti9ulc+6B3yHu+nU17AtpsPMz7wb80jB8HYfNex+Vndj
	 e4+zBf38p/M+i8Qc96bEojq36Ei8bSfds4uYrCXWCccYG5xferbTDkzShDyq25tn/6
	 dLCG5MANSBD+jMHf7ZvhPVhbos0pUuCB+SuLuMoEwL1evGQlWhuDFH+5o9I2gqXP8a
	 XteDFGZS6sH7viiHTgvkfLu9jblZJtOg9pwsOd6nLYOsMDATLBwTKqDUBX1WKERZ30
	 QmzHZ6/CCDI+Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 070F2C41614; Sat, 12 Apr 2025 10:15:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217256] 0bda:b00a Realtek Bluetooth 4.2 adapter disappears
 after suspend
Date: Sat, 12 Apr 2025 10:15:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217256-62941-7Vph4JARIZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217256-62941@https.bugzilla.kernel.org/>
References: <bug-217256-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217256

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
Is this still an issue in 6.14.2?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
