Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CA5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 04:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3C522AAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 04:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgLUEft convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Dec 2020 23:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgLUEft (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Dec 2020 23:35:49 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 21 Dec 2020 04:35:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yrds96@protonmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-QgoR4F7uXt@https.bugzilla.kernel.org/>
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

--- Comment #164 from Yuri Santos (yrds96@protonmail.com) ---
(In reply to vinodmishra from comment #155)
> (In reply to Flole from comment #154)
> > (In reply to Alex from comment #86)
> > > Hi Swyter,
> > > 
> > > I also tried your patch v2 and actually in my case see no difference with
> > > the previous ones I tried (see my comments 55/56
> > > https://bugzilla.kernel.org/show_bug.cgi?id=60824#c55 )
> > > 
> > > Linux recognizes the controller, but it's unusable:
> > > 
> > > Can't init device hci0: Invalid argument (22)
> > > 
> > > > HCI Event: Command Complete (0x0e) plen 4                               
> > > >                                                                  #22
> > [hci0]
> > > > 11.191461
> > >       Set Event Filter (0x03|0x0005) ncmd 1
> > >         Status: Invalid HCI Command Parameters (0x12)
> > > = Close Index: 00:1A:7D:DA:71:12                                          
> > > [hci0] 11.191493
> > > 
> > > 
> > > I've seen several people here have this issue, and I believe that comment
> > 59
> > > may be quite relevant here:
> > > 
> > > > Set Event fails, looking at hci_core.c the set filter and previous
> calls
> > > are
> > > > made only if device supports BREDR, is there any way to tell device
> > doesn't
> > > > support, or patch this ?
> > 
> > I have the same device, and my fix was simply changing the #define that
> > checks if a device supports BREDR to "false" (aka disabling BREDR support
> > completely) and that solved it.
> Thanks so much. 
> Same device and same issue on Pi Zero. Changing the "#define
> lmp_bredr_capable(dev)" in hci_core.h to return false did the trick.

Thanks, i did that. Seems to have a advance, but still not working as expected.


Info and logs:

https://gist.github.com/Yrds/5c2d610c86facc9b1f0522a6509e9e23

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
