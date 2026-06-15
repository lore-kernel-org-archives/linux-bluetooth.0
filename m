Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED13FC5C5
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534978; cv=none; b=pnn+idgOpB592tmyEJ1r7CrUz0hZ+SdtHu+Zp08LUc8EZE5II1eNQnzk0F4DJuX6W4grnsTgQfDRGzJstFFrNcTir9tOlH0h+HOZ12DuKYWbN5gvYIpOYnERxRg1Y8l1Tcb/JghGDMWnKLK9u7BbV1YSVOdE89aG/3bCzwX6FmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534978; c=relaxed/simple;
	bh=2RYayaSn8smOv44zUgw4M3T04txByl1jBU4IPpQ91jA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JclzkPbRg/d39UR4ijoKFkvZoRELeURHUdoJ7ivYuxCpqu231E2SJcfRFpbeBtMTjCydZ1c9Y0se/D1aU8Kx/qSpRm/q/OiIXCW3oEoXHjy9Aef+U4bKx+8Rp9U0lW/7b0BHC/EU36tNcPAH8R1fdcBfXT1/ao7hwwOfs3/uZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKGz2feD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKGz2feD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2F84C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 14:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781534978;
	bh=2RYayaSn8smOv44zUgw4M3T04txByl1jBU4IPpQ91jA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vKGz2feD0Ofip+TmvnucvyRvEfQqOFlEW8aj1FQR2tCGbMHd7pz2VelQaWVT2FMKc
	 XX5nYnnXaBfiomDzsw9rXFZ7KgcsCC5NrN8dYuF7eB2bUu7DYp24dBwbgjdfCKSIfj
	 XoTOiE6LPhJMDY2Ry7txyVbaJ6HlcyR9zEMIcyfRn9ALGJOmePnaXUmvodx/pdX4sa
	 bOOd2ZUJyCaT70arNALdZkx/k2HsIR4IpXMhwbMfg3miODbUzFAlqUhT3jVIru2gsS
	 AJEWYjGBb1+QmH7SGd+QfZV4HXA75BN2cLdLrTxAAVDllM6Lqp3vFlwlf3+eIjX1e+
	 sRpX5zgbV49VQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DC4A1C53BBF; Mon, 15 Jun 2026 14:49:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Mon, 15 Jun 2026 14:49:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: furstenau+kernelbugWGvWw1PW1l@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221637-62941-hFoxxqCteY@https.bugzilla.kernel.org/>
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

--- Comment #9 from Bianca F=C3=BCrstenau (furstenau+kernelbugWGvWw1PW1l@po=
steo.net) ---
I applied the patch and it mostly worked.

Quick note: I was unable to figure out how to non-manually get a patch file
from the googlesource site and this incurred several hours of delay while I=
 did
something else before I had the idea of trying to find the patch on kernel.=
org:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/patch/?id=3D5917dd39db2bfc8b1b4c6ea8ed99adb4badef707

When I applied the patch to 7.0.11, the Bluetooth worked with the current
firmware and the dmesg logs looked the same as with the old firmware except=
 for
timings and version identifiers. When I applied the patch to 7.0.12, the
Bluetooth still worked but there were a lot of gp1 mailbox interrupts and n=
ew
warnings in the dmesg logs. This seems unexpected to me, but if it seems
expected to Kiran et al., I do not have any further issue with this. If it
seems unexpected to you, too, it might warrant further investigation.

Am I seeing correctly that the patch is already in 7.1.0? If so, it seems
unnecessary to revert anything for me as my understanding of the release
strategy of NixOS for the configuration I am running is that my next kernel
will be 7.1.0 anyway. If I am wrong about that, the consequence is only that
applying updates takes me an hour instead of a few minutes at most if one of
the updates was to the kernel. Definitely quite annoying, but also not terr=
ibly
prohibitive, as the device stays usable during the update process. (Still,
nothing I would look forward to doing a dozen times until 7.2.0 releases or
something.)

Linux 7.0.11 with 5917dd39, Firmware 20260519 $ sudo dmesg | grep -i blueto=
oth
[   31.058834] Bluetooth: Core ver 2.22
[   31.058854] NET: Registered PF_BLUETOOTH protocol family
[   31.058855] Bluetooth: HCI device and connection manager initialized
[   31.058860] Bluetooth: HCI socket layer initialized
[   31.058862] Bluetooth: L2CAP socket layer initialized
[   31.058864] Bluetooth: SCO socket layer initialized
[   31.085847] Bluetooth: hci0: Device revision is 0
[   31.085852] Bluetooth: hci0: Secure boot is enabled
[   31.085854] Bluetooth: hci0: OTP lock is disabled
[   31.085855] Bluetooth: hci0: API lock is enabled
[   31.085855] Bluetooth: hci0: Debug lock is disabled
[   31.085856] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   31.085858] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 bu=
ild
45995
[   31.086590] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-iml.sfi
[   31.086594] Bluetooth: hci0: Boot Address: 0x30098800
[   31.086595] Bluetooth: hci0: Firmware Version: 99-13.26
[   31.142382] Bluetooth: hci0: Waiting for firmware download to complete
[   31.142386] Bluetooth: hci0: Firmware loaded in 54485 usecs
[   31.144680] Bluetooth: hci0: Waiting for device to boot
[   31.144682] Bluetooth: hci0: Device booted in 2235 usecs
[   31.144683] Bluetooth: hci0: Waiting for device transition to d0
[   31.144683] Bluetooth: hci0: Device moved to D0 in 0 usecs
[   31.144815] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
[   31.148426] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-pci.sfi
[   31.148435] Bluetooth: hci0: Boot Address: 0x10000800
[   31.148436] Bluetooth: hci0: Firmware Version: 99-13.26
[   31.684955] Bluetooth: hci0: Waiting for firmware download to complete
[   31.684977] Bluetooth: hci0: Firmware loaded in 523972 usecs
[   31.721113] Bluetooth: hci0: Received gp1 mailbox interrupt
[   31.721318] Bluetooth: hci0: Waiting for device to boot
[   31.721770] Bluetooth: hci0: Device booted in 35918 usecs
[   31.721773] Bluetooth: hci0: Waiting for device transition to d0
[   31.721837] Bluetooth: hci0: Device moved to D0 in 61 usecs
[   31.722508] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0190-0291-pci.ddc
[   31.722682] Bluetooth: hci0: Applying Intel DDC parameters completed
[   31.723019] Bluetooth: hci0: Firmware timestamp 2026.13 buildtype 1 build
117603
[   31.723022] Bluetooth: hci0: Firmware SHA1: 0xde043160
[   31.723308] Bluetooth: hci0: Fseq status: Success (0x00)
[   31.723311] Bluetooth: hci0: Fseq executed: 00.00.04.202
[   31.723312] Bluetooth: hci0: Fseq BT Top: 00.00.04.202
[   33.048540] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   33.048544] Bluetooth: BNEP socket layer initialized
[   33.049844] Bluetooth: MGMT ver 1.23
[   43.952601] Bluetooth: RFCOMM TTY layer initialized
[   43.952611] Bluetooth: RFCOMM socket layer initialized
[   43.952613] Bluetooth: RFCOMM ver 1.11

Linux 7.0.12 with 5917dd39, Firmware 20260519 $ sudo dmesg | grep -i blueto=
oth
[  235.299907] Bluetooth: Core ver 2.22
[  235.299924] NET: Registered PF_BLUETOOTH protocol family
[  235.299925] Bluetooth: HCI device and connection manager initialized
[  235.299929] Bluetooth: HCI socket layer initialized
[  235.299932] Bluetooth: L2CAP socket layer initialized
[  235.299935] Bluetooth: SCO socket layer initialized
[  235.340849] Bluetooth: hci0: Device revision is 0
[  235.340854] Bluetooth: hci0: Secure boot is enabled
[  235.340854] Bluetooth: hci0: OTP lock is disabled
[  235.340855] Bluetooth: hci0: API lock is enabled
[  235.340855] Bluetooth: hci0: Debug lock is disabled
[  235.340856] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[  235.340857] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 bu=
ild
45995
[  235.341842] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-iml.sfi
[  235.341845] Bluetooth: hci0: Boot Address: 0x30098800
[  235.341846] Bluetooth: hci0: Firmware Version: 99-13.26
[  235.403312] Bluetooth: hci0: Waiting for firmware download to complete
[  235.403315] Bluetooth: hci0: Firmware loaded in 60029 usecs
[  235.405554] Bluetooth: hci0: Waiting for device to boot
[  235.405579] Bluetooth: hci0: Device booted in 2206 usecs
[  235.405580] Bluetooth: hci0: Waiting for device transition to d0
[  235.405580] Bluetooth: hci0: Device moved to D0 in 0 usecs
[  235.405731] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
[  235.408475] Bluetooth: hci0: Found device firmware:
intel/ibt-0190-0291-pci.sfi
[  235.408482] Bluetooth: hci0: Boot Address: 0x10000800
[  235.408482] Bluetooth: hci0: Firmware Version: 99-13.26
[  235.653214] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.653367] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.653539] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.653673] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.654661] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.654798] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.654998] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.655161] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.656670] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.656790] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.676405] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.676593] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.680410] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.680540] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.680908] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.681047] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.684592] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.684693] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.684817] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.684924] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.685464] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.685583] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.685708] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.685831] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.689008] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.689155] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.690617] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.690721] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.694404] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.694523] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.694671] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.694785] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.695897] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.696005] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.696186] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.696299] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.699381] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.699483] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.701368] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.701469] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.702431] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.702535] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.703859] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.703953] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.704123] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.704230] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.704426] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.704528] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.704714] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.704803] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.705816] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.705899] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.706020] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.706147] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.706801] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.706905] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.710379] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.710481] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.710639] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.710747] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.716898] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.717012] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.718284] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.718378] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.718593] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.718679] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.719490] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.719575] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.719732] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.719816] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.721102] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.721200] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.721444] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.721541] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.723024] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.723163] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.724594] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.724685] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.725061] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.725141] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.725816] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.725918] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.878235] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.878324] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.878449] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.878530] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.885430] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.885514] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.886566] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.886633] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.886755] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.886847] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.914645] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.914746] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1003)
[  235.963268] Bluetooth: hci0: Waiting for firmware download to complete
[  235.963274] Bluetooth: hci0: Firmware loaded in 541794 usecs
[  235.999442] Bluetooth: hci0: Received gp1 mailbox interrupt
[  235.999526] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db100f)
[  235.999536] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db100f)
[  235.999659] Bluetooth: hci0: Waiting for device to boot
[  236.000092] Bluetooth: hci0: Device booted in 35942 usecs
[  236.000093] Bluetooth: hci0: Waiting for device transition to d0
[  236.000158] Bluetooth: hci0: Controller device warning (boot_stage:
0xa0db1007)
[  236.000162] Bluetooth: hci0: Device moved to D0 in 67 usecs
[  236.001511] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0190-0291-pci.ddc
[  236.001689] Bluetooth: hci0: Applying Intel DDC parameters completed
[  236.002010] Bluetooth: hci0: Firmware timestamp 2026.13 buildtype 1 build
117603
[  236.002012] Bluetooth: hci0: Firmware SHA1: 0xde043160
[  236.002292] Bluetooth: hci0: Fseq status: Success (0x00)
[  236.002293] Bluetooth: hci0: Fseq executed: 00.00.04.202
[  236.002294] Bluetooth: hci0: Fseq BT Top: 00.00.04.202
[  236.035455] Bluetooth: hci0: Controller device warning (boot_stage:
0xa09b1047)
[  237.596110] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  237.596115] Bluetooth: BNEP socket layer initialized
[  237.598181] Bluetooth: MGMT ver 1.23
[  250.315840] Bluetooth: RFCOMM TTY layer initialized
[  250.315848] Bluetooth: RFCOMM socket layer initialized
[  250.315852] Bluetooth: RFCOMM ver 1.11

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
