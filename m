Return-Path: <SRS0=BvBO=6Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38485C54E4B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AA0214DB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 15:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgEJPPK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 May 2020 11:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbgEJPPK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 May 2020 11:15:10 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 10 May 2020 15:15:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: virtuousfox@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-WGdlD9HAT8@https.bugzilla.kernel.org/>
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

--- Comment #69 from Sergey Kondakov (virtuousfox@gmail.com) ---
(In reply to Mikhail Novosyolov from comment #68)
> (In reply to Sergey Kondakov from comment #39)
> > (In reply to Fernando Carvalho from comment #38)
> > > Hi,
> > > 
> > > I merged a few fixes and quirks (including some from this thread) and
> sent
> > > them to linux-bluetooth@vger.kernel.org :
> > > 
> > > https://www.spinics.net/lists/linux-bluetooth/msg81304.html
> > > 
> > > Feel free to test it if you have a simillar CSR device
> > > (ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="0001",
> > > ATTRS{bcdDevice}=="8891").
> > > 
> > > It's not perfect, but it allows the use of the adapter and connect a
> > headset
> > > (with some connect errors/retries now and then).
> > > 
> > > Regards.
> > 
> > Great work ! Unlike the actual maintainers who don't even bother to read
> > bug-tracker anymore or use ready fixes for their code that they themselves
> > don't care about, it seems.
> > 
> 
> I have nothing in common with maintaining bluetooth stack in the kernel, but
> I'd like to comment on this a bit.
> That patch adds a device ID to the list of "Fake CSR devices with broken
> commands".
> And you write that it is a "workaround" of this bug, not a "fix".
> If I were a maintainer of BT stack in the kernel, I would try to avoid
> merging such patches unless I have this piece of hardware and a datasheet.
> So, here, I would not blame kernel maintainers for ignoring such bugs.
> 
> Maybe I misunderstood something, feel free to correct me.
> 
> Actually I did not understand from this bug report if this patch works or
> not. Does btusb-Enablement-of-HCI_QUIRK_BROKEN_STORED_LINK_KEY-quirk.patch
> make device just detectable or actually working?

It's detectable but the only device I tested it was Sony DualShock 4 which acts
as master that connects PC to itself which uses "sixaxis" hacks in bluez. And,
in the end, it was a failure: DS4 does not want to pass input data and then
promptly shuts itself off after "pairing". It does work under Windows® with
that dongle but on Linux I had to resort to old BT 2.1 one.

The more important thing is "fixup" parameter patches that allow to at select
hacks per device and at least figure out what it needs without recompiling and
rebooting kernel every time. But, apparently, BT maintainer is not interested
in BT stack being as robust and easy to test as USB either.

I'm pretty sure that the problem is not just that those CSR chips may require
hacks by themselves but that "manufacturers" have flashed them with
inappropriate/misconfigured firmwares without testing, other than trying
something on Windows®, and then flooded Ebay and Aliexpress with those
unlicensed fakes. It's pretty much all you can get in an adequate "simple
dongle" price range. But Windows® manages to avoid those issues somehow,
meaning that Linux's BT stack is too picky, pedantic and too hardcoded for
unnecessary things. And that is something maintainers should care about. We
shouldn't keep figuring out crutches for every model & revision for things that
are not even required for device's purpose.

-- 
You are receiving this mail because:
You are the assignee for the bug.
