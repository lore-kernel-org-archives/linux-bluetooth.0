Return-Path: <SRS0=sfNh=XG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5300C49ED6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Sep 2019 11:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D3F20CC7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Sep 2019 11:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfIKLY4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfIKLYz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Sep 2019 07:24:55 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200039] BT advertising packet wakes up the system from S3 and
 suspend-to-idle
Date:   Wed, 11 Sep 2019 11:24:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario_limonciello@dell.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200039-62941-mVzwYWSbPI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200039-62941@https.bugzilla.kernel.org/>
References: <bug-200039-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=200039

--- Comment #35 from Mario Limonciello (mario_limonciello@dell.com) ---
@Tom:

The offending commit that caused this behavior is being reverted for 5.4:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/commit/?id=1ffdb51f28e8ec6be0a2b812c1765b5cf5c44a8f

You may also need to update to latest linux-firmware.git as well if your distro
has old firmware.

-- 
You are receiving this mail because:
You are the assignee for the bug.
