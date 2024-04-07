Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C1208B4
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712491954; cv=none; b=Hdq5dnAFzTVk+FA8jfMePKsZXsEX7X/bFsoukHHIqB4KyjIKSrtNflsvZMw97ezLFWVy2Ch0BWqCI1qxOEkbPfQTsSaPC1il3UbX4mVtI/USP6iZQ8cTm/3EjJvy53lKc4NuVIqFyel4meNb7EupEyQI8NWhQkCei84zcq37m1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712491954; c=relaxed/simple;
	bh=Nm0otkgRtsJVdyLhRFoSC1h9QEUqTSJTivIE/yYjXhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iLajaU3TsQzA7m9Ee6BvgKbrMXdotvWk2BTGmPTExxMl/y9nMrIsRUR5CPGlPiPW+/7+pFu4sRQgmQv/huZMP+N+7YAlsGzQJ3Thu6omC3VW/OR94eu97VoRhfYYY0QPaxdWE56rmZMk7l+5GKSS6lhIeAEfBflkEvvRVoG4mJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFWeFBbP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFWeFBbP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87339C433C7
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712491953;
	bh=Nm0otkgRtsJVdyLhRFoSC1h9QEUqTSJTivIE/yYjXhI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eFWeFBbPYO/jhR3hyMbbe3ooVspdYeZc31PDGl7gaLGQFqoDd6/nzRlkLes3YBFPg
	 7fWKZJb2jfWuXpLnmkq0UwdVkF5OeaDOLAMS31JCflVpWalChKEP0voRB2J55BXsI9
	 453MWNzqpf03qWRG1s6UfCTqCXrzQpNKVFamJp6OpG95VevB6o6eCWBUNPNNOtACRh
	 CURhwaWalcBj2YGf8gy0L2zuPDkYy8tktrNG25Osh1mdbG5Ilj8CNfJ5El+haexgVm
	 gQARC4EAmStwQeu68F5gFDkJXHW82azCtY6hKOuDgQOjvNT8sNazSqyBzL4E+GSczy
	 UxDmvEIdaZycQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7673FC53BDA; Sun,  7 Apr 2024 12:12:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218680] bluetooth connected status not shown in KDE desktop
 GUIs
Date: Sun, 07 Apr 2024 12:12:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wolf.seifert@web.de
X-Bugzilla-Status: VERIFIED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-218680-62941-rMTEPzaoMh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218680-62941@https.bugzilla.kernel.org/>
References: <bug-218680-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218680

wolf.seifert@web.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |VERIFIED

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
