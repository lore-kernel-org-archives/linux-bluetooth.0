Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B55DC43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 11:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C4861261
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 11:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbhEQLhZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 07:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236831AbhEQLhY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 07:37:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EBBFA6135F
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621251368;
        bh=jsWugzmp0X1wwsVJ4Y8aYgRnijoV+veQQ43dk1A1pKE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jwigoLjIT5B+jTmPHnyXVYFBQlgeEPgSggPOZvIGf7zRH15fZ+iIuTU7tG54Lp2Tv
         GBL6sHj4KYuMa82ccif1xDkED7yoXF+53w8rVLSrZDvLouvYkHKE5sjKip67EKcvk+
         bksFsCq/fIambGd03q/LivbyHaWsdu9LjyzcJrQolgie5UqPyqe/qdmdlwCucgivTB
         KRjjPE5JvTDeeknDs7/e4UZl5WopGKhLJ3k4rcwBdSLN/5mVWXBuDyDbnhbMtO2qor
         P2cW/MeZO8EmXCzgB+U2XnfrDU125Pt1joQErxuVf0wyWVOTkVHhkipUwtZFD9Fzws
         gkwfxWD3WG/NA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 17 May 2021 11:36:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hurikhan77+bko@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-U3XbBrLoLe@https.bugzilla.kernel.org/>
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

Kai Krakow (hurikhan77+bko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hurikhan77+bko@gmail.com

--- Comment #179 from Kai Krakow (hurikhan77+bko@gmail.com) ---
(In reply to Hans de Goede from comment #178)

> I suggest you buy a new dongle. If you search on say aliexpress (*) for
> csr8510 then you will find several dongles which are advertised as "origi=
nal
> csr8510 chip" in my experience these indeed contain a real CSR8510 chip a=
nd
> they work a lot better then the clones. So the best advice which I have is
> just to order one of those.

Is there a way the kernel could identify those as a fake/clone, and adverti=
se
this in dmesg? It would make debugging user reports much easier as we could
just say "get an original instead of a fake/clone".

This chipset (and clones) seems to be very common, almost any USB dongle I =
can
find has this chipset (or a clone) inside (according to lsusb), and some wo=
rk,
others don't. This chip is even in dongles of manufactures who somewhat cla=
im
that the Bluetooth dongle is completely made by themselves (with no mention=
 of
the CSR chip inside), or maybe these are just fake dongles with a brand nam=
e on
it, I'm not sure. It's difficult to get something else even if you're not
looking explicitly for CSR.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
