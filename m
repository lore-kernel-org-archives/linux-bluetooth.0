Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42017799F
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988502; cv=none; b=Xi+8ZFypnRITw+fm14Pw4Ia/wKr4Ii9EPxAI1/hPYUnnijVI237WZMiPjnnqpCcQbxSHlIxxKA1ND/ACHfvUgvPr+JvuOddjcpY1dz7HwRprOGhlVJO4CadHnMAipeX1BdGmbF/40Hrg1yeh7FDbmDCv/GQtk9H2DGynpiEUiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988502; c=relaxed/simple;
	bh=Z/MIJKJhAiACVDK6+BAB6QxieTE7HssjdwYtUoVZB/o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmDsgJ+4P41itZJI97oGISQEdVjBS3oa5Lxr0ERD1atAevSbANHIBiWrKKgLiXuCxUlyt0+d9jWiE/+kGRFie8Zlo8LXXVZTxLr9J9TA0haLnaUrMRhG4fPKMd5zoLfT7b8tsGbA7e81NDGkoepU/OBgu1gxRA6DnsOnFCcjn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu+2nh3E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu+2nh3E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7213C4AF07
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 10:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721988501;
	bh=Z/MIJKJhAiACVDK6+BAB6QxieTE7HssjdwYtUoVZB/o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wu+2nh3EHp1DmsJp2wMZw/pKNoSffR0GA0GVAM3g0cEI5c3GUDDeg02JEg1+7JaL/
	 TQO3zPEsg3Ewa0vfYefsA2wGrAOvHngaVx+ZYYyEWiQlXUs8lrPz1XlSxp/xoX57bk
	 9x7Eui4LmUHKSZW3YE7dHlkgaW3BTZ2wXWNNupVXC45Hy9uiKUmeFjLGznbu8Wd/Ns
	 xXYqmZHlpIu9Y7BTQBdQ0yQeMGSlRjEoNkmdmAPOvGrT8ty7BMB98xAU3aAcFJRZZk
	 lmrS0+zMDMMFVJXAkTYKZxrO+gRNcx6fsGj8jdIt0cWdn+5waV7EwW5Gbtwu4OI+Zm
	 S9lRVPghoCa/w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B72A2C53BB8; Fri, 26 Jul 2024 10:08:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Fri, 26 Jul 2024 10:08:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit bug_status resolution
Message-ID: <bug-219088-62941-MYeT1N6Jje@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |2e2515c1ba384ae44f6bf13dd64
                   |                            |b9a0a950798c4
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #20 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Luiz Von Dentz from comment #18)
> Created attachment 306621 [details]
> Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning

Please push to stable.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
