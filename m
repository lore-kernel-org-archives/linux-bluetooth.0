Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495063BF
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 May 2024 05:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716613888; cv=none; b=HFWvey1b9D7JJWhHheOKCKjG+mtmUbBlWcoVqVsKV4EsHNOsMXzP3sV3h7KgKojKYU3C5hyH3Iyc1eL6RU5ARfIFuodYlUB0Q8PNtO2yiuD31pNf8t+TqLPSDhdTdqXS5WRJTcOgeJtCEQiP4exSrqCjXGM1Kad3VpG6Dw+/pys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716613888; c=relaxed/simple;
	bh=vsobi3s5pyGPPC8gHpncoKfHYpg8ksJbVv7e7xTLoSs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CfDk8gRYlLtuiPQldbFKJ8uoksez0JDSrmAD9EhXuNl0w5IO/pyhzd+sOJR8E4/kDkVogFYpoWp5GT1j6geknxyK0ugquMidXjxPjg+5qWocqKvn/gpjcKgcsd0jWHFdJvJnHPFm//tFWVJ+qiGnG0ERz0KhOSTWnKhVW2LnSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWG0HNsH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWG0HNsH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C9DBC4AF09
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 May 2024 05:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716613887;
	bh=vsobi3s5pyGPPC8gHpncoKfHYpg8ksJbVv7e7xTLoSs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RWG0HNsHkt6d9sc5izsV1U9y1YufKEQWWM1cXDBC53BVj96LK1FFStPVc449bX9sM
	 UfUH8mZS7iJHiX9Kl9SHX6EGHzY7I9vui7wSNoiq6qplq+9rdHQVDrktVIWSTDaKsd
	 A07GrmW31x7Ckyg/kvy6InU7jlWKT5imk410dGGcHc/tRdQ0Szsy4k+UuRcpRcooIK
	 QrnWKHpkjsN1qlW06lQehtyaWpcmIKn//cOX1Kv9i0ggPKWDqURMMyQxdBIBr59VN9
	 HCUwuWa0qXrXqjkbHEFCqHk6aaTrRyaLKqAxjSxKLHdJkGvfklA7x5hGlQLw0D8WAJ
	 Feqef+TvXkE8A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 67F49C53BB9; Sat, 25 May 2024 05:11:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date: Sat, 25 May 2024 05:11:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-gMXltgL5uA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #58 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
@Harri, @George, reading the openSUSE report it sounds like *your* issue =
=E2=80=93 not
others commented here =E2=80=93 should be fixed in 5.16.1. Can you please c=
omment here
on the current state for some conclusion.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
