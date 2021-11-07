Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1134BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Nov 2021 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD95261215
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Nov 2021 19:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhKGTZV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Nov 2021 14:25:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhKGTZU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Nov 2021 14:25:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8D56F61502
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Nov 2021 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636312957;
        bh=Gd3I2KfxIZoj3KHt0t91xeE1VN7S/OSkaIg5sX29SMM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TkyL3T/8M5mcDvdU/VnfSHGMcnE2ig2tpSyp/xGSbA0F1GyNS5yS6towRZCxk+Bxh
         723rGRfs880bIW8yEuhemPMkaSBCJJDraKcHajNo1dvqAxpg65r2qAIfh3gtOvtoec
         XdfYhVx0emiVgRHwzc+7m464P4vBi1l3BVpMdZM5fXAfq5IF2CaOUgmUDMA2U717Ao
         XiWoo/ScHGU6MoeYVaFHU7IIJO2Kj9BUk82q6VY0pgPPTMXa0A3GsAWWsdnskIQaej
         HETLbkq4bmDCyTjsy2ukRUU8RrSnU5QNEWRJ7HWUURWcrqqg4fcUz+KXBOKNpssaun
         jVut6ZF/I0EJw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 07 Nov 2021 19:22:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-gW9rMDiB3v@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #206 from Jack (ostroffjh@users.sourceforge.net) ---
I just upgraded to kernel 5.15.0.  My dongle seemed to be recognized, but w=
as
not recognized as a controller.  Adding the patch I have labelled as
skip-HCI_FLT_CLEAR_ALL.patch got things working.  So, one of the patches (w=
hich
I had labelled as
Bluetooth-btusb-Make-the-CSR-clone-chip-force-suspend-workaround-more-gener=
ic.diff)
is included in the upstream kernel sources as of 5.14.somethign, but only p=
art
of the other one.  Similar to my earlier comment 195, selected output from
dmesg:

[   11.715825] usb 1-2: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D88.91
[   11.715831] usb 1-2: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[   11.715833] usb 1-2: Product: BT DONGLE10

[   20.888671] btusb: unknown parameter 'fixups' ignored
[   20.889220] usbcore: registered new interface driver btusb
[   20.891778] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[   20.891788] Bluetooth: hci0: CSR: Failed to suspend the device for our
Barrot 8041a02 receive-issue workaround

[   27.326897] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   27.326903] Bluetooth: BNEP filters: protocol multicast
[   27.326910] Bluetooth: BNEP socket layer initialized
[   58.539089] Bluetooth: RFCOMM TTY layer initialized
[   58.539100] Bluetooth: RFCOMM socket layer initialized
[   58.539107] Bluetooth: RFCOMM ver 1.11
[  109.777696] input: WH-CH700N (AVRCP) as /devices/virtual/input/input23

I'm also still curious how to get the "fixups" recognized, although it does=
n't
appear I actually need any now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
