Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3729BD91
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782555199; cv=none; b=u0MfT2gO6y0glCXb5aQVUzJHK1DYofaN0fGth7sBX1ONXRkuFdiY7hynzA+os3biouPDVp8aG4XD/7OivsmxqEWvX45DX0kAPmcLw7ux8d2tIv4Nk7vOkJc27Kg4lvJT/QSGCCAscrF6ot9N1tCIKcjk/eP4BSyT0oWP0JNd6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782555199; c=relaxed/simple;
	bh=b6EkOpvSwGHUv3eO+z3JklU/4lSEuqlKBNofegbUyt0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OrrklsCDvGLp+Ikf2zmxKnwLKtTXBQSsuOwHRP4yxtdef+vJ2PIH+rZaByyFkQsq6ynZfwZ42pJd0jCFaLLxGxSUo6CNDJB30XTLbhWWQwCBQJol25kiInH5GdHifRLHiXwLpzTzgTzwTNoDr4WXRAGvSa7lZLpoQErlnAwF//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym7DXGP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym7DXGP6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE3B4C2BCB3
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782555198;
	bh=b6EkOpvSwGHUv3eO+z3JklU/4lSEuqlKBNofegbUyt0=;
	h=From:To:Subject:Date:From;
	b=Ym7DXGP6v7MB5fcckIBgB9M+RkIuhC/PF6KKDvSEh6Jbc4bg9xrxDdQCrUmXj4krd
	 98BcBXZQH/eu6jFi4KMfSxoSwDQA1cSxuqyUF2xlAQlVe+Ho2WksdbX3kqNXnjhsvh
	 xtM5dPKdXmXF13omsaxi2CPqWaf3sQAXI8Vd1oLfMH715MMFuTCbKiJuFqSy9FuwWr
	 ZAkJDR1Q27/UuqK0u+B/gABNb9Rbbc9pDIJ5vcEUBRGCRuhN6pmaFq62TjBVBszEzK
	 dyqUV2F+9OZMmJUQp09pqzxFWMSS6ZpM05a0Ne1mt0SuqIZNUQyLxO1K9iXYEVcqyA
	 muwBGkt/7+yAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 857A2C3279F; Sat, 27 Jun 2026 10:13:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] New: btmtk: regression in 6.6.142: NULL pointer
 dereference in btmtk_usb_hci_wmt_sync during resume from S4
Date: Sat, 27 Jun 2026 10:13:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@mattwhitlock.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-221696-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221696

            Bug ID: 221696
           Summary: btmtk: regression in 6.6.142: NULL pointer dereference
                    in btmtk_usb_hci_wmt_sync during resume from S4
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.6.142
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kernel@mattwhitlock.name
        Regression: Yes

I have a problem that appeared in the 6.6.y series recently, I believe in or
around f0457842215438786e2e205ad06a4fbb8ab63cd0, although I haven't bisecte=
d.
The problem did not exist in 6.6.140 but does exist in 6.6.142 and 6.6.143.

The problem =E2=80=94 during resume from hibernation (platform S4) I see th=
is NULL
pointer dereference in the kernel log:

BUG: kernel NULL pointer dereference, address: 0000000000000219
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP
CPU: 7 PID: 214 Comm: kworker/u33:0 Not tainted 6.6.143-gentoo #1
Hardware name: Framework Laptop 16 (AMD Ryzen 7040 Series)/FRANMZCP09, BIOS
04.03 12/22/2025
Workqueue: hci0 hci_power_on
RIP: 0010:__pm_runtime_resume+0x15/0x80
Code: 55 fe ff ff 83 e0 02 45 31 e4 e9 45 fd ff ff 66 0f 1f 44 00 00 f3 0f =
1e
fa 41 54 55 53 48 89 fb 48 83 ec=E2=80=A6
RSP: 0018:ffffc90004a37c18 EFLAGS: 00010246
RAX: ffff88810bdcd4f8 RBX: 0000000000000050 RCX: 0000000000000000
RDX: 0000000000000035 RSI: 0000000000000004 RDI: 0000000000000050
RBP: 0000000000000035 R08: ffff888fdfde6bd0 R09: ffff888101338a40
R10: 0000000000000001 R11: 0000000000000040 R12: ffff888101338a40
R13: ffffc90004a37cc0 R14: 000000000000003a R15: ffffc90004a37cb4
FS:  0000000000000000(0000) GS:ffff888fdfdc0000(0000) knlGS:0000000000000000
GS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000219 CR3: 0000000003e11000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 usb_autopm_get_interface+0x1a/0x50
 btmtk_usb_hci_wmt_sync+0xb8/0x480
 ? btmtk_usb_wmt_recv+0x240/0x240
 btmtk_setup_firmware_79xx+0x1a4/0x360
 btusb_mtk_setup+0x45b/0x690
 hci_dev_open_sync+0xdd/0xa40
 ? try_to_wake_up+0x235/0x510
 hci_power_on+0x69/0x2b0
 ? lock_timer_base+0x6a/0x90
 process_one_work+0x154/0x2f0
 ? process_one_work+0x2f0/0x2f0
 worker_thread+0x18b/0x310
 kthread+0xe0/0x110
 ? kthread_complete_and_exit+0x30/0x30
 ret_from_fork+0x2c/0x40
 ? kthread_complete_and_exit+0x30/0x30
 ret_from_frok_asm+0x11/0x20
 </TASK>
CR2: 0000000000000219
---[ end trace 0000000000000000 ]---

The BUG dump appears while the system is waiting for me to enter my LUKS
passphrase =E2=80=94 i.e., *before* the initramfs writes the swap device ma=
jor:minor to
/sys/power/resume to initiate resume from hibernation.

I am still running kernel 6.6.140 in my current session. In other words, a
6.6.143 kernel is booting to resume a suspended session that is running a
6.6.140 kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
