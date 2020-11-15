Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D02FC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 08:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB3B20797
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 08:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKOICX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Nov 2020 03:02:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgKOICV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Nov 2020 03:02:21 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210205] New: Repairing for btle-devices fail
Date:   Sun, 15 Nov 2020 08:02:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marko.lavikainen@netkoti.fi
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-210205-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210205

            Bug ID: 210205
           Summary: Repairing for btle-devices fail
           Product: Drivers
           Version: 2.5
    Kernel Version: Ubuntu 5.10.0-3-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: marko.lavikainen@netkoti.fi
        Regression: No

Created attachment 293677
  --> https://bugzilla.kernel.org/attachment.cgi?id=293677&action=edit
Log from bluetoothctl

I have recently bought two Bluetooth devices:

 - Microsoft Bluetooth Mouse 3600 (requires confirmation for pairing)
 - Microsoft Surface Keyboard (requires passcode for pairing)

Both devices pair with the system and work fine. However, at random times
(maybe when idling) both devices change their mac-addresses to a new one.

This is a problem, because pairing disconnects, and bluez sees those devices as
new devices. Thus I need to manually repair them and... well, it should not be
like that.

I did make a bit crude python-script that communicates with 'bluetoothctl' and
repairs the mouse whenever it is discovered as a new device. But that does not
work with the keyboard because of the passcode requirement.

I attached some log from 'bluetoothctl'.

Is it possible to detect in the device driver that newly discovered device is
actually the same but with different mac-address and repair it automatically?

Bluetoothctl version is 5.53

-- 
You are receiving this mail because:
You are the assignee for the bug.
