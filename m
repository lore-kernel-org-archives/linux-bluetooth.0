Return-Path: <SRS0=okSL=QO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4934DC282C2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 12:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C9821904
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 12:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBGM7d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:59:33 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:36496 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbfBGM7d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Feb 2019 07:59:33 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 04FBC2CF38
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Feb 2019 12:59:33 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id ED7822D342; Thu,  7 Feb 2019 12:59:32 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202515] Bluetooth LE Extended Connect returning Command
 Disallowed
Date:   Thu, 07 Feb 2019 12:59:31 +0000
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
Message-ID: <bug-202515-62941-f4ksudsXMH@https.bugzilla.kernel.org/>
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

--- Comment #11 from Mathias Tillman (master.homer@gmail.com) ---
Created attachment 281037
  --> https://bugzilla.kernel.org/attachment.cgi?id=281037&action=edit
Btmon extended working log

This is pretty odd, all of a sudden it has decided to start working without me
doing anything. Looking at the log, I can see it has started to use LE Set
Extended Scan Enable instead of LE Set Scan Enable - and sure enough, the Local
Supported Commands now lists LE Set Extended Scan Parameters (Octet 37 - Bit
5).
I haven't done anything to try and fix it - I even reverted to the bt firmware
that's included in my distro, and it's still working.

Any idea what might have caused the Extended Scan command to suddenly appear in
the supported list?

-- 
You are receiving this mail because:
You are the assignee for the bug.
