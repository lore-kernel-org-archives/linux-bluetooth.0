Return-Path: <SRS0=J43N=QM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A00C282CB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Feb 2019 22:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC46F2184B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Feb 2019 22:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfBEWLP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:11:15 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:42244 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726742AbfBEWLP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Feb 2019 17:11:15 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C601B2CB7A
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Feb 2019 22:11:14 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id BA2B32CB51; Tue,  5 Feb 2019 22:11:14 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202465] Bluetooth adaptor dies - 0489:e0a2 Foxconn / Hon Hai
Date:   Tue, 05 Feb 2019 22:11:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jccantele49@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202465-62941-UYnirjDYTI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202465-62941@https.bugzilla.kernel.org/>
References: <bug-202465-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202465

--- Comment #2 from Jacob C (jccantele49@gmail.com) ---
I've just confirmed that this issue also does not occur on kernel
4.18.16_rt9-1, but this kernel also has various stability issues with the
laptop. This issue seems isolated to just the 4.19 and 4.20 kernels.

-- 
You are receiving this mail because:
You are the assignee for the bug.
