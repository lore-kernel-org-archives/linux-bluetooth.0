Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41323C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 07:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B1221E92
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 07:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbhABHTz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Jan 2021 02:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbhABHTz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Jan 2021 02:19:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 17A6722285
        for <linux-bluetooth@vger.kernel.org>; Sat,  2 Jan 2021 07:19:15 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] Bluetooth: command tx timeout with Intel Corporation
 Wireless 7260 in A2DP mode
Date:   Sat, 02 Jan 2021 07:19:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kalmaevlv@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203535-62941-dP5K2T9023@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203535-62941@https.bugzilla.kernel.org/>
References: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203535

--- Comment #10 from Leonid Kalmaev (kalmaevlv@gmail.com) ---
(In reply to ValdikSS from comment #9)
> It's been 12 days without any issues.
> 
> Workaround this bug by executing the following command, which disables
> Bluetooth autosuspend:
> 
>     echo 'options btusb enable_autosuspend=0' | sudo tee
> /etc/modprobe.d/bluetooth.conf
> 
> Reboot afterwards.

Hi. This does not work for some reason in the case of sleep. After waking up
from sleep in powertop I see a good state again. Can you advise on more options
for this to work correctly?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
