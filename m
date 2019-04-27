Return-Path: <SRS0=3gzF=S5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEFEC43218
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Apr 2019 07:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31AC2067D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Apr 2019 07:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfD0H4W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:56:22 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:58420 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbfD0H4W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Apr 2019 03:56:22 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 853B028AA2
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Apr 2019 07:56:21 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 79ACD28B1C; Sat, 27 Apr 2019 07:56:21 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202963] [REGRESSION][BISECTED] Bluetooth broken on MBP and
 kernel NULL pointer dereference
Date:   Sat, 27 Apr 2019 07:56:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ronald@innovation.ch
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202963-62941-dk7K0a1uNs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202963-62941@https.bugzilla.kernel.org/>
References: <bug-202963-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202963

--- Comment #3 from Ronald (ronald@innovation.ch) ---
(In reply to Ronald from comment #2)
> Btw., I tested https://lkml.org/lkml/2019/3/31/344 and that fixes the issue.

Forgot to add: more confirmations that this fixes the issue can be found at
https://github.com/Dunedan/mbp-2016-linux/issues/97#issuecomment-482865366

-- 
You are receiving this mail because:
You are the assignee for the bug.
