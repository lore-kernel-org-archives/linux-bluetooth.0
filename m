Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF7285CBA
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211792; cv=none; b=qfwEGxTcbsOfWjYm9Nr2gzU/saeYWKE3gFndytp5L8fm6Wk9ESNzDF3hiEbrxOqFFN/Va4gzu/vgCemaEQyob04fM27ZW4wDovWz53rmr1YvwaK0HkSdCqnOVQ5GnY6HEPA5+a42BdoFqPw8hKqVFuaHcNgc64Uzro/wNw5RO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211792; c=relaxed/simple;
	bh=uK1igBHmYuY0zcddX/XnnBFpGQYQQx9ol6jKa6fQc5Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IIBE1Zb2KljcxkIJlLvrc65X/Q+Mr7fyif647+74fkmVKBOXeXmNld+krID6AOLIXPFm/yRDDUTIuyN0ztJx/QUkM8YAE1Sc9SBDIA50mt/LHgFVyGUmFYmlPocJ1MxKcUJiaZsnMwjHNPIZPy2zBcjX4SfxDNmI97NZPoatDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlkkJ2qu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlkkJ2qu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63029C2BCB3
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211792;
	bh=uK1igBHmYuY0zcddX/XnnBFpGQYQQx9ol6jKa6fQc5Y=;
	h=From:To:Subject:Date:From;
	b=XlkkJ2quQWa/D7MAU0xGz2F5jBMy5eeEk66TLHUg57nc59I3GhTAXveIoCa9B0gj6
	 1mrSUphcj+hYP0Y6ewxNb+YxOzsGilWeorFKtcqpvBxq9pfQjel6CItXndtj7hsGoN
	 WWgYsGt76/fx7A95TOrWQ9Xa7XuXVywjpqEq7Cwc2jw/6Z/VcYXCairiL0WtkdyiEY
	 4WRSWnlqfIlKfBPOiu+jYHySi8U6kSNT+orwE1Nyx2POI4UeIRvTfGGHyxFtpSAgRw
	 7I6dtV/2POMgsyFjEycnn6Zgp/gdHvQpoEwceXAU7sS4epK1pnL4IE+8FFfd03ro73
	 Vkze00a1aFQJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5A0A3C4160E; Tue, 19 May 2026 17:29:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221552] New: btmtk: MT7921 (USB 0e8d:e020 / PCI 14c3:7920)
 Bluetooth broken since 7.0.7 - fix for 0489:e0e2 does not cover this PID
Date: Tue, 19 May 2026 17:29:52 +0000
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
Message-ID: <bug-221552-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221552

            Bug ID: 221552
           Summary: btmtk: MT7921 (USB 0e8d:e020 / PCI 14c3:7920)
                    Bluetooth broken since 7.0.7 - fix for 0489:e0e2 does
                    not cover this PID
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

Created attachment 310159
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310159&action=3Dedit
dmesg kernel (from 7.0.9-hardened1-1-hardened)

Regression: Bluetooth controller fails to initialise on a MediaTek MT7921
(Legion Pro 5 16ADR10, Realtek-branded module) since kernel 7.0.7.
Last known good: 7.0.6. Same dmesg symptom as the regression already
patched for USB ID 0489:e0e2, but the fix does NOT resolve it for this
device (USB 0e8d:e020), which suggests the patch missed a code path or
device-ID entry.

Hardware
--------
lspci -nnk:
  03:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7920]
        DeviceName: Realtek
        Subsystem: Lenovo Device [17aa:e020]
        Kernel driver in use: mt7921e

lsusb:
  Bus 003 Device 006: ID 0e8d:e020 MediaTek Inc. Wireless_Device

Kernels tested
--------------
7.0.6                    : Bluetooth works
7.0.8 / 7.0.9 (mainline) : broken
7.0.9-hardened1-1        : broken (linux-hardened =E2=80=94 current)
  This build includes the backport
  https://github.com/anthraxx/linux-hardened/commit/<=E2=80=A681d80fcd09>
  which adds the fix for USB ID 0489:e0e2. It does NOT fix 0e8d:e020.

uname -r : 7.0.9-hardened1-1-hardened

dmesg (from kernel 7.0.9, relevant lines)
-----------------------------------------
[   23.898011] Bluetooth: Core ver 2.22
[   23.898032] NET: Registered PF_BLUETOOTH protocol family
[   23.898033] Bluetooth: HCI device and connection manager initialized
[   23.898041] Bluetooth: HCI socket layer initialized
[   23.898043] Bluetooth: L2CAP socket layer initialized
[   23.898045] Bluetooth: SCO socket layer initialized
[   24.800153] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time:
20260224111231
[   24.922472] Bluetooth: hci0: Failed to send wmt func ctrl (-22)
[   24.922477] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
                command is advertised, but not supported.
[   25.517793] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   25.517796] Bluetooth: BNEP filters: protocol multicast
[   25.517800] Bluetooth: BNEP socket layer initialized

Userspace state
---------------
bluetoothctl list  =E2=86=92 (no output)
bluetoothctl show  =E2=86=92 No default controller available

Module
------
modinfo btmtk:
  filename:
/lib/modules/7.0.9-hardened1-1-hardened/kernel/drivers/bluetooth/btmtk.ko.z=
st
  firmware: mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin
  firmware: mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin
  firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
  firmware: mediatek/mt7668pr2h.bin

Versions (Arch Linux)
---------------------
linux-firmware           : 20260410-1
linux-firmware-mediatek  : 20260410-1
bluez                    : 5.86-6

Steps to reproduce
------------------
1. Boot kernel >=3D 7.0.7 on a system with MediaTek 14c3:7920 / USB 0e8d:e0=
20.
2. Bluetooth controller fails to initialise; -EINVAL (-22) on wmt func ctrl.

Expected
--------
Controller comes up, same as on 7.0.6.

Related
-------
- Arch forum thread: https://bbs.archlinux.org/viewtopic.php?id=3D313552
- Same symptom, different PID 0489:e0d8:
  https://bbs.archlinux.org/viewtopic.php?id=3D313561
- Existing fix that targets 0489:e0e2 only:
=20
https://github.com/anthraxx/linux-hardened/commit/d019930b0049fc2648a6b2798=
93d8ad330596e81
  (does not cover USB ID 0e8d:e020 =E2=80=94 a second device-ID / code-path=
 entry
  appears to be needed)

I can test patches.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
