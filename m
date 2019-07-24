Return-Path: <SRS0=wkNI=VV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC3DC7618B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jul 2019 15:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D8F20651
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jul 2019 15:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfGXPbV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:31:21 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:47332 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727491AbfGXPbV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jul 2019 11:31:21 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3056A286B8
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2019 15:31:21 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 2AFD028908; Wed, 24 Jul 2019 15:31:21 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204275] bluetoothd consumes 100% cpu on keyboard disconnect
Date:   Wed, 24 Jul 2019 15:31:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: steve@snewbury.org.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204275-62941-ywPEYHuvdl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204275-62941@https.bugzilla.kernel.org/>
References: <bug-204275-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=204275

--- Comment #7 from Steven Newbury (steve@snewbury.org.uk) ---
(In reply to Luiz Von Dentz from comment #6)
> Ive sent a fix upstream:
> 
> https://lore.kernel.org/linux-bluetooth/20190724110151.4258-1-luiz.
> dentz@gmail.com/T/#u
> 
> Let me know if that works.

That will prevent the channel getting left dangling, but it doesn't address the
issue of the callback not happening on initial connect, which is AFAICT what
results in that part of the bug for me.

Is it really supposed to be waiting for G_IO_OUT?  It seems it only gets
triggered for me when a second connection is attempted on the dangling channel,
presumably during handshake..?

-- 
You are receiving this mail because:
You are the assignee for the bug.
