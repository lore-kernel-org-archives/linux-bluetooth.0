Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE4C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 10:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CD32158C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 10:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgILKEm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 06:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgILKEk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 06:04:40 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204765] debugfs: File 'le_min_key_size' in directory 'hci0'
 already present!
Date:   Sat, 12 Sep 2020 10:04:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: maarten.fonville@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204765-62941-N8mQiCKdd3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204765-62941@https.bugzilla.kernel.org/>
References: <bug-204765-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204765

Maarten Fonville (maarten.fonville@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |maarten.fonville@gmail.com

--- Comment #10 from Maarten Fonville (maarten.fonville@gmail.com) ---
I am suddenly seeing the same error after suspend/hibernation on my laptop with
my Microsoft Surface bluetooth mouse, using latest Ubuntu kernel
5.4.0-47-generic #51-Ubuntu SMP Fri Sep 4 19:50:52 UTC 2020 x86_64 x86_64
x86_64 GNU/Linux:


[82250.719088] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 2015
[82250.720091] Bluetooth: hci0: Device revision is 16
[82250.720092] Bluetooth: hci0: Secure boot is enabled
[82250.720093] Bluetooth: hci0: OTP lock is enabled
[82250.720094] Bluetooth: hci0: API lock is enabled
[82250.720094] Bluetooth: hci0: Debug lock is disabled
[82250.720095] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[82250.720099] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
[82250.722178] done.
[82250.757394] PM: suspend exit
[82250.980766] Generic FE-GE Realtek PHY r8169-200:00: attached PHY driver
[Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-200:00, irq=IGNORE)
[82251.091652] r8169 0000:02:00.0 enp2s0: Link is Down
[82252.225425] Bluetooth: hci0: Waiting for firmware download to complete
[82252.226105] Bluetooth: hci0: Firmware loaded in 1472555 usecs
[82252.226211] Bluetooth: hci0: Waiting for device to boot
[82252.238154] Bluetooth: hci0: Device booted in 11754 usecs
[82252.238165] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-12-16.ddc
[82252.241173] Bluetooth: hci0: Applying Intel DDC parameters completed
[82326.333382] Lockdown: systemd-logind: hibernation is restricted; see man
kernel_lockdown.7
[82358.148284] debugfs: File 'le_min_key_size' in directory 'hci0' already
present!
[82358.148303] debugfs: File 'le_max_key_size' in directory 'hci0' already
present!

-- 
You are receiving this mail because:
You are the assignee for the bug.
