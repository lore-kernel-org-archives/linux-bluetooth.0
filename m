Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99D1AB6D1
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342507; cv=none; b=u3wjqTnSea4Kl6dWavQi992WKFX6X6E3SjQDdeqoDnlo+Ulwjw3xHY963vp54PJ2Kae1g+MNzVYlZ5G+J6wD0mTq8Hp+0+TARJ06jeSRufIPte60pB2Us1yQHroC4OvdqeX8X55DOAQIpDbeUlsdjqH0/Vf8HVQm2c8NV90y/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342507; c=relaxed/simple;
	bh=OBKZU5vdCUJL/2GMwJl+7ISlYEMwgDC/RncMXMHKa8Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fy9fn3fhkCeLSX5iBJqiZBq+GxqYkS9aUkiAb8D2wAlaSR5CP19N2ulZyaa/5dAeh1xirYGbGfpw9rQqUPQHZ66A8yc5x78LhDMrSR1CGCETwXvl2ChtK2y7YexUt2NEs4KyNZc21xTqnFdJ3pw3tCZ78lVuFh1G8uxtD93NV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oixhSnNN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oixhSnNN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4129FC4CEC9
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727342507;
	bh=OBKZU5vdCUJL/2GMwJl+7ISlYEMwgDC/RncMXMHKa8Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oixhSnNNP66y3H4Kf4UzE0WGKPHN6NOy/8ZLv4/R1yKpK1Fyh0F8v0y3RVvI/mxEk
	 Kq15Jrni6xJu+H70LPIwYR5N138w4g6cTDqNDLilB47/u+ekB8FjvICN13nTQEAlzb
	 ATNVW4WwoPZ9Z23HV1UbK0B7CXAQHbhiIwHoYQLSxcT1AwznaMlu+J24iZp2d7xMJD
	 42pLeFnXiqlyJT0UgbXNFmEHWDxZDW0EDpMj3lsKVK9NysORzlKU66rkSHXMHKd7dH
	 neBNd0wD2BHKY+sCkYCWLCJsIvrH6hcLj6MIcnvoz3ktn6m3u+lpFdGed0akJ00iyK
	 IiMvTcQA5ef9A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3AF6FC53BC4; Thu, 26 Sep 2024 09:21:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] NULL dereference pointer in Bluetooth at boot
Date: Thu, 26 Sep 2024 09:21:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219294-62941-vLwikLat2v@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219294-62941@https.bugzilla.kernel.org/>
References: <bug-219294-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219294

--- Comment #4 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Forwarded:
https://lore.kernel.org/regressions/af319b4c-2417-4f2f-85d0-e72d1c4fb2ac@le=
emhuis.info/T/#u

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
