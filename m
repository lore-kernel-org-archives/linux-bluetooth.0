Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39829B78D
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753599; cv=none; b=EgoZcFfr1CX5cXBxjbhOYLZj9y/ckFKSQ9MJ45LNCTGFk3VdMtMDpLfe7zjVnOGlBZJLjqO5qI1M5VS5FNPqdRW7GeLq8O2gt4nVeN/m23xd2YvacrfpuNIelHgi4FnFrzkkiDMpRSZZcBxSW/LS5pu/Ggpmr2rnOnaqaFqVhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753599; c=relaxed/simple;
	bh=OquvsLePnBZfquWJXyza2AiBVl31+OuxIHijYe6vPiQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JdFNbRbxuKpapedkEPp3DNTgRJtJ0BW8xaTfVVbe+9nykhfPv49V6m+qIZYyY58ucm4YZLbHoMwXOAtvH/Nuxx/Xy44pH5pMuoeSLM0WkRM8waj7sajbgIt4/I7btbJNbv9hWoQws7i7puDlxpwRLP3D9ubOC6gXFVx5gFazn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTqaPyTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTqaPyTh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11099C2BCAF
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775753599;
	bh=OquvsLePnBZfquWJXyza2AiBVl31+OuxIHijYe6vPiQ=;
	h=From:To:Subject:Date:From;
	b=GTqaPyThSKWPZuPA2i7Cy27XMV17GpyRV3g19/FXy7wZYWPRHS4XJsFhjUr0pVztp
	 M0oXn8hG3Wt1JQZ/c6BSk0mudrovKJl3vK7oWKdwiBEVdz6Uv8mI0yr2bGEWaywIxH
	 K+z66DQDE/+taDMLTyJ4oreo6Q6zyJXEwRAWwPAGKIiAUDTNnjmJg6eKkBlu8kNEmo
	 2+XFQDfzt6mJDwcXCQW2pJhPM1gSMm1ddLnuPLlh1X2Gpr+RESInWIcnRygy4DBowr
	 xIotxLUtTX5VM9VI8hC8i4U2XcQtnqJfa8a1EpXjvSWpJLP0nfNajU0oO7dJoLzBX5
	 2+AUJqPEajbow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0424AC4160E; Thu,  9 Apr 2026 16:53:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] New: AX200 -19 errors on boot after firmware
 20260313-1.1
Date: Thu, 09 Apr 2026 16:53:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pallaswept@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_file_loc bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cc cf_regression cf_bisect_commit
Message-ID: <bug-221339-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221339

               URL: https://bugzilla.suse.com/show_bug.cgi?id=3D1260599
            Bug ID: 221339
           Summary: AX200 -19 errors on boot after firmware 20260313-1.1
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.19.9
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pallaswept@proton.me
                CC: tiwai@suse.de
        Regression: Yes
           Bisected 81608d9216ce1fe954e205aa867655b1a5bce1c5
         commit-id:

Since updating my firmware recently I started to see these -19 errors on bo=
ot:

> journalctl -b 0 -g hci0
Mar 26 13:40:39 Pallas kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
Mar 26 13:40:39 Pallas kernel: Bluetooth: hci0: Boot Address: 0x24800
Mar 26 13:40:39 Pallas kernel: Bluetooth: hci0: Firmware Version: 255-255.2=
55
Mar 26 13:40:39 Pallas kernel: Bluetooth: hci0: FW download error recovery
failed (-19)
Mar 26 13:40:39 Pallas kernel: Bluetooth: hci0: sending frame failed (-19)
Mar 26 13:40:39 Pallas kernel: Bluetooth: hci0: Reading supported features
failed (-19)
Mar 26 13:40:39 Pallas kernel: Bluetooth: hci0: Error reading debug features
Mar 26 13:40:39 Pallas kernel: Bluetooth: hci0: HCI LE Coded PHY feature bi=
t is
set, but its usage is not supported.
Mar 26 13:40:41 Pallas kernel: Bluetooth: hci0: Failed to read MSFT support=
ed
features (-110)
Mar 26 13:40:42 Pallas kernel: Bluetooth: hci0: Bootloader revision 0.3 bui=
ld 0
week 24 2017
...

These errors are present with firmware 20260313-1.1 but are not with
20260206-1.1. I also see failures to mount USB drives during boot, and this
device is USB connected. Bluetooth and USB in general do seem to be working=
 OK
after I'm logged in.

Thanks for any help

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
