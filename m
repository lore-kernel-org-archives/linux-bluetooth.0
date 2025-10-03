Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695F1EB5D6
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483624; cv=none; b=sNe38QoTXVyCSQf4q6knxDnohNeBl0AsnGNrXI3IwG9PggnUdoDV4yQ7ERZNRgzGM0jNLOlsAeqAyyr9METyLoK8gvXj1bagNyaJnwwz/yeqf4wTNrgZzfqvZGP5lcdf/Hy1YO5WIpL25agF84EmFE82RGDDZ3xzHyQI5sFTHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483624; c=relaxed/simple;
	bh=NcFztfkOXZJMgA5I2UBtcDgGaGOZnmO57zJ80JIbl/I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A19k4Hj568Gt6p5nsDlYbf/vKAdm7AlJDC/yD3lj8I+GzVqghOs/FhcJkfocphBWJi+75VyOzrWeEV4wmEH2L83lWFZK+cMM5sBsdt3tDC13dDxvKooBTjf4CKwOYGyT94BXm9jQDoCD0EYtkIPPegb1JypbmvgV7xKrSQDSz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpgixT4b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpgixT4b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDB13C4CEFD
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759483622;
	bh=NcFztfkOXZJMgA5I2UBtcDgGaGOZnmO57zJ80JIbl/I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RpgixT4bHjoL8Qdci40wTnMJWeBnqaD6PGnS7G3KBhn8jW522z/44R0hUTFGWCp0p
	 eCT7xIqxXyAFpyGwF9jResTA9rwNOcV3DhFrdPLGnXlL/Qn1KtLI51KJoFrPOG4EN+
	 LksqFmVRXmPB7xQsnAZareKJjzDp/z4PivJ8qy8YIGLD+gJAnXLN0TP+Wb/yycnwxu
	 sJy7MpmfIwAO/fwE8v4p6ptscem6Pa/XVyF5Xaje5l6Ipo9pnslFTfyM3QUyVm18P3
	 FhQPEH0wzEIsjYCAEGB7jPIoEe1MS5foD6Ytbb1j2awvMCuIYDMTpnVIUej1kZp0VD
	 rNyum/m3JgucA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AE3A9C41614; Fri,  3 Oct 2025 09:27:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date: Fri, 03 Oct 2025 09:26:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pverda@ziggo.nl
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-YBK8NWVpTq@https.bugzilla.kernel.org/>
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

--- Comment #282 from pverda@ziggo.nl ---
About CSR dongles:=20

I have tested my Chinese CSR clone dongle with the new kernel. I have used
kernel 6.15.10 and it worked perfectly. However, I did need to remove the
barrot quirk in order to let it work. It also needs module option
enable_autosuspend=3D0. The dongle in question is:
idVendor=3D0a12, idProduct=3D0001, bcdDevice=3D25.20
OUI: 00:1A:7D =3D Cyber Blue (HK) Ltd - Shenzhen
HCI Version: 4.0 (0x6)  Revision: 0x3120
LMP Version: 4.0 (0x6)  Subversion: 0x22bb

I also have an older dongle that started to work somewhere during the
kernel/module updates. I don't know precisely when. This dongle is a blueto=
oth
2.0 type. It does not need module option enable_autosuspend=3D0 and does no=
t need
the removal of the barrot quirk. This dongle is:
idVendor=3D0a12, idProduct=3D0001, bcdDevice=3D19.15
OUI: 00:1F:81 =3D Accel Semiconductor Corp - Shanghai
HCI Version: 2.0 (0x3)  Revision: 0x44
LMP Version: 2.0 (0x3)  Subversion: 0x3

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
