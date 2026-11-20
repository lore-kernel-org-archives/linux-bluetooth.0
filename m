Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795151744;
	b=oGeL85p5+rZ/UO4999DCC02z0eSFvCqXE0HbdREYWrKxkatTgO06RDYeYBW5jwJLaWF4
	 wsQtAVaVSpyIADwNjprfiDL/sE+OGPyqWcvKIB2rABH4aG5TRxPJQnLUoaMN/q8r/xYdr
	 IyJt+i+5cF3GOVp60R/0myg1rEI3rHnHdYcRbhuImPmBG+cEaXAc5stdfjjEv75nJHGO/
	 wvKQ1U+Fbu+pVWWBQBu1CxTS1Af8zrcQuSaK+CfdFj7kFRgscSEn8XlqPkWho9lYl4Ro4
	 0a1bU+1slm6rPk1KLaSEPuuHN//dYY5bRe1dQRiINQrG3BklAUrYduDzMxOWRCLrKyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795151744;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=OrWVFCYpkQPb/7iZfx+naK76HHwQHsJ2DfbmtbbkUmM=;
	b=eWjwvY3yeeSWAnrZM+/lfzmUjHhMsDE8+WRVo1zHoqtYHKeCP14AcRsz8vQm1PQ8qWEx
	 /quHQuxikonbMAWrG7qTxdXgWoz7f8Eo4oDHWTl/FXMS1w3PUaCbOc10Qy8LlGI04WFK0
	 xXxgP42InpJKHk03cOBTgbthIIDOFLses46opRWgOccGpDpwBfgt5ECLHztCxcEBVSkMG
	 wYqtE8pzY1WcZZ+2PZLvUDMUA9I8cEKG3SBD/AWCWrnlDbuaJblpqTpceGqYYF4hLrPNL
	 uw2p2O6r79BD3X7AOywhc+L1sU5+iv1ZYVN4nuHEvMernP3SDcxNsE2NggF86vezs+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At8bCCGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78B606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At8bCCGr
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF1DE1F000EB
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 05:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795151743;
	bh=OrWVFCYpkQPb/7iZfx+naK76HHwQHsJ2DfbmtbbkUmM=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=At8bCCGry10pVpIVaszo9feOahC3rGYQK153mtsXpHClFh6DYgVvLmmFCxX4V46hd
	 3SQiBjPM25R+HgF5KmLrsWpYa52RfZFxApQCLwWkvS30pDSgmxT8ybwUJCDUGaLNLn
	 UqmR/ixnmfHHn+dbgzYgQL3WNU+Y6MJhMXXUP9YDW2HvsTihvtV7E2CPxV79N7jxeo
	 mVBTLxURQne+xAoaJdHifIv4YoG2u6sf0GKaLO7xS8B1Fz/Np0rTnsWxOPojvgo2iQ
	 YehBorVQUAV2CatdkNlQEYpNbZDYUkXz7ahpKWies8uXA415N5Wwh7IGHuBepWcCQW
	 nkQ5Fd2qmwSoQ==
Received: by aws-us-west-2-korg-bugzilla-alma10-1.codeaurora.org (Postfix, from userid 48)
	id ABC5C240040E; Fri, 20 Nov 2026 05:15:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Fri, 20 Nov 2026 05:15:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219387-62941-fKFbbyJFZA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

--- Comment #16 from cheako+kernel_org@mikemestnik.net ---
The issue with this bug was that if your vend/prod ID was not in the list, =
it
wouldn't work and there was no way to tell the driver to "Force detection f=
or
this `new` product ID."  As I've said, instead of recompiling with a new ta=
ble
of IDs...  I just edited the binary module replacing one of the other IDs a=
nd
now I'm just not updating the kernel until a driver with the aforementioned
module option is added, or my ID is added to the table.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
