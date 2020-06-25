Return-Path: <SRS0=OFBO=AG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55129C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 00:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF42207DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 00:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbgFYAEO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387828AbgFYAEO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jun 2020 20:04:14 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 25 Jun 2020 00:04:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hello@andres.codes
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-BBfxahlkH6@https.bugzilla.kernel.org/>
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

--- Comment #88 from Andrés Rodríguez (hello@andres.codes) ---
@Swyter
I'm happy to report some progress!

After patching the bitwise 0x04 comparison, the controller can finally be
detected, but is unable to find any devices (tested against a Wiimote and an
Android phone).

This is the hcidump -X:

https://gist.github.com/mixedCase/d6962b3d24e13cf4443e8193c1451c5d

These are the relevant dmesg lines:

[   50.227320] Bluetooth: hci0: CSR: New controller detected; bcdDevice=0x2520,
HCI manufacturer=10, HCI rev=0x3120, LMP subver=0x22bb
[   50.227330] Bluetooth: hci0: CSR: Modern CSR controller type detected
[   50.251489] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   50.251490] Bluetooth: BNEP filters: protocol multicast
[   50.251493] Bluetooth: BNEP socket layer initialized
[   50.340205] NET: Registered protocol family 38
[   50.362740] Bluetooth: RFCOMM TTY layer initialized
[   50.362745] Bluetooth: RFCOMM socket layer initialized
[   50.362756] Bluetooth: RFCOMM ver 1.11

After trying to find devices with Blueman:

[  107.543868] Bluetooth: hci0: command 0x2005 tx timeout
[  109.677220] Bluetooth: hci0: command 0x200b tx timeout
[  111.810719] Bluetooth: hci0: command 0x200c tx timeout

---

After patching out both comparisons, the hcidump -X changes a little bit:

https://gist.github.com/mixedCase/e286bbc5f43807bd04c59c2c75cfb88f

I notice in there my machine's hostname (Enterprise) which is the default bluez
identifier.

Thanks for all the help so far! Hope we can find a pattern here.

-- 
You are receiving this mail because:
You are the assignee for the bug.
