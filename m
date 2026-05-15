Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128433DF00F
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828497; cv=none; b=Focr+lMD9Omw/VMkMm6l41oBuFZRyubx1Q9MFN4pVB3Qrovz4Ap7wJMMRRrHTirZsi6qK2aPDRYFieNNovxMPvouC9o480Wxtgm+2YCTUA+Oqti5LmftVG7L1jYuOzZ90/Ky8fBOatt5Sn6Vu9nm0L6+9XsPAD+FM9IL9xgV9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828497; c=relaxed/simple;
	bh=C2NNfWrL+p5YS1e4wbllvrK+9AEJBlDuRbnQwlB3BIU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qKxZEPQ7sopjfPA0jWdXqa3ab2Y9QEDAstqGunY1FWNhJJo608uVWqvMOUR2V0Se5Xf43RfX45BF46U0iP2rCZ/iphjyQxBB3xp+XOfB9tmRPP7fec9mnzww6A4aA5behYkgbEQ2bL428jl/nmZh6LeMHNP8a9T1v5Snw/lJ8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCbZ372w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCbZ372w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74558C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778828496;
	bh=C2NNfWrL+p5YS1e4wbllvrK+9AEJBlDuRbnQwlB3BIU=;
	h=From:To:Subject:Date:From;
	b=uCbZ372wxA4sxTd1q0pb7aJhrSvmyG99l0fE2hiYdbrvcYZjSftfPEu82H6I53KvM
	 8/1dp+q4O6cMqu8plwLUkbV6MBk/MbsWsapPo/CY7TD8NUf2G9l6ktl4DHxew4o0a8
	 Rt0AX6P9FEwA0d3Go/nUZdaofqOimk/dMllRlcmtBBiKUN9LyUrW+NKdjZ0XvkqTUS
	 ElZf/9/bO2gJb0rAbKgd2US95XhX7uWyTPWIyqhTQwwzGRYg9CI/hRpjfk5HjSVdsk
	 bOdg/vtEG1O4O9UMG4HioV14qvjQ042pJHmLyu7pjU/FkdeEKStQ7rUUHocmFVS0+M
	 nQ8BAYI8EBszw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 61823C4160E; Fri, 15 May 2026 07:01:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] New: Bluetooth: btusb/mt7921 - Failed to send wmt func
 ctrl (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 07:01:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: txxlc@pm.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

            Bug ID: 221521
           Summary: Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
                    (-22) on MediaTek MT7921 combo adapter
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: txxlc@pm.me
        Regression: No

On kernel 7.0.7, the Bluetooth portion of the MediaTek MT7921 PCIe combo
adapter fails to initialize. The btusb driver detects the device (hci0), but
initialization aborts with:
Bluetooth: hci0: Failed to send wmt func ctrl (-22)
As a result, bluetoothd starts successfully but reports no available
controllers. bluetoothctl list returns empty, and GUI managers (blueman,
bluedevil) cannot enable the adapter. RFKill shows no software/hardware blo=
cks.
The Wi-Fi portion (mt7921e) initializes and works correctly.

Steps to Reproduce
    1. Boot system with kernel 7.0.7
    2. Check dmesg | grep -iE 'bluetooth|btusb|mt7921'
    3. Run bluetoothctl list
    4. Observe Failed to send wmt func ctrl (-22) in kernel log and No defa=
ult
controller available in BlueZ

Relevant logs:
% sudo dmesg | grep -A2 -B2 'wmt func ctrl'
[    6.063435] input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input16
[    6.063488] input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input17
[    6.078123] Bluetooth: hci0: Failed to send wmt func ctrl (-22)
[    6.078129] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[    6.133913] mt7921e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build Time:
20260224110909a

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
