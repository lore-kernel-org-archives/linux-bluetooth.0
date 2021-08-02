Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C939AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 18:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D87B610A2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 18:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhHBSMu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSMu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 14:12:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5A80761158
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Aug 2021 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627927960;
        bh=3b2qTti0LyTxsNOcEMoEvXz88zDO53WJ1WUIhkh6bxc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pqOEloJI1dCe++b3LzvNYqaLDQJYqbI9+eDFfHujRmbZUiyV+Op8xw5Y7CAaZ7jcj
         gv+ym7kRmooEpKeNa4bgHv2QDcl7oq9x+iOcuHsRFeQrqxjWY7A1jAEASOQ248t/I4
         2lZbsb+pOxYUDMeBbHzq+XHJKsS7cVgxxi7BGAxtO8TdO0Y8MQDR5EvPEekpMT0iGs
         7KpXnm2JUIo/mDZfBZMRW9JOKBQVN32iegUdaIKpBwCf9wM+h1ZioUdRO3+gZzI6vR
         mEIBugZwJsprbdx+rK4Ld/pGhlLLmzn+RuNGGOJXEKkTLC6tWQcbGgmHj1j0SxuNQd
         g75rSZtHUJCmg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 02 Aug 2021 18:12:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-EWZkWDZuC8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

Jack (ostroffjh@users.sourceforge.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ostroffjh@users.sourceforge
                   |                            |.net

--- Comment #188 from Jack (ostroffjh@users.sourceforge.net) ---
The last hunk of that last patch fails to apply to 5.13.7, although it looks
like at least some of it is already there (net/bluetooth/hci_request.c).  A=
lso,
is there a quick summary of what I should post to identify and report the
failure with my dongle?  (shows up as BT DONGLE10, and gives "Bluetooth: hc=
i0:
CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue
workaround"

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
