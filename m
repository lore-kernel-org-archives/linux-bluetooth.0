Return-Path: <SRS0=6WQ0=6W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C110AC38A2A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 09:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989D3208CA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 09:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEHJYH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 05:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgEHJYH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 05:24:07 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207623] New: Bluetooth LE keyboard wake ups slowly and drops
 key presses
Date:   Fri, 08 May 2020 09:24:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chfast@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-207623-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207623

            Bug ID: 207623
           Summary: Bluetooth LE keyboard wake ups slowly and drops key
                    presses
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.4.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: chfast@gmail.com
        Regression: No

Created attachment 289001
  --> https://bugzilla.kernel.org/attachment.cgi?id=289001&action=edit
bluetoothd.log

Hello everyone.

I have Microsoft Surface (Designer) Keyboard. It is connected by Bluetooth
4.0/4.1 Low Energy.

I'm having small usability issue with the device. After 10 minutes of being
idle the keyboard goes to some kind of sleep state. Later, to wake it up it
takes ~2 seconds and during this time keys pressed are ignored.

Keyboard info:
Device E8:0B:AE:73:18:16 (random)
        Name: Surface Keyboard
        Alias: Surface Keyboard
        Appearance: 0x03c1
        Icon: input-keyboard
        Paired: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        LegacyPairing: no
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
        UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
        UUID: Human Interface Device    (00001812-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v045Ep0917d0130

Adapter info:
hci0:   Type: Primary  Bus: USB
        BD Address: 9C:B6:D0:96:E8:12  ACL MTU: 1024:8  SCO MTU: 50:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:186892186 acl:2266519 sco:0 events:3335487 errors:0
        TX bytes:103210 acl:6540 sco:0 commands:1497 errors:0
        Features: 0xff 0xfe 0x8f 0xfe 0xd8 0x3f 0x5b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF 
        Link mode: SLAVE ACCEPT 
        Name: 'x13'
        Class: 0x1c010c
        Service Classes: Rendering, Capturing, Object Transfer
        Device Class: Computer, Laptop
        HCI Version: 4.2 (0x8)  Revision: 0x0
        LMP Version: 4.2 (0x8)  Subversion: 0x25a
        Manufacturer: Qualcomm (29)


I collected logs from bluetoothd and dmesg - see attachment with additional
comments.

-- 
You are receiving this mail because:
You are the assignee for the bug.
