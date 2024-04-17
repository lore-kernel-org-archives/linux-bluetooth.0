Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462495D8F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342011; cv=none; b=T2Dy+cE3GZeLJq47jxxQyDSYbxGd5pi16iwBoRWhtQV1oqCW1kx4Mht+hqKrmUSW7In+zV/mbhqBbdmxbRvAVLvCEswstn9mQmAhE3Z4Lqd7C6wiUxq61G0fuGKBr1EDswj8l1QWoZGgPUSNTp2JKEepPZHD0Rs/GuT7MY5r8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342011; c=relaxed/simple;
	bh=7Kjz4PnutNXJPnTsFLIUGNcTlAYp1RmRDqwVfl07YbU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ewiChkyZ2Y34l3XlzzS3HK6q1dIOXEYz0esmdFEpmVQr3RG+Sds9ruSCZka5JwYs5FtBs9J+f0KY9jOVv8sFzdn9rdnAT/ovCYIyEKnH3eQcAJDq/MIIReU9ahUEPE7G7SL2biF1ZpfCEkgJgJtAhFFozbkeYWsZgAWWZfmmE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4zYgWhl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4zYgWhl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C44F1C072AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342010;
	bh=7Kjz4PnutNXJPnTsFLIUGNcTlAYp1RmRDqwVfl07YbU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F4zYgWhlTkMW8HIG5AmqxI0GtV21b6pSHdoVKq30CZ2xRJupgIDVTc4SHdF2ZHJ2g
	 UBIojgbzQRrHe7oTiCBKfnVyg5pJlaUi/DcbJalcFg+IB0TADkqCurctTx+XKQCTQf
	 rmXqVT9mktoYIdpGAOCdlnV3CmicbNg1xGT07o3joe+Huae4NREQAVlKk3HGUjtTbU
	 ZbiRWkHeEfBzmF4/SUK4XYtcwTSMCBpvPzAcBmLWk5rQ99DLHUxpEJvfa8IG4fEIwj
	 9f2mwmObxA4K/ZgTvYQpr0WovntSX9EavxYacwo/v3IT3Abei2jFGbvDgZ3YMatiOV
	 NvDYespxNwErA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BA627C433DE; Wed, 17 Apr 2024 08:20:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 08:20:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218726-62941-Qcf1OgPKfA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #26 from Wren Turkal (wt@penguintechs.org) ---
Created attachment 306172
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306172&action=3Dedit
00567f70051a41 + Zijun's 2 patches + cold_boot

This is a log from startup to shutdown of bluetooth-next/master + Zijin's
patches after a cold boot. Then I restart (for a warm boot next).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
