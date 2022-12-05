Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C193C4321E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 11:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLELg0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 06:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLELgY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 06:36:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA3319C15
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 03:36:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2B51B80EF9
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 11:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C29FC43154
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 11:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670240180;
        bh=d+b6ziB3TtnEeThLUq1kQRbCzrRWswx7ZGtrzqLeYf0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e9vK3NTuc2tyUzwDsF0WiY7WI8MFd5rnz3VoGifVWIvpm0dTqFB0mym+JCdshWZ9o
         Jo4sefr1HSSpYQbJS+4izrtEIhzIb1vppIRjeLW+i/q49xNlftf1NG9LGHW+ukK0bT
         EKP4uMsT+vyBU1Hk9H4ON38UkE5UdKTwNBLo7JiM7YkI7XQtwboK2ucX+vV84ojvwC
         PawuFNUNozpoc+nukjsXNWCpUPEfcHTLZBwsSnkbYTfCTLR8qlu13FkXOv5hJrHScN
         9LNGGf22MXoERPt5SZd8ZJDnvOv/zG1+bQRIdz567WmOHSZ/0ZTEmxan1dawXHe3dy
         Q8/oubNJiTTKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8CAE1C433E6; Mon,  5 Dec 2022 11:36:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 05 Dec 2022 11:36:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tr.ml@gmx.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-yCXDhuT4DN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

RockT (tr.ml@gmx.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tr.ml@gmx.de

--- Comment #43 from RockT (tr.ml@gmx.de) ---
I see this problem with the switch of kernel 6.0 (all versions work) to
6.1.0rc7.
Bluetooth has stopped working. :(

$ dmesg |grep -i bluetooth
[    0.890611] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is
unblocked
[    9.373051] Bluetooth: Core ver 2.22
[    9.373087] NET: Registered PF_BLUETOOTH protocol family
[    9.373088] Bluetooth: HCI device and connection manager initialized
[    9.373093] Bluetooth: HCI socket layer initialized
[    9.373096] Bluetooth: L2CAP socket layer initialized
[    9.373102] Bluetooth: SCO socket layer initialized
[    9.667105] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.667109] Bluetooth: BNEP filters: protocol multicast
[    9.667114] Bluetooth: BNEP socket layer initialized
[   11.669721] Bluetooth: hci0: Reading Intel version command failed (-110)
[   11.669725] Bluetooth: hci0: command 0xfc05 tx timeout

Sys: Lenovo Thinkpad T14s Gen2
lspci:
$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root
Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost
Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost
Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP
Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP
Bridge
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP
Bridge
00:02.5 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP
Bridge
00:02.7 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP
Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost
Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe=
 GPP
Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;
Function 7
01:00.0 Non-Volatile memory controller: Shenzhen Unionmemory Information Sy=
stem
Ltd. Device 6304 (rev 03)
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411
PCI Express Gigabit Ethernet Controller (rev 0e)
03:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
04:00.0 Unassigned class [ff00]: Quectel Wireless Solutions Co., Ltd. EM120=
R-GL
LTE Modem
05:00.0 USB controller: Renesas Technology Corp. uPD720202 USB 3.0 Host
Controller (rev 02)
06:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev d1)
06:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon =
High
Definition Audio Controller
06:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 10h-1fh) Platform Security Processor
06:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne U=
SB
3.1
06:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne U=
SB
3.1
06:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
06:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD
Audio Controller

Any further info to provide?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
