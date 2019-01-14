Return-Path: <SRS0=wTsk=PW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D31C43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 07:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A11420663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 07:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfANHae convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:30:34 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:57352 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbfANHae (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jan 2019 02:30:34 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C045E28992
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jan 2019 07:30:33 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id B4937289B8; Mon, 14 Jan 2019 07:30:33 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201921] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver
 a99e, hci rev 826c, hci ver 0008
Date:   Mon, 14 Jan 2019 07:30:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vasthusya@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-201921-62941-RmIdQbgGXF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-201921-62941@https.bugzilla.kernel.org/>
References: <bug-201921-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201921

--- Comment #5 from vasthusya@gmail.com ---
Created attachment 280459
  --> https://bugzilla.kernel.org/attachment.cgi?id=280459&action=edit
Kernel messages from various boot states.

Yes, the coldboot lmp_subver=8221 & hci_rev=c are correct and Bluetooth works
on vanilla kernel.

Unfortunately, I must restart the computer in order to gain CPU clock boost on
my Ryzen 5 2500u.
Separate issue, haven't checked around here for that bug yet.
https://community.amd.com/thread/229980#2893988

-- 
You are receiving this mail because:
You are the assignee for the bug.
