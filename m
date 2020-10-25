Return-Path: <SRS0=eDkG=EA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F8EC388F7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Oct 2020 13:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68180222B9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Oct 2020 13:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416435AbgJYNwC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1414920AbgJYNwB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Oct 2020 09:52:01 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209847] [Regression] keyboard doesn't connect after initial
 pair
Date:   Sun, 25 Oct 2020 13:52:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: kanru.kernel@kanru.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209847-62941-bTAbJIlL61@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209847-62941@https.bugzilla.kernel.org/>
References: <bug-209847-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209847

--- Comment #1 from Kan-Ru Chen (kanru.kernel@kanru.info) ---
Related reports and possible fix:

https://bbs.archlinux.org/viewtopic.php?id=259954
https://bugzilla.kernel.org/show_bug.cgi?id=209717
https://bugzilla.kernel.org/show_bug.cgi?id=209403
https://bugzilla.kernel.org/show_bug.cgi?id=209745

https://patchwork.kernel.org/project/bluetooth/patch/20201022082304.31757-1-sathish.narasimman@intel.com/

-- 
You are receiving this mail because:
You are the assignee for the bug.
