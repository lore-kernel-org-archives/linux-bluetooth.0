Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7CEAD2
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818792; cv=none; b=GDwmHooYUmpNRoh8ei8ItAXMlrmLa/zjDCuQInf7Ww+DnBIQxAlVBTihrDuIdzHVUF5rPYLRqvPrIEEtAk1yAc8Xr2Z3h6vzRFfLmKTa6YBuqJ9JVrXsow4FMLJP8IbEJ6fKKZ8jpDtx6ZFpMtTEso7be9CqXU0hn8X0lZ4Z6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818792; c=relaxed/simple;
	bh=icJ+v/XhkfVOWc7G5RU+z/jUKdPtNWoyv6eOM9Tc/Ys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ey/eus3mhiRAr9KhKlT4+Ty+mPMk0VwOSeiCSgZHaz6500H44uub0j5rhqolCuVSMGOTfXzEq0kEsmVKtdKHmROJcPMu7mINeuh+NK/37w9pxouQi2Jmm7LfJttJgGAaW1gl4tk4qXMj8eIoE4WyqPEuSjsP58GSs7p3l7Xo+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuucfW3K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuucfW3K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DEC9C4CED0
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 14:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730818792;
	bh=icJ+v/XhkfVOWc7G5RU+z/jUKdPtNWoyv6eOM9Tc/Ys=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NuucfW3KFu7TV6++frGpu5NR04toYv1Dp27wqXLSidX0mR5A1+pp46n5GzcInO2yr
	 BKZaBoX0vMmtG2yZB2SD+EH4TfJQPA8QR4wMDVTNZOK9J01lThI53N9pUXEKxn4RUo
	 vm8UN3bUMNDFsJoHdidr8TolKOiiehwaE+XxGj5wsIpY7zXuLAaPxdz+oCIerKRAoc
	 iu96WRmYFnreSVhgXgB2mcuRavO34WVFvTIbp4yLPKSr6zrw1mMKWAMN6mf3Zfl6hg
	 RB/mWJhKlgF6UWO9kA78N7V8YyZ0l5lI2Pd0BIm7lHT/+XcjwCic77DPpJy2DupfE1
	 liSov7aPfSMgQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ED581C53BC7; Tue,  5 Nov 2024 14:59:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Tue, 05 Nov 2024 14:59:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219458-62941-OBlv7OQxfW@https.bugzilla.kernel.org/>
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

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #1 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Giuseppe Ghib=C3=B2 from comment #0)
> Difficult to track in logs, as logsa are pretty verbose anyway, as even i=
n a
> situation where a connection working there are a lot of warnings; mostly =
in
> a broken connection with the patch included, logs are like:
>=20
> bluetoothd[10741]: Failed to set mode: Failed (0x03)
> bluetoothd[10741]: No matching connection for device
> bluetoothd[10741]: No matching connection for device
>=20
> while in a working connection, with the patch reverted, logs are like:
>=20
> bluetoothd[10863]: Failed to set mode: Failed (0x03)
> ...
> bluetoothd[10863]: No matching connection for device
> ...
> bluetoothd[10863]: /org/bluez/hci0/dev_<mac_address>/sep2/fd2: fd(42) rea=
dy

Could you please attach the btmon trace when this happens?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
