Return-Path: <SRS0=loPc=XL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30B7C49ED7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 11:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EB920678
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 11:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfIPLLX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfIPLLW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Sep 2019 07:11:22 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204877] New: [Regression] Linux 5.3 break connecting a
 DualShock 4 controller via bluetooth
Date:   Mon, 16 Sep 2019 11:11:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oschowa@web.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204877-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204877

            Bug ID: 204877
           Summary: [Regression] Linux 5.3 break connecting a DualShock 4
                    controller via bluetooth
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: oschowa@web.de
        Regression: No

Distribution: Arch Linux
Kernel: 5.3 mainline
Hardware: DualShock4v1 and Intel Wireless-AC 9260 for bluetooth

Since kernel 5.3 a DualShock4 controller fails to connect properly via
bluetooth with the following in dmesg:

[   69.529697] sony 0005:054C:05C4.000B: unknown main item tag 0x0
[   69.529879] sony 0005:054C:05C4.000B: DualShock 4 calibration report's CRC
check failed, received crc 0x1cffff88 != 0xeb31207e
[   69.529880] sony 0005:054C:05C4.000B: Retrying DualShock 4 get calibration
report request
[   69.529885] sony 0005:054C:05C4.000B: DualShock 4 calibration report's CRC
check failed, received crc 0x1cffff88 != 0xeb31207e
[   69.529886] sony 0005:054C:05C4.000B: Retrying DualShock 4 get calibration
report request
[   69.529899] sony 0005:054C:05C4.000B: DualShock 4 calibration report's CRC
check failed, received crc 0x1cffff88 != 0xeb31207e
[   69.529901] sony 0005:054C:05C4.000B: Failed to get calibration data from
Dualshock 4
[   69.530370] sony 0005:054C:05C4.000B: hidraw8: BLUETOOTH HID v81.00 Gamepad
[Wireless Controller] on a0:51:0b:5a:40:50
[   69.530372] sony 0005:054C:05C4.000B: failed to claim input

Repairing doesn't bring any change. Connection via usb still works. Reverting
to kernel 5.2.14 restores porper functionallity.

-- 
You are receiving this mail because:
You are the assignee for the bug.
