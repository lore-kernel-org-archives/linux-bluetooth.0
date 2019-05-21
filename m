Return-Path: <SRS0=xYxd=TV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A38C072B5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 May 2019 23:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFB6217D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 May 2019 23:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfEUXKv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 May 2019 19:10:51 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:49612 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfEUXKv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 May 2019 19:10:51 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EAEFC28AF3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2019 23:10:50 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id DF3CB28AF1; Tue, 21 May 2019 23:10:50 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203643] [REGRESSION][BISECTED] Sixaxis gamepad no longer
 connects via Bluetooth
Date:   Tue, 21 May 2019 23:10:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: didierg-divers@orange.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203643-62941-I0mnkzjOO0@https.bugzilla.kernel.org/>
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

didierg (didierg-divers@orange.fr) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |didierg-divers@orange.fr

--- Comment #7 from didierg (didierg-divers@orange.fr) ---
I cannot connect Logitech BT mouse using kernel 5.0.15 or higher.

Works fine with 5.0.14 or lower.

See: https://bugzilla.redhat.com/show_bug.cgi?id=1711468

-- 
You are receiving this mail because:
You are the assignee for the bug.
