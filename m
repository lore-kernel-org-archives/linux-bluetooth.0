Return-Path: <SRS0=7X4B=CL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674C7C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 02:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406432068F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 02:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIBC26 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgIBC26 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 22:28:58 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 02 Sep 2020 02:28:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-K6NX66hUVP@https.bugzilla.kernel.org/>
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

--- Comment #148 from Swyter (swyterzone@gmail.com) ---
Yeah, I tested 5.8.2-arch when it came out and it was a bit disappointing, to
be honest. Something in that timespan caused a regression. It was still an
improvement, because the counterfeit detection worked fine and the dongle
talked back and forth, but it suffered from weird connection problems, so it
probably didn't play well with some of the Bluetooth stack changes introduced
recently.

As you said, my patch on kernel 5.7 worked more or less fine. I haven't had
time to properly track down the issue or see what happens in newer kernel
versions with the patch included (from 5.8.2 onwards, I think). 

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/drivers/bluetooth/btusb.c?id=v5.8.2&id2=v5.8.1

But maybe it has ironed out itself. ¯\_(ツ)_/¯

If anyone has time to do some regression testing to narrow down the issue and
better document what's going on, it would probably help a lot.

-- 
You are receiving this mail because:
You are the assignee for the bug.
