Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4D1A29F
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707572087; cv=none; b=fqdTtdnclol2UTPgSF+05ftHzm2F2o8pJNEUEuu6t5wuLsEGVZlgIQfeqT1Dqy9m/MfGR2IkgQIiJrcPWrxHmUuPQizREbedv09Y+cF6VPdF1G07Vzjto2JLdQqfV9R/yHZLbNDE+SgaibJYECNWmIr6CV/p+G/9qoLxYi1W6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707572087; c=relaxed/simple;
	bh=rnpNe+QaT3FeNzA79dzeKB381Jk4dlih3w7q6W4efx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jb6CMBxyPoPm96j+/9taTjqNpQ8xkwouVejifaffqmgqhX2Uycy/QZhCiC+tvJh0Zzdy8wPyt3a+oE8fIsENtt7+uTHcxN7i008h1kieyBw8QAQhhILd0sfljqVt5D9uoYx/0edW15tA0zOPTO8GwjrXZqiaQWRMLBqL18cgI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM9DfgJP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM9DfgJP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ADC3C433C7
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707572087;
	bh=rnpNe+QaT3FeNzA79dzeKB381Jk4dlih3w7q6W4efx0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NM9DfgJPLmgfD9MBq/Nl7DzTrsm4Pa23aExBt0gENn2B22D8ycY3Zve8hhLxe+yj4
	 3DYH2hlPb/DeaTrr/pa0a9nLke54BLWNYolKky5sm42tIUE8ZKX+nTRamJgTMR5p63
	 X3XqL+3D7sDNYo93IxdrI+Uo90CCi/IAkUXOWdY1a7gD6Yl+8gPohDLhxbBFxh4cNI
	 IU2fnE7MyRgtKaYyMuRJvBOvLo7oZr6HAxsyNa7FHHglwTxA6bc0kvoonDa9/lKAJU
	 8gogzdfK40mCL+0+bROSG3vFvCDisU0n9lFM3LPEdalkiXCAKIRLK40RpZkWsnLG+W
	 THF95ZeHo2sEQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2E6DFC4332E; Sat, 10 Feb 2024 13:34:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218472] mt7921e bluetooth not working
Date: Sat, 10 Feb 2024 13:34:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@mail.cam-it.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218472-62941-LK4afxLHFt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218472-62941@https.bugzilla.kernel.org/>
References: <bug-218472-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218472

--- Comment #2 from Chris (bugzilla@mail.cam-it.nl) ---
(In reply to Artem S. Tashkinov from comment #1)
> What's the output of `sudo rfkill`?

[root@geekom ~]# rfkill
ID TYPE      DEVICE      SOFT      HARD
 0 bluetooth hci0   unblocked unblocked
 1 wlan      phy0   unblocked unblocked

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
