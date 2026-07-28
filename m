Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5FD471417
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264970; cv=none; b=LbNufzFE8rJqPHB/93yTLrAy5t7Wr9JNERbySl35TKXZHygcFGl2DxqO9mCnUlRTG8VwUZV/BBHZro3sMgHiESNJKMUqdjOZGVRJK4S0Fqv6Mc9OFUIilH7e/dQCjyEwih4VUaTW75ipEXOR4qzKx4J1svoDs0tzzTID215L0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264970; c=relaxed/simple;
	bh=KYkZKvMn57vTy2c1Hamkq7awx3C6FibBhU2i+bEDuhA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MuUSamyu3DLpw4V5EPcyU9l6QxQpoEFtiH/aMyzC5M4qKIdIzalOygLiIekAKt7tZty2KPi1u5K9HQI1tQiJPICADFXo/ndPO17X4oOZIryGuxI5GZeaH0BCixxSwxtIUX0asJf//IBpAu224XlI3u3mm7LOF5huUBg25b+Nlfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myqyT/Mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myqyT/Mk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFB37C2BCC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785264969;
	bh=KYkZKvMn57vTy2c1Hamkq7awx3C6FibBhU2i+bEDuhA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=myqyT/MkWiQx4/Mz7BmkxM4VtQWR45eXuH7IFS+Nx6N9nzUQHr/fjvwz+k2ogB2so
	 1gQvbVmbhJnQ8BAw0WcCpjjDDc24TfsPfhKl7BtHwcrYPwPLyeiB9DuMA3v/5dO10M
	 zp4zAJg4j1kkkHkA1Ryd44YjRhX2rfF2n4skh2y/EQuYGRfTGeze7CWEjnXKdM74GV
	 Kkwik5FFYBVTDDCZQow/suT4w5NmcdqZfDbsZL7dzV3sL2xQo54ifnqIWor8ExMdXp
	 4evtC72xVqOOWuWKP4fXviNAsxGlw8MKw7nxVKL1g6MlUaDX4GTj/LPfYagNEsRn8M
	 iCTc6oqqZf9Nw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0261C433E1; Tue, 28 Jul 2026 18:56:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221783] Bluetooth: new-device pairing consistently fails on
 Intel AX211 due to ~20s delay between connect and Authentication Requested
 (WiFi/BT coexistence?)
Date: Tue, 28 Jul 2026 18:56:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: galagann@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221783-62941-ze21WVx9g7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221783-62941@https.bugzilla.kernel.org/>
References: <bug-221783-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221783

--- Comment #2 from GaLaGaNN (galagann@gmail.com) ---
Hello, it used to work fine; I=E2=80=99m on rolling release. It was when I =
switched to
kernel 7.1.3-1 that I noticed the problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
