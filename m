Return-Path: <SRS0=Ml/a=S4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A9C43218
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Apr 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4145C206E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Apr 2019 08:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfDZIe0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:34:26 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:40638 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbfDZIe0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Apr 2019 04:34:26 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 62F0428CA2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2019 08:34:25 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 56EA428CA9; Fri, 26 Apr 2019 08:34:25 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203429] New: RTL8822BE (USB id 13d3:3526) rfkill unblock fails
 1 out of 3 attempts
Date:   Fri, 26 Apr 2019 08:34:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jprvita@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-203429-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203429

            Bug ID: 203429
           Summary: RTL8822BE (USB id 13d3:3526) rfkill unblock fails 1
                    out of 3 attempts
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.0.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: jprvita@gmail.com
        Regression: No

Created attachment 282539
  --> https://bugzilla.kernel.org/attachment.cgi?id=282539&action=edit
btmon logs

When rfkill un-blocking this controller using the Bluetooth settings panel on
gnome-control-center, about 1 out of 3 attempts fail. We can see in the kernel
logs (with dynamic debug enabled) and in btmon that a HCI reset is getting a
timeout.

Interestingly, the problem is only reproducible if there was a LE scanning
procedure running before the rfkill switch was blocked. So blocking and
unblocking the adapter in a loop like the one bellow does not hit the problem:

  while true ; do echo 1 > /sys/class/rfkill/rfkill2/soft ; sleep 1 ; do echo 0
> /sys/class/rfkill/rfkill2/soft ; sleep 3 ; done

But if I also run another loop in parallel trying to start a LE scan (which
fails most of the time because the adapter is OFF, but things align and a scan
starts quite a few times), the problem reproduces very easily:

  while true ; do btmgmt find -l ; done

-- 
You are receiving this mail because:
You are the assignee for the bug.
