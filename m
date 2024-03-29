Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399281E893
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735187; cv=none; b=a6fnT22466ZDVCV/JlywtH/Pgcz5rD19/pJHlEOVNeyQ+ohX7SPVlf2BWOygdTLHUrRLCeLwAZR4fR4mpV58YIEV79tp+oKwH/15L3esTe5VnPo1RDZPDjrKR+ptBzmfW35o1wourlLQsHLFahxhsAcrQNIjYpi1+C9qfV1wZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735187; c=relaxed/simple;
	bh=4oGADmJuiZ8xan04O+kk5IQeNYbRNOQoXRzwB732UBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SFCWjcHGEuph8m7zX2oZxWuUZnGuRK9/l5lWmEDvQZH5o0bVlVMjt6HS77lBnOU+MZmp9I32sZ9+ieC1D60Xjo5e/dDGyxoh+f83ZvosMdcDs/WSChk8Eezmb4gECfaJe3eETEUzXlOIGMdnUb1dztkwXZEKQOshGC2dNxWR3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzz7IB4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzz7IB4+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2DD0C43399
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711735186;
	bh=4oGADmJuiZ8xan04O+kk5IQeNYbRNOQoXRzwB732UBA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fzz7IB4+1U0Z/UrGK0D8zuy67wNhHsTuleqq8t6Ur6ITaPM6IvPKnXE/Lsxnt/5AQ
	 fdR5+Lm85fXiq7QtmvnQ38ftxJ3Ef7ut58pSEV6SPhwtGocLXfJzZxxo1mhRTzb3mT
	 aJtwMbasCyu/8hYp8t2aqOTyM48eTv8YRwZlCpO2KGqCPuUn9n20tVpJ6iEqecxgTl
	 eQjJ1bVloLhMDsYwGyBGJEPuAbaRB9QNEM9O4rQwyiD6lT9PARre2ceiFleXxDKV61
	 ZE8122LIygZyyesm9aTz8WNkY77ktd7WIpt7/nplKDLMaNwDlTV6IpL7JRqAogCXwK
	 8o4wjkN69nqmA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A846BC53BD8; Fri, 29 Mar 2024 17:59:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date: Fri, 29 Mar 2024 17:59:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: grivel.ocsin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217023-62941-EWWeXKSKXz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

grivel bugsky (grivel.ocsin@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |grivel.ocsin@gmail.com

--- Comment #10 from grivel bugsky (grivel.ocsin@gmail.com) ---
My report for an:

Manufacturer: ASUSTeK COMPUTER INC.
Product Name: ROG Zephyrus G16 GU603VI_GU603VI

https://linux-hardware.org/?probe=3De7501b45b5

Error initial : [6.736003] Bluetooth: hci0: Malformed MSFT vendor event: 0x=
02.

0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no

Linux polmton 6.5.0-26-generic #26-Ubuntu SMP PREEMPT_DYNAMIC Tue Mar 5
21:19:28 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux$

[    4.961218] Bluetooth: hci0: Device revision is 0
[    4.961221] Bluetooth: hci0: Secure boot is enabled
[    4.961223] Bluetooth: hci0: OTP lock is enabled
[    4.961223] Bluetooth: hci0: API lock is enabled
[    4.961224] Bluetooth: hci0: Debug lock is disabled
[    4.961225] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    4.961226] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 bu=
ild
38
[    4.963975] Bluetooth: hci0: Found device firmware: intel/ibt-0040-0041.=
sfi
[    4.963996] Bluetooth: hci0: Boot Address: 0x100800
[    4.963997] Bluetooth: hci0: Firmware Version: 98-13.23
[    6.412347] Bluetooth: hci0: Waiting for firmware download to complete
[    6.413186] Bluetooth: hci0: Firmware loaded in 1415242 usecs
[    6.413217] Bluetooth: hci0: Waiting for device to boot
[    6.429192] Bluetooth: hci0: Device booted in 15615 usecs
[    6.429195] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    6.429344] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0040-0041.ddc
[    6.433886] Bluetooth: hci0: Applying Intel DDC parameters achieved
[    6.436212] Bluetooth: hci0: Firmware timestamp 2023.13 build type 1 bui=
ld
62562
[    4.821065] Bluetooth: Core ver 2.22
[    4.821103] Bluetooth: HCI device and connection manager initialized
[    4.821108] Bluetooth: HCI socket layer initialized
[    4.821111] Bluetooth: L2CAP socket layer initialized
[    4.821115] Bluetooth: SCO socket layer initialized
[    4.961218] Bluetooth: hci0: Device revision is 0
[    4.961221] Bluetooth: hci0: Secure boot is enabled
[    4.961223] Bluetooth: hci0: OTP lock is enabled
[    4.961223] Bluetooth: hci0: API lock is enabled
[    4.961224] Bluetooth: hci0: Debug lock is disabled
[    4.961225] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    4.961226] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 bu=
ild
38
[    4.963975] Bluetooth: hci0: Found device firmware: intel/ibt-0040-0041.=
sfi
[    4.963996] Bluetooth: hci0: Boot Address: 0x100800
[    4.963997] Bluetooth: hci0: Firmware Version: 98-13.23
[    5.046967] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.046971] Bluetooth: BNEP filters: protocol multicast
[    5.046975] Bluetooth: BNEP socket layer initialized
[    6.412347] Bluetooth: hci0: Waiting for firmware download to complete
[    6.413186] Bluetooth: hci0: Firmware loaded in 1415242 usecs
[    6.413217] Bluetooth: hci0: Waiting for device to boot
[    6.429192] Bluetooth: hci0: Device booted in 15615 usecs
[    6.429195] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    6.429344] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0040-0041.ddc
[    6.433886] Bluetooth: hci0: Applying Intel DDC parameters completed
[    6.436212] Bluetooth: hci0: Firmware timestamp 2023.13 buildtype 1 build
62562
[    6.506296] Bluetooth: MGMT ver 1.22
[    6.519923] Bluetooth: RFCOMM TTY layer initialized
[    6.519929] Bluetooth: RFCOMM socket layer initialized
[    6.519934] Bluetooth: RFCOMM ver 1.11
[    4.961218] Bluetooth: hci0: Device revision is 0
[    4.961221] Bluetooth: hci0: Secure boot is enabled
[    4.961223] Bluetooth: hci0: OTP lock is enabled
[    4.961223] Bluetooth: hci0: API lock is enabled
[    4.961224] Bluetooth: hci0: Debug lock is disabled
[    4.961225] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    4.961226] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 bu=
ild
38
[    4.963975] Bluetooth: hci0: Found device firmware: intel/ibt-0040-0041.=
sfi
[    4.963996] Bluetooth: hci0: Boot Address: 0x100800
[    4.963997] Bluetooth: hci0: Firmware Version: 98-13.23
[    6.412347] Bluetooth: hci0: Waiting for firmware download to complete
[    6.413186] Bluetooth: hci0: Firmware loaded in 1415242 usecs
[    6.413217] Bluetooth: hci0: Waiting for device to boot
[    6.429192] Bluetooth: hci0: Device booted in 15615 usecs
[    6.429195] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    6.429344] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0040-0041.ddc
[    6.433886] Bluetooth: hci0: Applying Intel DDC parameters completed
[    6.436212] Bluetooth: hci0: Firmware timestamp 2023.13 buildtype 1 build
62562


description: Bluetooth wireless interface
product: AX211 Bluetooth

  *-network
       description: Ethernet interface
       product: Raptor Lake PCH CNVi WiFi
       vendor: Intel Corporation
       physical id: 14.3
       bus info: pci@0000:00:14.3
       logical name: wlo1
       version: 01
       serial: 0e:0e:c5:26:e5:be
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress msix bus_master cap_list ethernet
physical
       configuration: broadcast=3Dyes driver=3Diwlwifi
driverversion=3D6.5.0-26-generic firmware=3D83.e8f84e98.0 so-a0-gf-a0-83.uc
ip=3D192.168.0.130 latency=3D0 link=3Dyes multicast=3Dyes
       resources: iomemory:620-61f irq:16 memory:622f284000-622f287fff
  *-network
       description: Ethernet interface
       product: RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
       vendor: Realtek Semiconductor Co., Ltd.
       physical id: 0
       bus info: pci@0000:39:00.0
       logical name: enp57s0
       version: 15
       serial: 08:bf:b8:2f:21:e0
       capacity: 1Gbit/s
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress msix bus_master cap_list ethernet
physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
       configuration: autonegotiation=3Don broadcast=3Dyes driver=3Dr8169
driverversion=3D6.5.0-26-generic firmware=3Drtl8168h-2_0.0.2 02/26/15 laten=
cy=3D0
link=3Dno multicast=3Dyes port=3Dtwisted pair
       resources: irq:18 ioport:3000(size=3D256) memory:60204000-60204fff
memory:60200000-60203fff

...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
