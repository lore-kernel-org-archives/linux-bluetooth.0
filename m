Return-Path: <SRS0=e9K0=WO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D12BC3A59B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Aug 2019 01:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274AE21773
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Aug 2019 01:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfHRBp1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Aug 2019 21:45:27 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:39612 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbfHRBp1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Aug 2019 21:45:27 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 43F6928908
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Aug 2019 01:45:26 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 3562D28904; Sun, 18 Aug 2019 01:45:26 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 18 Aug 2019 01:45:25 +0000
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
Message-ID: <bug-60824-62941-p6PNNm9nmm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #36 from Sergey Kondakov (virtuousfox@gmail.com) ---
(In reply to Arthur Fragoso from comment #35)
> The code for these devices are bellow.
> 
> You are right, the patch is way too old for this.
> 
> I will probably buy a different device while we wait for someone with more
> knowledge to fix this.
>...
>       /* Detect controllers which aren't real CSR ones. */
>       if (le16_to_cpu(rp->manufacturer) != 10 ||
>           le16_to_cpu(rp->lmp_subver) == 0x0c5c) {
>...

Luckily, I still have my old 2.1 dongle.

It seems that this check is too specific, mine has 0x811 subversion but the
real problem is idiotic notion of holding all BT devices to some imaginary
standard of compliant vendor-approved behaviour and creating blacklists for
actual devices only if someone from BT maintainers have heard something about
some problems from someone. No normal user is going to write them letter with
complains, let alone patches for hard-coded workarounds to artificial problems.
They need to redo the whole initialization logic to be more generic or at least
allow passing quirk-flags at runtime.

There is and will be myriad of devices with random IDs and crappy firmwares,
sometimes even circuitry, and kernel MUST make all that crap work at least
partially, not backdown on smallest of mislabelings. It is saddening to see
only recently created built-in Windows 10 BT stack to behave more sanely than
bluez.

-- 
You are receiving this mail because:
You are the assignee for the bug.
