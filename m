Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4760C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 07:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6961D64DCD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 07:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhBMHJR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Feb 2021 02:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBMHJQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Feb 2021 02:09:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CFBFD64E6A
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Feb 2021 07:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613200115;
        bh=hz495s5XmhPPkded2R+kdKMpvxIHrZUZuRqUpzXd2QM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=E5I1mIwUMZ9gyUvCMt6/+RV71LlCJjRXpPyk4eoTo+S3e8DmSB1VE960qgWe7Ygxk
         WK77CpY/sbab0S9FG/3VeFZERdcUhguGX5bDQy4k6+ZFPq8POYBrikMK+5Ae9obcmY
         MDaPPfZbcQKYL5+7jdeoiF+8n1dawWWBikC88ZWeqJ9nnyXl1tGFa+aYlo7Rw6MLDU
         FzILa89cVNCxoSBLXbzNhb30RrN8RVWxeRItsLh2vNtbOlIN8EhOzHCX5XGAhi/c/h
         e0DQLwyqopDnL36vPqalHSKFSvjdfTPSxHpDvHv/hQ4+Mwu4tRTMVL4zHBaj/MSFJi
         4k/8AUMpqsOgw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210681] kernel: Bluetooth: hci0: don't support firmware rome
 0x31010000
Date:   Sat, 13 Feb 2021 07:08:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: carnil@debian.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210681-62941-GsvpF2d3iM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210681-62941@https.bugzilla.kernel.org/>
References: <bug-210681-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210681

--- Comment #31 from Salvatore Bonaccorso (carnil@debian.org) ---
Hi=20

On Tue, Dec 29, 2020 at 10:50:10AM +0000, bugzilla-daemon@bugzilla.kernel.o=
rg
wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D210681
>=20
> Bradley Jarvis (brad@pocketinnovations.com.au) changed:
>=20
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |brad@pocketinnovations.c=
om.
>                    |                            |au
>=20
> --- Comment #10 from Bradley Jarvis (brad@pocketinnovations.com.au) ---
> Created attachment 294393
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D294393&action=3Dedit
> fix hci0: don't support firmware rome error
>=20
> Avoid returning error code when bluetooth version match is not made from
> qca_devices_table and version high is set.
>=20
> This reverts an error check that was removed to support WCN6855 which does
> have
> the high version set. The fix is to move the check after the table is sca=
nned
> and no version match is made.
>=20
> This fix will still produce the error message for example (for ATK3K
> 13d3:3402
> IMC Networks Bluetooth USB Host Controller)
>=20
> Bluetooth: hci0: don't support firmware rome 0x1020200
>=20
> But the bluetooth hardware still works as it used to

Several people have reported that since b40f58b97386 ("Bluetooth:
btusb: Add Qualcomm Bluetooth SoC WCN6855 support") they have issues
with their Bluetooth adapter stopping working. It was reported at
bugzilla[1].

Bradley Jarvis posted/attached a patch which seems to resolve the
issue, Moreno has added an alternative patch.

 [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D210681

But there is another report at

 [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D211571

and that last one was applied to bluetooth-next tree according to
https://lore.kernel.org/linux-bluetooth/CA2C8796-11CA-4E6F-A603-AE764516C85=
0@holtmann.org/

Regards,
Salvatore

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
