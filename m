Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E8157A43
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239266; cv=none; b=GxHDRgo3q/8G3bEVkPdLjEvu2vSYrqySsNSq75Mj372ypuYZU8mSVbKPU59e5V53R4nCc7UAWUxKsK3zCbHFnSgEgtAhOGyAqepKjONqXoZvTjfifyJObPnB70U1D8UmCshndNQx4q1Up6RU57Cu01WLfKuzGgiNqH8OrT2m/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239266; c=relaxed/simple;
	bh=y2lBoTytvzCMgLFIfOt7MsidWEPwsJXjzTEV9zIOgTA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c79e+tYSGCUDOjlraklHNltIYbGp+WshDdvywOz/me3axuKcBhINv0wz4LtRqFr2GXYqKuIgPcIX94uiVadT5pto5pzUY6W5h1H46quKMmBMca4hdGVQLKFbNeznOHjNsglcVv3eyuV6Q1u8U4W0sFe93krChRoFnOtyPW/PypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sioTJ1UF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sioTJ1UF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D8ABC4AF0C
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724239266;
	bh=y2lBoTytvzCMgLFIfOt7MsidWEPwsJXjzTEV9zIOgTA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sioTJ1UFj++yon/IRCx6PiuqW0jecKr6njpddWD0InrQtGvWTf2iRgw8fZrVTkRwS
	 CsCUURa6pq5Gv4NYU0z9ulTTvLt/KR9pdlj+M6v9XztbjGU219n9y/wI9WMKlVA8gR
	 m9VMbzhROIMkkPsPaq5WU+ndpR3toJ/6waoEicU6RHWElmC1F+nx5P98z+Mikn+qvc
	 XCj4ENHTG5ZUKhdiRnwMgYrK/C38xCreHa+cFXUbj4mUPLB31owEED0pmT1DBQfwoP
	 JsgxwRQ+nLwJ+xHSuXMYxiZVywxx9tle+5ZhOLnh/Hk8gbbi0ov8wLRePRY52XqawY
	 jVIUu3Lj4Q72Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0BD87C53BA7; Wed, 21 Aug 2024 11:21:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219182] MT7925 new USBID 13d3:3608
Date: Wed, 21 Aug 2024 11:21:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pavel@noa-labs.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219182-62941-IEJV2UtBpX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219182-62941@https.bugzilla.kernel.org/>
References: <bug-219182-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219182

--- Comment #4 from Pavel (pavel@noa-labs.com) ---
https://patchwork.kernel.org/project/bluetooth/patch/20240821110856.22552-1=
-pavel@noa-labs.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
