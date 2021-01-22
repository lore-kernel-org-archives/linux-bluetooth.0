Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE5EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 13:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727E623433
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 13:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbhAVNqV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:46:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbhAVNqI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 08:46:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C023323A81
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 13:45:27 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 22 Jan 2021 13:45:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-rtSKAYGblx@https.bugzilla.kernel.org/>
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

--- Comment #167 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
mirh, hi, interesting comment.

I wonder if this perhaps is a USB packet timing issue, rather then a signal
strength issue, esp. the " "hci0: unexpected event for opcode 0x0000" error
that I'm only getting..." bit makes me wonder this.

Your old PC was likely using an EHCI controller. Where as your new PC is using
a xHCI controller, or a mix of EHCI + xHCI.  There is a subtle problem with
USB1/2 compatibility and xHCI controllers. the UHCI/EHCI USB1/2 controllers
have a frameclock of 1 ms and when sending a new USB packet to a device just
after the frame clock-tick, it will get delayed until the next frame. The xHCI
controller however will send any new USB control/bulk transfers *immediately*
if there is room for it on the BUs schedule (IOW if the bus is otherwise idle).

I've recently helped fix support for some old USB scanners by inserting a 1 ms
delay for some requests during the initialization of the scanner since the new
xHCI behavior made the time between 2 requests too short for the firmware of
the scanner to handle.  I wonder if something similar is going on here.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
