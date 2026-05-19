Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D063DB32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211283; cv=none; b=j2pskQ+kA9RgfLaC797eetMHNdp3qcVybMVaBADNn6DwTDIi/KLbPotkAR2HHphSH05rLJy5Vq1IbABNokcnhcyLjD+3TXu31wwrDyArVSleq2zU7RPgob/5HZ4msSXgdyuLZXaUDuj/UJi+yu9GAwe+BWRFzD9q88U+iCVJuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211283; c=relaxed/simple;
	bh=kKgQKr4/6zpjJHIK+0ldog74hnf4i77nO4OnhB8zfc8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gjacn8KyB4qOjLMrVNQMJL0j2xLyW755amHty7REaMSgq4JtjD5LJjtd8vn4+KzR9RrtzvRpvUL4bMm6Aj1DarNVvOHiu/IOedcUmggcSaDKuCOsh0wFpqtPSkB8rdsqd+FjR1f75q+JLPR9P7T9FWtOG0PIODlPEy/91jcdSOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgNDt17I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgNDt17I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91923C2BCB3
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211282;
	bh=kKgQKr4/6zpjJHIK+0ldog74hnf4i77nO4OnhB8zfc8=;
	h=From:To:Subject:Date:From;
	b=bgNDt17IbXcSP6S+Wl/T1A8OFopBDQJPISBdVxUxsASx1HV4BIbjLggMazf3QOcYi
	 6pK1s4AWmNYsj2T9+Jw29LXgX53dLtAqkGq9TSMo909YGV7ACOfIIstgzcPmQ9lJ5L
	 nFzxcHbUM2eN2Z3dH2vAwQrIMMEDj/BvxtHqnAEvJ2lua2r34FiIYyOqNIsHycf1LK
	 HfUB1a4I9lGPuwcHWIGmCmCfizySd8A+WEAi4aK/8rOTigYGyckiSB7uTxILXKrXJV
	 YV4WoFVuhV07WPLe9LHqaQavpMJuFlVRtMgWaOV5dXFcdZ7/gAn4tPHdEZKGYa3N+m
	 8SKFTNEWLObfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7F31DC433E1; Tue, 19 May 2026 17:21:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE1NTFdIE5ldzogYnRtdGs6IE1UNzkyMSAoVVNCIElE?=
 =?UTF-8?B?IDBlOGQ6ZTAyMCkgQmx1ZXRvb3RoIGJyb2tlbiBzaW5jZSA3LjAuNyDigJQg?=
 =?UTF-8?B?Zml4IGNvbW1pdCBmb3IgMDQ4OTplMGUyIGRvZXMgbm90IGNvdmVyIHRoaXMg?=
 =?UTF-8?B?UElE?=
Date: Tue, 19 May 2026 17:21:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: gagnieux.virgil@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221551-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221551

            Bug ID: 221551
           Summary: btmtk: MT7921 (USB ID 0e8d:e020) Bluetooth broken
                    since 7.0.7 =E2=80=94 fix commit for 0489:e0e2 does not=
 cover
                    this PID
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: gagnieux.virgil@proton.me
        Regression: No

Created attachment 310158
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310158&action=3Dedit
dmesg (from kernel 7.0.9, relevant lines)

Regression: Bluetooth controller stops initialising on a MediaTek MT7921
since kernel 7.0.7. Last known good: 7.0.6.

Same symptom as the regression already discussed and patched for USB ID
0489:e0e2, but the fix does NOT resolve it for my device (0e8d:e020),
which suggests the patch missed a code path / device ID.

Hardware
--------
lspci:  03:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7920]
        Kernel driver in use: mt7921e
lsusb:  Bus 003 Device 006: ID 0e8d:e020 MediaTek Inc. Wireless_Device

Kernels tested
--------------
7.0.6              : Bluetooth works
7.0.8 / 7.0.9      : broken (mainline Arch build, please confirm if you also
tested it)
7.0.9-hardened1-1  : broken (linux-hardened, includes the backport
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
https://github.com/anthraxx/linux-hardened/commit/<=E2=80=A681d80fcd09>
                    which targets 0489:e0e2 =E2=80=94 it does NOT fix 0e8d:=
e020)

dmesg (relevant lines)
----------------------
[   24.800153] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time:
20260224111231
[   24.922472] Bluetooth: hci0: Failed to send wmt func ctrl (-22)
[   24.922477] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
               command is advertised, but not supported.

Userspace state
---------------
bluetoothctl list  =E2=86=92 (no output)
bluetoothctl show  =E2=86=92 No default controller available
rfkill             =E2=86=92 hci0 not present / soft blocked depending on b=
oot

Versions
--------
bluez                     : <colle ta version>
linux-firmware            : <=E2=80=A6>
linux-firmware-mediatek   : <=E2=80=A6>

Steps to reproduce
------------------
1. Boot kernel >=3D 7.0.7 on a system with MediaTek 14c3:7920 / USB 0e8d:e0=
20
2. Bluetooth controller fails to initialise; -EINVAL on wmt func ctrl

Expected
--------
Controller comes up, same as on 7.0.6.

Related
-------
- Arch forum thread: https://bbs.archlinux.org/viewtopic.php?id=3D313552
- Related thread (same symptom, different PID 0489:e0d8):
  https://bbs.archlinux.org/viewtopic.php?id=3D313561
- Fix that addresses 0489:e0e2 only:
  https://github.com/anthraxx/linux-hardened/commit/<=E2=80=A681d80fcd09>

Please note: the existing fix above is referenced because it explicitly
does NOT cover USB ID 0e8d:e020. A second code path / device-ID entry
seems to be needed.

I can test patches.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
