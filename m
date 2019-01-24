Return-Path: <SRS0=7kT9=QA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA61C282C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jan 2019 14:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007DD21872
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jan 2019 14:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfAXOVP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:21:15 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:36730 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727562AbfAXOVP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jan 2019 09:21:15 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3FD7B30675
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jan 2019 14:21:14 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 3E01730624; Thu, 24 Jan 2019 14:21:14 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201921] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver
 a99e, hci rev 826c, hci ver 0008
Date:   Thu, 24 Jan 2019 14:21:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kai.heng.feng@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-201921-62941-uf8Cgsc2nL@https.bugzilla.kernel.org/>
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

--- Comment #6 from Kai-Heng Feng (kai.heng.feng@canonical.com) ---
Created attachment 280713
  --> https://bugzilla.kernel.org/attachment.cgi?id=280713&action=edit
0001-Bluetooth-btrtl-Let-rtl_load_file-always-return-erro.patch

-- 
You are receiving this mail because:
You are the assignee for the bug.
