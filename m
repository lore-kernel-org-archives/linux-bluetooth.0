Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BC7C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 08:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A798422C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 08:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbhATIyB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jan 2021 03:54:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbhATIxd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jan 2021 03:53:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8D31D23357
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 08:52:26 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 20 Jan 2021 08:52:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: er.krali@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-dvGTZWEjnT@https.bugzilla.kernel.org/>
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

er.krali@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |er.krali@gmail.com

--- Comment #165 from er.krali@gmail.com ---
(In reply to Yuri Santos from comment #164)
> (In reply to vinodmishra from comment #155)
> > (In reply to Flole from comment #154)

[snip]

> > Thanks so much. 
> > Same device and same issue on Pi Zero. Changing the "#define
> > lmp_bredr_capable(dev)" in hci_core.h to return false did the trick.
> 
> Thanks, i did that. Seems to have a advance, but still not working as
> expected.
> 
> 
> Info and logs:
> 
> https://gist.github.com/Yrds/5c2d610c86facc9b1f0522a6509e9e23

I can report some success here using the solution proposed here:

https://askubuntu.com/a/1304723

IOW, disabling the "clear event filter" step altogether in hci_core.c (lines
around 296-297).

Perhaps this could be added as another quirk, but that's sadly beyond my
ability.

For reference, here's the data of my model (Bluetooth 5.0, bcdDevice 8891) :

    Features: 0xbf 0x3e 0x4d 0xfa 0xdb 0x3d 0x7b 0xc7
    HCI Version: 5.0 (0x9) HCI Revision: 0x810
    LMP Version: 5.0 (0x9) LMP Subversion: 0x2312
    Manufacturer: Cambridge Silicon Radio (10)

  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
  idProduct          0x0001 Bluetooth Dongle (HCI mode)
  bcdDevice           88.91
  iManufacturer           0 
  iProduct                2 BT DONGLE10

I have tried pairing a couple of devices and it has worked so far.

Hopefully a cleaner version of this hack will be able to get into the official
kernel.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
