Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8202BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 16:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492E62343E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 16:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbhAVQUy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbhAVQUD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 11:20:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4C3B123A60
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 16:19:23 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 22 Jan 2021 16:19:20 +0000
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
Message-ID: <bug-60824-62941-0VLQC6nCzN@https.bugzilla.kernel.org/>
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

--- Comment #169 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Ah, so your old PC was that old, ok. So there are basically 4 generations of
USB controllers which are relevant here:

1. The first USB-2 capable Intel PCs use UHCI for USB-1, and EHCI for USB-2.
Ports directly on the motherboard are automatically muxed to the UHCI/EHCI
controller depending on device speed (and some BT dongles are USB1).

When a USB-2 hub is plugged into this generation and then an USB-1 device
plugged into the HUB, then the USB-1 device will be handled by the EHCI
controller. If you still have your old PC you can check if the BT USB adapter
you are using perhaps dislikes being routed through the TT (transaction
translator) of a hub, but putting an USB-2.0 hub in between.

2. Later USB-2 capable Intel PCs dropped the UHCI controllers (and the muxing
of ports) instead integrating a USB-2 hub with the EHCI controller(s)

3. The first USB-3 capable motherboards had a combinationn of USB-3 ports
connected to a XHCI controller and also had some EHCI controllers. Also the
USB-3 ports could be muxed to the EHCI controller (loosing USB-3 support) for
use with operating systems which do not support the XHCI controller. With the
1st gen the ports were actually muxed to the EHCI by default IIRC.

4. Current PCs often only have a XHCI controller which serves both the USB-3
and USB-2 ports of the PC.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
