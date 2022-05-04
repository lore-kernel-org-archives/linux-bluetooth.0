Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA0DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 14:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbiEDOZK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 10:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351290AbiEDOZG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 10:25:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781FE1D0D6
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 07:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14C1B61A70
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 14:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EC56C385A4
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651674089;
        bh=dRiTF/8/KRYGh2Dqdh/AMyqhyn1BvrXIDnCmedwrnnM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mJmmnV7n2Yc9KmYO8YoHp3nAoQycULGekaGRZ+36LR3s0fHCa67jJkIdBa+l9bY23
         5MzPk4rgOnbowadpLPZEy5YHHvyLwnCcghKCbBADXRT6W1M2MitjFP7iBka2uVKwqd
         sfwVfx1uPBwfkljF6BTJ9hPltt0dQAWv+T0FHJEKUU4R+DVewR2Ee5GhEJLRrGk2Nu
         XF2yZjp/8aGbcaJr1gIB6AyPcK+KwJtOqjRFewyKj/3HgzHb825SEGi3mRGC/I7OEr
         rPhXPJygN6FsolDCs86Huq8FbZA7muyv8Yg+WEsHApkW2X5wAXUhTkuVimO9wfwUlj
         JQOWR5Am3/beg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4CD96C05FD5; Wed,  4 May 2022 14:21:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215725] Basilisk X Hyperspeed Bluetooth LE mouse fail to
 connect under 5.17 with Opcode 0x2043 failure
Date:   Wed, 04 May 2022 14:21:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: winstonwu91@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215725-62941-CT4ATDFArr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215725-62941@https.bugzilla.kernel.org/>
References: <bug-215725-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215725

--- Comment #4 from Winston Wu (winstonwu91@gmail.com) ---
Hi it seems that the problem no longer presents after 5.17.3 or so=E2=80=A6=
=20

> =E5=9C=A8 2022=E5=B9=B45=E6=9C=884=E6=97=A5=EF=BC=8C=E4=B8=8A=E5=8D=889:1=
2=EF=BC=8Cbugzilla-daemon@kernel.org =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFhttps://bugzilla.kernel.org/show_bug.cgi?id=3D215725
>=20
> The Linux kernel's regression tracker (Thorsten Leemhuis)
> (regressions@leemhuis.info) changed:
>=20
>           What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                 CC|                            |regressions@leemhuis.info
>=20
> --- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemh=
uis)
> (regressions@leemhuis.info) ---
> (In reply to Luiz Von Dentz from comment #2)
>> (In reply to Winston Wu from comment #0)
>>> I am using AX201 wireless card (lsusb shows Bus 001 Device 004: ID
>> 8087:0026
>>> Intel Corp. AX201 Bluetooth) and the mouse stopped working with bluetoo=
th
>>> mode under 5.17. 5.16 does not have such problem.
>>=20
>> Could you please attach the HCI trace using btmon -w?
>=20
> Winston Wu, did you miss this, are you having trouble with this, or what's
> the
> status here?
>=20
> --=20
> You may reply to this email to add a comment.
>=20
> You are receiving this mail because:
> You reported the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
