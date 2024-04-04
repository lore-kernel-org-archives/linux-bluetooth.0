Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FE548F1
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214129; cv=none; b=J/12m1Lcc5W7LrjPZ5VQh+7RDuv5PX3T5BSx/8DFlS1fsImB/Hpn56jjX5DDMK+Fij3X+APNwN/mqOa2i08QdSXVbhhCosst9R0tXIkoe9o5AwYAAgbl+VxxHS+VLtuhytGnfr65yPwp9sn12zVRSCt2Q433ncc/W0jdwramJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214129; c=relaxed/simple;
	bh=dFJRj380gKVI43/nlP7xKAJau1g/342z2iAdld/1AII=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EDf2Q5WxXsllrdmfASKPv5yZ56axeleGK5FZnJkkvW8Ge1UdrsMvXGJsiwGlb+FaFBBh1jCniuURVLvI6qmwURbZavyznv+61b/wB7xbz4rxzgzXircaEeBfG9pcCA16WnbYAoPltfaYNdE4eWg3xhrrmo0hcUsqfnJnN8HcBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svsFl811; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svsFl811"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 076A6C433C7
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 07:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712214129;
	bh=dFJRj380gKVI43/nlP7xKAJau1g/342z2iAdld/1AII=;
	h=From:To:Subject:Date:From;
	b=svsFl811ZEe04D6HBhFox7Dqr9TC9jCTQ0fAEWcgM64ZJ5INHsLUyknrr1PYRkKL1
	 fGXoeUlDmCn3wTE1yD4YE4N1tt1lIYRYWrxC8ei/majDyLt8mLEdCT6CdRCdVSyfTq
	 w6uPAAtvDGIXtNYLcEXTcSRwfYfVsl4Ei16t8Y8WZ3hrCkFv3ZN2X045fqE4WRSp2e
	 f7MqfBmV7D+3toYijRYb60DeLA66uSrw2ZaB8DHC1vwlXunpYfRNJ0KNaLZ3HmmzQn
	 nu0vNsa3sKT//OJkI5u9X2FPlsulva1Pie5dxfj/8NLH2L/hysVIqkO4SbN4FcTDhu
	 MN4hPPC3gHHnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EC501C53BD2; Thu,  4 Apr 2024 07:02:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218680] New: bluetooth connected status not shown in KDE
 desktop GUIs
Date: Thu, 04 Apr 2024 07:02:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wolf.seifert@web.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_file_loc bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cc cf_regression cf_bisect_commit
Message-ID: <bug-218680-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218680

               URL: https://github.com/archlinux/linux.git
            Bug ID: 218680
           Summary: bluetooth connected status not shown in KDE desktop
                    GUIs
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.8.2
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: wolf.seifert@web.de
                CC: luiz.dentz@gmail.com
        Regression: Yes
           Bisected 81526f2920bf8a03b670dbc2d45f35f204344d55
         commit-id:

Since 6.8.2 bluetooth connected status is not shown any more in KDE desktop
GUIs: it looks disconnected but in fact is connected and working (bluetooth
headset).

$ systemctl status bluetooth
bluetoothd[413]: Authorization request for non-connected device!? (in RED)

The "Authorization request for non-connected device!?" also appears in the
journalctl output.


It turned out that commit "81526f2920bf8a03b670dbc2d45f35f204344d55" is
responsible for this malfunction: I made an Arch Linux package build for
6.8.2.arch1-1 with this single commit
"81526f2920bf8a03b670dbc2d45f35f204344d55" reverted and it worked again. So
"81526f2920bf8a03b670dbc2d45f35f204344d55" is the one and only cause for th=
is
malfunction.


$ git show 81526f2920bf8a03b670dbc2d45f35f204344d55
commit 81526f2920bf8a03b670dbc2d45f35f204344d55
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Jan 31 11:24:19 2024 -0500

    Bluetooth: hci_event: Fix not indicating new connection for BIG Sync

    [ Upstream commit eeda1bf97bb500a901f7a9ee5615bad2160f2378 ]

    BIG Sync (aka. Broadcast sink) requires to inform that the device is
    connected when a data path is active otherwise userspace could attempt
    to free resources allocated to the device object while scanning.

    Fixes: 1d11d70d1f6b ("Bluetooth: ISO: Pass BIG encryption info through
QoS")
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Signed-off-by: Sasha Levin <sashal@kernel.org>
...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
