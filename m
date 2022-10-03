Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 10:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJCKyy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJCKyv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 06:54:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E358D1260A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 03:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0AD3B8105A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 10:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEBDFC433B5
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664794484;
        bh=Tymf4dqap0ZGfPXEv3jH8bx/q7ZX3DKCafXUKlwTCCs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tPBMvVIUtms+m6q6/WuCsfOapRaShqSa42z5p6idVs934VRNw0RH6/8gB8AyaU4ez
         2qAZCXRstgvzvz0uQXMTFfp7p81+QC4ItFBe0bxfiWFOqVuuIcjI2gtn5j/PhnJaJZ
         4ez6WcfmH0yXxj52JzDj8fo0T5CjheW7VNYxmZ0dcPinYMlgM9oFDoHHMDhoSR32Bz
         wNcesH2N8U8YInDO/MsFGSQcTFJuPYsBRnpt1y5AUloqLraER9fIJC3BKbE9ssVEXk
         FytBjUmEgV8dO5taHVIyMh7OhZEp6gTASNQl2NJSBx5TsC2ecKwHoKgfxpBWT3aIrI
         K5TDUiQRxMCtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9BADBC433EA; Mon,  3 Oct 2022 10:54:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215725] Basilisk X Hyperspeed Bluetooth LE mouse fail to
 connect under 5.17 with Opcode 0x2043 failure
Date:   Mon, 03 Oct 2022 10:54:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215725-62941-dSiUd4ETFs@https.bugzilla.kernel.org/>
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

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #5 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
(In reply to Winston Wu from comment #4)
> Hi it seems that the problem no longer presents after 5.17.3 or so=E2=80=
=A6=20

Thank you for reporting back. If you have time, it=E2=80=99d be great if yo=
u could
figure out the exact commit. Otherwise, it=E2=80=99d be great if you closed=
 the
issue/bug report.

PS: If you reply via email, please do not quote/cite the original email, as=
 the
quote is not hidden in the Bugzilla comment, making it hard to read.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
