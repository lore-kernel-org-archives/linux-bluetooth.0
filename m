Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B6CC19425
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 20:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE8F23A33
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 20:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgLIU0H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388454AbgLIU0A (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 15:26:00 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210275] Bluetooth stopped working on kernel 5.9
Date:   Wed, 09 Dec 2020 20:25:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: francesco.kirico@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210275-62941-Ct1Sfi5iio@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210275-62941@https.bugzilla.kernel.org/>
References: <bug-210275-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210275

--- Comment #7 from Francesco Chirico (francesco.kirico@gmail.com) ---
(In reply to Francesco Chirico from comment #6)
> (In reply to m11.1l1.f64 from comment #5)
> > Today’s update for the kernel fixed the issue!!
> 
> Could you please tell what kernel version / package solved the problem?
> In my case (Fedora 33) even latest kernel update (5.9.12-200.fc33.x86_64)
> didn't solve the problem.

Finally I figured out where the problem was.
In my case I needed a file /etc/modprobe.d/btusb.conf with the following
content:

options btusb reset=0

This solved the problem for me.
I wonder why this file became suddenly so important (before I never needed it
with the same dongle).

-- 
You are receiving this mail because:
You are the assignee for the bug.
