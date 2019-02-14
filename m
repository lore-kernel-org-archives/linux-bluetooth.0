Return-Path: <SRS0=ZFDx=QV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF659C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 10:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78E2222A4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 10:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfBNK4A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:56:00 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:53568 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbfBNKz7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Feb 2019 05:55:59 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 50BC32D792
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Feb 2019 10:55:59 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 452A82D796; Thu, 14 Feb 2019 10:55:59 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202429] No Bluetooth Adapter on boot - Works after woken up
 from suspend/sleep - Intel Ac 9260
Date:   Thu, 14 Feb 2019 10:56:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: cordleztoaster@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202429-62941-pDFzMbWtnB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202429-62941@https.bugzilla.kernel.org/>
References: <bug-202429-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202429

--- Comment #3 from Tp (cordleztoaster@gmail.com) ---
Hi Mattchen

Appreciate the response. 
Have tried power off and on. I can confirm i have tried both of those commits.
Still no luck.

Have also tried Kernel 5.0-rc6 and still have the same issue.

-- 
You are receiving this mail because:
You are the assignee for the bug.
