Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD32EC282D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 00:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F0420857
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 00:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfAaALC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:11:02 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:57432 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfAaALC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 19:11:02 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4757930191
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 00:11:01 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 43E0E2FC75; Thu, 31 Jan 2019 00:11:01 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202465] New: Bluetooth adaptor dies - 0489:e0a2 Foxconn / Hon
 Hai
Date:   Thu, 31 Jan 2019 00:11:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jccantele49@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-202465-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202465

            Bug ID: 202465
           Summary: Bluetooth adaptor dies - 0489:e0a2 Foxconn / Hon Hai
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.20.3-1 and 4.19.16-1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: jccantele49@gmail.com
        Regression: No

Created attachment 280879
  --> https://bugzilla.kernel.org/attachment.cgi?id=280879&action=edit
journalctl -b -k

I have a 2018 Dell XPS 15 9575 2-in-1 laptop (the one with VEGA graphics). The
bluetooth adapter reports as 0489:e0a2 Foxconn / Hon Hai (which is curious,
because all other references to this adapter in kernel.org date back to 2011 or
2012).

The bluetooth adapter works well until it abruptly dies. Often times, the
bluetooth adapter simply dies in the middle of use, but the laptop going to
sleep seems to increase the frequency of these issues.

I've verified that the issue does not exist in kernel 4.14.94-1 (although this
kernel has other compatibility issues with my laptop.

I've verified that using modprobe to remove and readd btusb does not bring the
bluetooth device back, and neither does restarting the systemd service.


I'm using Manjaro Linux 18 (Gnome 3.30.2), Systemd 239.303, and bluez 5.50-6.

-- 
You are receiving this mail because:
You are the assignee for the bug.
