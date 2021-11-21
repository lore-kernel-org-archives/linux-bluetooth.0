Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D83C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Nov 2021 21:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhKUVZ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Nov 2021 16:25:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhKUVZ0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Nov 2021 16:25:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4CE7E6069B
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Nov 2021 21:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637529741;
        bh=1PNfoi+IFnOxP3cipVS5XzG6AIJU716cvYtXqdt6Scs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KzVoQb8dtVu+SGvvj23NUSYnYLf8hq5BWCyfncskY1T6AZHFBeCsdP3POwcz89EWg
         bR0V8CzdnpGQVb/ULQkPtrkN5mP2nOdl1yDfckysEet1kish3Sf2rVhg2mlPupAQU7
         Lez3thZ2wtOyMoQ0Nnpqna31mgVFd6P5nQAss0CwqfrbqeHrr0w35HiYenYS4zmuAu
         k4jPZSR0zTseqTsuW+EMqCW/TfaRAzDB4zctfuMaUmRVk6Ap1lZ3snc4+TqKutBTS+
         +qCBXzYKHwQvhU3turBxgyQnm7J9yAdNtDrFIrM8Yddgsl+WTO09WoWFsvAI6FSQIT
         HIa/OeZTCvHWg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 3C07F60EBD; Sun, 21 Nov 2021 21:22:21 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215015] rtl8723bs restarting loop
Date:   Sun, 21 Nov 2021 21:22:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: serg@podtynnyi.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215015-62941-d1ylzPplis@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215015-62941@https.bugzilla.kernel.org/>
References: <bug-215015-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215015

--- Comment #1 from Serg Podtynnyi (serg@podtynnyi.com) ---
Fixed in 5.15.3

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
