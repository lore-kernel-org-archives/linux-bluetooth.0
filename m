Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE673186
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220967; cv=none; b=WsSqJKrXUUlB8V1umuoTXFF2FsVfQ11DhlwvdTopPBoWHbZvGy7E9ytpHeULyiozVZIIvL/6eSOnjGzoaU3uS7FoLwHogbEA3xotLBK7sGdpBF5eAt449zunDjvw+JO9XGuYire3u6o6ItGr30ymG01S5K9eRS85Bvl3SrWlcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220967; c=relaxed/simple;
	bh=bYygI2VOT8AazDaDo8arJm9dxX5T6RVJsxIgZ39uaws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cf6wgoJiy/LriIkaeSK9VGz0wGuVOebSJCeI2xQkrIvW28US7Veii3GTghlQrAU3nEqj6GLgUdbi7Gan0VUlU9ZIyHyTknS9WOo68y3IZ9b+TSXijcXkfOo56oPTucvT/OBwLMh9kdYrN6uPKoYYJuFMqLwc5dSBvkgKdCmsGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLTB0fF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLTB0fF5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73CF9C43601
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712220966;
	bh=bYygI2VOT8AazDaDo8arJm9dxX5T6RVJsxIgZ39uaws=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kLTB0fF5erF50vrxf1Tjq7lMGH5MTq5FshJ0oY2Dr8cRDSVxz2p2qgwf5NsgkVSKN
	 yyI0xTlZa6T/KYNELsIX9Bk/EgSkGSh+pGNHDuFGY4klJTdYZQTo/3OGKvzRHMbulL
	 ACl9n4qcgR5UhcY4+xbCTh2Lng2fjeA+5WcapLTPRmXEUbpJGHZPZ86cwEoHbX6UXj
	 WMKPdD/kYNxxs6fjeKZzC9ZjJYAHtSq16LqggLccgLMeDGY1yLyJK9W50NiaimOErb
	 WevQ6DfLmTIgPfQiwF6pYSfTHINAv2Snd8dV60u9CtRfvGmd/29cj+6loosTWrhY9C
	 NbaFLPisff2hg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6D2E7C53BD7; Thu,  4 Apr 2024 08:56:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 04 Apr 2024 08:56:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-AZaWmPunET@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #24 from Gurenko Alex (agurenko@protonmail.com) ---
So far so good on my end with 6.8.3, thank you everyone

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
