Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD4938B7D6
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975206; cv=none; b=lvvElMohCcfeR5GPaDhnNgE82e8WnUy/nAmEt/wfuyVUafIKyPTUwLaxoIqeGD6fTyBJdOC5Jk2/jFHEzicCABkjdnQhSVVSmEwTa/zp8oMZuFqgbxzdk7EZ9D66u98JDyylH5DA1hzKAM5YjsrIaTq9YjFrV+StTdlifa6p8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975206; c=relaxed/simple;
	bh=7fcVIXfw9It8nwbBRSdjA7WZ8U7JJtbpNH52BzhbEzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUiBaskYdAhewE9tNUmZG96YFBz1G+/mNBi14z5pZDvWtlq1hPpgXsfoKv515yWzVLgaSS0zXqKOFAIfMOlKR2OOqNyDDP7yQSeh8t0uUEohFKwWHpfr83rxj81uCXhlcuMh4NeB6/KaOdQv4WaWAr6BFRTlDGN/kgT6didifxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+2Hhp+N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+2Hhp+N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49329C2BCC6
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 06:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782975206;
	bh=7fcVIXfw9It8nwbBRSdjA7WZ8U7JJtbpNH52BzhbEzQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J+2Hhp+NrzHTLYdg6lbs4VFYvwjV2+UwFrLMBi2v2Yplsc9Zm3yNaPT32jbyJW0Pk
	 eEBx8qivZ3CJH0jYGVyhrMx6uBb3q1TS1mBXLdhN5HjXmDSpB2mavkI/eucV8el+mi
	 6dyQnhaao3NHGRu22SRkfEeT6lXg/elcUsF2/kb6LX1xfW8SqRaCXZCuQ2VmN7FXm2
	 w+p9n31GTg5ns/yqEdEO1dJMzeuuq0b0YVPKnDBcRM8tRitrKnCCzhQC0+epNTPr5M
	 P3i3H+a75rHVisDo6+AeQ27ohSF8/2glNuK9g9+dyNXJ+sokkLkwSJzPq6ClAaGkv9
	 1rHKC8CTe8aMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E115CC4160E; Thu,  2 Jul 2026 06:53:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Thu, 02 Jul 2026 06:53:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221696-62941-vEZfsCJMpF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221696-62941@https.bugzilla.kernel.org/>
References: <bug-221696-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221696

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
In that case: unless someone chimes in here with an idea what's wrong you m=
ost
likely need to check (a) if 7.2-rc is affected as well and (b) run a git
bisection (c) check if this is a stable-specific problem or happens in
mainline, too.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
