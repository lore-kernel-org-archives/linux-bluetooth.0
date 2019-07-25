Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D75DC7618B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A222238C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 13:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfGYNNf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:13:35 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:41660 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbfGYNNf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 09:13:35 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id BC3A12881C
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 13:13:34 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id B08FB289D1; Thu, 25 Jul 2019 13:13:34 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204275] bluetoothd consumes 100% cpu on keyboard disconnect
Date:   Thu, 25 Jul 2019 13:13:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204275-62941-VEkpFT0qYt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204275-62941@https.bugzilla.kernel.org/>
References: <bug-204275-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=204275

--- Comment #9 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Im not sure we even need the watch in the first place, the kernel should block
any in/out until the connection is encrypted (BT_SK_SUSPEND) so it might be
possible to get rid of sec_watch altogether.

-- 
You are receiving this mail because:
You are the assignee for the bug.
