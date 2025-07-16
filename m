Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816121C19E
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679754; cv=none; b=LoIBHV22n31fVtIeVCLfte/C/UljXjMp0j9VSo//6vdUA2go65JDHUh6eEJRfaElQ/9eM20Q3Mgoeec2slhhXsC9tKGo0XazC2gMN7NBSge2mKncjdPtDxOEiaMRvvbKg5E86m6fCJPE4baegL3RL0VXjtc+UUPIIA+C9BFxtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679754; c=relaxed/simple;
	bh=vKkfBfs/uqauTl5dAKOtUR+Aw1Jn/AU6sfjQ2elBgTo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lrqlStUM1TI2ShHL8Mvqy8qgE4QSzMHCP9HERkI2j97lVgMPV3etyK9Rxl/SPYhe340ULXTxlMnlt+Krrq+ocKw1fgfhsDR/YZc9SxGU86xByUkVdhTTPGcX4f3tem7boQhZn8TR5WLjfOPC1+rszmmFv8pEwGM95q7hXCLGWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPHwNyXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPHwNyXj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42FA5C4CEF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679754;
	bh=vKkfBfs/uqauTl5dAKOtUR+Aw1Jn/AU6sfjQ2elBgTo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JPHwNyXjow9IpBTbqDC5Rf/Qz6Ey4CyfvASLisM643RLjHqes0Y6pJdSjnO1vc5VD
	 bADJKGUW49v+nTk/z6k1H8n4nhporU+iUfEyPrF4LE+PRo5DsYm2s5J8krtroBkIGY
	 8sofjDEY6KPF+vTBu1Okqi9zYOtvEFBwerul6FDGEDHnKWmSoXgsj4MhltcdpBgsve
	 gXX46uuyN7fOmg0ileWQ+F6F97TiyTmHARwzQLwNkxoucs6X+m+CN1qEtpYY26xujB
	 EVVKi9TnhMJ+tQ/JFcHVm1W4GJY7w3Rlnm0d5KMa6UZZ/qP5EjnHxVdKd4GJ3tM+HX
	 Bv6mU+VNL1/Cw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3ABAFC3279F; Wed, 16 Jul 2025 15:29:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Wed, 16 Jul 2025 15:29:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220341-62941-uSoehpbdaa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #9 from Martin Hignett (martin@hignett.net) ---
Created attachment 308382
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308382&action=3Dedit
Output from dmesg

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
