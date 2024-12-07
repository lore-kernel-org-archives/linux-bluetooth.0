Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268A7711F
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Dec 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733564514; cv=none; b=iihHUhUV6xdFCv9xxLCqYK+ixNeJVCx02wuvMOJOvh5Gy602lTVblVq2nSx8xXRqV9HGxQfLqzocnFEuCDn5SmkM18Ojm/qPaeWEJCRPcSTRMPuFrVK3N7nwMqhI8bgIAJ9Cq+Fiyug6jIS7C+EFVU3p53Y32oLlyGsdRuMaZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733564514; c=relaxed/simple;
	bh=0dXKZeuxxXLJGLC5WfWPN6/rTfiI3XTXFETmvn0oTJE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KCax2Ts2yvK9zinQhrkS32d78CnlClPpsOC+VcbXvZvRA7XeSQTViBO8feQzQGRYHC7NCjFGKz/LEqM3iOBzbcrkZ3hmLzgmGyeW9NA1e6imCPkFN+/gFdRNLd1Xdg+LjE3oYA4yt9P8qMau2tkKIxjFuYGTR7McluEn44xwqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXQWQ+EX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXQWQ+EX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B715C4CECD
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Dec 2024 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733564513;
	bh=0dXKZeuxxXLJGLC5WfWPN6/rTfiI3XTXFETmvn0oTJE=;
	h=From:To:Subject:Date:From;
	b=sXQWQ+EXa14L8x+yKrvb2fX34xEaB5uV+usJC9u0GJAB8ZERXvwD0H2DxRjgeIFQy
	 RuTtqIBLc4MMJG8IJS2yn/fNkpiVfA7CGWbqNdl8H+nyYu2gsGQq0+Xe9HGY5XkI24
	 vgbVSxzh/1s0jU3azksvm2COE1TgnaIkzvt6iOrw7VMckBHpfaIg6sZcGfmEnVAm2X
	 tDPPjh6VvK1D6uleuCMHMSM5nAe24GLdsgrJ1+zJKQAUIXj3Gcne2+II2QlwPgIubE
	 4k7gmP3iKDgwkKUtoDZlr1LCcMsXZa9sge/kLcLsAnhgd//9XR6qodMWwx6eJ5eyQ1
	 DHJ5YmSyEWvFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6BBC0C3279E; Sat,  7 Dec 2024 09:41:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219571] New: Previous handle short-transfer fix for fake CSR
 controllers does not account for other fake devices
Date: Sat, 07 Dec 2024 09:41:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: sohailsameja@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression cf_bisect_commit
Message-ID: <bug-219571-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219571

            Bug ID: 219571
           Summary: Previous handle short-transfer fix for fake CSR
                    controllers does not account for other fake devices
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: sohailsameja@gmail.com
        Regression: Yes
           Bisected 2c1dda2acc4192d826e84008d963b528e24d12bc
         commit-id:

[  +9.730469] usb 1-1: new full-speed USB device number 10 using xhci_hcd
[  +3.071646] usb 1-2: new full-speed USB device number 11 using xhci_hcd
[  +0.374696] usb 1-2: New USB device found, idVendor=3D10d7, idProduct=3Db=
012,
bcdDevice=3D88.91
[  +0.000009] usb 1-2: New USB device strings: Mfr=3D0, Product=3D2, Serial=
Number=3D0
[  +0.000003] usb 1-2: Product: CSR8510 A10
[  +0.017967] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[  +0.000007] Bluetooth: hci0: HCI Read Transmit Power Level command is
advertised, but not supported.
[  +0.000002] Bluetooth: hci0: HCI LE Set Random Private Address Timeout
command is advertised, but not supported.


Some fake CSR controllers can also be identified as "Actions Semiconductor
ATS2851 based devices" i.e. 0x10d7, 0xb012 as seen above.

The previous fix should also account for such devices as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
