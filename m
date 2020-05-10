Return-Path: <SRS0=BvBO=6Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3521EC38A2A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 14:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A5C2082E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 14:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgEJOuw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 May 2020 10:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgEJOuw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 May 2020 10:50:52 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 10 May 2020 14:50:50 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-qFu0UDeMKi@https.bugzilla.kernel.org/>
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

Mikhail Novosyolov (m.novosyolov@rosalinux.ru) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |m.novosyolov@rosalinux.ru

--- Comment #68 from Mikhail Novosyolov (m.novosyolov@rosalinux.ru) ---
(In reply to Sergey Kondakov from comment #39)
> (In reply to Fernando Carvalho from comment #38)
> > Hi,
> > 
> > I merged a few fixes and quirks (including some from this thread) and sent
> > them to linux-bluetooth@vger.kernel.org :
> > 
> > https://www.spinics.net/lists/linux-bluetooth/msg81304.html
> > 
> > Feel free to test it if you have a simillar CSR device
> > (ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="0001",
> > ATTRS{bcdDevice}=="8891").
> > 
> > It's not perfect, but it allows the use of the adapter and connect a
> headset
> > (with some connect errors/retries now and then).
> > 
> > Regards.
> 
> Great work ! Unlike the actual maintainers who don't even bother to read
> bug-tracker anymore or use ready fixes for their code that they themselves
> don't care about, it seems.
> 

I have nothing in common with maintaining bluetooth stack in the kernel, but
I'd like to comment on this a bit.
That patch adds a device ID to the list of "Fake CSR devices with broken
commands".
And you write that it is a "workaround" of this bug, not a "fix".
If I were a maintainer of BT stack in the kernel, I would try to avoid merging
such patches unless I have this piece of hardware and a datasheet.
So, here, I would not blame kernel maintainers for ignoring such bugs.

Maybe I misunderstood something, feel free to correct me.

Actually I did not understand from this bug report if this patch works or not.
Does btusb-Enablement-of-HCI_QUIRK_BROKEN_STORED_LINK_KEY-quirk.patch make
device just detectable or actually working?

-- 
You are receiving this mail because:
You are the assignee for the bug.
