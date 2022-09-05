Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EDDECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Sep 2022 20:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiIEUL0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Sep 2022 16:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIEULY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Sep 2022 16:11:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2DD5F23E
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Sep 2022 13:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF863B815DA
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Sep 2022 20:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C3D6C43150
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Sep 2022 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662408679;
        bh=lF+Pbm6zoKR6opfsyR0oRLAUngjQ7EhxHywhDEBTHAc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h0PqRAJ3M4xgWWPAL3acL2RXp8yU6LPN0O41rCemoR6SqeAjj5d7b8Nwf7GHuuaT1
         ZYvebawVpI6ELDHnQ5SD9rKiMc50m2LGKnuuvsCpOw9z8TGLyRxOIGMhVr2FThQ2FY
         SVRWAv+BOITTtFO0eptlOQXVYsTGeiTihdww1Bcx9jGmZdySnJMYu8ZACavp2IwoKT
         kLsjkox4Dq8bWPhAfTIXilAebxxo6JD91osQyuUa4uFavPMZruHT6GqQLU/AsiVk0r
         /0/Kx4txmUQ0McXL9wXJ0XwF9XneD/IWjRp8CzaxoabR0hFVwYdPHjEi1FEhz8z5fP
         5jUlQjFvDp07A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4D0CFC433E4; Mon,  5 Sep 2022 20:11:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Mon, 05 Sep 2022 20:11:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mike@it-loops.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215768-62941-psOcZLRcj9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

--- Comment #41 from Michael Guntsche (mike@it-loops.com) ---
Hi,=20

this worked for me in 5.19.3 but stopped working in 5.19.5 again. With 5.19=
.3 I
could go into standby with my BT headphones connected, with 5.19.5 and 6.0-=
rc3
the machine does not go to standby.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
