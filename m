Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22229C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 22:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D6F2068D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 22:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgFAW0k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbgFAW0j (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 18:26:39 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208015] Logitech K380 pairs but cannot connect
Date:   Mon, 01 Jun 2020 22:26:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gm4jervin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208015-62941-l33iDHgRcC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208015-62941@https.bugzilla.kernel.org/>
References: <bug-208015-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208015

--- Comment #3 from Joseph Ervin (gm4jervin@gmail.com) ---
I did experimentation on this problem all afternoon, and I've come to the
conclusion that the problem is with the keyboard.  This keyboard has three
buttons on it that allow it to be paired with three different devices. 
Presumably it has three MAC addresses (if that's what they're called with
bluetooth).  

You press and hold one of the three buttons to enable pairing for that MAC
address.  It's a great feature, but I think between pairing and unpairing and
switching between its three virtual personalities (or MAC addresses), something
got messed up.  Looking at the btmon traces, I saw cases where the keyboard
appeared to be speaking gibberish during pairing, with btmon reporting lots of
"unknown" interpretations of capability structures.  

I was using MAC #1 for my windows laptop, MAC #2 for my android tablet, and MAC
#3 for the linux box with the Broadcom USB BT adapter.  Anyway, I turned off
the Windows laptop, unpaired the keyboard from the Android tablet and then
turned off bluetooth entirely on the android tablet.  In that state, I was able
to pair and unpair the keyboard using to the Linux box over and over with no
problems.  Then I re-enabled and repaired the keyboard on MAC #2 with the
android tablet, and now all is well, and I can switch back and forth between
them. 

I'm closing this bug.

-- 
You are receiving this mail because:
You are the assignee for the bug.
