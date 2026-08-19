Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7F30CDBC
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160868; cv=none; b=SHiIpdtdtX8TC5+HHYuAnlAUGHSArZI4hqifsWmCQg94s8nt4Y7MAN/S6f5qCLzWXUnLiY9sLBVViQ/jUOS4PobTAh58erPJJQ2WEzsgZK5/+O/S+R0ppRmDdsAky1g51+rfHtauATV1Oak11sK05ntPjsEJW9hfcco3KAjtsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160868; c=relaxed/simple;
	bh=7IoTYUNi8ouBrP+4A0yryntZ2r1/VgTK/ClBd1SSJA4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hB2kPNQpyhfBvo6mXpK1UtkquuaMq0z6gWZ16SXx+s3OfpQ+db5K/y+7liTqCVIvU++bJ2GsjSr9dzPPFp9sVBtwB1Q+huRyz7UEI61pcBSObpWdsEqPv1r5AhgVJIIclURSE9BWJGDcDYJrVM28rz0GcbuRsgsLYGxh866n2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s++OXeXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s++OXeXh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7062CC2BCFA
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787160868;
	bh=7IoTYUNi8ouBrP+4A0yryntZ2r1/VgTK/ClBd1SSJA4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s++OXeXh179OYfSEgMei/QBti2aPQkTOqa/QFpeKoKPWtXCDDhzP4h9BYyfPZ07HY
	 HVc2pk+EROPAxd8WGIJpZOG83yMfylDo4pUMPzfttqC1XBX35jdB9m4Gbmu81Iq0On
	 MHMo5dTpmwczDX2FD8V8qCjhoBoQvNI2limjMiZOMxViIyypogSqPa8jN2vIQgZaA6
	 2RgZL3DWrSVMzUYF1sAu/cQpR1yVXVux3Ave0Ld690tpwanKTm3Rua0MuKlS+0xQot
	 mIHroo+rgutoHayP5fP3dnY/xE8LsbHvDRWG1PkKCggjV9whyPxGzSpGQ2LK50/ntq
	 Yj8YDj2eZA4yg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 569A1C53BC7; Wed, 19 Aug 2026 17:34:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221481] btintel_pcie: suspend fails with -EBUSY on Intel Lunar
 Lake (s2idle)
Date: Wed, 19 Aug 2026 17:34:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: markgerlach@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221481-62941-zuesNp2gjZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221481-62941@https.bugzilla.kernel.org/>
References: <bug-221481-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221481

markgerlach@mailbox.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |markgerlach@mailbox.org

--- Comment #2 from markgerlach@mailbox.org ---
Laptop: Lenovo ThinkPad E14 Gen 7
CPU: Intel Core Ultra 7 258V
Kernel: 7.1.8-200.fc44.x86_64
Distro: Fedora 44 Gnome Wayland
Bluetooth device: 00:14.7 Bluetooth [0d11]: Intel Corporation Device
[8086:a876] (rev 10)

Additional detail regarding firmware:

In dmesg, the driver fails to load the firmware:
`Bluetooth: hci0: Failed to load Intel firmware file
intel/ibt-0190-01a1-iml.sfi (-2)`

Checking `/lib/firmware/intel/` shows that `ibt-0190-0041` and `ibt-0190-02=
91`
are present in linux-firmware, but revision `01a1` (`ibt-0190-01a1-iml.sfi`=
) is
missing.

This missing firmware leaves the Bluetooth controller in an uninitialized
state, which directly leads to the D2 suspend timeout (error -16)

[s2idle] failed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
