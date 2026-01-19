Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C54221F20
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833390; cv=none; b=Ki0tv3cdn4h8BHrjtG8z3YoQkP5P4KIaGT+HUkwvGzKmR5nN8mk1ci4D0zbuLDCKqd9LTKHgNR7lqKBzzxGFNRTVfJL60GlHPBa+gdpxaMs8xyMVJcFDdSaYuaPO3+KmOuXW9Yn+VLkRTWIdZxYI8KVfNvmHKvlmplYT4KoIGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833390; c=relaxed/simple;
	bh=rnUkthTjj2eIxbW2xbmekW+WY2aPM4lb0ORqG5vNWlU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T4MvhdF/VS8tpJkgFXq0zpeLEQt7zRYHFlMEV0kvWqIZuhWUtPM0nLOIreuvPYYCcSKg48uNrTZ5QpmQYDJ6QLqvq93hk56muagMhdPPZfFUtE2tzuOvt8aXVwfjqmpPiZWFBGgQgq7Lwm1FBvjMeyUOKqdaZ/yQ/VyFWPya6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/RT7mlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/RT7mlh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D86AC116C6
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833389;
	bh=rnUkthTjj2eIxbW2xbmekW+WY2aPM4lb0ORqG5vNWlU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W/RT7mlhFvY98xJUNO0Yg+rMb86CNcvK+mpYf5/r+On9GejiuOYSd3B8BGMd2f6Hl
	 x4qXnwBJVSdqTBsKzwIMv2l4Lv04yWuPmlUdfNsp22SiaLRhxBSSWORphLqWzn1p5r
	 KDLCfEI9/K/p/vveHT84hOYL3uYbAz1sNQd8iw341haSeEoGDTaynSodsYOcuQdHIy
	 rtKHG0FESG5BL092KKpRzQFurRKln3II50fZZGPpGuT3ntHdRjTcz6mQPvjCoYRkGD
	 +8gcN2OlHwvuH9gtZTKNthm2SC2ixHuYp5z4+54hm363+Zv/Y96ZFUXSLbORQ0xi+T
	 Ey1VURjj9qJ9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 917B3C3279F; Mon, 19 Jan 2026 14:36:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220990] hci_uart_bcm: BCM43341 on Intel Atom (serdev) fails
 init (MTU 0:0, DOWN RAW)
Date: Mon, 19 Jan 2026 14:36:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@emircanerkul.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220990-62941-XUXc1v2D6U@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220990-62941@https.bugzilla.kernel.org/>
References: <bug-220990-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220990

--- Comment #1 from Erkul (bugzilla@emircanerkul.com) ---
unfortunatelly nothing worked tried a lot of config files. DARK-XSW150.clm_=
blob
needed. But its really old device and they cant support. Not sure how to
restore bluetooth part..

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
