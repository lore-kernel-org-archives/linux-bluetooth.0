Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ABA15622E
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jan 2025 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735973311; cv=none; b=I9bduosp/WKLBYz/thJVZaAhN+b1wH7U2E8q/axfmbTBVaQTDSw1YpEBNpQ6yZNLu25Q9pln0rI21mIiOn8NYNTdZud6a98upllXrGaKR7BJXUpPqZkqOGWMB6JkIscbouCbcoROIEiPFuLmK/fVryyFKXdVQbFQkeEKzbmUk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735973311; c=relaxed/simple;
	bh=424DxucYVqOV2zWcq8VdPeCjw4XasuQBUPxKMEe5y1s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScBrd5BnsbOWex56uEn11Qj6dQWrWsEl64ARoBcp0PWJbhbnjgu4yvG0lTGlM4UzZ2lql9ZBhdhU3SG2eC83etn3A3kZ+DSqXjDj1CtdZ1h22aDkzMjC/UYDnFJRK/xPBMK1jJlaze1enxCYt4IFpUus93fm2clkpPHQ6W3m8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6pMargW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6pMargW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC5CEC4CEE4
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jan 2025 06:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735973310;
	bh=424DxucYVqOV2zWcq8VdPeCjw4XasuQBUPxKMEe5y1s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y6pMargWKNTxpY6XBTDnAHTKUpxJRvOtiG/45DOIn+l6uWWiPsSPKe6Lj+DHBiguk
	 jbXAEdoLYE2e9ad2nka6i+cXwCUsLrxY5QMXC0X3SJEu/8zeISXBonfMPn6BDFVVpZ
	 XNdeJzjoCzxHNiEoDrJ3Ns0weCDKrq5M5LzGWbEEDCxhE1Cshy46tZ+NO6WOhM8WiL
	 dLp+ii/i0TNn3HO34lspmfg9z4QVmCJ1gO/eqEmrthnu6FUVYf4RX7Sc5osygUBK4f
	 UMcw+B4ZRAEwgQHVXhVmeAncoMylsm7BpJcrQCDdjv4y0sxc2On58g9oGTUVyJUNcO
	 QtXAYt2iNZ2DA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A3115C41614; Sat,  4 Jan 2025 06:48:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Sat, 04 Jan 2025 06:48:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: olivier@croquette.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-SuFHjU0OzZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #6 from Olivier Croquette (olivier@croquette.de) ---
Quick update: the workaround with rfill does not seem to work reliably for =
me.
I am left with not suspending, or using an old kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
