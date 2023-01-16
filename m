Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26EEC46467
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Jan 2023 12:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjAPMnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjAPMnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Jan 2023 07:43:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58CB1E293
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jan 2023 04:43:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73074B80D31
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jan 2023 12:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA11C433EF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jan 2023 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673872980;
        bh=SrfYS/IBIU5d0GARPdnpQCMv7lCnUHF4lamEyT/zfbI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m8z7i9pUU2o3juEn1jvKR91JCMTK8vyS/nHGRmUiQ9z853SSeOLUTsPa4lguP/N28
         YgPvt7o5NxsOq4ECdltGa7SHUgmh8+1eMVYQYA9gVF++QHBootvI07p8RwN2xlk4vQ
         FoEJIQ2rVmSZh8AfSWZbIKacCUCk6mKdgPB1mEUWelF4w0Va6JebW1yhzmfI0YWFQG
         ITvRoaXRoGrRjL+V4mzlgMvnTaZfNF0+4cFFX9ZM2+5ueyfHa5NM+8e5AsezkzZSu5
         TFrZAsuU7t8ocaKO2pric6ayJKFTdkNz9V4zJQc4H2mBz+2J0GbEcrNpjeO95iabhc
         cozRf/yrZEJTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E1086C43142; Mon, 16 Jan 2023 12:42:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Mon, 16 Jan 2023 12:42:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216936-62941-2BF8FoJ845@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Artem S. Tashkinov from comment #2)
> I had these errors with 6.1.4 as well.

But earlier series (e.g. 6.0.y) worked fine?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
