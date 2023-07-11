Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683CFEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 14:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjGKOoS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjGKOoQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 10:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5BE4B
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 07:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC8C61515
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 14:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62FDCC433CA
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689086648;
        bh=1aTCbTcNJ8sYvNxPsMYiGBVKppXoIBgKMPQSMWHN+ws=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XVJFBguRpPTFSo1laMKGmXP+D5rD1CCMmffz8RTAmbKWeSva9IK3OUpP0BEL0uKWa
         mq9FJCA9yePy3e7E83/1bN36ZkUwf6QmL/8i616vp6j0hP6gJPmtaVE50jrS53AHbS
         aHBlof7isRbs0kyUNw92bCqpDk76HoIQ0Y1oIX+bYlEvlF4bQeCenJxP3+3IEwGyoQ
         2B2Y4oBAgtCOZL+l+2UH89ZRzQXRmMlhoX/I6qxKT4NsQLlG3DINdRuLmMvNrZDVE2
         //lCM8krwCT4+/pwR3e6f3UlqkUl9mCl57Dp75XuGW22rFHsiuMo5lhaNZOQ+SWqLa
         /uKGlTecpfoiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4454AC53BD1; Tue, 11 Jul 2023 14:44:08 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Tue, 11 Jul 2023 14:44:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: espritlibre@yadim.dismail.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216936-62941-qsYg0T2B2v@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

espritlibre (espritlibre@yadim.dismail.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |espritlibre@yadim.dismail.d
                   |                            |e

--- Comment #12 from espritlibre (espritlibre@yadim.dismail.de) ---
i have the same issue

Jul 11 16:06:56 kernel: thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: r=
adio
is unblocked
Jul 11 16:06:57 kernel: Bluetooth: Core ver 2.22
Jul 11 16:06:57 kernel: NET: Registered PF_BLUETOOTH protocol family
Jul 11 16:06:57 kernel: Bluetooth: HCI device and connection manager
initialized
Jul 11 16:06:57 kernel: Bluetooth: HCI socket layer initialized
Jul 11 16:06:57 kernel: Bluetooth: L2CAP socket layer initialized
Jul 11 16:06:57 kernel: Bluetooth: SCO socket layer initialized
Jul 11 16:06:57 kernel: Bluetooth: hci0: Device revision is 0
Jul 11 16:06:57 kernel: Bluetooth: hci0: Secure boot is enabled
Jul 11 16:06:57 kernel: Bluetooth: hci0: OTP lock is enabled
Jul 11 16:06:57 kernel: Bluetooth: hci0: API lock is enabled
Jul 11 16:06:57 kernel: Bluetooth: hci0: Debug lock is disabled
Jul 11 16:06:57 kernel: Bluetooth: hci0: Minimum firmware build 1 week 10 2=
014
Jul 11 16:06:57 kernel: Bluetooth: hci0: Bootloader timestamp 2019.40 build=
type
1 build 38
Jul 11 16:06:57 kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-0040-0041.sfi
Jul 11 16:06:57 kernel: Bluetooth: hci0: Boot Address: 0x100800
Jul 11 16:06:57 kernel: Bluetooth: hci0: Firmware Version: 98-13.23
Jul 11 16:06:57 NetworkManager[1454]: <info>  [1689084417.8760] Loaded devi=
ce
plugin: NMBluezManager
(/usr/lib/NetworkManager/1.42.6-1/libnm-device-plugin-bluetooth.so)
Jul 11 16:06:58 rfkill[1709]: block set for type bluetooth
Jul 11 16:06:58 systemd[1557]: Reached target Bluetooth.
Jul 11 16:06:58 kernel: Bluetooth: hci0: Failed to send firmware data (-19)
Jul 11 16:06:58 kernel: Bluetooth: hci0: sending frame failed (-19)
Jul 11 16:06:58 kernel: Bluetooth: hci0: FW download error recovery failed
(-19)
Jul 11 16:06:58 kernel: Bluetooth: hci0: sending frame failed (-19)
Jul 11 16:06:58 kernel: Bluetooth: hci0: Failed to read MSFT supported feat=
ures
(-19)
Jul 11 16:06:58 systemd[1]: Starting Bluetooth service...
Jul 11 16:06:58 systemd[1557]: Stopped target Bluetooth.
Jul 11 16:06:58 bluetoothd[1842]: Bluetooth daemon 5.68
Jul 11 16:06:58 systemd[1]: Started Bluetooth service.
Jul 11 16:06:58 systemd[1]: Reached target Bluetooth Support.
Jul 11 16:06:58 systemd[1]: Stopped target Bluetooth Support.
Jul 11 16:06:58 kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Jul 11 16:06:58 kernel: Bluetooth: BNEP filters: protocol multicast
Jul 11 16:06:58 kernel: Bluetooth: BNEP socket layer initialized
Jul 11 16:06:58 bluetoothd[1842]: Bluetooth management interface 1.22
initialized

i'm not exactly sure when this started happening but i can say it's at least
since kernel 6.1.x
i still have these errors on linux-hardened 6.1.38 and linux 6.4.2 and for =
me
it doesn't matter if they appear on a cold or warm boot, for example i can =
have
3 cold boots in a row without erros and on the fourth cold boot these errors
appear.
i can still connect my phone via bluetooth and send files to my phone and b=
ack,
when i have these errors but whenever i have these errors (most of the time)
turning bluetooth on most likely results in a kernel panic and i have to ha=
rd
power off the laptop which is fscking up my drive (sysrq/reisub ain't worki=
ng)
my wifi card is AX211

i can try to bisect, if someone gives me instructions how to...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
