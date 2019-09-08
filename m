Return-Path: <SRS0=4P0p=XD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Sep 2019 11:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9272021734
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Sep 2019 11:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfIHL4D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Sep 2019 07:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbfIHL4C (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Sep 2019 07:56:02 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204585] Bluetooth Mouse Polling Rate Regressed to 20hz
Date:   Sun, 08 Sep 2019 11:56:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: trivial
X-Bugzilla-Severity: normal
X-Bugzilla-Who: leif.liddy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204585-62941-t1LZmG68jW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204585-62941@https.bugzilla.kernel.org/>
References: <bug-204585-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204585

Leif Liddy (leif.liddy@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |leif.liddy@gmail.com

--- Comment #1 from Leif Liddy (leif.liddy@gmail.com) ---
I'm seeing this exact same issue with an orochi (2015) mouse on my laptop
running kernel 5.2.11
What'd odd is that this issue isn't present when using this mouse on my other
laptop running the same distro + kernel (but different bluetooth chipset).

Not sure when this issue started exactly, but it was either kernel 5.1.x or
5.2.x.  

The stated hcitool command solves the issue for me. Since hcitool is
deprecated, what is the 'proper' method we're meant to use to implement this
change?

I'm not able to change the polling intervals via debugfs as conn_min_interval
and conn_max_interval don't exist

# find /sys/kernel/debug/bluetooth/hci0 -type f 
/sys/kernel/debug/bluetooth/hci0/le_max_key_size
/sys/kernel/debug/bluetooth/hci0/le_min_key_size
/sys/kernel/debug/bluetooth/hci0/vendor_diag
/sys/kernel/debug/bluetooth/hci0/dut_mode

-- 
You are receiving this mail because:
You are the assignee for the bug.
