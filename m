Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0623BE
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497993; cv=none; b=RYYdvAcTA09PRn0bCzGK7qw8beJv/boj90Razjvk3NuFsqrYOfl6/uH2Q1Psbu8BnosSjnUjJ33FX6igblLOLL7Pl/VkX2WG3EpbH8voo4JSWEmGDg+kWUB+jX3MvBBncDkkUZHN7T3AoKbg9frJ32iKtaVW8xcycPb08sbgOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497993; c=relaxed/simple;
	bh=daWVEAN1q3q/ZZLiz6KELSEoBkdFvPdeVSmTxxMc6iY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T7Dd1df50XFBR2SMLtzy29528HDka5l75z4/4427Ilmg+P+dl38eUMeOq32YzZa2/DFjlySFmaReKW8WpsB1XzYjqOenB0ZfNcsrQaIPYEKR8E1ik492ryUUF+tq90KOO2OhUEORIWIudWweelltbZ0lUHvF33c1BTElcYyKcbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQ7yXG/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQ7yXG/W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95CA6C4CECF
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497992;
	bh=daWVEAN1q3q/ZZLiz6KELSEoBkdFvPdeVSmTxxMc6iY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pQ7yXG/WMGpWwHDrq7dorTISwDFNgWa41Nx4Ub0s12vIUKmTVxCyo3DcFvHIS9j5/
	 s+gj3pCGVrEi4lodcdeyFCzFk6uUsWuUFBrLfchdCG25QjEcPRNM1I1Yjr2lOgqCBh
	 rMoY4IbylVNhQ33BVO09nZOAqwRYRzuAT+d3cweLUYJO8/zR1+PeIRsn5Ao7uFyx7p
	 gd4poKpJdJ3lS8CQDgquvcnmkI/HrU60sm3semCyMjYdXXHiXXOJASSIXHXs5Q3234
	 wAk/see0Zg6MqNgJ/yc/cyUbdl4RTKvsQ1souNUBmgeWWr8RWO4yLXrGVEq0bVtgXr
	 oXaHMLAzcwD+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 81E05C53BBF; Wed,  9 Oct 2024 18:19:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Wed, 09 Oct 2024 18:19:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219365-62941-YWjFkFjaUs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219365-62941@https.bugzilla.kernel.org/>
References: <bug-219365-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

--- Comment #5 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Crap, looks like these old CSR dongle don't really handle the
ZPL/sort-transfers, so we will likely need some workaround for these, most
likely a new quirk.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
