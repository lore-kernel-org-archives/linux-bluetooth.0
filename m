Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3593C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 01:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAA72078C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 01:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgFIBFB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgFIBE7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 21:04:59 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208109] bluetooth module blocking suspend on Toshiba X30-F
Date:   Tue, 09 Jun 2020 01:04:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abhishekpandit@chromium.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-208109-62941-T5BmTYmwUa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208109-62941@https.bugzilla.kernel.org/>
References: <bug-208109-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208109

Abhishek Pandit-Subedi (abhishekpandit@chromium.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |abhishekpandit@chromium.org

--- Comment #1 from Abhishek Pandit-Subedi (abhishekpandit@chromium.org) ---
Looks like a dupe of https://bugzilla.kernel.org/show_bug.cgi?id=207629. 

This is being fixed via https://patchwork.kernel.org/patch/11586221/

-- 
You are receiving this mail because:
You are the assignee for the bug.
