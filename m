Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D92798E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857908; cv=none; b=Ypu1ZxijiO4lQz/p6M6E6g6dscIVPcgXBmhVNdoeats00SU1kHM1hw1QtxQCb4U1mcyr454NuBm/Pe+ClvXcm33qRKzDgrCX8BrjtFnXSjqB6eGzoRoHtwbtkbU3TxBaAw5CZQ6klW2sNysC2+VfX0p8DtZuTI8gRSRv5gZCF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857908; c=relaxed/simple;
	bh=Fs8yCFSYuQ9wn5Hk9I3Umk3OzNN2SREwpy4S1xo19gE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qYHTHYoGdLv4Meh5sxape8NYJwPCAxYFvd+NDxADPD4W0rOYzEZn5MbLdkRZ4YBlijjpe5EwoMVXBF26wFJQTo+RUQw6k8p+RRFX+0mo5dHmmpDVkEpZa/KN2hBUvAK7FP3ngtxO3Qm2XCiUf82RbtbUdOvrd01NukCCsSbiQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQkm1wTz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQkm1wTz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74564C4CEE4
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745857906;
	bh=Fs8yCFSYuQ9wn5Hk9I3Umk3OzNN2SREwpy4S1xo19gE=;
	h=From:To:Subject:Date:From;
	b=KQkm1wTz6VMey1p8dNBTOiB+gqUGUBy0gayk3WSJ5QMBoGnDwCgr8Wkbv6y5ta0yo
	 2KPgnC75mtL/pGoOCpMxHba/XKxJyjjCoO26FzVWVJULCljNCUVk7JfU8CSKgAfmbL
	 UcfTHEL/6pKoCGbkjdhgLH0ie34Vwf9zgCRNdIMllE0/btMsOPTMMRe+kFfxpGZsT3
	 lndC09Uhg6HA3sNbnCvv6vp70b/UzjjHEs7EgCHAWUUSKFNwPbLAE3koNC1H5dZDIC
	 Z5h9PNTWixgJCeYbm6Cr205p0emrDVQkb3FYRLw1duDPJrHDMTnXuoikerjbtzqXKD
	 c54ofSh8iEFVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 651F7C4160E; Mon, 28 Apr 2025 16:31:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220063] New: DualSense and DualShock 4 controllers fail to
 connect since 6.14.4
Date: Mon, 28 Apr 2025 16:31:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alan.loewe@foobarlibre.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220063-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220063

            Bug ID: 220063
           Summary: DualSense and DualShock 4 controllers fail to connect
                    since 6.14.4
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: alan.loewe@foobarlibre.net
        Regression: No

DualSense and DualShock 4 controllers fail to connect since kernel version
6.14.4, at least if no other devices are connected. Connecting headphones
beforehand is a workaround.

Log message:
profiles/input/device.c:control_connect_cb() connect to ...: Host is down (=
112)

Someone on the Arch Linux forum bisected it to commit
d4ca2fd218caafbf50e3343ba1260c6a23b5676a:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.14.4&id=3Dd4ca2fd218caafbf50e3343ba1260c6a23b5676a

Arch Linux forum thread:
https://bbs.archlinux.org/viewtopic.php?id=3D305211

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
