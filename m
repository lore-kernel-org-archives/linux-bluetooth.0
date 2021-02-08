Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37545C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3D364E3A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 00:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBHAUu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Feb 2021 19:20:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhBHAUt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Feb 2021 19:20:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 02D7964E3A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Feb 2021 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612743608;
        bh=rr+FWiw8R4zRZXKsasimBWorM3oSRi1QmclCtqvbtZw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EHHvMbhZLFWTVyWMQdiU7hvlb4Ld6li6IalZJh/55D3A/DoWUmlR7n3NI+u6BoMdD
         Ll8UkJLS6IcXAo9wLJQhdw18V0NeOAZxOw9hfTy5KudhCXgw2SGSsRpswPQf6UC5hw
         5bCbLsM+SoccGSmWhiCwIml4SrGDyuCO0Fg6V8Q0dENIZnwf3LRtMfxabYDx2KcI28
         cYVAO9zAkhl25X3Ylbe96UrAqiN816FPar2svYlCuPfKC9esevijOsFw9hpqTGTPdl
         bs5WAc9F43pGIrfaaKxeeoZ0VXEjDYG98rXpOf5q027FeVqfkyONmD+JBpbYkq7xq+
         uh5QLv5aWwWAQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211571] Bluetooth: hci0: don't support firmware rome 0x1020200
Date:   Mon, 08 Feb 2021 00:20:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sinekonata@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-211571-62941-puKkek8zwM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211571-62941@https.bugzilla.kernel.org/>
References: <bug-211571-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211571

sinekonata@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sinekonata@gmail.com

--- Comment #2 from sinekonata@gmail.com ---
I have the same problem=20

sudo dmesg |grep Bluetooth
[    1.376617] usb 1-1.1: Product: Bluetooth USB Host Controller
[   13.557022] Bluetooth: Core ver 2.22
[   13.557043] Bluetooth: HCI device and connection manager initialized
[   13.557047] Bluetooth: HCI socket layer initialized
[   13.557050] Bluetooth: L2CAP socket layer initialized
[   13.557054] Bluetooth: SCO socket layer initialized
[   13.623406] Bluetooth: hci0: don't support firmware rome 0x1020200
[   18.084063] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   18.084067] Bluetooth: BNEP filters: protocol multicast
[   18.084072] Bluetooth: BNEP socket layer initialized

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
