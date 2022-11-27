Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD938C4321E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Nov 2022 12:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiK0Mce (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Nov 2022 07:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiK0Mcd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Nov 2022 07:32:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164A0B8C
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 04:32:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D4B860D28
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 12:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7484FC433C1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669552349;
        bh=2BHInnwRlNimDBih5L2Qc9X7Zg61CAI/jIw26+aJFAg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aXl5kTvjrlYDNFYxHwGSO7YuaXwkslEeVDveUmizqQvfIl2f+oqTemeFxcu0GuzOJ
         a6GC7POx0razy+4Ly/PuJ50sZF193Q+B9rNYXrZvge7q5p3rY7q0guqc42icedq0oi
         IbKTE/de1pzs/KkhB5uVtRWqoDhlpi1tCHalBeG7hi0XoGI8LYtxLcooMYekb9r+Li
         BJ8pPQxlZ3MhAi5FvO/XsDm+QhFb+orvZQ9TI7ea3uCpAw4wEEQLRiPMKMT4423kUr
         q95RZtmhojIXqzPzqpV0hL33/5QExoSDVycE/4GN5VT5uu/qySWXN3UT5aeEs8Y0H6
         DfRrO1TWvETRA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 49C28C433E9; Sun, 27 Nov 2022 12:32:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Sun, 27 Nov 2022 12:32:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216683-62941-OFSvIiRydZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #7 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to JustANormalTinkererMihir from comment #4)
> I don't really know what I am doing this is confusing as hell.

Well, ideally you would have followed these guides:

https://docs.kernel.org/admin-guide/reporting-issues.html
https://docs.kernel.org/admin-guide/reporting-regressions.html

But whatever, it's not important.

Thing is: when you patch your kernel (or Gentoo might have -- don't known) =
you
are own your own. And that seems to be the case here.

But TBH: the hole situation wrt to the problems recently discussed in Bug 6=
0824
are confusing for outsiders like me (and developers likely as well). But I'm
willing to help there. Could you maybe please provide me with an update? All
adapters that used to work really should work again without any external
patches -- and ideally without any new module parameters or similar tricks,
unless that can't be avoided (for example due to security concerns or becau=
se
it would cause regressions for others).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
