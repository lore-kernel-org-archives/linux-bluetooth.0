Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8E14B83F
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631974; cv=none; b=F4d06L22Xg4FEsOBZnrS6LLYsWVZW6xGMpmmp43kfSuhNdnOVSarkxxWJ/mQsBbele7dgYwt+yf8wmARlgn/+07iUneDZrAvbZhIxS/pVtLJ+5VsZVlHJyC36s+USeKRsrhmFOqq5ZyE/gY1uaCpFZZLuwRoYlLJGQMe+f5NHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631974; c=relaxed/simple;
	bh=43+tBd5DIlK5+2TmaF2YYYvq3n+qwqXG+bn2FLeEvHw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mL09r/tUk2o81R8EtkHFO8GMRB4DhCo+kkTkfCejBaRtJn5nWYjd3Mtouzc8at1XIAg9+DConaqJEC9QDu2FlPmivg1U9Kk9ZehDUv9Kh6+20QhCPOKqxpFDMidoK3kg1ktXKHSLhAt3fCk6nDPWU8EIgd3MK4CcGYz6GQQHU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCTsF+HV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCTsF+HV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A48BCC43394
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708631973;
	bh=43+tBd5DIlK5+2TmaF2YYYvq3n+qwqXG+bn2FLeEvHw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jCTsF+HV/iOwvKkYwJ9zIQfdD+ONev7vKcIuqau8zsyX58qH74wLt4Xhmxq0l/9+E
	 wORSh67JGNVYW0bwMTgHZ6/9qJOl0WtvFiaSZg8W9O4dRr3jnRTl9bTy6sV+i/Mcr9
	 c/PBmc4x9T6ruTJYJzTO0kyjc/TSr24ZJQJJYX26AF0V267phD/Eaj4Ybz6CtxsvbX
	 sbxlSX0zz64ZC9OW7eA/jPDHG+AVhEEi/tHQjwiG0d5PS2B34bxHqU4nVeRdcPcMrA
	 sQw4Toe2eNdILIqtOA77PMNO0jUHmNcrZ7wB0jcqCS6XYZtt9BiFqlDXvvnuZadyXe
	 2faqMhdyyMhhA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9458EC53BD0; Thu, 22 Feb 2024 19:59:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date: Thu, 22 Feb 2024 19:59:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aayuspatre@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-4oSrTLZMe6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

5vr (aayuspatre@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aayuspatre@gmail.com

--- Comment #278 from 5vr (aayuspatre@gmail.com) ---
(In reply to Henrique Lechner from comment #277)
> My bluetooth USB device: Baseus BA04
>=20
> lsusb:
> Bus 003 Device 012: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle (HCI mode)
>=20
> Kernel with the problem: 6.7.4
> Kernel without the problem: 6.1.77 (installed via AUR: linux-lts61)
>=20
>=20
> When I tried with kernel 6.1 to connect to my PS5 controller already pair=
ed
> with the kernel 6.7 it do not work, once I removed it and re-paired it did
> work.
>=20
> Once the pair was done on kernel 6.1 I could go back to 6.7 and it connec=
ted
> without issue.

Could you see Bluetooth devices pop up already before doing that?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
