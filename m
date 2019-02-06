Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A99C169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 11:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC46218A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 11:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfBFLL7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:11:59 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:56180 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726914AbfBFLL7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 06:11:59 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 152A92B560
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Feb 2019 11:11:59 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 099FB2B5DF; Wed,  6 Feb 2019 11:11:59 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202515] Bluetooth LE Extended Connect returning Command
 Disallowed
Date:   Wed, 06 Feb 2019 11:11:58 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-202515-62941-GDcMbWY1C6@https.bugzilla.kernel.org/>
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

--- Comment #6 from Mathias Tillman (master.homer@gmail.com) ---
Created attachment 281017
  --> https://bugzilla.kernel.org/attachment.cgi?id=281017&action=edit
Working btmon log

-- 
You are receiving this mail because:
You are the assignee for the bug.
