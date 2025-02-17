Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090F1494DF
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805727; cv=none; b=Y7dTGwJ9p5Z5AkYB1UetJAm15dTjVivqYmZ/Oz8vkdcXgnfwp9iFNYsn0fbYwu/cTEf/q6jYS88wNlwcuRuJ1s2ldDit+LHtIXZ3oXmlyREvJbWVmZ2SwUyoMZDTb77syRHfySdBGjHKvlyzrfO2GRheU0QtMCeafBOjk4gziZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805727; c=relaxed/simple;
	bh=MUGCRu7mEbIXlBaJnqRAloZvEWvQ0Q2WiP0ajNI5n1k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gDp0k/ywchmp/lBBSVtkY0/RR7b2r2xumZU99z/KJjld1Uc3/00A/dCkTtLBu9WP/DBEqktqe0jpOyZsbGjH2n+wyehgb4y8tZSTFCTGpMP1lIoqoHviQFKiywLRsUyb0KprII8qCTiG6RI53f/WF+VtdlzTKkHtryV59xcZla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvgxz3+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvgxz3+2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ABC0C4CEEE
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739805727;
	bh=MUGCRu7mEbIXlBaJnqRAloZvEWvQ0Q2WiP0ajNI5n1k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Xvgxz3+25d3tb8y6A1Xg9BaLt/fPMaeJO3nso1/A8CLLbIwYvmU4/J47tRuA6m4+H
	 30or/PXhPYrvRe+rxdBa9Tlg3W4hKdSTd0j/pIOysUYqw09BOzncVjaksajij5aiQw
	 /MczSjw/MAl8bR9438QSPtDHKZ+fO5kbs1Mx4O7lP3Fbg7gU4m+4hxY0UGKSE2b3Xz
	 S9JbVV2C1TSDjPAWwT4xuMSkQ05EA7+htJ1nCAI+Y7KnLVzC22Id6sZsArp+XfVnVM
	 BbfT5WBRGP0OOY/fbWQZO69u7WJ1V1iFS39aCIVNiHllCpuN0FiyHVNDN1GbAEMRA3
	 Hjf7AZQc6b/EA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 14BB4C41612; Mon, 17 Feb 2025 15:22:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Mon, 17 Feb 2025 15:22:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jaromir.obr@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219514-62941-gO6aS7Y0Rb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

jaromir.obr@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jaromir.obr@gmail.com

--- Comment #17 from jaromir.obr@gmail.com ---
I have the same issue since a new kernel 6.11 that I got in Ubuntu 24.04.2 =
with
latest updated. Previously there was a kernel 6.8 and no such issue.
The workaround with the service containing "rfkill block bluetooth" works f=
or
me, thanks.
My motherboard is Asus ROG Strix B650E-F Gaming Wifi, CPU Ryzen 9700x

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
