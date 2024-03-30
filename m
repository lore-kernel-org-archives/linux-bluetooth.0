Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9213D0C4
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711835521; cv=none; b=PDNabSy0jPyg6Py3wZKE2mCkadOJrPdl+gMIrvJ932SF7iXKtaqxknNAYj5+MDLW4xhD7XYB92uALXKGGpcYJ1URXyk27JBR95AmZKBdntYM4esZ1bKWk9xJK2xHI32EONdE+6l6qc5BAxeTe+cOFCwCqVlDaDu3kh5Inn0YlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711835521; c=relaxed/simple;
	bh=M3vxbeo4W5eydHAVM+Wm2XhVoEDPJu1G/IGkCDXcfdE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r5wUG9x7UyPo0wX9Dnd+OKwIf95MhVEclrvip0LloNConRaIpGdYHXp0TYY8hIP3x6UuW20LxBm3J4CPB0QTI0pKVhxxckzrM62kC5cBI8Dez+DoQg8z0l3PXO4JKindemG/IGhKCn0xWiF6Vg1rhfzCKKa54lajtuZESu2VYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXaIo2WR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXaIo2WR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F687C433C7
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 21:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711835521;
	bh=M3vxbeo4W5eydHAVM+Wm2XhVoEDPJu1G/IGkCDXcfdE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HXaIo2WRoIGbtzR5EvVDrVHR7iMB/NGfBIe88l5ecSWu3Br/ayctrLBwBArL+Tby5
	 PZ4C/eDq2NmiXhEHB5/3Zde2zqXpJNQ8aRBaWTpKZdmyl4F/9Sbf3N7EfgKgP3boUz
	 Niggw9g4GYfsri1XARuX2wcwGJ9nz3H1uzH1e5k5oJJnS0lohD0fzNthXgBMl1N8cY
	 zHYO4Zy7ZLEwh2fxhF+3jNmKluK43DWrp8vtkf7gzjuFVBlT0+zGlwGspJHy5zuRKO
	 W/lMf1csygIiH8ZVaC/cKLs0a5oCaCyxgIKzNoYxQLh2puakVZJGuzchs/KuviNjKk
	 kjQA5ixfo3NVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1ABF7C53BD2; Sat, 30 Mar 2024 21:52:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sat, 30 Mar 2024 21:52:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ferdi@sttc-nlp.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218651-62941-NqUQwgw3Yu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

Ferdi Scholten (ferdi@sttc-nlp.nl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ferdi@sttc-nlp.nl

--- Comment #16 from Ferdi Scholten (ferdi@sttc-nlp.nl) ---
The bug is also in kernel v6.7.11 affecting bluetooth and usb. Also causing=
 the
system to hang at reboot or shutdown. This is on a Lenovo thinkpad T560 (in=
tel
skylake)

Also confirmed on Lenovo thinkpad p52s laptop. Also causing hang on
reboot/shutdown.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
