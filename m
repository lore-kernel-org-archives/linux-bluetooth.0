Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BC0C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D939523433
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 13:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbhAVN0a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:26:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbhAVN00 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 08:26:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A2F8023A9A
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 13:25:45 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 22 Jan 2021 13:25:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mirh@protonmail.ch
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-IrnVnUZtXA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

mirh (mirh@protonmail.ch) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mirh@protonmail.ch

--- Comment #166 from mirh (mirh@protonmail.ch) ---
So.. I hate to bring yet another variable (and probably yet another scenario)
to the equation, but have people in here tried to also consider electrical
interference?

I had been using my fake CSR (lsusb is identical to comment 77, except
bcdUSB=2.00 and MaxPower=0mA) for months on my old Core 2 Quad PC with
WH-1000XM2. Arguably I was getting even a better run with A2DP and LDAC than
windows itself, which is quite the achievement considering how infamous the
linux wireless audio stack is. 

I changed to a more modern Z97 system, and lo and behold I was getting all
kinds of crazy errors, disconnections, stuttering, failures to connect.. you
name it. After bisecting all my software I eventually turned to the hardware,
and see yourself:

https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/usb3-frequency-interference-papers.pdf

Now, with an USB extension cord (or the USB 2.0 port on my laptop *very* far
from all the others), I can get a rock solid signal.. at least up to the
distance of literally a finger from the antenna inside the headphones. More
than that, and anything goes. Sometimes I can listen to an entire album with a
normal posture and position, others I have almost to touch the bluetooth
receiver. 

A long cry from when I could even go to the bathroom meters, a wall, and a
wooden door away (which is more or less what the AR3012 built-in in my laptop
can still score instead). 

Something is rotten here electromagnetically but I cannot figure out anything
more (reported RSSI in btmgmt looks indeed like shit). 
I tried to disable some of the usb power saving stuff, to no avail. 
And I wonder if the "hci0: unexpected event for opcode 0x0000" error that I'm
only getting on the the first connect on the new Intel southbridges is in any
way related.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
