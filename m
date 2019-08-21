Return-Path: <SRS0=uRtI=WR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E95C3A59E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Aug 2019 15:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4E722DA7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Aug 2019 15:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfHUPlq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfHUPlq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Aug 2019 11:41:46 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204633] Connecting BT headphones causes spinlock to lock up
Date:   Wed, 21 Aug 2019 15:41:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: olivier.crete@ocrete.ca
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-204633-62941-0L3JeBrN9j@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204633-62941@https.bugzilla.kernel.org/>
References: <bug-204633-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204633

Olivier Crête (olivier.crete@ocrete.ca) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|5.2.8-200.fc30.x86_64       |5.2.9-200.fc30

--- Comment #1 from Olivier Crête (olivier.crete@ocrete.ca) ---
Also fails on 5.2.9

I should mention that after I get this error, I'm pretty much guaranteed ot get
a kernel lockup at some point, either the spinlock in kobject_add_internal() or
the mutex inside netlink, which I assume is related to some thread holding it
and stuck deeper in the net layer.

-- 
You are receiving this mail because:
You are the assignee for the bug.
