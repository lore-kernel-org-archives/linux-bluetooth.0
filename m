Return-Path: <SRS0=eb2H=PR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F76C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 21:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2179B206BB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 21:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfAIVEM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:04:12 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:37300 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbfAIVEL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jan 2019 16:04:11 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id DBB8327F98
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jan 2019 21:04:10 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id D0058284C0; Wed,  9 Jan 2019 21:04:10 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202203] Bluetooth mouse doesn't move until sending a pair
 request
Date:   Wed, 09 Jan 2019 21:04:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: felixonmars@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-202203-62941-VibZUEYdLe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202203-62941@https.bugzilla.kernel.org/>
References: <bug-202203-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202203

--- Comment #1 from Felix Yan (felixonmars@gmail.com) ---
Created attachment 280365
  --> https://bugzilla.kernel.org/attachment.cgi?id=280365&action=edit
btmon output when sending "pair" command, which finally makes the mouse move
correctly

-- 
You are receiving this mail because:
You are the assignee for the bug.
