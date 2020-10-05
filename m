Return-Path: <SRS0=3clX=DM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93CBC4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Oct 2020 21:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843AA212CC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Oct 2020 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJEVau convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Oct 2020 17:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgJEVau (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Oct 2020 17:30:50 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209527] New: motherboard bluetooth fails to initialize after
 resume
Date:   Mon, 05 Oct 2020 21:30:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: mikolajczyk.mateusz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-209527-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209527

            Bug ID: 209527
           Summary: motherboard bluetooth fails to initialize after resume
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.6.19
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mikolajczyk.mateusz@gmail.com
        Regression: No

I am using asrock h470m-itx/ac which has a built-in bluetooth device. the board
itself works quite perfectly, however it has problem which occurs randomly when
I suspend the motherboard (it manifests itself once per several suspends).
After hitting the spacebar to resume the computer, the board either does not
start at all, or it starts, however POST time is significantly long - that's
when I know that the problem starts. after POST messages dissapear, the kernel
boots as usual and then at lightdm greeter I am unable to use my mouse and
keyboard (they are both USB devices). I have to wait for a moment (usually 2
minutes) at which point in time I can log in and my blutooth is disabled. The
only way to restore proper behavior of the motherboard is to shutdown the PC,
completely disable bluetooth in BIOS, boot, then shutdown and enable bluetooth
again. when I did `lsmod` I noticed these modules:

```
btbcm                  20480  1 btusb
btintel                28672  1 btusb
```

which would explain why I am unable to use the usb devices when the bug occurs
- as if the bluetooth would be somehow virtually connected as an USB device on
the motherboard ? lsusb confirms this theory (I think):

Bus 001 Device 007: ID 8087:0aa7 Intel Corp. Wireless-AC 3168 Bluetooth

I am certain that the system log would contain some useful information, however
I don't know where I would be able to find it since I believe the logs are now
inside systemd. I would be more than happy to provide some additional
information, it's just that I don't know where to start.

kindest regards,
toudi

-- 
You are receiving this mail because:
You are the assignee for the bug.
