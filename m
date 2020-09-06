Return-Path: <SRS0=/VTe=CP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD86C43461
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Sep 2020 17:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C932C20738
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Sep 2020 17:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgIFRwS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Sep 2020 13:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgIFRwR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Sep 2020 13:52:17 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209173] New: laptop boot takes 1.20 minutes - i cant seem to
 find anything wrong other than bluetooth in Dmesg
Date:   Sun, 06 Sep 2020 17:52:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: thiviyan@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-209173-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209173

            Bug ID: 209173
           Summary: laptop boot takes 1.20 minutes - i cant seem to find
                    anything wrong other than bluetooth in Dmesg
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.7.0
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: thiviyan@gmail.com
        Regression: No

Created attachment 292379
  --> https://bugzilla.kernel.org/attachment.cgi?id=292379&action=edit
dmesg -T output

expected behavior : system supposed to boot within less than 20 seconds
current  behavior : it take around 1.30 Minutes to reach user space.

its loads normally when i try live usb disk without the RTL8822be drivers
loaded for wifi and bluetooth but when i try the os which is installed in HDD
with all the drivers it takes a long time to boot. i am not sure if its the
problem caused by the wifi/bluetooth drivers(i have no complains on their
connectivity)

tried solutions : checked UUID of swap and it maches. tried couple different
cmdline options in grub none fixed the issue.

i have attached the dmesg -T output and systemd-analyze critical-chain outputs. 

OS: Kali GNU/Linux Rolling x 
Host: 81FV Lenovo Legion Y53 
Kernel: 5.7.0-kali3-amd64 
CPU: Intel i5-8300H (8) @ 4. 
GPU: NVIDIA GeForce GTX 1050 
GPU: Intel UHD Graphics 630 
Memory: 3807MiB / 23995MiB

-- 
You are receiving this mail because:
You are the assignee for the bug.
