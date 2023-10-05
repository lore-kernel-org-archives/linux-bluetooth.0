Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F26EE936ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 00:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjJEAVh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 20:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjJEAVg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 20:21:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A5CE
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 17:21:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CDFEC433C9
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 00:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696465291;
        bh=2ZW9m7b3m2xtkSipuUdrtxA1owVJZxWdNgcpr6uFM7c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=W2ZgZ1a334blXKfdeFhZnrZFC5FLFas9Bm9P2p4ptlcJ3x8A+2Tda9zfVVq9wRDNn
         b82L3F5NPn8vYDAvuPckH3XpzkY+xkDuKuhlcsGa+5UoRTNIfylnDUmnvt4CxmZxl4
         PBbErfSAjtxBD2fg83QtRODtQMjQuH0O/RTW4It8uNS6YhZUobNTgzGHu3Zxpyli0N
         L2Cti5EstzfLW4clY+utxgamLTYL8Oh+StsqwYVgg0q0wUJiLrjVSq6J1NK0JTRrCy
         3NyC7tfvAJ2Lm1Y1wJ5BuZTuQrDOXdVUcHy+zl9NS/h1uhByTz1uzyjy0k8dIj7Jgy
         wm20DgBHrsp7g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 34234C53BC6; Thu,  5 Oct 2023 00:21:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date:   Thu, 05 Oct 2023 00:21:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nelson@live.cl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217023-62941-E4gM9aizvx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

Nelson (nelson@live.cl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nelson@live.cl

--- Comment #9 from Nelson (nelson@live.cl) ---
- LT: HP ProBook 430 G8
- Kernel Version: 6.4.12-zen1-1-zen

lsusb | grep -i bluetooth
Bus 003 Device 005: ID 8087:0026 Intel Corp. AX201 Bluetooth

rfkill list
0: hci0: Bluetooth
    Soft blocked: no
    Hard blocked: no
1: phy0: Wireless LAN
    Soft blocked: no
    Hard blocked: no

journalctl -p err -b
sep 01 22:07:54 amida kernel: Bluetooth: hci0: Malformed MSFT vendor event:
0x02

dmesg | grep Bluetooth
[    2.135878] Bluetooth: Core ver 2.22
[    2.135896] Bluetooth: HCI device and connection manager initialized
[    2.135901] Bluetooth: HCI socket layer initialized
[    2.135904] Bluetooth: L2CAP socket layer initialized
[    2.135907] Bluetooth: SCO socket layer initialized
[    2.215220] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[    2.216228] Bluetooth: hci0: Device revision is 2
[    2.216231] Bluetooth: hci0: Secure boot is enabled
[    2.216232] Bluetooth: hci0: OTP lock is enabled
[    2.216233] Bluetooth: hci0: API lock is enabled
[    2.216234] Bluetooth: hci0: Debug lock is disabled
[    2.216235] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    2.224767] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
[    2.224796] Bluetooth: hci0: Boot Address: 0x24800
[    2.224797] Bluetooth: hci0: Firmware Version: 206-22.23
[    2.312520] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    2.312523] Bluetooth: BNEP filters: protocol multicast
[    2.312527] Bluetooth: BNEP socket layer initialized
[    3.954983] Bluetooth: hci0: Waiting for firmware download to complete
[    3.955209] Bluetooth: hci0: Firmware loaded in 1689881 usecs
[    3.955250] Bluetooth: hci0: Waiting for device to boot
[    3.970455] Bluetooth: hci0: Device booted in 14875 usecs
[    3.970474] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    3.980165] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-19-0-4.ddc
[    3.982432] Bluetooth: hci0: Applying Intel DDC parameters completed
[    3.983427] Bluetooth: hci0: Firmware revision 0.4 build 206 week 22 2023
[    4.052609] Bluetooth: MGMT ver 1.22
[   42.896475] Bluetooth: RFCOMM TTY layer initialized
[   42.896481] Bluetooth: RFCOMM socket layer initialized
[   42.896484] Bluetooth: RFCOMM ver 1.11

Despite the error, my Bluetooth devices seem to be functioning correctly.
However, I'd like to address this error if possible.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
