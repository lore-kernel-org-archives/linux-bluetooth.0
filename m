Return-Path: <SRS0=igZI=Y6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A430C5DF63
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1660D2178F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 15:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfKFPy4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfKFPy4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Nov 2019 10:54:56 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204585] Bluetooth Mouse Polling Rate Regressed to 20hz
Date:   Wed, 06 Nov 2019 15:53:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: trivial
X-Bugzilla-Severity: normal
X-Bugzilla-Who: saroumane@rbox.me
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204585-62941-4OFNwbDzzz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204585-62941@https.bugzilla.kernel.org/>
References: <bug-204585-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204585

saroumane@rbox.me changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |saroumane@rbox.me

--- Comment #9 from saroumane@rbox.me ---
The problem is still here on kernel 5.3.0-19-generic

I discovered it with my Logitech M535 bluetooth mouse.

The workaround (overriding /sys/kernel/debug/bluetooth/hci0/conn_min_interval
and conn_max_interval) works.

-- 
You are receiving this mail because:
You are the assignee for the bug.
