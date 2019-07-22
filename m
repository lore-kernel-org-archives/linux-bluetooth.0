Return-Path: <SRS0=sX4l=VT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_CSS,URIBL_CSS_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BCDC7618F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jul 2019 19:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA0F20644
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jul 2019 19:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfGVTgJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:36:09 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:43388 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728176AbfGVTgJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jul 2019 15:36:09 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id A8DCA2837D
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2019 19:36:08 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 9D24128497; Mon, 22 Jul 2019 19:36:08 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204275] bluetoothd consumes 100% cpu on keyboard disconnect
Date:   Mon, 22 Jul 2019 19:36:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: steve@snewbury.org.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204275-62941-B7R13OXBYG@https.bugzilla.kernel.org/>
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

--- Comment #2 from Steven Newbury (steve@snewbury.org.uk) ---
strace results in continuous repeating:

poll([{fd=3, events=POLLIN}, {fd=6, events=POLLIN}, {fd=7, events=POLLIN},
{fd=8, events=POLLIN}, {fd=10, events=POLLIN}, {fd=11, events=POLLIN}, {fd=12,
events=POLLIN}, {fd=16, events=POLLIN}, {fd=17, events=POLLIN}, {fd=18,
events=POLLIN}, {fd=19, events=POLLIN}, {fd=20, events=POLLIN}, {fd=21,
events=POLLIN}, {fd=22, events=POLLIN}, {fd=23, events=POLLIN}, {fd=42,
events=POLLIN}, {fd=43, events=POLLIN}, {fd=44, events=POLLIN}, {fd=45,
events=POLLIN}, {fd=46, events=POLLIN}, {fd=47, events=POLLIN}, {fd=48,
events=POLLIN}, {fd=49, events=POLLIN}, {fd=50, events=POLLIN}, {fd=51,
events=POLLIN}, {fd=52, events=POLLIN}, {fd=53, events=POLLIN}, {fd=55,
events=POLLOUT}], 28, -1) = 1 ([{fd=55, revents=POLLNVAL}])

-- 
You are receiving this mail because:
You are the assignee for the bug.
