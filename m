Return-Path: <SRS0=G13S=DD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D063DC2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 10:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E174238E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 10:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIZKkU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 06:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKkU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 06:40:20 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209403] New: c123 Realtek Bluetooth Radio not detected with
 Kernel 5.9
Date:   Sat, 26 Sep 2020 10:40:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: simon@freakmail.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-209403-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209403

            Bug ID: 209403
           Summary: c123 Realtek Bluetooth Radio not detected with Kernel
                    5.9
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.9-rc6
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: simon@freakmail.de
        Regression: No

Created attachment 292661
  --> https://bugzilla.kernel.org/attachment.cgi?id=292661&action=edit
lscpi, lsusb and dmesg output

Bluetooth stopped working after switching to kernel 5.9, it still works if I
boot kernel 5.8 again.

Hardware:
Lenovo IdeaPad5 14are05
Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac PCIe Wireless Network
Adapter
with integrated Bluetooth 2.1/3.0/4.2 USB interface controller

bluetoothhctl list doesn't show the controller

lsusb -v shows a Realtek Bluetooth Radio controller.

lspci -vv show also the Realtek Wireless Network Adapter.

-- 
You are receiving this mail because:
You are the assignee for the bug.
