Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0EFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Jan 2021 08:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DADB2080D
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Jan 2021 08:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhACIWb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Jan 2021 03:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbhACIWb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Jan 2021 03:22:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 12D152080D
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 Jan 2021 08:21:51 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211013] Cannot find ath3k bluetooth controller attached on USB
Date:   Sun, 03 Jan 2021 08:21:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cth451@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211013-62941-IFEafVVRDP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211013-62941@https.bugzilla.kernel.org/>
References: <bug-211013-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=211013

--- Comment #1 from Tianhao Chai (cth451@gmail.com) ---
Apparently this ver_rom 0x11020000 has never been recorded in
qca_devices_table[] defined in btusb.c.

Before 5.10 (i.e. 5.9.x and possibly earlier), the function btusb_setup_qca()
will short circuit and return 0 before querying the device table (the following
from 5.9.16, btusb.c:3627):

        ver_rom = le32_to_cpu(ver.rom_version);
        /* Don't care about high ROM versions */
        if (ver_rom & ~0xffffU)
                return 0;

Since this check is removed in 5.10.x due to added support of WCN6855 (which
has a high ROM version), the driver would return -ENODEV as this 0x11020000
doesn't exist in qca_devices_table in the first place.

I am not sure how this should be resolved. We could check whether ver_rom ==
0x11020000 and directly return 0 (and the card would work after that), but I
think this is a very dirty approach.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
