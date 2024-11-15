Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139F188015
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668440; cv=none; b=SQrwyp5Qhm1IoJWG0HlERFDZ0LQ5M1qoNnDYsj6TSmTF0L+9QOJynECvMgvObOS/bsXWC7fVGy5CUakDdTRzCAa0v0RWFFg9P4T7CeszrO5maWEu10lP7SiSxLT7PPXyrEeqfJLgHjZ2zHzvHfo2mhNelX8MO3pVbDNHKBqILGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668440; c=relaxed/simple;
	bh=K5pLV4foVSoh92ZHhNOyd31DCThsHj5oOpkAKZc5MSw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8yoFzr3ENixoCUU6jaYZgas6O4gFB7CiePZXN3XL9XPMXCBv4WwGbpXDrd3GjwrXm1JZLEdL0q4Ltmo62r0LnDfPSNWp/7SGjdIz9nupym2kC1jMK92jLy1v4s7WU04qTrpGDYxMa5Ej1tWeICRomIP6EpDl9aJ9y61PXXtNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAr4G5yA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAr4G5yA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F237C4CECF
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 11:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731668439;
	bh=K5pLV4foVSoh92ZHhNOyd31DCThsHj5oOpkAKZc5MSw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HAr4G5yAEQDsNFFowCsVz7g/nZljCcaoFKDKAgIlD3TlQ3QRLUWYhcx4ol29DzApW
	 Dri7VICO659ZpWSbWOJ4+zU/d78Y/Ho0F48Aj3QQwdYU2UWwoHnlVlb5YE7tSjpx+D
	 fTjOHnQsrE/ti4wc4B1dOBhxcQy2yB1r/I1hma7I/GDAdTJQKJ26M5GPdRnkz+XryS
	 TZcTa/iOc3SR3Q1bPi2ZzraAxvKXP2vgAlNBpTXcy4chlZej8vCH3nOwpfdsk5KtuK
	 jQoxORGy/RaL+hZgdTw05MyY7s4x7d6Y0EydX5rfGjv5zic09bcxtY/omljdCnvgMZ
	 xEgJYVHz7E09Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 97029CAB781; Fri, 15 Nov 2024 11:00:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219494] Mediatek MT7921U WIFI + bluetooth USB Dongle - System
 Crash - Cold Boot
Date: Fri, 15 Nov 2024 11:00:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219494-62941-FkPxlPNqTZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219494-62941@https.bugzilla.kernel.org/>
References: <bug-219494-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219494

--- Comment #4 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Could you also try reverting ccfc8948d7e4? And checking if switching to the
older firmware package helps? If neither, then this is a different issue =
=E2=80=93 and
you might need to bisect it to get the developer's attention.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
