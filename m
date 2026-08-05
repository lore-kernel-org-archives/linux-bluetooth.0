Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0F30D40F
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785903451; cv=none; b=D2GeRGujBVtCn7aRA4UnA6aduD12XRlMfZdHspMT0ApxNUoLeidKfjEhF7kUZDjIirF/+bMlcjbgA5f4bF7IcMCXob2aM4pgfBR/PhnlD4WY81uMq/6bOzepttcV++Zl6TDIIkfEsbftJp+BcBXsjMKJyCWIldVtVPM1SEcOAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785903451; c=relaxed/simple;
	bh=Uk0jQ62/r6yVe8RFXRVC7TyHKSbWm/Tio0Oi3Jqfznk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kFVXT2RjWrG6Xf8y3V+0LYaniNsLPcvSnS4s5WCqeTE7KfS6AbIAeg70lP3rr3MMckUheG8UyNtBOMIs+2/H1hXw5G9pwY7OvJNRgVvI2hPRTu2sPb7oxo2uNXoNHObYyTiIsDfU5fVdorf08E2N59pTaib0DjN4OrVkHtvdnjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftVm1g6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftVm1g6E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B0D6C19425
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 04:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785903451;
	bh=Uk0jQ62/r6yVe8RFXRVC7TyHKSbWm/Tio0Oi3Jqfznk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ftVm1g6EEMsgNu4rHTXbji3II3iox8mX9NkAnaWquTe9vqjDdAKwcTUGVfSY6sHWv
	 IOtSEK8ecWxrvjP4+eB9UKR1vCQdjnCU/uupnBgwZhA3r8dRH1tRNienlrb6akC2H5
	 brafLes74cCarb9gUW55R+ScjpDj9DyxMieNEeqgbaKKW97yp8ysQGUfTI23vgNiCz
	 qIJhDPVi2VerlMF5ZsQHzaKyy+u+ep3YnVuJZlPuAeZGomOQ0a3y/k/QcWAOzdgPhw
	 gEwMK/vDu9jxId6LjeYcGsip2sbg6VWn0Uk/W4smZp5/bUzm6gSSJensNyPh9vz6RE
	 Di6OBNEdvBFPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 05F00C41612; Wed,  5 Aug 2026 04:17:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Wed, 05 Aug 2026 04:17:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnxps@bbtex.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221832-62941-9hHyLaHFk3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221832-62941@https.bugzilla.kernel.org/>
References: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

--- Comment #7 from IQ (lnxps@bbtex.net) ---
I've tried the resolute 7.0.0 repo, this one doesn't even see the PCIe Wifi
component... quite a piece of crap

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
