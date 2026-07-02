Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000443C98BA
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984315; cv=none; b=ls1MAtYqGJPeZ3GiFC9R+I0n+OBC5vUqW9ogjoEMYs5ljBcrK8fACwBUeElLhZD5/F/d9b6pPzLTkhQ5W7pbWcJEhdP4iB+SN80EC8ZkQAyO7C2DMmDu5Gkz1Ux26ii0V9ZElalsBAGvCRC2euBLk6CsPfEGO4tcT9PE+l7i7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984315; c=relaxed/simple;
	bh=e+IU2xGGTuQw1nSJz/Ig1CeOu/lvJuM9RD2soZcwu2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeG/LkhBmndXVf8HgLY7PJuCpcWA38gHAb5yLSH+TblDv6/2sNUdpu/6j/qHkbt+Oc5IRG93EobX/W7M4Q9ZhupVQwX3sfHAcN/U8PluZJvTkt7Q8Od3i7KymvoFuKJCRo3j6IIHpxebVMSp9uNXbQJHQ2yILTQhd4AxpXQHuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duNx5LgU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duNx5LgU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9671DC19425
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 09:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782984314;
	bh=e+IU2xGGTuQw1nSJz/Ig1CeOu/lvJuM9RD2soZcwu2c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=duNx5LgUQBpwYoIVRmdeITZTd4XkQdcd6bFeDpQtmN5Vog0W56nPVeDdx84RPatMG
	 mNeeTTHrfmoyeAq+vtGNg/XkQTVYeO1yRmi0gcMQYsHfK66QQtsajox9E9st5r3vsd
	 ZsvcHfhYsq1Npopy8gtTbfi/7Gq8xRR+AVTSpWi+3QTuD7kbkVTlFAlCzv7re0isgB
	 uJweMki9XSCGB9VsnLwthlGPpr1XUn0054q24GP3GYZUcO/8KnZnaS9s0+yclOZCVb
	 eTCTZtftuTMc4rDJlJ4amqw6gtYGYPez9zx2N5ziurAnlQaSu9VRdfBVBZke3Kf/Me
	 atUjcvjq+wHVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 79CE6C4160E; Thu,  2 Jul 2026 09:25:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Thu, 02 Jul 2026 09:25:14 +0000
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
Message-ID: <bug-221696-62941-scsS5pzUbP@https.bugzilla.kernel.org/>
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

--- Comment #6 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Another wild guess: wondering if e3ac0d9f1a205f ("Bluetooth: btmtk: accept =
too
short WMT FUNC_CTRL events") [v7.1-rc5, v7.0.10, v6.18.33, v6.12.91] will h=
elp
(https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.17770=
58551.git.pav@iki.fi/
)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
