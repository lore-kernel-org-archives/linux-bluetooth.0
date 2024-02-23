Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE022329
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706750; cv=none; b=DMcFCv57PWM7icks6KVbyfXRxtuoG0WH/CcmnGCp/QVbh6XOFtrobEtELXSgwCUb+GGIEPx2Xrt/9nIdED1FCOh+1b7T/fzyVnq+dK536J8VU/GEF/Z8cl3ULFNg42VwJe6ObIf9C3l4Ckh05LtEDdJW3Gx/10MBs/GqrhaO45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706750; c=relaxed/simple;
	bh=lLaHGNga1gz962zr+72LKxQudBVyZr8lmTBGnH9llz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGMnBpdDUP9QS0nTtsupcv62EhGo3YcPBrkwk4u6HxWdv/M++BX6fmnMo+xPSX4kU049JVgUu4frtzepxadTccBnZqRyf1v2y8hU/qsFhaNeXpb0NTA2BFTroK+zWNxgc5rdl4QmuiQKPMnE6vI+oUrptaOomrB0Du2mlrITZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Heq4KxWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Heq4KxWa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 928FDC43142
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708706749;
	bh=lLaHGNga1gz962zr+72LKxQudBVyZr8lmTBGnH9llz8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Heq4KxWagYp/GcwXFSyvHXLysiS6Xj6W0IVzotpJGsY79dYOMKhsyAkeuhUVQ+mNb
	 z3wNX0Y46TLwQtKuyJ0PgslaUXC05JYgi7wU+N6bY+j5VKnqgs1bSDDuDFk99ssHpf
	 0AXQibRf8ggParStuA2Xp/nzsOK/6W1K/Zn4RenPbetWK5mBcpeiJpa96UQFTrkKKg
	 eTeCZMLV+0JdZdFg5cx6rwnLBB+4u90sjbifuH13opoRHMFw28Pdw8j6crv8kc1Jkh
	 pq5+o4e2K9maOyq+nUgkqV0jD7wpL83zGu3uQqhiABXTAoIQCO+lqdjpW/V+Xtwf99
	 WrEAfRFxiyJng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 82972C53BD3; Fri, 23 Feb 2024 16:45:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date: Fri, 23 Feb 2024 16:45:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hlechner@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-GK6TbZQNYC@https.bugzilla.kernel.org/>
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

--- Comment #279 from Henrique Lechner (hlechner@gmail.com) ---
(In reply to 5vr from comment #278)
> (In reply to Henrique Lechner from comment #277)
> > My bluetooth USB device: Baseus BA04
> >=20
> > lsusb:
> > Bus 003 Device 012: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> > Dongle (HCI mode)
> >=20
> > Kernel with the problem: 6.7.4
> > Kernel without the problem: 6.1.77 (installed via AUR: linux-lts61)
> >=20
> >=20
> > When I tried with kernel 6.1 to connect to my PS5 controller already pa=
ired
> > with the kernel 6.7 it do not work, once I removed it and re-paired it =
did
> > work.
> >=20
> > Once the pair was done on kernel 6.1 I could go back to 6.7 and it
> connected
> > without issue.
>=20
> Could you see Bluetooth devices pop up already before doing that?

Yes, I'm using GUI (gnome-bluetooth) when not paired it shows in the blueto=
oth
device list to pair, but when I click to pair with kernel 6.7 it shows as
paired but it do not connect.

However if I pair when using a kernel 6.1 it will connect even on kernel 6.7
later. If paired with kernel 6.7 it do not connect on 6.1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
