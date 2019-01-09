Return-Path: <SRS0=eb2H=PR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9A7C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F70206B7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfAIVDW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:03:22 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:37216 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727767AbfAIVDV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jan 2019 16:03:21 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8966F2948A
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jan 2019 21:03:20 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 7DC22294CB; Wed,  9 Jan 2019 21:03:20 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202203] New: Bluetooth mouse doesn't move until sending a pair
 request
Date:   Wed, 09 Jan 2019 21:03:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: felixonmars@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-202203-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202203

            Bug ID: 202203
           Summary: Bluetooth mouse doesn't move until sending a pair
                    request
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.20
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: felixonmars@gmail.com
        Regression: No

Created attachment 280363
  --> https://bugzilla.kernel.org/attachment.cgi?id=280363&action=edit
btmon output when the mouse "connects" but not moving

My Bluetooth LE mouse (Rapoo MT750) doesn't move when it's turned off and on
again. The problem is that it's shown as connected but the pointer won't move.
The mouse itself (reading from LED) doesn't think it's connected.

The mouse works if I disable/re-enable bluetooth (using laptop's key binding),
or simply send a "pair" command in bluetoothctl. The pair operation here will
always timeout, but the mouse correctly moves right after sending the command.
The pair command will succeed after a second try (after the first timeout), but
it doesn't fix the problem (shown as unpaired after reconnecting).

-- 
You are receiving this mail because:
You are the assignee for the bug.
