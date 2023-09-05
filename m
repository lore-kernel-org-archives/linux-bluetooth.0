Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE97CA0FFB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbjIEQW4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354260AbjIEKZ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 06:25:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070B4DB
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57022CE10C5
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B68DC433CA
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693909549;
        bh=ReYIv/lJSUCN2TISpUCGknhn5VMKNQvhKGo4kpm9GKI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sdirHi/WA6NZ90ChwFkGcVQ3zviq/0xi0XP9RdkntnFwIM6ul8knxOxSUF6crYZXP
         T25yNtHfhYqNcT+TmD24P3viF/yNjJghUhmZyuIOpt2jgEpSWLoFv9eqTgBBSsiyxL
         quaJXXzJUD6XLwdosNTFU0h3KEBuhAuP0rf85tPWZTsPAfraChtiY977KsRaKKZhkT
         5IPHYfYEKOczsWgIS/8Shqu4mAmV+Li/5Bh5fYP9lnck7ITPIaG6EgYoVm2/bVG/EN
         MoyjDm63XjLN1WdaelUgiBORt+s3farp0pdwkSfSyEAfB9dWZoOO92kgl4rt4MafIw
         mzAojByxARd6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 85A1EC53BD4; Tue,  5 Sep 2023 10:25:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date:   Tue, 05 Sep 2023 10:25:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-80791-62941-kvaYmdNv6I@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Lot of "hci0 sco packet for |"Bluetooth: hci0: ACL
                   |unknown connection handle"  |packet for unknown
                   |                            |connection handle" must be
                   |                            |hidden behind "debug"

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
