Return-Path: <SRS0=3wSE=QD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A715C282CA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 23:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A392133D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 23:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfA0XwP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Jan 2019 18:52:15 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:53986 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbfA0XwP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Jan 2019 18:52:15 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id AAE922A1F8
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jan 2019 23:52:14 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 9F1BB2A427; Sun, 27 Jan 2019 23:52:14 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202429] No Bluetooth Adapter on boot - Works after woken up
 from suspend/sleep - Intel Ac 9260
Date:   Sun, 27 Jan 2019 23:52:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cordleztoaster@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-202429-62941-LgvR0oYW9v@https.bugzilla.kernel.org/>
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

Tp (cordleztoaster@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|No Bluetooth Adapter on     |No Bluetooth Adapter on
                   |boot - Works after woekn up |boot - Works after woken up
                   |from suspend/sleep - Intel  |from suspend/sleep - Intel
                   |Ac 9260                     |Ac 9260

-- 
You are receiving this mail because:
You are the assignee for the bug.
