Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2024AC2D0F8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 04:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC74720708
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 04:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgEME4o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 00:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEME4o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 00:56:44 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207629] BISECTED Bluetooth: hci0: command 0x2042 tx timeout -
 suspend fails - Dell XPS 9300
Date:   Wed, 13 May 2020 04:56:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207629-62941-UYDYHEu6qX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207629-62941@https.bugzilla.kernel.org/>
References: <bug-207629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207629

--- Comment #13 from Len Brown (lenb@kernel.org) ---
Re: rfkill

$ sudo rfkill
ID TYPE      DEVICE      SOFT      HARD
 0 wlan      phy0   unblocked unblocked
 1 bluetooth hci0   unblocked unblocked

$ sudo rfkill event
2020-05-13 00:41:30,772265-0400: idx 0 type 1 op 0 soft 0 hard 0
2020-05-13 00:41:30,772289-0400: idx 1 type 2 op 0 soft 0 hard 0

Here I ran 10 suspend/resume attempts (4 succeeded),
but rfkill didn't print any more lines.

If I manually run "bluetooth off", rfkill prints this:

2020-05-13 00:49:00,003851-0400: idx 1 type 2 op 2 soft 1 hard 0

If I manually run "bluetooth on", rfkill prints this:

2020-05-13 00:49:15,297390-0400: idx 1 type 2 op 2 soft 0 hard 0

I get the same two lines by turning bluetooth off/on in the
system settings GUI, no matter if the bluetooth program is available or not.

-- 
You are receiving this mail because:
You are the assignee for the bug.
