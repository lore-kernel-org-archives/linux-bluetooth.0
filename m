Return-Path: <SRS0=J5Bo=YA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2D9C47404
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 13:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5B32070B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 13:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfJGNIJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfJGNII (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Oct 2019 09:08:08 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 205115] New: MacBookPro13,1 (2016) Bluetooth not working
Date:   Mon, 07 Oct 2019 13:08:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: christoph.gysin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205115-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205115

            Bug ID: 205115
           Summary: MacBookPro13,1 (2016) Bluetooth not working
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.3.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: christoph.gysin@gmail.com
        Regression: No

Since https://bugzilla.kernel.org/show_bug.cgi?id=110901 was closed, I would
like to open a new bug to track the remaining issue on MacBookPro models
without touchbar, where bluetooth fails to initialise without an additional
patch.

$ dmesg | grep Bluetooth
[    9.416324] Bluetooth: Core ver 2.22
[    9.416343] Bluetooth: HCI device and connection manager initialized
[    9.416348] Bluetooth: HCI socket layer initialized
[    9.416350] Bluetooth: L2CAP socket layer initialized
[    9.416355] Bluetooth: SCO socket layer initialized
[    9.721375] Bluetooth: HCI UART driver ver 2.3
[    9.721377] Bluetooth: HCI UART protocol H4 registered
[    9.721377] Bluetooth: HCI UART protocol BCSP registered
[    9.721390] Bluetooth: HCI UART protocol LL registered
[    9.721390] Bluetooth: HCI UART protocol ATH3K registered
[    9.721400] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    9.721433] Bluetooth: HCI UART protocol Intel registered
[    9.749504] Bluetooth: HCI UART protocol Broadcom registered
[    9.749517] Bluetooth: HCI UART protocol QCA registered
[    9.749518] Bluetooth: HCI UART protocol AG6XX registered
[    9.749526] Bluetooth: HCI UART protocol Marvell registered
[   11.995669] Bluetooth: hci0: command 0xfc18 tx timeout
[   12.663134] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.663136] Bluetooth: BNEP filters: protocol multicast
[   12.663140] Bluetooth: BNEP socket layer initialized
[   19.892179] Bluetooth: hci0: BCM: failed to write update baudrate (-110)
[   19.892196] Bluetooth: hci0: Failed to set baudrate
[   22.022193] Bluetooth: hci0: command 0x0c03 tx timeout
[   29.915576] Bluetooth: hci0: BCM: Reset failed (-110)

The issue has been previously discussed at:
https://github.com/Dunedan/mbp-2016-linux/issues/29

Current workarounds are either:
https://github.com/lategoodbye/rpi-zero/commit/ed5900296dfb
or:
https://github.com/christophgysin/linux/commit/ddf622a0a19697af473051c8019fffc1eb66efe7

-- 
You are receiving this mail because:
You are the assignee for the bug.
