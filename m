Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC3FC282D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 18:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC7E21473
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 18:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbfA3S14 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:27:56 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:59566 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732542AbfA3S14 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 13:27:56 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6DB1F2FB8B
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 18:27:55 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 6C1DE2FBA9; Wed, 30 Jan 2019 18:27:55 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 86931] hid-generic 0005:099A:0500.0001: unknown main item tag
 0x0
Date:   Wed, 30 Jan 2019 18:27:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mybigspam@mail.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-86931-62941-xPv8TLGiu3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86931-62941@https.bugzilla.kernel.org/>
References: <bug-86931-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=86931

--- Comment #6 from mybigspam@mail.ru ---
It's not clear from the description what is the problem exactly?
I have similar symptoms with "unknown main item tag 0x0" message after timeout.

But my problem is that bluetooth keyboard disconnects on timeout (which is
normal), but then, on the first key press it's just loss, while the keyboard
reconnects successfully.

It doesn't occurs on the same system with Windows 10 - the key doesn't lost on
reconnect.

I wonder if it can be the same problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.
