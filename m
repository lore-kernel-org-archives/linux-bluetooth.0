Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBDCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Jan 2022 21:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiAAVAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Jan 2022 16:00:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55860 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiAAVAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Jan 2022 16:00:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB3D0B8076A
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 21:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C818C36AF2
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jan 2022 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641070818;
        bh=3Y3cBHrbGUIDNcvWJdO0Bbl0NQs865tu/EcMJ7Hwzq8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rzMRV7M7pCvyiWn/t11+dh+7zKlyPyhaAjfCV7smzflDQTIVqAt3Ggpr+BQx3xSvg
         cJtJLHOv4KUahML8XRIO5Kimi5+q5TcJo3IDSG/Z0X+E/RJn4UtBcpt8HM1HU1HW3z
         HLCd5p4XzrBlhomHK6YOM1J8N0hwHVCmWWFxdO0DbCOUC7dHqdRbFesUbZ5vGE6Qz1
         95A/OicklxsXtFnEdAONDFp0gehrkBduTQ14QAMoaAGc9q/1FYhPjCQe0CK0Ptf8EC
         PHGIPZXQ9MUnTJT/b20g44EIgZILpBF++Wdk3N8XnGgx/WlKu933+/ptnPOKETDU0T
         EkW4Z1eG02F8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3C4B2C05FCD; Sat,  1 Jan 2022 21:00:18 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 01 Jan 2022 21:00:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guimarcalsilva@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-bJABKiFeOj@https.bugzilla.kernel.org/>
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

--- Comment #212 from guimarcalsilva@gmail.com ---
Hi, I know this is very weird but I noticed the bluetooth adapter works just
fine if I pass it through a VM using Gnome Boxes, but no matter what I do it
doesn't work on a real machine. On the virtual machine, I'm running OpenSuse
Tumbleweed with kernel 5.15.5.1 (also worked with KDE Neon with kernel 5.11)
and on the host, I have the kernel 5.15.11-200. I have no idea why it can't=
 get
an HCI address on a real machine (check my prior comments) but it can on a =
VM
with any kernel version.

I hope I'm not spamming this with useless information, sorry if that's the
case.

On the VM hciconfig shows:

hci0:   Type: Primary  Bus: USB
        BD Address: 00:1A:7D:DA:71:10  ACL MTU: 310:4  SCO MTU: 64:8
        UP RUNNING=20
        RX bytes:12949005 acl:284564 sco:0 events:91 errors:0
        TX bytes:1460 acl:17 sco:0 commands:56 errors:0

Dmesg on the VM shows:

[  797.515701] usb 4-1: USB disconnect, device number 2
[  821.123684] usb 4-1: new full-speed USB device number 3 using uhci_hcd
[  821.388913] usb 4-1: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D25.20
[  821.388917] usb 4-1: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[  821.388919] usb 4-1: Product: CSR8510 A10
[  821.395210] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[  821.395214] Bluetooth: hci0: CSR: Failed to suspend the device for our
Barrot 8041a02 receive-issue workaround


There's also a BTMON log on the VM I'll add after this post as an attachment
because it's too big. Note the log was taken by disconnecting the adapter,
running btmon and connecting it. I have no idea why it's that long.

I hope this can help somewhat.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
