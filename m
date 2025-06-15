Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C0262FDD
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750022446; cv=none; b=CRbJ2H5ZJJJ2bBkUipHBm39NLWOT6u/4UEWlkqVAyXUhzBEdtfcGX5VzdJP7AIZBAkknWAyqAUWMISS4Ox2yCtf+7b3DfrvbfLgMROhPaE6W2Zii2VUdUk7rVpuz2fYrD6Kvj+1+iT8tS4G2erQQygOa7oJw+bQhLlKGWUcHai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750022446; c=relaxed/simple;
	bh=yh6KfsZuovLQuS0UVMKTMRGc22O8BNhNA5t0ikKloBQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SQkRSbfJtmaLY75JQM6LduKnd5mcwBjpqljfOcEo8nU/SWujRmnbnDC+kGGZSSkzlXg/y8sxCn2jMIigkeceSDAG3+jh+Y/uF+8Pi/SXP1ioZy+HFx7dXbwnB/flFfStGqO5yVUNiNl3sIhqaUw8kq024rWZvJG66NDmdc8/t7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB7QM3Ag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB7QM3Ag"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB4A1C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 21:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750022445;
	bh=yh6KfsZuovLQuS0UVMKTMRGc22O8BNhNA5t0ikKloBQ=;
	h=From:To:Subject:Date:From;
	b=XB7QM3AguAqYuMxbQ/fp9zeKWpynHP7Mq23ggGFaiNJVFTOY/eQ/KHUfUiMhKMk1G
	 kemQRD7F/4jr2Gw+oBb0hFlrO2B6dhaMao0rPYEWxcCTn5VYC70TIIZoFobio4HrDE
	 bo65wXTONJ4KJLP/bRDNAIC3nzN3EyByMm2QK7h0WhmjIf1RKMzvKoVD2KTwo90uAd
	 POBSWsAhbZlUB0FoEfkpVFENwTm1s4KfpNEwbZhxPdk3HuMlwXSx76flNbGCjv2umx
	 SZhte/HD+kRWMyTuHOxCVoonmifIoRdrwR3MkmsvXE3FBcHWm3bgQqLcDcyPQZiQiS
	 mBOQIobluufdw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BDFE1C4160E; Sun, 15 Jun 2025 21:20:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220237] New: Bluetooth: MediaTek MT7925 (0e8d:7925) fails to
 load firmware with timeout (-110)
Date: Sun, 15 Jun 2025 21:20:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: are.mehus@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220237-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220237

            Bug ID: 220237
           Summary: Bluetooth: MediaTek MT7925 (0e8d:7925) fails to load
                    firmware with timeout (-110)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: are.mehus@protonmail.com
        Regression: No

Created attachment 308259
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308259&action=3Dedit
Output from dmesg log

Hello,

The MediaTek MT7925 Bluetooth device (ID 0e8d:7925) consistently fails to
initialize on my Debian Trixie (Sid) system. The kernel log shows a firmware
upload timeout (-110) during the boot process.

Key Findings:

This is not a recent regression. The issue occurs on the latest experimenta=
l=20
kernel (6.15) and also on an older kernel (6.12).
This is not a missing firmware issue. I have installed the latest
firmware-misc-nonfree package and have also manually updated the firmware f=
iles
from the master branch of the linux-firmware git repository.
This is not a power management issue solvable by parameters. The pcie_aspm=
=3Doff
kernel parameter has no effect on the problem.
This is not a BIOS/UEFI configuration issue. Fast Boot and other aggressive
PCIe power-saving features have been disabled in the BIOS with no effect.
This appears to be a fundamental bug in the kernel driver's handling of this
hardware.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
