Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291343173
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jan 2025 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735862108; cv=none; b=H7VCVqcmsBbQQsf76hpfHL7v2MOfiLS6R6D7/AJYLmx3VLbVMVgk273ogAoXKXYhFv0Ch4E/HJyy2RUGU4AEZ5RLXGRhoIBNmp7MJhAX9ZfJFANLLg/Z2dajysrnKgjDDPXvkoaRl5c/3dgYMPrHWf+IZuasQ0JypFvt0p9/wpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735862108; c=relaxed/simple;
	bh=sLLbOFgv4p3NvoTW9eswCE6wAfUuhBoTFDYl/LILpgk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gcak+wTHbNc7Ow85Q6zYnU7VPVrbRQfyRBuDILGUwkJheUMZRTBtMgseQ2PU47vAzxlLl/1xCztya+O0ZRMmqWEZ4TbLF25sJFPzrTgh8reIEPD4VbCKWOSGiRlAXbqSudyKXUFnGoi2OJ/EybGazYjjsDFRw/AnfVxgJlQqtkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvOc0wyZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvOc0wyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA60EC4CEDE
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jan 2025 23:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735862107;
	bh=sLLbOFgv4p3NvoTW9eswCE6wAfUuhBoTFDYl/LILpgk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qvOc0wyZE7mHeRzcdLjiXJMFx8Q8XW2zoFObAPU3KSlZNSAtS2bZy2vphXBrHzqb2
	 FXlP4giVw6sJQwRMCl4YvxRsogB2kekL909g05DXBzamAOFDSb6zasoZr4h7e8/WWL
	 0EzxRtMlzSyPFFWTKugnoC8eerPBjT6jDDKkOsU9R06Eza7lkVWMovoLY4wcnTTd+7
	 C9hrFWY55xNw09jCpEGsC1PW7z+VhjR3ZrrzEpKsucn82vrV47/3u/OxBwQspMec5Z
	 MtrarhnFJMAMJ/3HAL5SHpkbDq+8B0rk1wxrfopiICI8YNTFmlDCrLW5XemyNdZQWH
	 CYGvNm98BIknA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9AC61C41615; Thu,  2 Jan 2025 23:55:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Thu, 02 Jan 2025 23:55:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: olivier@croquette.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219514-62941-wXfMuccD2a@https.bugzilla.kernel.org/>
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

Olivier Croquette (olivier@croquette.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |olivier@croquette.de

--- Comment #4 from Olivier Croquette (olivier@croquette.de) ---
I also bisected this and came to commit
d019930b0049fc2648a6b279893d8ad330596e81, which is in the same area. I also
found similar reports:

https://bugzilla.kernel.org/show_bug.cgi?id=3D219290
https://bugzilla.redhat.com/show_bug.cgi?id=3D2314036
https://bbs.archlinux.org/viewtopic.php?id=3D295916
https://bbs.archlinux.org/viewtopic.php?id=3D299987
https://discussion.fedoraproject.org/t/kernel-6-11-3-200-fc40-unable-to-res=
ume-from-suspend-when-bluetooth-enabled/134008/10
https://discussion.fedoraproject.org/t/system-cannot-wake-up/134199/39

A workaround that works for me and does not require to patch the kernel is =
the
following service:

# /etc/systemd/system/bt-fix.service
#=20
# Author: Bojan Kseneman
#
https://discussion.fedoraproject.org/t/kernel-6-11-3-200-fc40-unable-to-res=
ume-from-suspend-when-bluetooth-enabled/134008/17

[Unit]
Description=3DDisable Bluetooth before going to sleep
Before=3Dsleep.target
StopWhenUnneeded=3Dyes

[Service]
Type=3Doneshot
RemainAfterExit=3Dyes

ExecStart=3D/usr/sbin/rfkill block bluetooth
ExecStop=3D/usr/sbin/rfkill unblock bluetooth

[Install]
WantedBy=3Dsleep.target



I also wrote on the linux-bluetooth mailing list, with stack trace from a
kernel oops:

https://lore.kernel.org/linux-bluetooth/073c3b772abe84d480913495eea0c4da736=
07d6e.camel@croquette.de/T/#u

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
