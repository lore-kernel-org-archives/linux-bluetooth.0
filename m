Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D9C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 Jan 2021 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD9264E22
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 Jan 2021 15:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhAaPrz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 31 Jan 2021 10:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhAaPrv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 31 Jan 2021 10:47:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2874B64E2B
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Jan 2021 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612108026;
        bh=vUTxVjaVyehaS+VDLVAufJBaSWHFiflvTGc6ekpj3uA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j5sb8aJdAmkOT8bFXI/zlOm2PT7EdnjSISmX/GA+kv5NBLpV7VpF20t7C+F5CIRDI
         ghWJDQIMVqKWkJ5n4hc4rBHNy4SQ0Rw8c+IOUEYgBO03TIb5X+1w3iXGulX7rqeWBG
         4Mo9VZcdqR4zjiJ7rqRCyFLozdJHyx9W14Ew/wDh3mqD7+Kt/vVnrcNQ7o2ce6lI4K
         rLyI5T7pSmmNqPUYTzzdO3bbupk6KEWGQ4hRSOM3mmRP+8xSQaeYclKsjm2zTB3keI
         mIt1mSflZgSDJm6dIn28xRNZXa9A7XqJOgXH6UqK5mSSSGVJRlX2DNCVYSMvxF+6Eq
         0AyIODBAQXtTQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 31 Jan 2021 15:47:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: virtuousfox@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-cpJhqCF0CE@https.bugzilla.kernel.org/>
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

--- Comment #171 from Sergey Kondakov (virtuousfox@gmail.com) ---
(In reply to fredleb from comment #170)
> Hi !
>=20
> Not sure it helps but this is the one I bought: https://ebay.us/Om8h1k
>=20
> Of course, before I discovered this thread...
>=20
> Should I get another stick or is there any chance that this will ever wor=
k ?
> Anything I can do to help ?
>=20
> Thanks for your efforts all !
>=20
> Cheers,
> FL

Likely. After all fiddling about, I gave up on that thing.

Instead I bought Orico BTA-508 (on BT5 RTL8761B chip) from
https://www.aliexpress.com/item/1005001273586697.html They also have previo=
us
BT4 version of a dongle based on real CSR8510 chip and proper firmware:
https://www.aliexpress.com/item/32734449020.html - I've seen reports that t=
his
one actually works too.

For BT5 RTL8761B I had to manually extract firmware file from its Windows
driver, current release kernel does not have any and one known from Github =
did
not work for me:
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/572#note_776534

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
