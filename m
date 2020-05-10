Return-Path: <SRS0=BvBO=6Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC83EC38A2A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD2220737
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgEJSxn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 May 2020 14:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgEJSxn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 May 2020 14:53:43 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 10 May 2020 18:53:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: m.novosyolov@rosalinux.ru
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-Dt8XxW3iHq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #72 from Mikhail Novosyolov (m.novosyolov@rosalinux.ru) ---
(In reply to Alex from comment #71)
> Unfortunately only part of devices actually work after detection. For
> example mine was detected, but I was not able to pair anything to it (my
> logs and traces were attached to this thread)
Do you mean that some devices with UDB device/vendor ID 0x0811/0x8891 do work
and some do not?!

Btw, some crappy USB dongles may have to be usb_modeswitch'ed. I once had to
deal with a RTL8188GU-based USB WiFi dongle Tenda W311MI. It reported one model
(USB device ID) before being usb_modeswitch'ed and another model after being
usb_modeswitch'ed.
https://www.raspberrypi.org/forums/viewtopic.php?t=215668
https://nixtux.ru/718

I mean that in some cases you may be trying to make an incorrect model work...
Hope that this is not the case.

-- 
You are receiving this mail because:
You are the assignee for the bug.
