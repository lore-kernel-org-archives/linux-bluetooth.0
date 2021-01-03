Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02786C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Jan 2021 05:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8CE20784
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Jan 2021 05:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbhACFez convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Jan 2021 00:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbhACFey (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Jan 2021 00:34:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 37C652078E
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 Jan 2021 05:34:14 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211013] New: Cannot find ath3k bluetooth controller attached on
 USB
Date:   Sun, 03 Jan 2021 05:34:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cth451@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-211013-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=211013

            Bug ID: 211013
           Summary: Cannot find ath3k bluetooth controller attached on USB
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.10.x
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: cth451@gmail.com
        Regression: No

bluetoothctl (from bluez 5.55) cannot find the bluetooth controller on my
ar5b22 wireless adapter. However /sys/class/bluetooth/hci0 points to the
correct device. rfkill would toggle blocking/unblocking state without problem,
but bluez won't be able to find the controller regardless.

Steps to reproduce:

1. Boot up the system
2. Run 'bluetoothctl list'. This will print nothing on my system since this
ath3012 is the only bluetooth adapter present, but wasn't found.
3. I checked /sys/class/bluetooth/hci0, where the device file pointed to the
correct USB device number.

Dmesg excerpt:

[   11.830504] Bluetooth: Core ver 2.22
[   11.836192] Bluetooth: HCI device and connection manager initialized
[   11.838836] Bluetooth: HCI socket layer initialized
[   11.841382] Bluetooth: L2CAP socket layer initialized
[   11.843458] Bluetooth: SCO socket layer initialized
[   11.964674] Bluetooth: hci0: don't support firmware rome 0x11020000
[   16.815785] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   16.815787] Bluetooth: BNEP filters: protocol multicast
[   16.815794] Bluetooth: BNEP socket layer initialized

The specific piece of hardware from lsusb and lspci:

    Bus 001 Device 002: ID 13d3:3395 IMC Networks
    23:00.0 Network controller: Qualcomm Atheros AR9462 Wireless Network
Adapter (rev 01)

Notably this issue is not present on kernel 5.9.x and looks very similar to bug
ID 199271. A regression?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
