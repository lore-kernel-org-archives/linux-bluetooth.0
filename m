Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FF3E1CE1
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321937; cv=none; b=Ar0Kkb+pWnTvt76bAYZohTjnUQBNmOaHUxyXYxNCVXhNMxO6x5Rw7F7WNxkbQkuxvTyfVfKGfuE8vIinJrJVnjU4U71pfWjQCHEUj2MdA5ge2GWmDKqXwOQOkuBQQG8xyqKatkPKZk/evqW+7zhXYmnuHWdlxTm/bcdZSWZUDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321937; c=relaxed/simple;
	bh=1WWbVLcxBy7agYAbzXd3j67NKI29fHLGerVPFUN8Ypc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ebTYITqKeQaT2oKfHBPpevGy35BGg1LwbKCAMOLcDbsXfnKFAQ1A0eh1LfGg/tur20Xsuth8HmJDu5+3UjPdF/OuPxSIvZIMWk1ZwJGX2sC0LPy6S0MgD5EIYD02k46hbu9+mUdBf4rrbnyffph3von+jqZpF5yPmnJ4tFgEkgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2Ur1O9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2Ur1O9d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BDC0C2BCF6
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 07:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783321936;
	bh=1WWbVLcxBy7agYAbzXd3j67NKI29fHLGerVPFUN8Ypc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n2Ur1O9dYZWNVG/OPaTwW2WIjRliHXQdBftenLJcddctBQE4rFM8RnaORu6eIGbXh
	 oKqfADs0BSnK5vuOECl5/ZwXfEq3k28JwEthpESNDhDUKTa+S/oCalDfPzcnMYpObp
	 ojSWu34H/90RH1Ld5qPviWlSezHc6V3YtFofqxQ8SbLVhHyBT5uGSv+dfpMR8Xg9wE
	 q+5wa1fbuLS28L2NnvRT7d2Je9pyT3rbWxIpw2O4P8lKRvG11+tSOYo8sHU1fJoL7W
	 9YI6L3cEicfdLjnCw65OkG8vvDhXSPqCty4EdIFwkfjTOkmrY0/qX0sbca+bC7RsTl
	 cXAXQ9V1TudNg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F423BC4160E; Mon,  6 Jul 2026 07:12:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Mon, 06 Jul 2026 07:12:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nibheis@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221637-62941-ra6fOwLdir@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221637-62941@https.bugzilla.kernel.org/>
References: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

--- Comment #10 from Pierre-Olivier Vall=C3=A8s (nibheis@gmail.com) ---
Hi,

Testing with kernel 7.1.2 and firmware snapshot from 22nd of June (no patch
applied).

Bluetooth device initialises correctly and is able to connect to other bt
devices (i.e. it works)
Still a lot of "Controller device warning (boot_stage: 0xa0db1003) / Receiv=
ed
gp1 mailbox interrupt" messages that we were not getting before.

$ uname -a
Linux x9.lan 7.1.2-arch3-1 #1 SMP PREEMPT_DYNAMIC Fri, 03 Jul 2026 23:25:36
+0000 x86_64 GNU/Linux

$ pacman -Ss firmware-intel
core/linux-firmware-intel 20260622-1 [installed]
    Firmware files for Linux - Firmware for Intel devices

$ sudo dmesg | grep -i bluetooth
[    1.242709] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is
unblocked
[    4.378750] Bluetooth: Core ver 2.22
[    4.379233] NET: Registered PF_BLUETOOTH protocol family
[    4.379235] Bluetooth: HCI device and connection manager initialized
[    4.379237] Bluetooth: HCI socket layer initialized
[    4.379239] Bluetooth: L2CAP socket layer initialized
[    4.379241] Bluetooth: SCO socket layer initialized
[    4.575746] Bluetooth: hci0: Device revision is 0
[    4.575750] Bluetooth: hci0: Secure boot is enabled
[    4.575751] Bluetooth: hci0: OTP lock is disabled
[    4.575752] Bluetooth: hci0: API lock is enabled
[    4.575753] Bluetooth: hci0: Debug lock is disabled
[    4.575754] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    4.575756] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 bu=
ild
45995
[    4.576600] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-iml.sfi
[    4.576610] Bluetooth: hci0: Boot Address: 0x30098800
[    4.576613] Bluetooth: hci0: Firmware Version: 226-18.26
[    4.634683] Bluetooth: hci0: Waiting for firmware download to complete
[    4.634696] Bluetooth: hci0: Firmware loaded in 56727 usecs
[    4.636984] Bluetooth: hci0: Waiting for device to boot
[    4.636987] Bluetooth: hci0: Device booted in 2220 usecs
[    4.636988] Bluetooth: hci0: Waiting for device transition to d0
[    4.636988] Bluetooth: hci0: Device moved to D0 in 0 usecs
[    4.637349] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
[    4.642013] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-pci.sfi
[    4.642028] Bluetooth: hci0: Boot Address: 0x10000800
[    4.642030] Bluetooth: hci0: Firmware Version: 226-18.26
[    4.654455] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.654463] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.654579] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.654582] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.678664] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.678672] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.697607] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.697611] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.699227] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.699230] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.699337] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.699339] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.704360] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.704363] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.717723] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.717738] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.777761] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.777765] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.790000] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.790031] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.790164] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.790166] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.837888] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.837891] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.838006] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.838008] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.841254] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.841257] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.841371] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.841374] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    4.841568] Bluetooth: hci0: Received gp1 mailbox interrupt
[    4.841570] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.048448] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.048453] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.048575] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.048578] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.056405] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.056409] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.056848] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.056855] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.056983] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.056985] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.078245] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.078250] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.098366] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.098390] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.098840] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.098843] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.098964] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.098974] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.101319] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.101322] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.115473] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.115477] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.115598] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.115601] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.117916] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.117918] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.118068] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.118070] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.118370] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.118372] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.118604] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.118606] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.122275] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.122299] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.136938] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.136950] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.137130] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.137132] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.139425] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.139430] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[    5.215958] Bluetooth: hci0: Waiting for firmware download to complete
[    5.215966] Bluetooth: hci0: Firmware loaded in 560493 usecs
[    5.251217] Bluetooth: hci0: Received gp1 mailbox interrupt
[    5.251229] Bluetooth: hci0: Controller device warning (boot_stage:
0xa09b100f)
[    5.251241] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db100f)
[    5.251285] Bluetooth: hci0: Waiting for device to boot
[    5.251883] Bluetooth: hci0: Device booted in 35062 usecs
[    5.251885] Bluetooth: hci0: Waiting for device transition to d0
[    5.251946] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1007)
[    5.251948] Bluetooth: hci0: Device moved to D0 in 62 usecs
[    5.252133] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0190-0291-pci.ddc
[    5.252344] Bluetooth: hci0: Applying Intel DDC parameters completed
[    5.252737] Bluetooth: hci0: Firmware timestamp 2026.18 buildtype 1 build
120290
[    5.252739] Bluetooth: hci0: Firmware SHA1: 0x38841b2b
[    5.253077] Bluetooth: hci0: Fseq status: Success (0x00)
[    5.253078] Bluetooth: hci0: Fseq executed: 00.00.04.202
[    5.253078] Bluetooth: hci0: Fseq BT Top: 00.00.04.202
[    5.286003] Bluetooth: hci0: Controller device warning (boot_stage:
0xa09b1047)
[    5.357344] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.357346] Bluetooth: BNEP filters: protocol multicast
[    5.357349] Bluetooth: BNEP socket layer initialized
[    5.358431] Bluetooth: MGMT ver 1.23
[    9.755544] Bluetooth: RFCOMM TTY layer initialized
[    9.755567] Bluetooth: RFCOMM socket layer initialized
[    9.755573] Bluetooth: RFCOMM ver 1.11

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
