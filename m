Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7012EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 08:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA2261076
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 08:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhKJIiF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 03:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhKJIiF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 03:38:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 32DF5610A3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636533318;
        bh=Sr3AKJ1PV3gd8O8AuHQw6nMHTGTedJQ958yM4s2gn74=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I0xaZvkuC9J2oIsd7fGgO6sHiHKxH1l5Dws81DDGKHcbc/IFNuGRgfiuoa5EwXRNn
         4Mr3Y06qzf5Qdnqn55f0kghyMU5SI3tVGGlk037L6uE806ZU14oq3lonVbEy3Yp99V
         Qek1IPpZ9cW3NVnF4922m+1hyqmfAcaXvbhD3BBUx7wS2uY0GBt13pr3sebvCHvGFS
         91/7lUfm2RDDJPXKi+Ii8XN8ZDeAbFDjNzLhYOZuquv4cSeVKq01gqL9dUiEq/9ynP
         7pvyBaocAIBkxes5ptCLb+6+NI7/0249cFlj3HC7ePXPJPj7BxsjXUssCLVwNbXQYE
         deuDvpyZxol2g==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214823] RTL8821CE Bluetooth adapter randomly stopped working,
 only suspend then resume can reset it
Date:   Wed, 10 Nov 2021 08:35:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: thanhdatwarriorok@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214823-62941-41gN3aX0VH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214823-62941@https.bugzilla.kernel.org/>
References: <bug-214823-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214823

--- Comment #5 from thanhdatwarriorok@gmail.com ---
Here is an updated log on 5.14.16 kernel

> sudo dmesg | grep 'hci'

[ 3489.447794] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c
lmp_ver=3D08 lmp_subver=3D8821
[ 3489.450797] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[ 3489.450803] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[ 3489.450817] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[ 3489.450829] Bluetooth: hci0: RTL: cfg_sz 10, total sz 31990
[ 3490.156772] Bluetooth: hci0: RTL: fw version 0x829a7644
[16782.570629] usb 1-2: new full-speed USB device number 5 using xhci_hcd

(suspend then resume event)

[26765.726605] Bluetooth: hci0: command 0x041f tx timeout
[26765.726616] Bluetooth: hci0: Timed out waiting for suspend events
[26765.726623] Bluetooth: hci0: Suspend timeout bit: 6
[26765.726646] Bluetooth: hci0: Suspend notifier action (3) failed: -110
[26766.591682] usb 3-1: reset full-speed USB device number 2 using xhci_hcd
[26766.605552] usb 1-4: reset high-speed USB device number 4 using xhci_hcd
[26766.796709] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c
lmp_ver=3D08 lmp_subver=3D8821
[26766.799656] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[26766.799662] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[26766.805135] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[26766.805399] Bluetooth: hci0: RTL: cfg_sz 10, total sz 31990
[26767.513646] Bluetooth: hci0: RTL: fw version 0x829a7644

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
