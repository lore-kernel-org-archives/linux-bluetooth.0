Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AF466B66
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515516; cv=none; b=JgJKf+zzdws0aYRLZDnkR159p6v1SspgBLTao+MP6IfVDdr58Rs7u8FMnV7f8VEldtadhGh/lC+NLEd8bEvfN7EqrYjAZ52IzkW6xOuDTR2kObsN7pfcUyV+InPnXRQa16UkF3r5RNkKuZLGu9zC49ygc1OYmYFkgKkWdmnCntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515516; c=relaxed/simple;
	bh=jtx1ZetQYVCZmrIez0DWDhPW2b7/ADqQCeHabKocLUU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=afguP6ih6Zxq6fggHbCXhdJ37NlaiRf05AhFYV+pgIhuUQKO3G8vT0MckJlE6wGEpW3nxrA7Ph8eZtuth1QG1Wj6P5t/5looS3aXlOzkuRJ1cwWoaeWlgrwQUxxCdSMCby7jymNPSZGYhJV0wJnZqqF1gsdtA297Orf7WUYzweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2bBm6Xo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2bBm6Xo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29744C2BCF6
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783515516;
	bh=jtx1ZetQYVCZmrIez0DWDhPW2b7/ADqQCeHabKocLUU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u2bBm6Xob3NKrVZxggvWJ/CjX5U1XIldXSktSzmOfRDAzxbs/9GSLb/CZIMkIYc+y
	 axmo48w2UkeZjUq9LBrqtXxNMtgoJ70ogZh+coyGSKZ2eMzB4hDdQNyZQcgiSgetSV
	 jCgJI2Qtmsh32CMUic+/KKvh7l63ojDb0tedznb74+poU1WJmTEX6LUVcWNdcIDGdZ
	 0aSL+MeYOuR7lVnYdfA75MC0+4Bc6Kyzx+AaW+uTw61Bzl8eEYD7btFmqWcxhSmyaZ
	 fpFaOLFYfvapoIFfsr+BYVJ2R3Em7xltsT/pYkmYSroU8lwuC5v5BQNuNgmDpJOx6C
	 jY3Vc8643vDVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 10378C41614; Wed,  8 Jul 2026 12:58:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] bluetooth and wireplumber stop working after some time
 - dmesg report BUG
Date: Wed, 08 Jul 2026 12:58:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: nicolas.baranger@3xo.fr
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218952-62941-yUUMWyzL4H@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218952-62941@https.bugzilla.kernel.org/>
References: <bug-218952-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218952

--- Comment #8 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
Hi=20=20

I'm sorry I cannot confirm or infirm as I don't have the affected hardware
anymore, but I can confirm I don't have this issue on my 2 new Dell laptops=
:=20=20


- Dell Precision 3590=20=20
- Dell ProMax 16=20=20=20=20

And XPS15 7590 is not affected (not XPS 9570 which was affected).=20=20=20=
=20


Please note that it could be hardware / firmware related as I had a similar
issue a few months ago on Win11 Enterprise edition installed on one partiti=
on
of my corporate Dell ProMax 16, and it had beed fixed by Dell Support Assist
firmware update (in the meantime I didn't constat this issue while using De=
bian
13 on this laptop)=20=20=20


Maybe @martin@hignett.net still have the hardware to test...=20=20=20=20=20

Regards
Nicolas

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
