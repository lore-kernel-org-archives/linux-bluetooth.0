Return-Path: <SRS0=xCmj=XQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280DDC49ED7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Sep 2019 08:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A162080F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Sep 2019 08:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393190AbfIUISN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 Sep 2019 04:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393159AbfIUISM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 Sep 2019 04:18:12 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204877] [Regression] Linux 5.3 breaks connecting a DualShock 4
 controller via bluetooth
Date:   Sat, 21 Sep 2019 08:18:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: robin.langenc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204877-62941-tH6OT44Un0@https.bugzilla.kernel.org/>
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

Robin Lange (robin.langenc@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |robin.langenc@gmail.com

--- Comment #3 from Robin Lange (robin.langenc@gmail.com) ---
Can confirm the same bug happens with a different wireless chip. Same error
messages.

Distribution: Archlinux
Kernel: 5.3.0-mainline from package linux-mainline
Wireless chip: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter
Kernel driver: ath10k_pci
Controller: DualShock 4 V2

[   79.020352] sony 0005:054C:09CC.0008: unknown main item tag 0x0
[   79.020463] sony 0005:054C:09CC.0008: DualShock 4 calibration report's CRC
check failed, received crc 0x1cffff8e != 0x732859f2
[   79.020463] sony 0005:054C:09CC.0008: Retrying DualShock 4 get calibration
report request
[   79.020465] sony 0005:054C:09CC.0008: DualShock 4 calibration report's CRC
check failed, received crc 0x1cffff8e != 0x732859f2
[   79.020466] sony 0005:054C:09CC.0008: Retrying DualShock 4 get calibration
report request
[   79.020467] sony 0005:054C:09CC.0008: DualShock 4 calibration report's CRC
check failed, received crc 0x1cffff8e != 0x732859f2
[   79.020467] sony 0005:054C:09CC.0008: Failed to get calibration data from
Dualshock 4
[   79.020587] sony 0005:054C:09CC.0008: hidraw7: BLUETOOTH HID v81.00 Gamepad
[Wireless Controller] on 9c:b6:d0:68:cd:b6
[   79.020588] sony 0005:054C:09CC.0008: failed to claim input

-- 
You are receiving this mail because:
You are the assignee for the bug.
