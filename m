Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95D273D77
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Oct 2025 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522109; cv=none; b=DBS7D0UtI+dECFKUtfv3ib3FOo9z72X8m1E/+FL3FAzpPq48XmcfAYqGalUreQq7I5XV1mgX+Y3kv/W1oG6Z7jpd7azBXPp4V2Vr50t14E7EzyR8PaTxV+PlSG0Q7mpH6jdf61EXmzC+o63NkAgESMMz526TvUluVMnoV5nugHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522109; c=relaxed/simple;
	bh=CAG0Oh1sgAv4ZDbqo1UlVRzS7jFtzlxpzFVPecO+V3s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MHKjVM8N4pombfgBLHha7hwu31qIDyPV8gzjpY+UhhiV85kPhadDP41B+Lz/txUkBgoBslhvG6RhvXoiWbFBN3x9j4YnkxPzk0C6fo9dh/LLyNfycSCtwBW76aXwsKi3y3cg9ciP8JmERT7BWOJghL3og1tomX0TSnBpIRMpCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQTPYvkl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQTPYvkl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F7D1C4CEE7
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Oct 2025 23:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761522108;
	bh=CAG0Oh1sgAv4ZDbqo1UlVRzS7jFtzlxpzFVPecO+V3s=;
	h=From:To:Subject:Date:From;
	b=FQTPYvklSzxHBPiVPxSzFmuugCFUCl4aGC3Ylz+R/6eUaI9Gg9/2pjHtZJF04/tVJ
	 YHalR64uuPotYqaad9DriPKQFF2hEiDPC/2bGspyvXbRneOSdVKEaLDdqRAyS7xwOc
	 VHJ5N+rGPsmj+ULalk9qYoQvEkaUstOvBNhL/0Sk9bu5/km63/2YS3JFQBYUggdI3+
	 2y5xDV4Z/i6q9OGtTEKpc8+x6Xv0lZRDd3jJlUZosHX99HU6/wnrwcvz0gQidYHluY
	 CwrZSdYTBHgAUFCrh3PR82GbR6vX+C5TQRyg3d3GNMZzm/PPnlKcdtRLsPFE3sOwDS
	 eohb9wH/olU8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F185DC3279F; Sun, 26 Oct 2025 23:41:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220703] New: Bluetooth connection is sporadic, quality is poor
 - halts and stammers with linux-firmware-network-20250917_1
Date: Sun, 26 Oct 2025 23:41:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bob.hepple@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220703-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220703

            Bug ID: 220703
           Summary: Bluetooth connection is sporadic, quality is poor -
                    halts and stammers with
                    linux-firmware-network-20250917_1
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: bob.hepple@gmail.com
        Regression: No

Laptop is a Dell Latitude 3120 probably manufactured in 2021.=20

OS is voidlinux/x86_64/glibc:

Linux dosa 6.12.54_1 #1 SMP PREEMPT_DYNAMIC Mon Oct 20 18:07:19 UTC 2025 x8=
6_64
GNU/Linux

Bluetooth Chip is an Intel AX201, lsusb gives:

Bus 001 Device 005: ID 8087:0026 Intel Corp. AX201 Bluetooth

I found that booting an old Mint USB stick worked fine so I thought to try =
an
older version of the firmware:

From dmesg I found that the firmware is /lib/firmware/intel/ibt-19-0-0.sfi =
and
ibt-0040-0041.ddc

The Mint 8 version of the firmware is 249-27.23

The VoidLinux version is 193-33.24 (ie 2024 and newer)

Get the 2023 firmware files:

cd /tmp=20
wget
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/plain/intel/ibt-19-0-0.sfi?h=3D20231030
-O ibt-19-0-0.sfi.20231030.249-27.23=20
wget
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/plain/intel/ibt-0040-0041.ddc?h=3D20231030
-O ibt-0040-0041.ddc.20231030.249-27.23=20
sudo cp /lib/firmware/intel/ibt-19-0-0.sfi
/lib/firmware/intel/ibt-19-0-0.sfi.193-33.24=20
sudo cp /lib/firmware/intel/ibt-0040-0041.ddc
/lib/firmware/intel/ibt-0040-0041.ddc.193-33.24=20
sudo cp ibt-19-0-0.sfi.20231030.249-27.23 /lib/firmware/intel/ibt-19-0-0.sf=
i=20
sudo cp ibt-0040-0041.ddc.20231030.249-27.23
/lib/firmware/intel/ibt-0040-0041.ddc=20
sudo reboot=20

bluetooth (& wifi) work perfectly with the older firmware - does the driver
need an update to catch up with the newer firmware?

Also posted here: https://github.com/void-linux/void-packages/issues/57670

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
