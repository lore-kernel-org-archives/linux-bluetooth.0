Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778E17BC8
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670831; cv=none; b=Vy2W73hFtW8UjiUNwwDbZ27dsBfXAObb8fnYgCrEtHInouLI1QKrmXgFNFDELd74st8OmmeIS6r5To3CxNitreA8QpDORf/fr51BCZTow4BBueKvaAC7onqCfhoLAQoGXo1MHjMgXzKQUt8X/G4D0b6Uc8prPGxQXlDmMxuotG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670831; c=relaxed/simple;
	bh=+q3Od6hv0+OhwUTbhjBNlpcIhG3SSbR+zRwZYg4AM3M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSPqoUJVwArS/+1nPlyxwLkvqmmvmaA8fPgG33/US8A/qNbTwwwpRaYDuoDFv3m/e0DvmIndVJ9+TTyA2SIl9N3JAiBGs8XfEgb8aPIaAYODQuQzYol7iKbxFoVv2cqctBHc4ThU5dHpKZBPSPhA+3gFXoNpR5hnWUOLH/SOK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5kz0TlH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5kz0TlH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96179C433F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 03:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706670830;
	bh=+q3Od6hv0+OhwUTbhjBNlpcIhG3SSbR+zRwZYg4AM3M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N5kz0TlHeNT6yj32IuNapwP0vRM7RYYl8fp7gPioRF1zVHFfNB8j07dq/DIGXsH/l
	 tpOivpKqpA6IF5+0KPmlqyPLOn7bTW+miWNdd2f1wuws09WIQT1ussmiL11ZNx0Ecy
	 dMi6S95p8B0z8BwQQ6ULkwZ0eC3axRt/EcOR5KgmgSCPicQImWOOHxw/1j89qCbTDC
	 LrUw+9ayaW7XIyN5v4VVDiOeOwoOLpu4XueRRIS5Bxpc+zIS3oyasBra6UO/5xrpez
	 xUjNGzzpydWX7xzhWN4Ug9Iq3YwXZfrfCyauK4D7z2EC8MQ9vztCfSPY6nwvddA/Bs
	 uyw627H+ZIiuQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 80F3AC53BD2; Wed, 31 Jan 2024 03:13:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218440] KASAN: slab-use-after-free in hci_send_acl in Kernel
 6.7-rc2
Date: Wed, 31 Jan 2024 03:13:50 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: zhenghaoran@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218440-62941-XBPhjYYpDH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218440-62941@https.bugzilla.kernel.org/>
References: <bug-218440-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218440

zhenghaoran@buaa.edu.cn changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |johan.hedberg@gmail.com,
                   |                            |linux-bluetooth@vger.kernel
                   |                            |.org, luiz.dentz@gmail.com,
                   |                            |marcel@holtmann.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
