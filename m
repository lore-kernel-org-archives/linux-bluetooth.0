Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97841194C92
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012392; cv=none; b=uFBjF2yWphnwMOBHZlMC2HBLL7uvUVGUiWNIkoJIzk7NGYhYApFiAEwnHm0fXDF7FYD4vXPTBWXo0+xN5G4Ek0PxeFNAQFonLPiUjHJykWKoKOS23vnPeX4CweUwUMPGhTPYZYlIVR+jPEfTEaKxZYwEu2Pv3/EBr2IwWlzSyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012392; c=relaxed/simple;
	bh=VX/jQUtPgqZ/dAH1VUpmtjkaR1j2ypc0WJiBHNrXHY0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3V1Nbj4P1c+xmOpaCow0WVE8jiyGP1TuojCdRvTs1qV/COn+jGT2te8h7vwmroYTdQKkfGXS7mjGlSBOwPCVUmrVpJhvgAXAncVCUt/e/OcWRNdVFemdqufCyzco6+d/SAepDsWUiHdqkb+nBOCMWMMvIXvr98CepD9L8+ocoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P82KpZmo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P82KpZmo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14E6AC4CED3
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 20:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731012392;
	bh=VX/jQUtPgqZ/dAH1VUpmtjkaR1j2ypc0WJiBHNrXHY0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P82KpZmo1sm7m766wSTy7Uhg6ffgfMf7+fWWLor4Z9Xf/PWk/Z2tPBmyNNpxwdYlu
	 7xU1NdgR8QpSoU3szBFHWjPfG0xyK64ZXAhhf2L4uicib2UQnsvtoTfhLzyyukNh8p
	 KKRgSlzpYLYk0WV+xkB9pQGzP3jeayqENejNDqtWd6P5IBHkFmaOQPa7ELFLIZFaF5
	 cI5ejEZPadhnhauJpG0Vwvl3DhkmBehAKeokrzfiBdyIk0czYWh8AB2b6PhWz2Ay/b
	 Jbf0gntgglZJcWN7eLuf+BbQjEr7XN3dxMxcAp+A8NG1zheMa/mkc6NUm4MRkDuBw/
	 uhunRFblzR7ow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0A535C53BC7; Thu,  7 Nov 2024 20:46:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Thu, 07 Nov 2024 20:46:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ghibo@mageia.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219458-62941-RxxXiLiIDU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

--- Comment #2 from Giuseppe Ghib=C3=B2 (ghibo@mageia.org) ---
Created attachment 307181
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307181&action=3Dedit
btmon output (connection working)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
