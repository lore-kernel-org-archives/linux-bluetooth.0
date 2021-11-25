Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C1CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 12:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbhKYMZF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 07:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349036AbhKYMXF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 07:23:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E315561156
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Nov 2021 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637842793;
        bh=KsIGIu1sOU2JqFvKf4kvi5ih4tE6UWCQNzhVevEbWR4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MeZ3gQQhptFdpCiyAi2Rjw+9O1WRVY+7Vyskaj37mmWD/pGq06xvnuuH2Wn/HtpYx
         SLxBqKzDhUVCpJKGw1NMRQ+t7R/jy9eb4WRxXnPyfvK1QbhKMYWP2JGAF8ndTnZ2Nx
         01k/t6d53ssGAv24qIwU5yM4PEMmFz/7cKRmCPUhi79Pehm+t3OuIkFqCr8a0Eqfcu
         f5zFJGiR8TtMvJht54uEOtoX1zRI2TL46mV3aeCTnETK5LQVN1nGojPY06eXaUMqje
         pcebRJFgv6NYhm1JVV26VXouAimLdwvhMQqiZS6ZzLTvf6jz6/0lAwAbgZ8YPH0zsP
         6k0abpYMH0bWw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id E04C7610E5; Thu, 25 Nov 2021 12:19:53 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Thu, 25 Nov 2021 12:19:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: crodjer@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213829-62941-FGE7c8W0fX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

Rohan (crodjer@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |crodjer@protonmail.com

--- Comment #39 from Rohan (crodjer@protonmail.com) ---
I faced a similar issue
(https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1000403) on Debian uns=
table,
but only with v5.15.3. When I built v5.15.4 of the kernel, it went away.

> It is fixed in Arch Linux though.
> I'm using 5.15.4.arch1-1, not the zen kernel.
>=20
> See
> https://github.com/archlinux/linux/commit/
> 236027c0ae73217898ac8249e44394cc1026dada

Applying this patch on 5.15.3 didn't resolve this for me, but simply moving=
 to
5.15.4 did.

>=20
> Let's hope it will soon land in the mainline kernel too.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
