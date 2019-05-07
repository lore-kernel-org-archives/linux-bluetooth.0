Return-Path: <SRS0=jYet=TH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D08BC04A6B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 00:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37812206A3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 00:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEGAYB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 20:24:01 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:39300 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbfEGAYB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 20:24:01 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3B5F7288EA
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2019 00:24:00 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 2E2DD288F1; Tue,  7 May 2019 00:24:00 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] New: Bluetooth: command tx timeout with Intel
 Corporation Wireless 7260 in A2DP mode
Date:   Tue, 07 May 2019 00:23:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iam@valdikss.org.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203535

            Bug ID: 203535
           Summary: Bluetooth: command tx timeout with Intel Corporation
                    Wireless 7260 in A2DP mode
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.0.11
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: iam@valdikss.org.ru
        Regression: No

I have Intel Corporation Wireless 7260 (rev 73) with 8087:07dc Intel Corp.
Bluetooth module.
From time to time, pausing and playing audio over A2DP causes Bluetooth stack
to stall with the following in kernel log:

Bluetooth: hci0: command 0x041f tx timeout
Bluetooth: hci0: command 0x0406 tx timeout
Bluetooth: hci0: command 0x0c03 tx timeout
Bluetooth: hci0: HCI reset during shutdown failed
Bluetooth: hci0: urb 0000000044e22bee failed to resubmit (113)
Bluetooth: hci0: urb 00000000fc976241 failed to resubmit (113)
Bluetooth: hci0: urb 00000000a59b126a failed to resubmit (113)
Bluetooth: hci0: urb 00000000215e997b failed to resubmit (113)

Note that "HCI reset during shutdown failed" happened when I tried to disable
Bluetooth and enable it again.
Removing btusb and btintel modules and inserting them again helps.

Bluetooth: hci0: read Intel version: 370710018002030d57
Bluetooth: hci0: Intel device is already patched. patch num: 57

Kernel version: 5.0.11. Happened on 4.9-4.19 as well.
Fedora's firmware package: linux-firmware.noarch 20190416-95.fc30

-- 
You are receiving this mail because:
You are the assignee for the bug.
