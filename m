Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FF4ADDA7
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865436; cv=none; b=k4jzEu858/CYd3FGr2pKdZLSFDtH6XXcbVA5mrirEoevqSZTGSFU3jr0Tz1HoIeCTJCAxiKiHB2ufuLAV7PPtslu6IDis0AGAHLklfu4UzdABiI/Em8/TPgDN5nE1YJw4QpMN828s5A4M3X8okc++Vo7iRilV/VRo9uL5znj5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865436; c=relaxed/simple;
	bh=lcHl68bUr3cYIgKXNGMzq5yQDhwbID0Pej+ij8O+Xqk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rhm9ws1eNEoP/BYnGNtQSNOdEfLY4HgovQcdM9/e0F+G2+UVaX+tbSRt00fpviCu4v+HcEzXs6FX4ztGENexuxFbdin9Fe9ahlddMtQYPNun523TXt+9fAjWgqX2xgfww0avznLzjLq4aDoOaZaXkdoT0r5F6kz5gT/0CZWE/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLqFVAwa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLqFVAwa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4D1FC2BCF5
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785865435;
	bh=lcHl68bUr3cYIgKXNGMzq5yQDhwbID0Pej+ij8O+Xqk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sLqFVAwadk1ESmJOgMAh9pqBLvKUymL2+iR2H8Xdc71GzMURst7L+JhgZKstxLK4D
	 iXo2wRvOOGrHVKNJa0ydgmv3PEMmlIABhFat92709v98raSmwPxZD7mCRMgvCHh/Sl
	 ESNgn5KjXBYSWXTMJ7zPYRYVws0lpUdPWU//KPqHPZXtHUwlaXd7iWuRB/QCxgyRJV
	 whvPqxzfZ1W/M9MZS4toHuF392V3fTWICSMH5QptEyTVNbnDjsefhfMlNYcKcDkKgN
	 DalT3RxIV1a0Tz/YX0IDcoGaAMaGb/9QhGxnQ4iznuwZxYc91Pc1IKi/bog7lDKkEE
	 FKY8kEKi3ZzSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BC2B5C3279F; Tue,  4 Aug 2026 17:43:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Tue, 04 Aug 2026 17:43:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnxps@bbtex.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221832-62941-wdIRUiis2O@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221832-62941@https.bugzilla.kernel.org/>
References: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

--- Comment #5 from IQ (lnxps@bbtex.net) ---
extract from dmesg: (it is trying to init wcn7850)

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x512f0011]
[    0.000000] Linux version 7.2.0-rc5 (root@A16) (gcc (Ubuntu 14.2.0-4ubun=
tu2)
14.2.0, GNU ld (GNU Binutils for Ubuntu) 2.43.1) #1 SMP PREEMPT_DYNAMIC Sun=
 Aug
 2 13:19:20 EST 2026
[    0.000000] KASLR disabled on command line
[    0.000000] Machine model: ASUS Vivobook S 15 X1P-42-100
[    0.000000] earlycon: efifb0 at I/O port 0x0 (options '')
[    0.000000] printk: legacy bootconsole [efifb0] enabled
[    0.000000] efi: EFI v2.9 by INSYDE Corp.
[    0.000000] efi: SMBIOS=3D0xd4462000 SMBIOS 3.0=3D0xd445f000
TPMFinalLog=3D0xd46e0000 ACPI 2.0=3D0xd47d3018 MEMATTR=3D0xd0a2a018 ESRT=3D=
0xcf3d8c98
TPMEventLog=3D0xd4771018 INITRD=3D0xc4845518 RNG=3D0xd47d3918 MEMRESERVE=3D=
0xc484a018
[    0.000000] random: crng init done
[    0.000000] esrt: Reserving ESRT space from 0x00000000cf3d8c98 to
0x00000000cf3d8d48.
[    0.000000] Skipping dt linux,cma-default node in favor for "cma=3D" ker=
nel
param.
....
[    7.914566] qcom-pcie 1c08000.pci: iATU: unroll T, 8 ob, 8 ib, align 4K,
limit 1024G
[    7.922145] Bluetooth: Core ver 2.22
[    7.922168] NET: Registered PF_BLUETOOTH protocol family
[    7.922170] Bluetooth: HCI device and connection manager initialized
[    7.922174] Bluetooth: HCI socket layer initialized
[    7.922176] Bluetooth: L2CAP socket layer initialized
[    7.922178] Bluetooth: SCO socket layer initialized
...
[    8.140142] Bluetooth: HCI UART driver ver 2.3
[    8.140149] Bluetooth: HCI UART protocol H4 registered
[    8.140150] Bluetooth: HCI UART protocol BCSP registered
[    8.140191] Bluetooth: HCI UART protocol LL registered
[    8.140192] Bluetooth: HCI UART protocol ATH3K registered
[    8.140220] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    8.140298] Bluetooth: HCI UART protocol Intel registered
[    8.140331] Bluetooth: HCI UART protocol Broadcom registered
[    8.140345] Bluetooth: HCI UART protocol QCA registered
[    8.140346] Bluetooth: HCI UART protocol AG6XX registered
[    8.140353] Bluetooth: HCI UART protocol Marvell registered
[    8.141317] Bluetooth: hci0: setting up wcn7850
...
[    9.335870] mt7925e_git 0004:01:00.0 mt0: renamed from wlan0
[   10.298232] Bluetooth: hci0: command 0xfc00 tx timeout
[   10.298495] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   10.298641] Bluetooth: hci0: Retry BT power ON:0
[   12.431550] Bluetooth: hci0: command 0xfc00 tx timeout
[   12.431967] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   12.432119] Bluetooth: hci0: Retry BT power ON:1
...
[   14.564761] Bluetooth: hci0: command 0xfc00 tx timeout
[   14.564997] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   14.565143] Bluetooth: hci0: Retry BT power ON:2
[   16.696488] Bluetooth: hci0: command 0xfc00 tx timeout
[   16.696679] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   18.829711] Bluetooth: hci0: AOSP get vendor capabilities (-110)
[   18.829831] Bluetooth: hci0: command 0xfc00 tx timeout

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
