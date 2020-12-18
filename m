Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278E4C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 17:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED99923B7A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 17:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgLRRBg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 12:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgLRRBf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 12:01:35 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210775] New: hci0 reset with multiple clients
Date:   Fri, 18 Dec 2020 17:00:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: gnulux@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-210775-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210775

            Bug ID: 210775
           Summary: hci0 reset with multiple clients
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.14.79
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: gnulux@gmail.com
        Regression: No

Created attachment 294217
  --> https://bugzilla.kernel.org/attachment.cgi?id=294217&action=edit
bluetoothd debug mode poutput

Hi all


I need support in bluez. 

My configuration is : 

Linux raspberry (stretch) 

Kernel : 4.14.79

Bluez: 5.43-2+rpt2+deb9u2


lsusb: 

us 001 Device 008: ID 0920:5550 Echelon Co. 

Bus 001 Device 013: ID 04b4:f901 Cypress Semiconductor Corp.  ← bluetooth
device

Bus 001 Device 012: ID 072f:223e Advanced Card Systems, Ltd 

Bus 001 Device 011: ID 1a40:0101 Terminus Technology Inc. Hub

Bus 001 Device 006: ID 0424:ec00 Standard Microsystems Corp. SMSC9512/9514 Fast
Ethernet Adapter

Bus 001 Device 004: ID 0424:9514 Standard Microsystems Corp. SMC9514 Hub

Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp. SMSC9512/9514 Fast
Ethernet Adapter

Bus 001 Device 002: ID 0424:9514 Standard Microsystems Corp. SMC9514 Hub

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub



I ‘m running bluez 5.43 on raspbian  with an external usb bluetooth device (but
i have the same behaviour with embedded bluetooth device  bcm43xx with uart) . 


I’ve developed a server that initiates and establishes sessions with a client
application  on a smartphone.  it works well but recently I noticed a weird
issue . When the smartphone is connected and I connect another device or simply
run gatttool -d 00:16:A4:4C:B9:37 -char-desc on my server , the hci0 device
disappears then comes back again. My application on the server crash as it can
no more access to the device


In kern.log :


Dec 18 12:33:56 box-121 kernel: [   37.927261] usb 1-1.4.1: usbfs: process 1083
(node /opt/filln) did not claim interface 0 before use

Dec 18 12:38:45 box-121 kernel: [  327.673582] Bluetooth: hci0 command 0x200c
tx timeout

Dec 18 12:38:47 box-121 kernel: [  328.908625] usb 1-1.4.4: USB disconnect,
device number 9

Dec 18 12:38:49 box-121 kernel: [  330.743618] usb 1-1.4.4: new full-speed USB
device number 10 using dwc_otg

Dec 18 12:38:49 box-121 kernel: [  330.898584] usb 1-1.4.4: New USB device
found, idVendor=04b4, idProduct=f901

Dec 18 12:38:49 box-121 kernel: [  330.898597] usb 1-1.4.4: New USB device
strings: Mfr=1, Product=2, SerialNumber=3


With bluetoothd in debug mode in attachement


I’m wondering why I lose the device when another device tries to connect and
discuss with my server. Any suggestions ?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
