Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9588AC4321E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Nov 2022 16:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiK1Q2S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Nov 2022 11:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiK1Q2O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Nov 2022 11:28:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B98024F07
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 08:28:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 398A5B80DFB
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 16:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0D3EC433C1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 16:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669652783;
        bh=v9NoVupXkMdpKazs0AXcQSJxA38ONZ7OEdPqoa6oeMg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mT/0/mnv3Cjvddyog2jeLIkWqbdc5fADWzBE0aOm1phPyNtKkga+X61MNEMmU4eh0
         xuMhpJHdtVGpJ4DQ2VBQZZNEgvj6UZvT9zDsS6iUafpwWJ5OotoSGf1TqUw8FjBX65
         V8785jhAbUzJ88vSrQVvYYSR8vmDGNH1wNdHAmZJAcQ58B10YW+p3heAJ6cPoc0m7B
         oJl20n0w03G+DdXTfQLve8rocakc64/NJPO06F33UUjWZWGqSYz/ZtztjLe48KxHT7
         BPWEbvPxWRVgNrjJATee39qkKdrxewXED+CyYN3C0d8knnGWVZh52KgdyNdpG8PdsF
         pXLZUDsNQx5uQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BC4C6C433E7; Mon, 28 Nov 2022 16:26:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Mon, 28 Nov 2022 16:26:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-m2DUrIxpa5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

--- Comment #9 from JustANormalTinkererMihir (justanormaltinkerermihir@duck=
.com) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #7)
What sort of update do you require? As far as I can tell
HCI_QUIRK_NO_SUSPEND_NOTIFIER causes this regression, and the dongle contin=
ues
to work fine after just removing the line. One thing I have noticed in the
dmesg log is that the dongle sometimes disconnects and reconnects, this is
largely the reason why the kernel fault even occurs, it disconnects and
reconnects like this:
[   53.494546] Bluetooth: RFCOMM TTY layer initialized
[   53.494558] Bluetooth: RFCOMM socket layer initialized
[   53.494561] Bluetooth: RFCOMM ver 1.11
[   60.757711] rfkill: input handler disabled
[   73.717144] rfkill: input handler enabled
[   80.462376] rfkill: input handler disabled
[   80.468335] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Q=
uota
mode: none.
[   93.275986] input: Airdopes 121v2 (AVRCP) as /devices/virtual/input/inpu=
t23
[  136.650027] usb 2-1.5: USB disconnect, device number 3
[  136.892439] usb 2-1.5: new full-speed USB device number 4 using ehci-pci
[  136.998154] usb 2-1.5: New USB device found, idVendor=3D0a12, idProduct=
=3D0001,
bcdDevice=3D88.91
[  136.998160] usb 2-1.5: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[  136.998162] usb 2-1.5: Product: BT DONGLE10
[  137.000158] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D9 rev=
=3D0810;
LMP ver=3D9 subver=3D2312; manufacturer=3D10
[  137.000163] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds...
[  137.000164] Bluetooth: hci0: CSR: Unbranded CSR clone detected;
force-suspending once...
[  137.000166] Bluetooth: hci0: CSR: Couldn't suspend the device for our Ba=
rrot
8041a02 receive-issue workaround
[  137.000188] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[  137.000189] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[  137.000190] Bluetooth: hci0: HCI Set Event Filter command not supported.
[  137.082247] Bluetooth: MGMT ver 1.22
[  143.561978] usb 2-1.5: USB disconnect, device number 4

This seems to only happen when idle not when there is any activity. Maybe t=
he
dongle has some built-in power saving feature that disables the dongle when=
 not
in use? Please note this also happens after disabling the
HCI_QUIRK_NO_SUSPEND_NOTIFIER. These dongles seem really messed up.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
