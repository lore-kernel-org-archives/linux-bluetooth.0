Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC778C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA498238EB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 23:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbgLIXZz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 18:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgLIXZt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 18:25:49 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210595] New: Gamepad Sony PLAYSTATION(R)3 Controller doesn't
 pair
Date:   Wed, 09 Dec 2020 23:25:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: orbea@riseup.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-210595-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210595

            Bug ID: 210595
           Summary: Gamepad Sony PLAYSTATION(R)3 Controller doesn't pair
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.9.12
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: orbea@riseup.net
        Regression: No

Created attachment 294065
  --> https://bugzilla.kernel.org/attachment.cgi?id=294065&action=edit
bluetoothd -n -d output

When using my official Dualshock3 gamepad with bluetooth it connects, but then
never pairs.

To pair it I did:

power on
agent on
default-agent
discoverable on
pairable on
scan on

Then plugged in the gamepad via the usb cable, entered 'yes' to the
authorization request, unplugged it and pressed the power button on the
gamepad.

The gamepad does work via the usb cable.

I attached a log with the output of 'bluetoothd -n -d' and in dmesg the
following is printed.

[94204.623301] debugfs: File 'force_bredr_smp' in directory 'hci0' already
present!
[94374.029398] debugfs: File 'force_bredr_smp' in directory 'hci0' already
present!
[94418.059222] usb 1-1: new full-speed USB device number 29 using xhci_hcd
[94418.209651] usb 1-1: New USB device found, idVendor=054c, idProduct=0268,
bcdDevice= 1.00
[94418.209656] usb 1-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[94418.209660] usb 1-1: Product: PLAYSTATION(R)3 Controller
[94418.209662] usb 1-1: Manufacturer: Sony
[94418.221403] input: Sony PLAYSTATION(R)3 Controller Motion Sensors as
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.0028/input/input98
[94418.279353] input: Sony PLAYSTATION(R)3 Controller as
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.0028/input/input97
[94418.280056] sony 0003:054C:0268.0028: input,hiddev98,hidraw4: USB HID v81.11
Joystick [Sony PLAYSTATION(R)3 Controller] on usb-0000:00:14.0-1/input0
[94426.300043] usb 1-1: USB disconnect, device number 29
[94435.739401] sony 0005:054C:0268.0029: unknown main item tag 0x0
[94440.855872] sony 0005:054C:0268.0029: Failed to set controller into
operational mode
[94440.856117] sony 0005:054C:0268.0029: hidraw4: BLUETOOTH HID v80.00 Joystick
[Sony PLAYSTATION(R)3 Controller] on 5c:f3:70:9c:8f:d0
[94440.856121] sony 0005:054C:0268.0029: failed to claim input

-- 
You are receiving this mail because:
You are the assignee for the bug.
