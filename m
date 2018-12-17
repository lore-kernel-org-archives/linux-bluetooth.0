Return-Path: <SRS0=yw44=O2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BADC43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Dec 2018 09:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FFA217F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Dec 2018 09:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbeLQJ3d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:29:33 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:47706 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbeLQJ3d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Dec 2018 04:29:33 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 72FD129BD1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Dec 2018 09:29:32 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 6758629BD8; Mon, 17 Dec 2018 09:29:32 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 198303] Bluetooth dies after a while.
Date:   Mon, 17 Dec 2018 09:29:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mika.noren@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-198303-62941-DAFXLDTKhj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198303-62941@https.bugzilla.kernel.org/>
References: <bug-198303-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=198303

Mika Norén (mika.noren@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #7 from Mika Norén (mika.noren@gmail.com) ---
(In reply to Grzegorz from comment #4)
> It would be helpfull if you attach logs from btmon (example: sudo btmon -i 0
> -w btmon.log) and from bluetoothd (sudo valgrind ./bluetoothd -n -d) -
> bluetoothd from bluez sources (you can checkout to 5.47-4 tag).
> 
> Regards,
> Grzegorz

As this issue has been solved in later kernel versions, I see no reason to keep
this open. Can be marked as solved. 

I'm not sure when it was solved though. Everything started to work as intended
after an update some time ago.

-- 
You are receiving this mail because:
You are the assignee for the bug.
