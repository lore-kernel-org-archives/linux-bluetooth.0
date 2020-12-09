Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B333C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 03:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBC823A1D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 03:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgLID1r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 22:27:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgLID1r (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 22:27:47 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203753] Bluetooth: hci0: advertising data len corrected
Date:   Wed, 09 Dec 2020 03:27:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sheepdestroyer@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203753-62941-KxdIU2IoZK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203753-62941@https.bugzilla.kernel.org/>
References: <bug-203753-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203753

sheepdestroyer (sheepdestroyer@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sheepdestroyer@gmail.com

--- Comment #3 from sheepdestroyer (sheepdestroyer@gmail.com) ---
Same problem on Fedora 33

kernel   5.9.11-200.fc33.x86_64
bluez    5.55-2.fc34.x86_64

Thinkpad X230 with integrated Broadcom Bluetooth :
Device 010: ID 0a5c:21e6 Broadcom Corp. BCM20702 Bluetooth 4.0 [ThinkPad]


Kernel log flooded by 

kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: bt_err_ratelimited: 6 callbacks suppressed              
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: bt_err_ratelimited: 1 callbacks suppressed              
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
kernel: Bluetooth: hci0: advertising data len corrected 20 -> 19
...

-- 
You are receiving this mail because:
You are the assignee for the bug.
