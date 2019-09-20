Return-Path: <SRS0=RD0i=XP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CDCC4CEC9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Sep 2019 20:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5175C208C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Sep 2019 20:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfITUU1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbfITUU0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Sep 2019 16:20:26 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204877] [Regression] Linux 5.3 breaks connecting a DualShock 4
 controller via bluetooth
Date:   Fri, 20 Sep 2019 20:20:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: atosser@linuxmail.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204877-62941-3NARGgCIRz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204877-62941@https.bugzilla.kernel.org/>
References: <bug-204877-62941@https.bugzilla.kernel.org/>
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

Novi (atosser@linuxmail.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |atosser@linuxmail.org

--- Comment #2 from Novi (atosser@linuxmail.org) ---
Distribution: Gentoo Linux
Kernel: gentoo-5.3.0
Hardware: 
    DualShock 4 v1
    Intel Corporation Wireless 8265 / 8275 [8086:24fd] (rev 78)

Confirm affects my model 1 DS4 (CUH-ZTC1U).

[158663.706012] sony 0005:054C:05C4.0019: unknown main item tag 0x0
[158663.706084] sony 0005:054C:05C4.0019: DualShock 4 calibration report's CRC
check failed, received crc 0x1cffff94 != 0x5e1d3aa3
[158663.706085] sony 0005:054C:05C4.0019: Retrying DualShock 4 get calibration
report request
[158663.706087] sony 0005:054C:05C4.0019: DualShock 4 calibration report's CRC
check failed, received crc 0x1cffff94 != 0x5e1d3aa3
[158663.706087] sony 0005:054C:05C4.0019: Retrying DualShock 4 get calibration
report request
[158663.706090] sony 0005:054C:05C4.0019: DualShock 4 calibration report's CRC
check failed, received crc 0x1cffff94 != 0x5e1d3aa3
[158663.706091] sony 0005:054C:05C4.0019: Failed to get calibration data from
Dualshock 4
[158663.706131] sony 0005:054C:05C4.0019: hidraw11: BLUETOOTH HID v81.00
Gamepad [Wireless Controller] on 74:70:fd:1a:b1:5b
[158663.706131] sony 0005:054C:05C4.0019: failed to claim input

-- 
You are receiving this mail because:
You are the assignee for the bug.
