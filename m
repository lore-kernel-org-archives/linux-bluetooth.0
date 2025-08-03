Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247C202C58
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 Aug 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754210446; cv=none; b=GWFtHkpYyP4GG9v3FelUtUdYfQehH0THdLTTKvZDdHr1TlP4NTxT6OSN1LmbZ7uVXv3mZzmfukEta1QauzzLrWYClOn5NbZmjx4sxwglZaQH7C435zGgPngWwX4v2JE9ZrhGos/oulFU5tk7NUd+yB3x28D47HAxGRkcTFk65JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754210446; c=relaxed/simple;
	bh=nQpbHy9ZGWkAo5ig7//LDSEGIcJqly28IBZkrpmREkY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYeijL/Edzlo03EPILjyaFoGaaaxXK0DexjFaMf8xStpTA/+Yb7y4Qx0Mo475Y2Bx7CFl2G12nsgs015XLYygI8rntiCrOaURBXLzKvAI75jLV0ar3uebTRxFzF6WObHZnsvD3DauxU24f3tGRcmqMocnWcEhIRTFjBed3Sz21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf69NYu6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf69NYu6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA228C4CEF4
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 Aug 2025 08:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754210445;
	bh=nQpbHy9ZGWkAo5ig7//LDSEGIcJqly28IBZkrpmREkY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lf69NYu68DKKw++ZvkTm2IhOu1cy1aeI5LBFq6jkihGSNyg42NccOfmg8+I927l3r
	 msFN6K5DCO0kXg4KzeOgHfcRII05Dn+vD7zdUljpYYVd8K9fk+5LFk8c39vSDkAKZw
	 WhfgDJrjytWBgMOk5Gn4VvbY2wuIle/Q35FSqj6pH/4yF4Jn3TyIJHihfxiIWyPzUi
	 KsBy/rJBNIkRr3M5rVTzTdDDOcFNufu7tSjGCTzSWl6a460RnJmQZrWG+eyxFdvxyu
	 iUnBas23Xq/JdG8CKqy+Emm9qsfTV46RjX2uj/GYpRudCl1inLK1672YTXG7GkRgtz
	 Tmp/zHfBIN9vA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BBA6BC433E1; Sun,  3 Aug 2025 08:40:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220398] Bluetooth devices experience severe connection issues,
 frequent disconnections, and input lag in kernel 6.15.2, working fine in
 6.15.1.
Date: Sun, 03 Aug 2025 08:40:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220398-62941-dWvBPg0d4L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220398-62941@https.bugzilla.kernel.org/>
References: <bug-220398-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220398

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you for the report. Looking through the commits between v6.15.1 and
v6.15.2, the only Bluetooth change is related to Qualcomm:

    $ git log --oneline v6.15.1..v6.15.2 drivers/bluetooth/
    8b91e4b6b82b5 Bluetooth: hci_qca: move the SoC type check to the right
place

Too speed up fixing this, could you bisect the commit [1]?

https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html=
#v

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
