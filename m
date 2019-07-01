Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4065BC0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 12:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFE820B7C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 12:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfGAM0p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:26:45 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:42758 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfGAM0p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 08:26:45 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 35D372870B
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2019 12:26:45 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 2B2E4286DA; Mon,  1 Jul 2019 12:26:45 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203643] [REGRESSION][BISECTED] Sixaxis gamepad no longer
 connects via Bluetooth
Date:   Mon, 01 Jul 2019 12:26:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matias.karhumaa@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203643-62941-OilXWMRM9l@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203643-62941@https.bugzilla.kernel.org/>
References: <bug-203643-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203643

Matias Karhumaa (matias.karhumaa@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |matias.karhumaa@gmail.com

--- Comment #22 from Matias Karhumaa (matias.karhumaa@gmail.com) ---
Hi Martin,

There is another regression: https://bugzilla.kernel.org/show_bug.cgi?id=203997

If the remote control has minimum enc key size of 7, then this is most likely
same problem. Could you check with btmon?

Feel free to try the patch posted on mailing list.

Br,
Matias

-- 
You are receiving this mail because:
You are the assignee for the bug.
