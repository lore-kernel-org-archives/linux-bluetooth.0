Return-Path: <SRS0=zNYh=W6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47562C3A5A2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Sep 2019 12:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0A820870
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Sep 2019 12:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfICMpi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfICMpi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Sep 2019 08:45:38 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203997] [REGRESSION] Unable to connect BT audio device on
 5.1.15
Date:   Tue, 03 Sep 2019 12:45:37 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-203997-62941-YQBN9i0sAe@https.bugzilla.kernel.org/>
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

--- Comment #20 from Pavel (pavel@noa-labs.com) ---
Created attachment 284773
  --> https://bugzilla.kernel.org/attachment.cgi?id=284773&action=edit
Capture of a mouse connection which leads to no mouse movement

I attached one more capture.

I see that connection lights up in the blueman UI, and then times out when I
stop pressing the mouse buttons after 30 seconds. All without a sign of mouse
movement.

Were there any changes to BTLE during 5.1, 5.2 release cycle?

I think this worth a separate bug report.

-- 
You are receiving this mail because:
You are the assignee for the bug.
