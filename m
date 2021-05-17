Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9AAC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927DA61263
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 23:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhEQXMn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 19:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234781AbhEQXMm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 19:12:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 62EEF613BB
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621293085;
        bh=u6Z0BSCT6Vf7asZUZ13DSAhkIHfdrKKeNHkzGGITh7g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aTukTAJJaRvzK+vU20+kkHacCck+KMDyt7fn2+gXPQ1+N1++TjC/76Y+QAgbAowTw
         CZxX/fDaAFJ/DA5X2Pt8ghHBn9s391YlZ+MSfE13n7POYNKzz5CpC+xPS+Fld+Ahhy
         z604yrycqu7tsLZvMeHy7N17gWYdYrNO2zvyM2tMcUdHpR5Ny1wSJOdds1rUycuUzf
         2R+ki7aKHYM7SXY8bByjtfQfe47lP27LXIBQSJfxsWvPyVs8CCV6ka7jTc+GYzMIo1
         9frOfVrZtvwzbVavO1hQwOp14ucC7fqPGr6C5x1AmCXePULgbuwUda+/sX6nyQW14T
         Bnk1fnShC+1qw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 17 May 2021 23:11:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-rIxOgWRAmF@https.bugzilla.kernel.org/>
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

--- Comment #183 from Swyter (swyterzone@gmail.com) ---
It ended up being included starting with Linux v5.9-rc1 in July last year, I
think I originally tested it with a late v5.7 or v5.8 kernel. Then it regre=
ssed
shortly afterwards. =C2=AF\_(=E3=83=84)_/=C2=AF

That's why I said a few months ago that trying to find what broke it is a g=
ood
start point. Solving it seems like a matter of finding the culprit by narro=
wing
down the range of changes between a known working point and now. Then it sh=
ould
be a matter of testing and sending a small patch that builds onto what's
already there in less than ten lines, adding one or more missing quirks.

If I were to start working on another fix now I would also compare the pack=
et
flow between the Windows and Linux Bluetooth stacks and see what's up and w=
hy
it locks up after receiving very trivial stuff. Linux is probably doing
something extra. :)

Comment #165 here and above (testing getting rid of the event filter thingi=
e)
seems also like a good candidate to expand the quirk list:
https://bugzilla.kernel.org/show_bug.cgi?id=3D60824#c165

Food for thought.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
