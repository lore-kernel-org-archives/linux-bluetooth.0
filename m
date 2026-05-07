Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3EB241CB7
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182119; cv=none; b=jQe1CDv2olqfsogh8m9DDHKst2f5E81dT6ORcxGfuDzvN3nZ1A4MkTUSYAS0AdA9HFlWBkp1ZesVC1UE1nW8uFYh3oVCltXtZNjgHOSOUx3P1vVku4paGZ7m7slBx086DPoCnic7mYDDRfAn3RutJ26+H88LJg9eCeR2zTv4Mt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182119; c=relaxed/simple;
	bh=cB4Ct01ZFwvEQ9sSqfLnZhfRPMc1qWRtPSDSTtVjSh8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=azsWRJ5+d+sRcNnPbuxUQElsZv94YJqAxx8bWq8noJFp9qv6tX5OUPmWgv3UNz47kh7u2kZ8BLGmu2iYmesvukCXj/7OmuCs9CLVKdeJt6dNOa8aO66fbJYhjFl0W31ZGUdBsHYrMGc5JTYzG4cN3C/JbtLjsm9Wl6e3MR4tWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzQMTi59; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzQMTi59"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43288C2BCB2
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778182119;
	bh=cB4Ct01ZFwvEQ9sSqfLnZhfRPMc1qWRtPSDSTtVjSh8=;
	h=From:To:Subject:Date:From;
	b=DzQMTi59qmCbxfOx6wvV2VYo8mWGDAgQYtUXCvzg+p1r7/uW8JUECQ3rda4AU7vQE
	 chnpzTURlvHyMYTXMYArA+q/trn+hW4w3BkI0Yh9Oon3Fx5GAup8OVGCDlG0jSY5K2
	 9/qGXSKhxc5++YDIZmtHEb4ETilaG3aRjVt8D9rb3aRSrro9+qXIC5z1u/y27NcTa3
	 3BmiBVC0OyircdykDcYbKIFQbwcxAD7XLkEHpWb8W4WmyUJK8Uwz9ajft8sfFfUXfO
	 wyAHMLEGc8EMlwElZBUgHInI5HPvIpHzmJmzbJwgzs8avAUYqnVQDw7PwAFpv/1k/w
	 uO5kDcx71SiGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 34411C41612; Thu,  7 May 2026 19:28:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221481] New: btintel_pcie: suspend fails with -EBUSY on Intel
 Lunar Lake (s2idle)
Date: Thu, 07 May 2026 19:28:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: vladko@duck.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221481-62941@https.bugzilla.kernel.org/>
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

            Bug ID: 221481
           Summary: btintel_pcie: suspend fails with -EBUSY on Intel Lunar
                    Lake (s2idle)
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: vladko@duck.com
        Regression: No

Summary:
btintel_pcie returns -16 (EBUSY) during suspend, causing the entire suspend
operation to abort on Intel Lunar Lake hardware. The system immediately res=
umes
after every suspend attempt.

Hardware:
- CPU/Platform: Intel Lunar Lake
- Bluetooth device: btintel_pcie at PCI 0000:00:14.7
- iGPU: Intel Arc 140V (xe driver)

Software
- Kernel: 6.19.13-arch1-1
- Distribution: EndeavourOS (Arch-based)
- Desktop: KDE Plasma (Wayland)
- Sleep state: s2idle only (mem_sleep shows [s2idle], no S3/deep)

Reproduction
1. Boot system with btintel_pcie loaded
2. Run: systemctl suspend
3. System immediately wakes up; suspend never enters sleep state

Kernel log (relevant excerpt)
  kernel: PM: suspend entry (s2idle)
  kernel: btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_sus=
pend
[btintel_pcie] returns -16
  kernel: btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend
returns -16
  kernel: btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
  kernel: PM: Some devices failed to suspend, or early wake event detected
  kernel: PM: suspend exit
  systemd-sleep: Failed to put system to sleep. System resumed again: Devic=
e or
resource busy

Workaround
Manually unloading the module before suspend allows sleep to succeed:
modprobe -r btintel_pcie && systemctl suspend

Expected behavior
btintel_pcie should successfully suspend alongside the rest of the system
during
s2idle, or yield gracefully so the suspend proceeds without it.

Notes
/sys/power/mem_sleep reports [s2idle] only (no deep/S3), consistent with
Lunar Lake's lack of S3 support. The issue is reproducible 100% of the time
with the module loaded.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
