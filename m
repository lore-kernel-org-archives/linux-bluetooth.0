Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E830FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Dec 2022 04:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiLRE2t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Dec 2022 23:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRE2q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Dec 2022 23:28:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3EFCDC
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Dec 2022 20:28:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E169B60C3D
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Dec 2022 04:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30AD8C433EF
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Dec 2022 04:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671337724;
        bh=JziwN6h8G2zihVLFR3Rl3I1wTUmN+8iIQwwVOn6FLTc=;
        h=From:To:Subject:Date:From;
        b=SXWGqV2l8qckQKasXCLo8HTow1ah0jAr0sCqiAc8BOdFu7UV+jgfC0Vf201jvvu7k
         o87iHtGm4UqaAE671kiWaJKr0RTrsdTDtEgB+s8+O2eneWCCArvDjHutydyX3FtAoy
         EHOUdHniJMI/CvSoaMD1qqgdl3sZSjT4xs1mx3bpxupnyYMfFlHGLWSJkg4RCb0Lrp
         Z2l+0Cio/XwWhUwFX6HIkgZqQ4fgAATbremO1gpiZ5+6b6C6FTeWLtZ5wK16o4KaSk
         Z5fa3S3VFlP1Dlo697HqblPVq+RsWnsBXs1+kJ/Akb6DR7yLMnAGqz9VqNMj2HmviF
         TWE96pQmp2evQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 12C11C43141; Sun, 18 Dec 2022 04:28:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] New: btusb device with ID 0489:e0d0 no longer working
 after v6.0
Date:   Sun, 18 Dec 2022 04:28:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quantumphazor@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

            Bug ID: 216817
           Summary: btusb device with ID 0489:e0d0 no longer working after
                    v6.0
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.0, 6.0.12
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: quantumphazor@gmail.com
        Regression: No

The internal USB Bluetooth device in my laptop no longer works since v6.0

Device in question:
ID 0489:e0d0 Foxconn / Hon Hai

Works fine in 5.19.x and fails after 6.0
I ran a bisect that resulted in it breaking after this commit:
26afbd826ee326e63a334c37fd45e82e50a615ec Bluetooth: Add initial implementat=
ion
of CIS connections

System: Lenovo ThinkPad T14 (AMD) Gen 2

dmesg output:

[    0.978396] usb 5-4: new full-speed USB device number 2 using xhci_hcd
[    1.142461] usb 5-4: New USB device found, idVendor=3D0489, idProduct=3D=
e0d0,
bcdDevice=3D 0.01
[    1.142467] usb 5-4: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    4.591285] Bluetooth: Core ver 2.22
[    4.591304] Bluetooth: HCI device and connection manager initialized
[    4.591308] Bluetooth: HCI socket layer initialized
[    4.591309] Bluetooth: L2CAP socket layer initialized
[    4.591315] Bluetooth: SCO socket layer initialized
[    4.871972] usbcore: registered new interface driver btusb
[    4.883484] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[    4.973465] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.973468] Bluetooth: BNEP filters: protocol multicast
[    4.973472] Bluetooth: BNEP socket layer initialized
[    4.975525] Bluetooth: hci0: unexpected cc 0x2060 length: 1 < 7
[    4.975537] Bluetooth: hci0: Opcode 0x2060 failed: -38
[    6.985714] Bluetooth: hci0: command tx timeout

Attached is output of lsusb -v -d 0489:e0d0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
