Return-Path: <SRS0=okSL=QO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5314AC282C2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 22:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FF721721
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 22:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfBGWzU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:55:20 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:35856 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfBGWzU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Feb 2019 17:55:20 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 93ED32E7AC
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Feb 2019 22:55:19 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 85B4B2E7C0; Thu,  7 Feb 2019 22:55:19 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202515] Bluetooth LE Extended Connect returning Command
 Disallowed
Date:   Thu, 07 Feb 2019 22:55:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: master.homer@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202515-62941-2OnJ0HnfNv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202515-62941@https.bugzilla.kernel.org/>
References: <bug-202515-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202515

--- Comment #12 from Mathias Tillman (master.homer@gmail.com) ---
Right, so it went back to not reporting the LE Set Extended Scan Parameters
(Octet 37 - Bit 5) in the supported commands list after shutting off my
computer and turning it on again after a short while. So while the card does
seem to be a bit buggy, should the kernel actually check for the parameters bit
when enabling or disabling ext scanning? From what I can tell, the ext scanning
parameters and enabling are two different commands, so shouldn't it check just
the ext scanning bit when sending the ext scan enable command, and check the
ext scan params bit only when sending the ext scan params command?

-- 
You are receiving this mail because:
You are the assignee for the bug.
