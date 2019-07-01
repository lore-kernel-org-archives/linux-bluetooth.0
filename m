Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E85C0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 12:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562AD20881
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 12:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfGAMX3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:23:29 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:40524 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727938AbfGAMX3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 08:23:29 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B605D204FB
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2019 12:23:28 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id A85F328708; Mon,  1 Jul 2019 12:23:28 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203997] [REGRESSION] Unable to connect BT audio device on
 5.1.15
Date:   Mon, 01 Jul 2019 12:23:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xenofil@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203997-62941-mbH4tjgX0s@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203997-62941@https.bugzilla.kernel.org/>
References: <bug-203997-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203997

--- Comment #10 from Eivind Eide (xenofil@gmail.com) ---
Compiled 5.1.15 kernel with this patch and it indeed fixes the problem of
pairing with KLIPSCH KMC 1. Thanks!

-- 
You are receiving this mail because:
You are the assignee for the bug.
