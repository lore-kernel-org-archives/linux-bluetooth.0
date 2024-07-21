Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D682C95
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721597081; cv=none; b=aXfh0QdIOGNJDWN6hmQnPR7A1QATlwhTEOtbM8S1v/btiyljM46KQ7bJa6GTvHPo0ZfZyJ5jLjkl98XdsUsZpvxxerANZxPySKa3EQyZ/uZP3iNjw0FJ9T7+OkIzY9UFreHxsc0xtO36cKhrUHIXWO9qzPeqA555qkyIqgjfsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721597081; c=relaxed/simple;
	bh=6WHeeWViOPeEdVljsGSRASo36EXZoM27h5XWPlzIvwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FymmWR2uLvE7mt0QitkyKjs/4ko8PO5Hwx+BTIRKm0Msb+Pz5inykhpEc4gLj5s4OM7tQzlk9GPS5tP/msIT6wEmerG0t/fMHhwt2EWAHOROXmOvEftVFlts0HNo5OwTO+h06V5Kg/02LgNZvcZncOJMe5wNbNo9V6ueoZvIe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDnte8Xt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDnte8Xt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ACA1C4AF0B
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 21:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721597081;
	bh=6WHeeWViOPeEdVljsGSRASo36EXZoM27h5XWPlzIvwc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uDnte8XtWR1DE3zyTAZ03aT40sEmA3GOX9QOzpbnjzs0DsixfvDs0e6MwfyY9bFG+
	 QiVxoJJBlQLynccvGqUTM2Y7itVkd1RWgMqV+y5gff9fvuAum8BCCEZwEbkCYdckS2
	 9JB9l/lnvk2PfGSLjFgHE4wNTAExfLPiSOx9iUO8Z/1/tUa8ZmLUufousn5xvY+PlO
	 UtuFsrRc/wmMuvEFaQofhBkR5jrRheDHaqrHVYEuIcVWuM6Cja9wKQEHgDQ8kRxZYp
	 0ZWE/OrS7Sopk/1cMHjUAxXd1g6YGmf2sEvF27QhCYiaBEHxds88lcV2/lcdCDtJzo
	 w5IfhV1oswkOA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 33820C53BB8; Sun, 21 Jul 2024 21:24:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Sun, 21 Jul 2024 21:24:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219057-62941-VhKcc3pfTl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

--- Comment #11 from Artem S. Tashkinov (aros@gmx.com) ---
You could try a solution posted here:
https://askubuntu.com/questions/1205962/bluetooth-dongle-problem

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
