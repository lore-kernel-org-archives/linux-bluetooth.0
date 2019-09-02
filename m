Return-Path: <SRS0=WMu/=W5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F79C3A59E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Sep 2019 11:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C562173E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Sep 2019 11:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfIBLoS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730340AbfIBLoS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Sep 2019 07:44:18 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203997] [REGRESSION] Unable to connect BT audio device on
 5.1.15
Date:   Mon, 02 Sep 2019 11:44:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pavel@noa-labs.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203997-62941-RDjihDdifS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203997-62941@https.bugzilla.kernel.org/>
References: <bug-203997-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203997

Pavel (pavel@noa-labs.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pavel@noa-labs.com

--- Comment #16 from Pavel (pavel@noa-labs.com) ---
Hello,

I'm afraid you are not out of the woods yet. I tried 5.2 and still can't pair a
lot of BT LE products based on MXCHIP chipset, including my mouse. My fear is
that they do use a key size of 1 by default 8-[]

-- 
You are receiving this mail because:
You are the assignee for the bug.
