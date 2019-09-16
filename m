Return-Path: <SRS0=loPc=XL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B21C49ED7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 07:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F09217D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 07:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfIPHaz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfIPHaz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Sep 2019 03:30:55 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 16 Sep 2019 07:30:54 +0000
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
Message-ID: <bug-60824-62941-8q3ZqXMUvV@https.bugzilla.kernel.org/>
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

--- Comment #39 from Sergey Kondakov (virtuousfox@gmail.com) ---
(In reply to Fernando Carvalho from comment #38)
> Hi,
> 
> I merged a few fixes and quirks (including some from this thread) and sent
> them to linux-bluetooth@vger.kernel.org :
> 
> https://www.spinics.net/lists/linux-bluetooth/msg81304.html
> 
> Feel free to test it if you have a simillar CSR device
> (ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="0001",
> ATTRS{bcdDevice}=="8891").
> 
> It's not perfect, but it allows the use of the adapter and connect a headset
> (with some connect errors/retries now and then).
> 
> Regards.

Great work ! Unlike the actual maintainers who don't even bother to read
bug-tracker anymore or use ready fixes for their code that they themselves
don't care about, it seems.

However, I doubt that even a scrupulous maintainer would ever allow that many
dedicated workaround options instead of one, in style of usbcore, usbhid and
snd-hda-intel even though they all use inconsistent schemes of their own. A
more reasonable approach would be passing model=vendorID:productID:<"model">
space-separated (to allow several dongles) override pairs with each having a
bunch of quirk-hacks associated (as snd-hda-intel) on it,
quirks=vendorID:productID:<comma separated list of all quirks> space-separated
pairs (as usbcore/usbhid) or both. But that means doing even more work that can
be ignored or offhandedly dismissed for code that was written without enough
foresight for it in the first place.

-- 
You are receiving this mail because:
You are the assignee for the bug.
